//
//  clipboard.cpp
//  drop-x
//
//  Created by Jordi Kroon on 8/21/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#include "clipboard+apple.hpp"

/**
 * @param std::string
 * @return void
 */
void Clipboard::setText(std::string text)
{
    LOG::write(INFO, "Writing text to clipboard: " + text);

    NSString *content = [NSString stringWithUTF8String:text.c_str()];
    [[NSPasteboard generalPasteboard] clearContents];
    [[NSPasteboard generalPasteboard] setString:content forType:NSPasteboardTypeString];
}

/**
 * @param std::string
 * @return void
 */
void Clipboard::setImageFromPath(std::string path)
{
    LOG::write(INFO, "Writing image to clipboard from path: " + path);

    NSString *filePath = [NSString stringWithUTF8String: path.c_str()];
    NSData *imageData = [[NSData alloc] initWithContentsOfFile:filePath];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];

    NSData *fileData = [imageRep representationUsingType: NSPNGFileType properties: @{}];

    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];
    [pasteboard writeFileContents: filePath];

    [pasteboard setData: fileData forType: NSPasteboardTypePNG];
}

/**
 * @return void
 */
void Clipboard::clear()
{
    [[NSPasteboard generalPasteboard] clearContents];
    [[NSPasteboard generalPasteboard] setString:@"" forType:NSPasteboardTypeString];
}