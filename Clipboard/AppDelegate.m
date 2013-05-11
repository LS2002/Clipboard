//
//  AppDelegate.m
//  Clipboard
//
//  Created by Hendrik Frahmann on 03.03.13.
//  Copyright (c) 2013 Hendrik Frahmann. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    clipboardController = [ClipboardController new];
}

@end
