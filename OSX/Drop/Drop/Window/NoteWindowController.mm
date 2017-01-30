//
//  NoteWindowController.m
//  Drop
//
//  Created by Jordi Kroon on 1/8/17.
//  Copyright © 2017 Jordi Kroon. All rights reserved.
//

#import "NoteWindowController.h"
#import "notification.hpp"
#import "clipboard.hpp"
#import "gist.hpp"
#import "notificationManager.hpp"
#import "configuration.hpp"

@interface NoteWindowController ()

@end

@implementation NoteWindowController

@synthesize syntaxHighlightedView;
@synthesize topHeader;
@synthesize gutterTopHeader;
@synthesize fileName;

NSDictionary *languageMap = @{
    @"bash": @{
        @"extension" : @"sh",
        @"syntaxName" : @"Shell"
    },
    @"cpp": @{
        @"extension" : @"cpp",
        @"syntaxName" : @"C++"
    },
    @"cs": @{
        @"extension" : @"cs",
        @"syntaxName" : @"C#"
    },
    @"css": @{
        @"extension" : @"css",
        @"syntaxName" : @"CSS"
    },
    @"ini": @{
        @"extension" : @"ini",
        @"syntaxName" : @"INI"
    },
    @"java": @{
        @"extension" : @"java",
        @"syntaxName" : @"Java"
    },
    @"javascript": @{
        @"extension" : @"js",
        @"syntaxName" : @"JavaScript"
    },
    @"json": @{
        @"extension" : @"json",
        @"syntaxName" : @"JavaScript"
    },
    @"markdown": @{
        @"extension" : @"md",
        @"syntaxName" : @"Markdown"
    },
    @"objectivec": @{
        @"extension" : @"mm",
        @"syntaxName" : @"Objective-C"
    },
    @"perl": @{
        @"extension" : @"pl",
        @"syntaxName" : @"Perl"
    },
    @"php": @{
        @"extension" : @"php",
        @"syntaxName" : @"PHP"
    },
    @"python": @{
        @"extension" : @"py",
        @"syntaxName" : @"Python"
    },
    @"ruby": @{
        @"extension" : @"rb",
        @"syntaxName" : @"Ruby"
    },
    @"sql": @{
        @"extension" : @"sql",
        @"syntaxName" : @"SQL"
    },
    @"xml": @{
        @"extension" : @"sql",
        @"syntaxName" : @"XML"
    },
    @"yaml": @{
        @"extension" : @"yml",
        @"syntaxName" : @"YAML"
    }
};

- (void)windowDidLoad
{
    [super windowDidLoad];
    [self assertTokenNotEmpty];

    self.fileName.focusRingType = NSFocusRingTypeNone;
    self.fileName.cell.focusRingType = NSFocusRingTypeNone;
    
    self.window.backgroundColor = [NSColor colorWithRed:0.19 green:0.20 blue:0.21 alpha:1.00];

    [self.window makeKeyWindow];
    [self.window becomeKeyWindow];
    [self.window setIsVisible:YES];
    
    [self.window setStyleMask:NSClosableWindowMask|NSResizableWindowMask|NSBorderlessWindowMask];
    [self.window setMinSize:NSMakeSize(930, 500)];
    [self.window setMovableByWindowBackground:YES];
    [self initSyntaxHighlight];
}

- (void) initSyntaxHighlight
{
    self.topHeader.layer.backgroundColor = [NSColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.00].CGColor;
    self.gutterTopHeader.layer.backgroundColor = [NSColor colorWithRed:0.19 green:0.20 blue:0.21 alpha:1.00].CGColor;
    
    syntaxHighlightedView.textViewDelegate = self;
    syntaxHighlightedView.textView.textContainerInset = NSMakeSize(5, 0);
    syntaxHighlightedView.syntaxDefinitionName = @"php";
    syntaxHighlightedView.autoCompleteEnabled = YES;
    syntaxHighlightedView.showsLineNumbers = YES;
    syntaxHighlightedView.showsGutter = YES;
    syntaxHighlightedView.showsSyntaxErrors = NO;
    syntaxHighlightedView.coloursCommands = YES;
    syntaxHighlightedView.coloursKeywords = YES;
    syntaxHighlightedView.coloursInstructions = YES;
    syntaxHighlightedView.coloursStrings = YES;
    syntaxHighlightedView.coloursNumbers = YES;
    syntaxHighlightedView.coloursVariables = YES;
    syntaxHighlightedView.coloursComments = YES;
    syntaxHighlightedView.coloursAttributes = YES;
    syntaxHighlightedView.coloursAutocomplete = YES;
    syntaxHighlightedView.hasVerticalScroller = YES;
    syntaxHighlightedView.lineWrap = NO;
    syntaxHighlightedView.showsInvisibleCharacters = NO;
    syntaxHighlightedView.scrollElasticityDisabled = NO;
    syntaxHighlightedView.pageGuideColumn = 140;
    syntaxHighlightedView.showsPageGuide = YES;
    syntaxHighlightedView.highlightsCurrentLine = YES;
    syntaxHighlightedView.indentWithSpaces = YES;
    syntaxHighlightedView.tabWidth = 4;
    
    syntaxHighlightedView.gutterBackgroundColour = [NSColor colorWithRed:0.19 green:0.20 blue:0.21 alpha:1.00];
    syntaxHighlightedView.gutterTextColour = [NSColor colorWithRed:0.38 green:0.39 blue:0.40 alpha:1.00];
    syntaxHighlightedView.colourForCommands = [NSColor colorWithRed:0.80 green:0.47 blue:0.20 alpha:1.00];
    syntaxHighlightedView.colourForKeywords = [NSColor colorWithRed:0.80 green:0.47 blue:0.20 alpha:1.00];
    syntaxHighlightedView.colourForInstructions = [NSColor colorWithRed:0.80 green:0.47 blue:0.20 alpha:1.00];
    syntaxHighlightedView.colourForStrings = [NSColor colorWithRed:0.42 green:0.53 blue:0.35 alpha:1.00];
    syntaxHighlightedView.colourForNumbers = [NSColor colorWithRed:0.41 green:0.59 blue:0.73 alpha:1.00];
    syntaxHighlightedView.colourForVariables = [NSColor colorWithRed:0.60 green:0.46 blue:0.67 alpha:1.00];
    syntaxHighlightedView.colourForComments = [NSColor colorWithRed:0.38 green:0.59 blue:0.33 alpha:1.00];
    syntaxHighlightedView.colourForAttributes = [NSColor colorWithRed:0.66 green:0.72 blue:0.78 alpha:1.00];
    syntaxHighlightedView.colourForAutocomplete = [NSColor colorWithRed:0.80 green:0.47 blue:0.20 alpha:1.00];
    syntaxHighlightedView.currentLineHighlightColour = [NSColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.00];
    syntaxHighlightedView.insertionPointColor = [NSColor colorWithRed:0.66 green:0.72 blue:0.78 alpha:1.00];
    syntaxHighlightedView.textColor = [NSColor colorWithRed:0.66 green:0.72 blue:0.78 alpha:1.00];
    syntaxHighlightedView.backgroundColor = [NSColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.00];
    syntaxHighlightedView.layer.backgroundColor = [NSColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.00].CGColor;
}

/**
 * @param text
 * @return NSString
 */
- (NSString *) getLanguageForText: (NSString *) text
{
    NSString *javascriptFile = [NSString stringWithFormat:@"%@/Contents/Misc/HighlightJs/highlight.js", [[NSBundle mainBundle] bundlePath]];

    JSContext *jsContext  = [[JSContext alloc] init];
    [jsContext evaluateScript:[NSString stringWithContentsOfFile:javascriptFile encoding:NSUTF8StringEncoding error:nil]];
    JSValue *result = [jsContext[@"languageForText"] callWithArguments:@[text]];

    return [result toString];
}

/**
 * @param notification
 */
-(void)textDidChange:(NSNotification *)notification
{
    NSString *textViewText = [[syntaxHighlightedView textView] string];
    NSDictionary *languageData = languageMap[[self getLanguageForText:textViewText]];
    syntaxHighlightedView.syntaxDefinitionName = languageData ? languageData[@"syntaxName"] : nil;
}

- (IBAction)onUploadNotePressed:(id)sender {
    Configuration &configuration = Configuration::getInstance();
    NSDictionary *languageData = languageMap[[self getLanguageForText:[[syntaxHighlightedView textView] string]]];
    NSString *fileExtension = languageData ? languageData[@"extension"] : @"txt";
    NSString *gistTitle = [NSString stringWithFormat:@"file.%@", fileExtension];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:SpinningShouldStart object:nil];

        Gist *gist = new Gist(configuration.get("Drop.Gist.Token"));
        gist->setMessage([[[syntaxHighlightedView textView] string] UTF8String]);
        gist->setTitle([gistTitle UTF8String]);

        Notification *notification = new Notification;
        if (gist->upload()) {
            Clipboard *clipboard = new Clipboard;
            clipboard->setText(gist->getResponse());
            notification->setTitle("Note uploaded");
        } else {
            notification->setTitle("Note upload failed");
        }

        notification->setMessage(gist->getResponse());

        NotificationManager *notificationManager = new NotificationManager;
        notificationManager->send(notification);

        [[NSNotificationCenter defaultCenter] postNotificationName:SpinningShouldStop object:nil];
    });

    [self close];
}

/**
 * @return BOOL
 */
- (BOOL) assertTokenNotEmpty
{
    Configuration &configuration = Configuration::getInstance();
    if (!configuration.get("Drop.Gist.Token").empty()) {
        return YES;
    }

    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"A valid Gist token is required to upload the notes. Would you like to obtain a token?"];
    [alert addButtonWithTitle:@"Bring me to github.com"];
    [alert addButtonWithTitle:@"Set up later"];

    [alert beginSheetModalForWindow:self.window completionHandler:^(NSModalResponse returnCode) {

        if (returnCode == 1000) {
            NSLog(@"%li", returnCode);
            [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/settings/tokens"]];
        }

        [self.window close];
    }];

    return NO;
}

@end
