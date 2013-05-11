//
//  ClipboardItem.h
//  Clipboard
//
//  Created by Hendrik Frahmann on 03.03.13.
//  Copyright (c) 2013 Hendrik Frahmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClipboardItem : NSObject

@property (strong) NSMenuItem* menuItem;
@property (strong) NSString* fullText;

- (id)initWithString:(NSString*)fullText withAction:(SEL)aSelector withTarget:(id)target;

@end
