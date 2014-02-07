//
//  PreferencesWindowController.m
//  InEvent Configurator
//
//  Created by Pedro Góes on 03/02/14.
//  Copyright (c) 2014 Estúdio Trilha. All rights reserved.
//

#import "PreferencesWindowController.h"

@interface PreferencesWindowController ()

@end

@implementation PreferencesWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Load our current paths
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSURL *projectPath = [userDefaults URLForKey:@"projectPath"];
    if ([projectPath isFileURL]) [self.projectField setStringValue:[projectPath path]];
    NSURL *filesPath = [userDefaults URLForKey:@"filesPath"];
    if ([filesPath isFileURL]) [self.filesField setStringValue:[filesPath path]];
}

- (void)windowWillClose:(NSNotification *)notification {
    
    // Save our current paths
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setURL:[NSURL fileURLWithPath:self.projectField.stringValue] forKey:@"projectPath"];
    [userDefaults setURL:[NSURL fileURLWithPath:self.filesField.stringValue] forKey:@"filesPath"];
    [userDefaults synchronize];
}

@end
