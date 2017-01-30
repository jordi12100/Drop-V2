//
//  WindowView.m
//  Drop
//
//  Created by Jordi Kroon on 1/17/17.
//  Copyright © 2017 Jordi Kroon. All rights reserved.
//

#import "WindowView.h"

@implementation WindowView

@synthesize mouseInside;
@synthesize minitButton, closeButton, fullScreenButton;

/**
 * @param aDecoder
 * @return self
 */
- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.minitButton = [NSWindow standardWindowButton:NSWindowMiniaturizeButton forStyleMask:self.window.styleMask];

        self.closeButton = [NSWindow standardWindowButton:NSWindowCloseButton forStyleMask:self.window.styleMask];
        self.closeButton.action = @selector(performCloseWindow:);
        self.closeButton.target = self;
        
        self.fullScreenButton = [NSWindow standardWindowButton:NSWindowZoomButton forStyleMask:self.window.styleMask];
        self.fullScreenButton.target = self;
        self.fullScreenButton.action = @selector(performZoomWindow:);
    }
    
    return self;
}

/**
 * @param dirtyRect
 */
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [self.closeButton setFrame:CGRectMake(7+8, self.window.frame.size.height - 30, closeButton.frame.size.width, closeButton.frame.size.height)];
    [self.minitButton setFrame:CGRectMake(27+8, self.window.frame.size.height - 30, minitButton.frame.size.width, minitButton.frame.size.height)];
    [self.fullScreenButton setFrame:CGRectMake(47+8, self.window.frame.size.height - 30, fullScreenButton.frame.size.width, fullScreenButton.frame.size.height)];
    [self.minitButton setEnabled:NO];
    
    [self addSubview:self.closeButton];
    [self addSubview:self.fullScreenButton];
    [self addSubview:self.minitButton];
}

- (void)updateTrackingAreas
{
    NSTrackingArea *const trackingArea = [
        [NSTrackingArea alloc]
        initWithRect:CGRectMake(15, self.window.frame.size.height - 30, 55, closeButton.frame.size.height)
        options:(NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways) owner:self userInfo:nil
    ];
    [self addTrackingArea:trackingArea];
}

/**
 * @param performZoomWindow
 */
- (void)performZoomWindow:(id)performZoomWindow
{
    [self.window zoom:nil];
}

/**
 * @param performCloseWindow
 */
- (void)performCloseWindow:(id)performCloseWindow
{
    [self.window close];
}

/**
 * @param event
 */
- (void)mouseEntered:(NSEvent *)event
{
    [super mouseEntered:event];
    self.mouseInside = YES;
    [self setNeedsDisplayForStandardWindowButtons];
}

/**
 * @param event
 */
- (void)mouseExited:(NSEvent *)event
{
    [super mouseExited:event];
    self.mouseInside = NO;
    [self setNeedsDisplayForStandardWindowButtons];
}

/**
 * @param button
 * @return BOOL
 */
- (BOOL)_mouseInGroup:(NSButton *)button
{
    return self.mouseInside;
}

- (void)setNeedsDisplayForStandardWindowButtons
{
    [self.closeButton setNeedsDisplay];
    [self.fullScreenButton setNeedsDisplay];
}

@end
