//
//  AppDelegate.h
//  Clipboard
//
//  Created by Hendrik Frahmann on 03.03.13.
//  Copyright (c) 2013 Hendrik Frahmann. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ClipboardItem.h"

#define MAX_ITEM_COUNT 20

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSStatusItem *statusItem;
    NSMenu* statusMenu;
    
    NSPasteboard* pasteBoard;
    NSInteger lastPasteBoardChangeCount;
    NSTimer* clipboardTimer;
    NSMutableArray* clipboardItems;
    
    NSMenuItem* itemNoEntries;
    NSMenuItem* itemQuit;
    NSMenuItem* itemInfo;
    NSMenuItem* itemReset;
}

- (void)checkClipboard;
- (void)createMenu;
- (void)actionSelectClipboardItem:(id)selector;
- (void)actionReset;
- (void)actionInfo;
- (void)actionQuit;

@end
