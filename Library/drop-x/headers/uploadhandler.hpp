//
// Created by Jordi Kroon on 10/30/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#ifndef DROP_X_UPLOADHANDLER_HPP
#define DROP_X_UPLOADHANDLER_HPP

#include <string>
#include "file.hpp"
#include "vendor/json11/json11.hpp"

class UploadHandler {
    public:
        bool uploadFile(const string &url, File *file);
        string getPublicPath();

    private:
        string publicPath;
};


#endif //DROP_X_UPLOADHANDLER_HPP
