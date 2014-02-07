//
//  AppDelegate.m
//  NMF Panel
//
//  Created by Pedro Góes on 07/02/14.
//  Copyright (c) 2014 Estúdio Trilha. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.panelViewController = [[PanelViewController alloc] initWithNibName:@"PanelViewController" bundle:nil];
    
    // Add the view controller to the Window's content view
    [self.window.contentView addSubview:self.panelViewController.view];
    self.panelViewController.view.frame = ((NSView*)self.window.contentView).bounds;
}

- (IBAction)showPreferencePanel:(id)sender {
    if (!self.preferencesWindowController) self.preferencesWindowController = [[PreferencesWindowController alloc] initWithWindowNibName:@"PreferencesWindowController"];
    
    [self.preferencesWindowController showWindow:self];
}

@end