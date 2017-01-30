//
// Created by Jordi Kroon on 10/1/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#include "keybinder+apple.hpp"
#include "logger.hpp"
#include <AppKit/AppKit.h>
#include <valarray>
#include <iostream>

using namespace std;

void Keybinder::listen()
{
    NSLog(@"Listen called");
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask handler: ^(NSEvent *event) {
        NSUInteger flags = [event modifierFlags] & NSDeviceIndependentModifierFlagsMask;
        for (Bind const& bind: BaseKeybinder::getBinds()) {
            size_t modifierSum = 0;
            for (int i : bind.modifierList) {
                modifierSum += i;
            }

            if (flags == modifierSum && [event keyCode] == bind.key) {
                LOG::write(DEVELOPER, "Did press key"
                        " with modifier " + std::to_string(modifierSum) +
                        " and code " + std::to_string(bind.key));

                bind.callback();
            }
        }
    }];
}
