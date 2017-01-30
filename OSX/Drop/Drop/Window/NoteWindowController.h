//
//  NoteWindowController.h
//  Drop
//
//  Created by Jordi Kroon on 1/8/17.
//  Copyright © 2017 Jordi Kroon. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Fragaria/Fragaria.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "../AppDelegate.h"

@interface NoteWindowController : NSWindowController <MGSFragariaTextViewDelegate, MGSDragOperationDelegate>
@property (strong, nonatomic) IBOutlet MGSFragariaView *syntaxHighlightedView;
@property (weak) IBOutlet NSView *topHeader;
@property (weak) IBOutlet NSTextField *fileName;
@property (weak) IBOutlet NSView *gutterTopHeader;


@end
