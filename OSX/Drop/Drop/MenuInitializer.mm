//
// Created by Jordi Kroon on 11/12/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#import "MenuInitializer.h"
#import "HandlerProtocol.h"
#import <Carbon/Carbon.h>
#import "AppDelegate.h"
#import "configuration.hpp"

@implementation MenuInitializer

@synthesize statusItem;
@synthesize currentFrame;
@synthesize animationTimer;

- (instancetype)initWithStatusItem:(NSStatusItem *)aStatusItem
{
    self = [super init];
    if (self)
    {
        statusItem = aStatusItem;
        [statusItem setHighlightMode:YES];
        [statusItem setImage:[NSImage imageNamed:@"MenuIconStill"]];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onConfigurationChanged:)
             name:ConfigurationDidChange object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSpinningShouldStart:)
                                                     name:SpinningShouldStart object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSpinningShouldStop:)
                                                     name:SpinningShouldStop object:nil];
    }

    return self;
}

/**
 * @param notification
 */
- (void)onSpinningShouldStop:(id) notification
{
    [animationTimer invalidate];

    NSImage* image = [NSImage imageNamed:@"MenuIconStill"];
    [statusItem setImage:image];
}

/**
 * @param notification
 */
- (void)onSpinningShouldStart:(id) notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        currentFrame = 1;
        animationTimer = [NSTimer scheduledTimerWithTimeInterval:5.0/30.0 target:self selector:@selector(updateImage:) userInfo:nil repeats:YES];
    });
}

/**
 * @param timer
 */
- (void)updateImage:(NSTimer*)timer
{
    if (currentFrame > 6) {
        currentFrame = 1;
    }

    NSImage* image = [NSImage imageNamed:[NSString stringWithFormat:@"MenuIconSpin%d",currentFrame]];
    [statusItem setImage:image];

    currentFrame++;
}


- (void) buildMenu
{
    NSMenu *menu = [[NSMenu alloc] init];

    [menu addItem: [self getMenuItem:@"Upload drop" handler: @"ScreenshotUpload"]];
    [menu addItem: [self getMenuItem:@"Copy to clipboard" handler: @"ScreenshotClipboard"]];
    [menu addItem: [NSMenuItem separatorItem]];

    [menu addItem: [self getMenuItem:@"Compose note" handler: @"Notes"]];

    /** Static menu items*/
    [menu addItem: [NSMenuItem separatorItem]];
    [menu addItem: [self getMenuItem:@"Preferences" handler: @"Preferences"]];
    [menu addItem: [self getMenuItem:@"Quit Drop" handler: @"Quit"]];

    [statusItem setMenu:menu];

    [self onConfigurationChanged:nil];
}

/**
 * @param NSString title
 * @param NSString * handler
 * @param NSString charCode
 * @param NSEventModifierFlags modifierMask
 * @return NSMenuItem
 */
- (NSMenuItem *)getMenuItem:(NSString *)title handler: (NSString *) handler
{
    id<HandlerProtocol> handlerClass =
        (id <HandlerProtocol>) [[NSClassFromString([NSString stringWithFormat:@"%@%@", handler, @"Handler"]) alloc] init];

    NSMenuItem *menuItem = [[NSMenuItem alloc] init];
    [menuItem setTarget:handlerClass];
    [menuItem setAction:@selector(handle)];
    [menuItem setRepresentedObject:handlerClass];
    [menuItem setTitle:title];
    [menuItem setEnabled:YES];
    return menuItem;
}

- (void) onConfigurationChanged:(NSNotification *) notification
{
    Configuration &configuration = Configuration::getInstance();

    /** Configurable menu items*/
    NSString *uploadKeycode = keyCodeToString(atoi(configuration.get("Drop.Bind.Upload.Key").c_str()));
    NSString *clipboardKeycode = keyCodeToString(atoi(configuration.get("Drop.Bind.Clipboard.Key").c_str()));
    NSString *notesKeycode = keyCodeToString(atoi(configuration.get("Drop.Bind.Notes.Key").c_str()));

    NSArray *uploadKeymodifiers = [self intVectorToArray: configuration.getArray("Drop.Bind.Upload.Modifiers")];
    NSNumber *uploadKeymodifierSum = [uploadKeymodifiers valueForKeyPath: @"@sum.self"];

    NSArray *clipboardKeymodifiers = [self intVectorToArray: configuration.getArray("Drop.Bind.Upload.Modifiers")];
    NSNumber* clipboardKeymodifierSum = [clipboardKeymodifiers valueForKeyPath: @"@sum.self"];

    NSArray *notesKeymodifiers = [self intVectorToArray: configuration.getArray("Drop.Bind.Upload.Modifiers")];
    NSNumber *notesKeymodifierSum = [notesKeymodifiers valueForKeyPath: @"@sum.self"];

    /* Upload */
    NSMenuItem *uploadItem = [[statusItem menu] itemAtIndex: 0];
    [uploadItem setKeyEquivalent:uploadKeycode];
    [uploadItem setKeyEquivalentModifierMask:(NSEventModifierFlags) [uploadKeymodifierSum integerValue]];

    NSMenuItem *clipboardItem = [[statusItem menu] itemAtIndex: 1];
    [clipboardItem setKeyEquivalent:clipboardKeycode];
    [clipboardItem setKeyEquivalentModifierMask:(NSEventModifierFlags) [clipboardKeymodifierSum integerValue]];

    NSMenuItem *notesItem = [[statusItem menu] itemAtIndex: 3];
    [notesItem setKeyEquivalent:notesKeycode];
    [notesItem setKeyEquivalentModifierMask:(NSEventModifierFlags) [notesKeymodifierSum integerValue]];
}

/**
 * http://stackoverflow.com/questions/1918841/how-to-convert-ascii-character-to-cgkeycode/1971027#1971027
 * @param keyCode
 * @return
 */
NSString* keyCodeToString(CGKeyCode keyCode)
{
    TISInputSourceRef currentKeyboard = TISCopyCurrentKeyboardInputSource();
    CFDataRef uchr = (CFDataRef)TISGetInputSourceProperty(currentKeyboard, kTISPropertyUnicodeKeyLayoutData);
    const UCKeyboardLayout *keyboardLayout = (const UCKeyboardLayout*)CFDataGetBytePtr(uchr);

    if (keyboardLayout) {
        UInt32 deadKeyState = 0;
        UniCharCount maxStringLength = 255;
        UniCharCount actualStringLength = 0;
        UniChar unicodeString[maxStringLength];

        OSStatus status = UCKeyTranslate(keyboardLayout,
                                         keyCode, kUCKeyActionDown, 0,
                                         LMGetKbdType(), 0,
                                         &deadKeyState,
                                         maxStringLength,
                                         &actualStringLength, unicodeString);

        if (actualStringLength == 0 && deadKeyState) {
            status = UCKeyTranslate(keyboardLayout,
                                    kVK_Space, kUCKeyActionDown, 0,
                                    LMGetKbdType(), 0,
                                    &deadKeyState,
                                    maxStringLength,
                                    &actualStringLength, unicodeString);
        }

        if (actualStringLength > 0 && status == noErr) {
            return [[NSString stringWithCharacters:unicodeString length:(NSUInteger)actualStringLength] lowercaseString];
        }
    }

    return nil;
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