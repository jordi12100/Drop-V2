//
//  NSConfigurationField.m
//  Drop
//
//  Created by Jordi Kroon on 11/20/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#import "NSConfigurationField.h"

@implementation NSConfigurationField

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(controlTextDidEnd:) name:NSControlTextDidEndEditingNotification object:nil];
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
            selector:@selector(controlTextDidEnd:) name:NSWorkspaceDidDeactivateApplicationNotification object:nil];

        [self setValueFromConfig];
    }

    return self;
}

- (void)controlTextDidEnd:(NSNotification *)notification {
    [self saveConfigFromValue];
}

- (void)setValueFromConfig
{
    Configuration &configuration = Configuration::getInstance();
    if (!configuration.exists([[self identifier] UTF8String])) {
        return;
    }

    NSString *configValue = @(configuration.get([[self identifier] UTF8String]).c_str());
    [self setStringValue:configValue];
}

- (void)saveConfigFromValue
{
    Configuration &configuration = Configuration::getInstance();
    configuration.put([[self identifier] UTF8String], [[self stringValue] UTF8String]);
}

@end
