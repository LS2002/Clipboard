//
//  AppDelegate.h
//  Clipboard
//
//  Created by Hendrik Frahmann on 03.03.13.
//  Copyright (c) 2013 Hendrik Frahmann. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ClipboardController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    ClipboardController* clipboardController;
}

@end
