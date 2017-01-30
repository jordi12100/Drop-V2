//
//  request.hpp
//  drop-x
//
//  Created by Jordi Kroon on 8/14/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#ifndef request_hpp
#define request_hpp

#include <fstream>
#include <iostream>
#include<stdlib.h>
#include <stdio.h>

#ifdef __cplusplus
    #include <string>
    #include <curl/curl.h>
    #include <math.h>
    #include "logger.hpp"
    #include "vendor/json11/json11.hpp"
    #include "file.hpp"
    #include <sys/stat.h>
    #include <fcntl.h>
#endif

using namespace std;
using namespace json11;

class Request
{
    public:
        enum ResponseStatus {
            SUCCESS,
            FAIL,
            SERVERERROR
        };
        ResponseStatus sendJson(const string &url, Json &jsonData);
        string getLastError();
        Json getJsonResponse();
        ResponseStatus sendFile(const string &url, const string &name, File *file);

    private:
        string lastErrror;
        Json jsonResponse;
        CURL *getCurl(const string &url);
        ResponseStatus performCurlRequest(CURL *curl);
};

#endif /* request_hpp */
