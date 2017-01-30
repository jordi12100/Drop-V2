//
//  gist.hpp
//  drop-x
//
//  Created by Jordi Kroon on 8/13/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#ifndef gist_hpp
#define gist_hpp

#ifdef __cplusplus
    #include <stdio.h>
    #include <string>
    #include "logger.hpp"
    #include "vendor/json11/json11.hpp"
    #include "request.hpp"
#endif

using namespace std;

class Gist
{
    private:
        static const string GIST_API_URL;
    
        string apiKey;
        string title;
        string message;
        string lastResponse;
    
    public:
        Gist(const string &apiKey);
    
        void setTitle(const string &title);
        void setMessage(const string &message);
    
        string getTitle();
        string getMessage();
    
        bool upload();
        string getResponse();
};

#endif /* gist_hpp */
