//
//  ClipboardController.m
//  Clipboard
//
//  Created by Hendrik Frahmann on 04.05.13.
//  Copyright (c) 2013 Hendrik Frahmann. All rights reserved.
//

#import "ClipboardController.h"

@implementation ClipboardController


- (id)init
{
    if(self == nil)
        self = [super init];
    
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
    
    return self;
}

- (void)checkClipboard
{
    NSInteger currentChangeCount = [pasteBoard changeCount];
    if(lastPasteBoardChangeCount< currentChangeCount)
    {
        lastPasteBoardChangeCount = currentChangeCount;
        
        NSString* pasteString = [pasteBoard stringForType:@"NSStringPboardType"];
        
        if(pasteString == nil)
            return;
        
        ClipboardItem* clipboardItem = [[ClipboardItem alloc] initWithString:pasteString withAction:@selector(actionSelectClipboardItem:) withTarget:self];
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
    [itemReset setTarget:self];
    [statusMenu addItem:itemReset];
    
    itemInfo = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"Info", nil) action:@selector(actionInfo) keyEquivalent:@""];
    [itemInfo setTarget:self];
    [statusMenu addItem:itemInfo];
    
    itemQuit = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"Quit", nil) action:@selector(actionQuit) keyEquivalent:@""];
    [itemQuit setTarget:self];
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
