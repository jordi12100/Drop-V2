//
// Created by Jordi Kroon on 10/2/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#ifndef DROP_X_FILE_HPP
#define DROP_X_FILE_HPP

#include <string>

using namespace std;

class File {
    private:
        std::string folderPath;
        std::string fileName;
        std::string fileExtension;
        int fileSize;
    public:
        void setFolderPath(const string &folderPath);
        void setFileName(const string &fileName);
        void setFileExtension(const string &fileExtension);
        void setFileSize(const int &fileSize);

        string getFolderPath();
        string getFileName();
        string getFileExtension();
        string getFilePath();
        int getFileSize();
};


#endif //DROP_X_FILE_HPP
