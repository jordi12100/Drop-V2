//
//  request.cpp
//  drop-x
//
//  Created by Jordi Kroon on 8/14/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#include "request.hpp"

/**
 * @param char* data
 * @param size_t size
 * @param size_t nmemb
 * @param std::string* buffer
 * @return long
 */
static long writeCallback(char *data, size_t size, size_t nmemb, std::string *buffer) {
    long result = 0;
    if (buffer != NULL) {
        buffer->append(data, size * nmemb);
        result = size * nmemb;
    }
    return result;
}

/**
 * @param std::string* url
 * @param Json& jsonData
 * @return Request::ResponseStatus
 */
Request::ResponseStatus Request::sendJson(const string &url, Json &jsonData)
{
    string jsonString = jsonData.dump();
    CURL *curl = Request::getCurl(url.c_str());
    curl_easy_setopt(curl, CURLOPT_POSTFIELDS, jsonString.c_str());
    curl_easy_setopt(curl, CURLOPT_POST, 1L);
    return Request::performCurlRequest(curl);
}

/**
 * @param std::string* url
 * @param File* jsonData
 * @return Request::ResponseStatus
 */
Request::ResponseStatus Request::sendFile(const string &url, const string &name, File *file)
{
    struct curl_httppost *formPost = NULL;
    struct curl_httppost *lastPointer = NULL;

    curl_global_init(CURL_GLOBAL_ALL);

    curl_formadd(
        &formPost,
        &lastPointer,
        CURLFORM_COPYNAME, name.c_str(),
        CURLFORM_FILE, file->getFilePath().c_str(),
        CURLFORM_END
    );

    CURL *curl = Request::getCurl(url.c_str());
    curl_easy_setopt(curl, CURLOPT_HTTPPOST, formPost);

    return Request::performCurlRequest(curl);
}

/**
 * @param std::string* url
 * @return CURL*
 */
CURL *Request::getCurl(const string &url)
{
    struct curl_slist *headers = NULL;
    curl_slist_append(headers, "Accept: application/json");
    curl_slist_append(headers, "Content-Type: application/json");
    curl_slist_append(headers, "charsets: utf-8");

    CURL *curl = curl_easy_init();
    curl_easy_setopt(curl, CURLOPT_USERAGENT, "Drop-X");
    curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeCallback);
    curl_easy_setopt(curl, CURLOPT_URL, url.c_str());

    return curl;
}

/**
 * @param CURL* curl
 * @return Request::ResponseStatus
 */
Request::ResponseStatus Request::performCurlRequest(CURL *curl)
{
    CURLcode res;
    long http_code = 0;
    std::string response;
    std::string jsonParseError;

    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response);

    res = curl_easy_perform(curl);
    curl_easy_getinfo (curl, CURLINFO_RESPONSE_CODE, &http_code);

    if (res != CURLE_OK || floor(http_code/100) != 2) {
        string curlError = curl_easy_strerror(res);
        if (!curlError.empty()) {
            jsonResponse = Json::parse(response, jsonParseError);
            LOG::write(WARN, "Curl request failed \n" + response);
            return FAIL;
        }

        LOG::write(ERROR, "Curl request error \n" + curlError);
        lastErrror = curlError;
        return SERVERERROR;
    }

    curl_easy_cleanup(curl);

    LOG::write(INFO, "Curl response received");

    jsonResponse = Json::parse(response, jsonParseError);
    return SUCCESS;
}

/**
 * @return std::string
 */
string Request::getLastError()
{
    return lastErrror;
}

/**
 * @return JSON
 */
Json Request::getJsonResponse()
{
    return jsonResponse;
}