//
//  clipboard+apple.hpp
//  drop-x
//
//  Created by Jordi Kroon on 8/21/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#ifndef screenshot_apple_hpp
#define screenshot_apple_hpp

#include "file.hpp"
#include "screenshot+base.hpp"
#include <boost/function.hpp>
#include <boost/function_equal.hpp>
#include <boost/filesystem.hpp>

#if defined(__cplusplus) && !defined(__drop)
    #include <Foundation/Foundation.h>
    #include <AppKit/AppKit.h>
#endif

class Screenshot : public BaseScreenshot
{
    public:
        bool capture(boost::function<void(BaseScreenshot *)> callback);
};

#endif
