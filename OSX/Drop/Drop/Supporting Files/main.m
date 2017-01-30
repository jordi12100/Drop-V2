//
//  main.m
//  Drop
//
//  Created by Jordi Kroon on 10/9/16.
//  Copyright (c) 2016 Jordi Kroon. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "../Extension/DropApplication.h"
#import "../AppDelegate.h"

int main(int argc, const char * argv[]) {
    NSArray *topLevelObjects;
    NSApplication *application = [DropApplication sharedApplication];
    [[NSBundle mainBundle] loadNibNamed:@"MainMenu" owner:application topLevelObjects:&topLevelObjects];
    
    AppDelegate *applicationDelegate = [[AppDelegate alloc] init];
    [application setDelegate:applicationDelegate];
    [application run];
    
    return 0;
}
