//
//  ClipboardItem.m
//  Clipboard
//
//  Created by Hendrik Frahmann on 03.03.13.
//  Copyright (c) 2013 Hendrik Frahmann. All rights reserved.
//

#import "ClipboardItem.h"

@implementation ClipboardItem

@synthesize menuItem = _menuItem;
@synthesize fullText = _fullText;

- (id)initWithString:(NSString *)fullText withAction:(SEL)aSelector withTarget:(id)target;
{
    NSString* shortedString = @"";
    
    if([fullText length] <= ITEM_STRING_LENGTH)
        shortedString = fullText;
    else
        shortedString = [fullText substringToIndex:ITEM_STRING_LENGTH];
    
    shortedString = [shortedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    _fullText = fullText;
    _menuItem = [[NSMenuItem alloc] initWithTitle:shortedString action:aSelector keyEquivalent:@""];
    [_menuItem setTarget:target];
    
    return self;
}

@end
