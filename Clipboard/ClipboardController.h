//
//  ClipboardController.h
//  Clipboard
//
//  Created by Hendrik Frahmann on 04.05.13.
//  Copyright (c) 2013 Hendrik Frahmann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClipboardItem.h"

@interface ClipboardController : NSObject
{
    NSStatusItem *statusItem;
    
    NSPasteboard* pasteBoard;
    NSInteger lastPasteBoardChangeCount;
    NSTimer* clipboardTimer;
    NSMutableArray* clipboardItems;
    
    NSMenu* statusMenu;
    NSMenu* settingsMenu;
    NSMenuItem* itemNoEntries;
    NSMenuItem* itemSettings;
    NSMenuItem* itemReset;
    NSMenuItem* itemInfo;
    NSMenuItem* itemQuit;
}

- (void)checkClipboard;
- (void)createMenu;
- (void)actionSelectClipboardItem:(id)selector;
- (void)actionReset;
- (void)actionInfo;
- (void)actionQuit;
@end
