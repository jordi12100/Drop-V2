//
//  DropApplication.m
//  Drop
//
//  Created by Jordi Kroon on 11/20/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#import "DropApplication.h"

@implementation DropApplication

- (void)sendEvent:(NSEvent *)event
{
    if (event.type == NSKeyDown)
    {
        NSString *inputKey = [event.charactersIgnoringModifiers lowercaseString];
        if ((event.modifierFlags & NSDeviceIndependentModifierFlagsMask) == NSCommandKeyMask ||
            (event.modifierFlags & NSDeviceIndependentModifierFlagsMask) == (NSCommandKeyMask | NSAlphaShiftKeyMask))
        {
            if ([inputKey isEqualToString:@"x"])
            {
                if ([self sendAction:@selector(cut:) to:nil from:self])
                    return;
            }
            else if ([inputKey isEqualToString:@"c"])
            {
                if ([self sendAction:@selector(copy:) to:nil from:self])
                    return;
            }
            else if ([inputKey isEqualToString:@"v"])
            {
                if ([self sendAction:@selector(paste:) to:nil from:self])
                    return;
            }
            else if ([inputKey isEqualToString:@"z"])
            {
                if ([self sendAction:NSSelectorFromString(@"undo:") to:nil from:self])
                    return;
            }
            else if ([inputKey isEqualToString:@"a"])
            {
                if ([self sendAction:@selector(selectAll:) to:nil from:self])
                    return;
            }
            else if ([inputKey isEqualToString:@"s"])
            {
                if ([self sendAction:@selector(save:) to:nil from:self])
                    return;
            }
        }
        else if ((event.modifierFlags & NSDeviceIndependentModifierFlagsMask) == (NSCommandKeyMask | NSShiftKeyMask) ||
                 (event.modifierFlags & NSDeviceIndependentModifierFlagsMask) == (NSCommandKeyMask | NSShiftKeyMask | NSAlphaShiftKeyMask))
        {
            if ([inputKey isEqualToString:@"z"])
            {
                if ([self sendAction:NSSelectorFromString(@"redo:") to:nil from:self])
                    return;
            }
        }
    }
    [super sendEvent:event];
}
@end
