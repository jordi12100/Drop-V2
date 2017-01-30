//
// Created by Jordi Kroon on 10/2/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#ifndef BOOST_SYSTEM_NO_DEPRECATED
#define BOOST_SYSTEM_NO_DEPRECATED 1
#endif

#ifndef DROP_X_SCREENSHOT_HPP
#define DROP_X_SCREENSHOT_HPP

#if __linux__
    // TODO
#elif __APPLE__
    #include "screenshot+apple.hpp"
#elif _WIN32
    // TODO
#endif

#endif //DROP_X_SCREENSHOT_HPP
