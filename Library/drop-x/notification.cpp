//
// Created by Jordi Kroon on 8/29/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#include "notification.hpp"

/**
 * @param string title
 */
void Notification::setTitle(const string &title)
{
    Notification::title = title;
}

/**
 * @return string
 */
string Notification::getTitle()
{
    return Notification::title;
}

/**
 * @param string message
 */
void Notification::setMessage(const string &message)
{
    Notification::message = message;
}

/**
 * @return string
 */
string Notification::getMessage()
{
    return Notification::message;
}

/**
 * @param string soundName
 */
void Notification::setSoundName(const string &soundName)
{
    Notification::soundName = soundName;
}

string Notification::getSoundName() {
    return Notification::soundName;
}
