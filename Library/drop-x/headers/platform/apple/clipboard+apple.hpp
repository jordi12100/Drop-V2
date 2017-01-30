//
//  clipboard+apple.hpp
//  drop-x
//
//  Created by Jordi Kroon on 8/21/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#ifndef clipboard_apple_hpp
#define clipboard_apple_hpp

#include <stdio.h>
#include <string>
#include "clipboard+interface.hpp"
#include <sstream>
#include <cassert>
#include <vector>
#include <map>
#include "logger.hpp"

// Obj-C Frameworks
#import <AppKit/NSPasteboard.h>
#import <AppKit/NSBitmapImageRep.h>
#import <Foundation/NSData.h>

class Clipboard : public ClipboardInterface
{
    public:
        /**
         * @param std::string
         * @return void
         */
        void setText(std::string text);

        /**
         * @param std::string
         * @return void
         */
        void setImageFromPath(std::string path);

        /**
         * @return void
         */
        void clear();
};

#endif
