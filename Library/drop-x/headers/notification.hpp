//
// Created by Jordi Kroon on 8/29/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#ifndef DROP_X_NOTIFICATION_HPP
#define DROP_X_NOTIFICATION_HPP

#ifdef __cplusplus
    #include <string>
#endif

using namespace std;

class Notification
{
    private:
        /**
         * @var std::string
         */
        string title;

        /**
         * @var std::string
         */
        string message;

        /**
         * @var std::string
         */
        string soundName;

    public:
        /**
         * @param std::string title
         */
        void setTitle(const string &title);

        /**
         * @param std::string title
         */
        void setMessage(const string &message);

        /**
         * @param std::string title
         */
        void setSoundName(const string &soundName);

        /**
         * @return std::string
         */
        string getTitle();

        /**
         * @return std::string
         */
        string getMessage();

        /**
         * @return string
         */
        string getSoundName();
};

#endif //DROP_X_NOTIFICATION_HPP
