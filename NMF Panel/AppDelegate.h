//
//  AppDelegate.h
//  NMF Panel
//
//  Created by Pedro Góes on 07/02/14.
//  Copyright (c) 2014 Estúdio Trilha. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PanelViewController.h"
#import "PreferencesWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (strong, nonatomic) IBOutlet PanelViewController *panelViewController;
@property (strong, nonatomic) IBOutlet PreferencesWindowController *preferencesWindowController;

- (IBAction)showPreferencePanel:(id)sender;

@end
