//
//  gist.cpp
//  drop-x
//
//  Created by Jordi Kroon on 8/13/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#include "file.hpp"

/**
 * @param std::string folderPath
 */
void File::setFolderPath(const string &folderPath) {
    File::folderPath = folderPath;
}

/**
 * @return std::string
 */
string File::getFolderPath() {
    return File::folderPath;
}

/**
 * @param std::string folderPath
 */
void File::setFileName(const string &fileName) {
    File::fileName = fileName;
}

/**
 * @return std::string
 */
string File::getFileName() {
    return File::fileName;
}

/**
 * @param std::string folderPath
 */
void File::setFileExtension(const string &fileExtension) {
    File::fileExtension = fileExtension;
}

/**
 * @return std::string
 */
string File::getFileExtension() {
    return File::fileExtension;
}

/**
 * @param int fileSize
 */
void File::setFileSize(const int &fileSize) {
    File::fileSize = fileSize;
}

/**
 * @return int
 */
int File::getFileSize() {
    return File::fileSize;
}

string File::getFilePath() {
    return File::folderPath + "/" + File::fileName;
}
