//
// Created by Jordi Kroon on 9/18/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#include "configuration.hpp"
#include <boost/property_tree/ptree.hpp>
#include <boost/filesystem.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <boost/lexical_cast.hpp>

boost::property_tree::ptree configTree;

/**
 * @param std::string filePath
 */
void Configuration::setConfigFile(std::string filePath)
{
    boost::filesystem::path fullPath(filePath);
    boost::filesystem::path directoryPath = fullPath.parent_path();

    if (!boost::filesystem::exists(directoryPath) && !boost::filesystem::create_directories(directoryPath)) {
        throw std::invalid_argument("Config file could not been created " + directoryPath.string());
    }

    if (!boost::filesystem::exists(filePath)) {
        boost::filesystem::ofstream fileStream(filePath);
        fileStream << "<?xml version=\"1.0\" ?>";
        fileStream.close();
    }

    boost::property_tree::xml_parser::read_xml(filePath, configTree, boost::property_tree::xml_parser::trim_whitespace);
    configFile = filePath;
}


/**
 * @param std::string key
 * @param std::string value
 */
void Configuration::put(std::string key, std::string value)
{
    LOG::write(INFO, "Put string " + key + "@" + value + " value in config file");

    configTree.put(key, value);

    boost::property_tree::xml_writer_settings<std::string> settings('\t', 1);
    boost::property_tree::xml_parser::write_xml(configFile, configTree, std::locale(), settings);

    Configuration::persist();
}

/**
 * @param std::string key
 * @param int value[]
 */
void Configuration::putArray(std::string key,std::string nodeKey, std::vector<int> values)
{
    boost::property_tree::ptree node;

    for (auto& value : values) {
        LOG::write(INFO, "Put int " + std::to_string(value) + "@" + key + "." + nodeKey + " value in config file");

        node.add(nodeKey, value);
    }

    configTree.put_child(key, node);
    Configuration::persist();
}

/**
 * @param std::string key
 */
std::string Configuration::get(std::string key)
{
    return configTree.get<std::string>(boost::property_tree::path(key));
}

/**
 * @param std::string key
 */
std::vector<int> Configuration::getArray(std::string key)
{
    std::vector<int> valueMap;

    for (boost::property_tree::ptree::value_type &value : configTree.get_child(key)) {
        valueMap.push_back(stoi(value.second.data()));
    }

    return valueMap;
}

/**
 * @param std::string key
 */
bool Configuration::exists(std::string key)
{
    try {
        Configuration::get(key);
        return true;
    } catch (...) {
        return false;
    }
}

void Configuration::persist()
{
    boost::property_tree::xml_writer_settings<std::string> settings(' ', 4);
    boost::property_tree::xml_parser::write_xml(configFile, configTree, std::locale(), settings);
}