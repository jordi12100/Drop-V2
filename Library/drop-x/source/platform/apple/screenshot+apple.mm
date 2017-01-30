//
// Created by Jordi Kroon on 10/1/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#import "screenshot.hpp"
#import "logger.hpp"

bool Screenshot::capture(boost::function<void(BaseScreenshot *)> callback) {
    if (
        !boost::filesystem::exists(Screenshot::getOutputFolder())
        && !boost::filesystem::create_directories(Screenshot::getOutputFolder())
    ) {
        throw std::invalid_argument("Config file could not been created " + Screenshot::getOutputFolder());
    }

    if (boost::filesystem::exists(Screenshot::getFilePath())) {
        boost::filesystem::remove(Screenshot::getFilePath());
    }

    NSString *nsFilePath = [NSString stringWithUTF8String:Screenshot::getFilePath().c_str()];
    NSString *nsScreenshotType = [NSString stringWithUTF8String:Screenshot::getImageType().c_str()];

    NSPipe *pipe = [NSPipe pipe];
    NSFileHandle *file = pipe.fileHandleForReading;

    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/usr/sbin/screencapture";
    task.standardOutput = pipe;
    task.arguments = @[
        @"-i", nsFilePath,
        @"-t", nsScreenshotType
    ];

    [task launch];

    [file readDataToEndOfFile];
    [file closeFile];

    if (!boost::filesystem::exists(Screenshot::getFilePath())) {
        LOG::write(INFO, "Screenshot could not be saved to it's location. "
                "Path given: " + Screenshot::getOutputFolder() +
                " Most likely this is caused by the user pressing the ESC key");

        return false;
    }

    boost::filesystem::path filePath(Screenshot::getFilePath().c_str());

    File *screenshot = new File;
    screenshot->setFolderPath(Screenshot::getOutputFolder());
    screenshot->setFileName(Screenshot::getImageName());
    screenshot->setFileExtension(filePath.extension().c_str());
    screenshot->setFileExtension(filePath.stem().c_str());
    screenshot->setFileSize(boost::filesystem::file_size(Screenshot::getFilePath()));
    Screenshot::setScreenshot(screenshot);

    callback(this);
    return true;
}
