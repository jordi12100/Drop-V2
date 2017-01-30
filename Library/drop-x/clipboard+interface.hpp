//
//  clipboard+interface.hpp
//  drop-x
//
//  Created by Jordi Kroon on 8/21/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#ifndef clipboard_interface_h
#define clipboard_interface_h

#include <stdio.h>
#include <string>

class ClipboardInterface {
    
public:
    /**
     * @param std::string
     * @return void
     */
    virtual void setText(std::string text){};
    
    /**
     * @param std::string
     * @return void
     */
    virtual void setImageFromPath(std::string path){};
    
    /**
     * @return void
     */
    virtual void clear(){};
};

#endif /* clipboard_interface_h */
