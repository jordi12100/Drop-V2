//
//  screenshot+base.hpp
//  drop-x
//
//  Created by Jordi Kroon on 11/17/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#ifndef screenshot_base_h
#define screenshot_base_h

#include <string>
#include "file.hpp"
#include <boost/function.hpp>
#include <boost/function_equal.hpp>

enum class SCREENSHOT_TYPE : char {
    PNG,
    JPEG,
    TIFF
};

class BaseScreenshot {
    protected:
        /**
         * @param std::string
         */
        std::string outputFolder;

        /**
         * @param std::string
         */
        std::string imageName;

        /**
         * @param std::string
         */
        std::string imageType;

        /**
         * @param File *
         */
        File *screenshot;
    public:
        /**
         * @param std::string
         */
        void setOutputFolder(std::string outputFolder);

        /**
         * @return std::string
         */
        std::string getOutputFolder();

        /**
         * @param std::string
         */
        void setImageName(std::string imageName);

        /**
         * @return std::string
         */
        std::string getImageName();

        /**
         * @param std::string
         */
        void setImageType(std::string imageType);

        /**
         * @return std::string
         */
        std::string getImageType();

        /**
         * @return std::string
         */
        std::string getFilePath();

        /**
        * @param File *
        */
        void setScreenshot(File *screenshot);

    /**
         * @return File *
         */
        File *getScreenshot();

        /**
         * @return File
         */
        virtual bool capture(boost::function<void(BaseScreenshot *)> callback){return nullptr;};
};

#endif /* screenshot_base_h */
