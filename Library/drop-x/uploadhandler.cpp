//
// Created by Jordi Kroon on 10/30/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#include "uploadhandler.hpp"
#include "request.hpp"

/**
 * @var std::string
 */
const string POST_FILE_NAME = "file";

/**
 * @var std::string
 */
const string RESPONSE_JSON_URL = "url";

/**
 * @param const string &url
 * @param File *file
 * @return bool
 */
bool UploadHandler::uploadFile(const string &url, File *file) {

    Request *request = new Request;
    Request::ResponseStatus responseStatus = request->sendFile(url, POST_FILE_NAME, file);

    if (responseStatus == Request::SUCCESS) {
        Json response = request->getJsonResponse();
        UploadHandler::publicPath = response[RESPONSE_JSON_URL].string_value();
    }

    return responseStatus == Request::SUCCESS;
}

/**
 * @return std::string
 */
string UploadHandler::getPublicPath() {
    return publicPath;
}
