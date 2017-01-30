//
// Created by Jordi Kroon on 10/1/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#ifndef DROP_X_KEYBINDER_BASE_HPP
#define DROP_X_KEYBINDER_BASE_HPP

#include <string>
#include <vector>
#include "keybinder.hpp"

#include <boost/function.hpp>
#include <boost/function_equal.hpp>
#include <iterator>

class BaseKeybinder {
    protected:
        struct Bind {
            std::vector<int> modifierList;
            int key;
            boost::function<void()> callback;
        };

        std::vector<Bind> binds;
    public:
        void addBind(std::vector<int> modifiers, int key, boost::function<void()> callback);
        std::vector<Bind> getBinds();
        void clearBinds();
        virtual void listen(){};
};


#endif //DROP_X_KEYBINDER_BASE_HPP
