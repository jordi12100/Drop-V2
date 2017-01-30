//
// Created by Jordi Kroon on 10/1/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#include "keybinder.hpp"

/**
 * @param string title
 */
void BaseKeybinder::addBind(std::vector<int> modifiers, int key, boost::function<void()> callback)
{
    Bind bind = (Bind){modifiers, key, callback};
    BaseKeybinder::binds.push_back(bind);
}

/**
 * @return string
 */
std::vector<BaseKeybinder::Bind> BaseKeybinder::getBinds()
{
    return BaseKeybinder::binds;
}

void BaseKeybinder::clearBinds()
{
    BaseKeybinder::binds.clear();
}