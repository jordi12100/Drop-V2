//
//  clipboard.hpp
//  drop-x
//
//  Created by Jordi Kroon on 8/21/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#ifndef clipboard_hpp
#define clipboard_hpp

#if __linux__
// TODO
#elif __APPLE__
#include "clipboard+apple.hpp"
#elif _WIN32
// TODO
#endif

#endif /* clipboard_hpp */
