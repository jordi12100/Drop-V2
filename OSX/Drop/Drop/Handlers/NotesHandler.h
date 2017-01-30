//
// Created by Jordi Kroon on 11/13/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HandlerProtocol.h"
#import "../Window/NoteWindowController.h"

@interface NotesHandler : NSObject<HandlerProtocol>

@property (strong, nonatomic) NoteWindowController *noteWindowController;

- (void)handle;
@end