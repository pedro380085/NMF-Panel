//
//  PreferencesWindowController.h
//  InEvent Configurator
//
//  Created by Pedro Góes on 03/02/14.
//  Copyright (c) 2014 Estúdio Trilha. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferencesWindowController : NSWindowController <NSWindowDelegate>

@property (strong, nonatomic) IBOutlet NSTextField *projectField;
@property (strong, nonatomic) IBOutlet NSTextField *filesField;

@end
