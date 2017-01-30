#import "AppleUserNotificationManager.h"

@implementation AppleUserNotificationManager

@synthesize userNotification;

- (id)init
{
    self = [super init];

    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate: self];
    userNotification = [[NSUserNotification alloc] init];

    return self;
}

/**
 *  @param NSUserNotificationCenter center
 *  @param NSUserNotification notification
 *
 *  @return bool
 */
- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification{
    return YES;
}

/**
 *  @param NSUserNotificationCenter center
 *  @param NSUserNotification notification
 */
- (void) userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification
{
    NSLog(@"On click");
    NSString *notificationText = [notification informativeText];
    NSString *urlRegEx = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";

    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    if ([urlTest evaluateWithObject:notificationText]) {
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:notificationText]];
    }
}

/**
 * @param NSString title
 * @param NSString message
 */
- (void)sendWithTitle:(NSString *)title andMessage:(NSString *)message
{
    [self sendWithTitle:title andMessage:message andSound: NSUserNotificationDefaultSoundName];
}

/**
 * @param NSString title
 * @param NSString message
 * @param NSString soundName
 */
- (void)sendWithTitle:(NSString *)title andMessage:(NSString *)message andSound:(NSString *)soundName
{
    userNotification.title = title;
    userNotification.informativeText = message;
    userNotification.soundName = soundName;

    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification: userNotification];
}

@end