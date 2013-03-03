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
    NSImage* statusBarIcon = [NSImage imageNamed:@"statusBarIcon"];
    [statusBarIcon setTemplate:YES];

    pasteBoard = [NSPasteboard generalPasteboard];
    lastPasteBoardChangeCount = [pasteBoard changeCount];
    clipboardItems = [[NSMutableArray alloc] init];
    statusMenu = [NSMenu alloc];
    
    clipboardTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkClipboard) userInfo:nil repeats:YES];
    
    [self createMenu];
    
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    [statusItem setImage:statusBarIcon];
    [statusItem setHighlightMode:YES];
}

- (void)checkClipboard
{
    NSInteger currentChangeCount = [pasteBoard changeCount];
    if(lastPasteBoardChangeCount< currentChangeCount)
    {
        lastPasteBoardChangeCount = currentChangeCount;
        
        NSString* pasteString = [pasteBoard stringForType:@"NSStringPboardType"];
        
        ClipboardItem* clipboardItem = [[ClipboardItem alloc] initWithString:pasteString withAction:@selector(actionSelectClipboardItem:)];
        [clipboardItems insertObject:clipboardItem atIndex:0];
        
        if([clipboardItems count] > MAX_ITEM_COUNT) {
            [clipboardItems removeObjectAtIndex:[clipboardItems count]-1];
        }
        
        [self createMenu];
    }
}

- (void)createMenu
{
    [statusMenu removeAllItems];
    
    if([clipboardItems count] == 0)
    {
        itemNoEntries = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"No entries available", nil) action:nil keyEquivalent:@""];
        [statusMenu addItem:itemNoEntries];
    }
    else
    {
        for(int i = 0; i < [clipboardItems count]; i++)
        {
            ClipboardItem* tempItem = (ClipboardItem*)[clipboardItems objectAtIndex:i];
            [statusMenu addItem:tempItem.menuItem];
        }
    }
    
    [statusMenu addItem:[NSMenuItem separatorItem]];
    
    itemReset = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"Reset", nil) action:@selector(actionReset) keyEquivalent:@""];
    [statusMenu addItem:itemReset];
    itemInfo = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"Info", nil) action:@selector(actionInfo) keyEquivalent:@""];
    [statusMenu addItem:itemInfo];
    itemQuit = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"Quit", nil) action:@selector(actionQuit) keyEquivalent:@""];
    [statusMenu addItem:itemQuit];
}


#pragma mark Actions

- (void)actionSelectClipboardItem:(id)selector
{
    for(int i = 0; i < [clipboardItems count]; i++)
    {
        ClipboardItem* tempItem = (ClipboardItem*)[clipboardItems objectAtIndex:i];
        if(tempItem.menuItem == selector)
        {
            NSString* fullText = tempItem.fullText;
            
            // insert selected string to the paste board
            [pasteBoard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:nil];
            [pasteBoard setString:fullText forType:NSStringPboardType];
            
            // move selected item to the top
            [clipboardItems removeObject:tempItem];
            
            break;
        }
    }
}

- (void)actionReset
{
    [clipboardItems removeAllObjects];
    [self createMenu];
}

- (void)actionInfo
{
    [NSApp orderFrontStandardAboutPanel:self];
}

- (void)actionQuit
{
    [NSApp terminate:self];
}

@end
