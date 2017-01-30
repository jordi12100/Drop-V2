//
//  gist.cpp
//  drop-x
//
//  Created by Jordi Kroon on 8/13/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#include "gist.hpp"

using namespace json11;

const string Gist::GIST_API_URL = "https://api.github.com/gists";

/**
 * @param string
 */
Gist::Gist(const string &apiKey)
{
    Gist::apiKey = apiKey;
}

/**
 * @param string title
 */
void Gist::setTitle(const string &title)
{
    Gist::title = title;
}

/**
 * @return string
 */
string Gist::getTitle()
{
    return Gist::title;
}

/**
 * @param string message
 */
void Gist::setMessage(const string &message)
{
    Gist::message = message;
}

/**
 * @return string
 */
string Gist::getMessage()
{
    return Gist::message;
}

/**
 * @return string
 */
string Gist::getResponse()
{
    return Gist::lastResponse;
}

/**
 * @return string
 */
bool Gist::upload()
{
    string uploadTarget = Gist::GIST_API_URL + "?access_token=" + Gist::apiKey;
    Json gistData = Json::object {
        {
            "description", Gist::getTitle()
        },
        {
            "public", false
        },
        {
            "files", Json::object {
                {
                    Gist::getTitle(), Json::object {
                        { "content", Gist::getMessage() }
                    }
                }
            }
        },
    };
    
    string jsonData = gistData.dump();
    LOG::write(DEVELOPER, "Uploading gist file to api: " + uploadTarget + "\n" + gistData.dump());

    Request *request = new Request;
    Request::ResponseStatus responseStatus = request->sendJson(uploadTarget, gistData);
    if (responseStatus == Request::SERVERERROR) {
        lastResponse = request->getLastError();
        return false;
    }
    
    Json response = request->getJsonResponse();
    if (responseStatus == Request::FAIL) {
        lastResponse = response["message"].string_value();
        return false;
    }

    lastResponse = response["html_url"].string_value();
    return true;
}