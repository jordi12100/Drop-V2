//
//  logger.hpp
//  drop-x
//
//  Created by Jordi Kroon on 8/14/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#ifndef LOG_H
#define LOG_H

using namespace std;

enum typelog {
    DEVELOPER,
    INFO,
    WARN,
    ERROR
};

class LOG {
    private:
        static inline string getLabel(typelog type) {
            string label;
            switch(type) {
                case DEVELOPER: label = "DEVELOPER"; break;
                case INFO: label = "INFO "; break;
                case WARN: label = "WARN "; break;
                case ERROR: label = "ERROR"; break;
            }
            return label;
        }
    public:
        static inline void write(typelog type, string msg) {
            fprintf(stdout, "[C++][%s][%s][%s:%d] \n %s \n", __TIME__, LOG::getLabel(type).c_str(), __FILE__, __LINE__, msg.c_str());
        }
};

#endif