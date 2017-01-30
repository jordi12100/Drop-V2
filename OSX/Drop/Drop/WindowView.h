//
//  WindowView.h
//  Drop
//
//  Created by Jordi Kroon on 1/17/17.
//  Copyright © 2017 Jordi Kroon. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface WindowView : NSView

@property (nonatomic, assign) BOOL mouseInside;
@property (nonatomic, strong) NSButton *minitButton;
@property (nonatomic, strong) NSButton *closeButton;
@property (nonatomic, strong) NSButton *fullScreenButton;
@end
