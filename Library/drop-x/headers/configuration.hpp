//
// Created by Jordi Kroon on 9/18/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#ifndef DROP_X_CONFIGURATION_HPP
#define DROP_X_CONFIGURATION_HPP

#ifndef BOOST_TYPE_INDEX_FORCE_NO_RTTI_COMPATIBILITY
    #define BOOST_TYPE_INDEX_FORCE_NO_RTTI_COMPATIBILITY 1;
#endif

#include <vector>
#include <string>

#if defined(__cplusplus) && !defined(__drop)
    #include "logger.hpp"
    #include <typeinfo>
    #include <stdexcept>
#endif

class Configuration {
    private:
        /**
         * @var std::string
         */
        std::string configFile;

        /**
         * @var Configurarion
         */
        static Configuration *instance;

        /**
         * @return void
         */
        Configuration() {};

    public:
        /**
         * @return Configuration
         */
        static Configuration &getInstance()
        {
            static Configuration instance;
            return instance;
        }

        /**
         * @param std::string
         */
        void setConfigFile(std::string filePath);

        /**
         * @param std::string key
         * @param std::string value
         */
        void put(std::string key, std::string value);

        /**
         * @param std::string key
         * @param std::vector values
         */
        void putArray(std::string key,std::string nodeKey, std::vector<int> values);

        /**
         * @param string key
         * @return int[]
         */
        std::vector<int> getArray(std::string key);

        /**
         * @param std::string
         */
        std::string get(std::string key);

        /**
         * @param bool
         */
        bool exists(std::string key);

        void persist();

        /**
         * Deletig these methods, so we can't accidently make copies of this instance
         */
        Configuration(Configuration const&) = delete;
        void operator=(Configuration const&) = delete;
};


#endif //DROP_X_CONFIGURATION_HPP
