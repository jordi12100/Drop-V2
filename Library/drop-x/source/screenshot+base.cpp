//
// Created by Jordi Kroon on 10/1/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#include <iostream>
#include "screenshot+base.hpp"

/**
 * @param std::string outputFolder
 */
void BaseScreenshot::setOutputFolder(std::string outputFolder) {
    BaseScreenshot::outputFolder = outputFolder;
}

/**
 * @return std::string
 */
std::string BaseScreenshot::getOutputFolder() {
    return BaseScreenshot::outputFolder;
}

/**
 * @param std::string imageName
 */
void BaseScreenshot::setImageName(std::string imageName) {
    BaseScreenshot::imageName = imageName;
}

/**
 * @return std::string
 */
std::string BaseScreenshot::getImageName() {
    return imageName;
}

/**
 * @param std::string imageType
 */
void BaseScreenshot::setImageType(std::string imageType) {
    BaseScreenshot::imageType = imageType;
}

/**
 * @return std::string
 */
std::string BaseScreenshot::getImageType() {
    return BaseScreenshot::imageType;
}

/**
 * @return std::string
 */
std::string BaseScreenshot::getFilePath() {
    return BaseScreenshot::getOutputFolder() + '/' + BaseScreenshot::getImageName();
}

/**
 * @return File
 */
File *BaseScreenshot::getScreenshot() {
    return screenshot;
}

/**
 * @param File *screenshot
 */
void BaseScreenshot::setScreenshot(File *screenshot) {
    BaseScreenshot::screenshot = screenshot;
}
