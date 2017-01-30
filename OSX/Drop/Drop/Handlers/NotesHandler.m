//
// Created by Jordi Kroon on 11/13/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#import "NotesHandler.h"

@implementation NotesHandler

@synthesize noteWindowController;

- (void)handle
{
    noteWindowController = [[NoteWindowController alloc] initWithWindowNibName:@"NoteWindowController"];
    [noteWindowController showWindow:nil];
    [[noteWindowController window] setLevel:NSFloatingWindowLevel];
    [[noteWindowController window] makeKeyAndOrderFront:self];
}

@end