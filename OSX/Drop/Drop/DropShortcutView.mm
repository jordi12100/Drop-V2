//
//  DropShortcutView.m
//  Drop
//
//  Created by Jordi Kroon on 11/20/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#import "DropShortcutView.h"
#import "AppDelegate.h"

static const CGFloat MASHintButtonWidth = 23;

@interface DropShortcutView()
    @property (nonatomic, assign) BOOL showsDeleteButton;
@end

@implementation DropShortcutView

/**
 * @param coder
 * @return instancetype
 */
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.showsDeleteButton = NO;

        __weak id weakSelf = self;
        self.shortcutValueChange = ^(MASShortcutView *shortcutView) {
            [weakSelf onShortcutChange: [weakSelf shortcutValue]];
        };

        [self setValueFromConfig];
    }
    return self;
}

/**
 * @param shortcutRectRef
 * @param hintRectRef
 */
- (void)getShortcutRect:(CGRect *)shortcutRectRef hintRect:(CGRect *)hintRectRef
{
    CGFloat hintButtonWidth = self.shortcutValue == nil || self.recording ? MASHintButtonWidth : 0;

    CGRect shortcutRect, hintRect;
    CGRectDivide(self.bounds, &hintRect, &shortcutRect, hintButtonWidth, CGRectMaxXEdge);
    if (shortcutRectRef) {
        *shortcutRectRef = shortcutRect;
    }

    if (hintRectRef) {
        *hintRectRef = hintRect;
    }
}

/**
 * @param shortcut
 */
- (void)onShortcutChange: (MASShortcut *) shortcut
{
    std::string configPrefix = [[self identifier] UTF8String];
    Configuration &configuration = Configuration::getInstance();

    std::vector<int> configBind;
    if (shortcut.modifierFlags & NSControlKeyMask) {
        configBind.push_back(NSControlKeyMask);
    }

    if (shortcut.modifierFlags & NSAlternateKeyMask) {
        configBind.push_back(NSAlternateKeyMask);
    }

    if (shortcut.modifierFlags & NSShiftKeyMask) {
        configBind.push_back(NSShiftKeyMask);
    }

    if (shortcut.modifierFlags & NSCommandKeyMask) {
        configBind.push_back(NSCommandKeyMask);
    }

    configuration.put(configPrefix + ".Key", [[@([shortcut keyCode]) stringValue] UTF8String]);
    configuration.putArray(configPrefix + ".Modifiers", "Modifier", configBind);

    [[NSNotificationCenter defaultCenter] postNotificationName:ConfigurationDidChange object:nil];
}

- (void)setValueFromConfig
{
    if (![self identifier]) {
        return;
    }

    std::string configPrefix = [[self identifier] UTF8String];
    Configuration &configuration = Configuration::getInstance();

    if (!configuration.exists(configPrefix + ".Key") || !configuration.exists(configPrefix + ".Modifiers")) {
        return;
    }

    NSArray *modifiers = [self intVectorToArray: configuration.getArray(configPrefix + ".Modifiers")];
    NSNumber* sum = [modifiers valueForKeyPath: @"@sum.self"];
    NSUInteger keycode = (NSUInteger) stoi(Configuration::getInstance().get(configPrefix + ".Key"));
    MASShortcut *shortcut = [[MASShortcut alloc] initWithKeyCode:keycode modifierFlags:[sum unsignedIntegerValue]];
    [self setShortcutValue:shortcut];
}

/**
 * @param vector<int>
 * @return NSArray *
 */
- (NSArray *) intVectorToArray: (std::vector<int>) vector
{
    id intArray = [NSMutableArray new];

    for (int integerValue : vector) {
        [intArray addObject:@(integerValue)];
    }

    return intArray;
}
@end


