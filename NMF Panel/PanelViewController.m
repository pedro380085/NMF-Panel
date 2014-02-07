//
//  PanelViewController.m
//  NMF Panel
//
//  Created by Pedro Góes on 07/02/14.
//  Copyright (c) 2014 Estúdio Trilha. All rights reserved.
//

#import "PanelViewController.h"

@interface PanelViewController () {
    NSArray *startCommand;
    NSArray *stopCommand;
    NSArray *statusLabel;
}

@end

@implementation PanelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}
#pragma mark - View cycle

- (void)loadView
{
    [super loadView];
    
    // Create our modules
    // They must have the same size!!
    startCommand = @[@"sudo /usr/local/bin/nginx",
                     @"sudo /usr/local/mysql/support-files/mysql.server start",
                     @"launchctl load -w ~/Library/LaunchAgents/homebrew-php*.plist"];
    
    stopCommand = @[@"sudo /usr/local/bin/nginx -s stop",
                    @"sudo /usr/local/mysql/support-files/mysql.server stop",
                    @"launchctl unload -w ~/Library/LaunchAgents/homebrew-php*.plist"];
    
    statusLabel = @[self.nginxStatus, self.mysqlStatus, self.phpStatus];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Task

- (void)executeTask:(NSString *)fullCommand {
    
    if ([fullCommand rangeOfString:@"sudo"].location == NSNotFound) {
        [self runProcess:fullCommand];

    } else {
        NSArray *components = [fullCommand componentsSeparatedByString:@" "];
        
        if ([components count] > 1) {
         
            NSString *command = [components objectAtIndex:1];
            NSArray *arguments = nil;
            
            if ([components count] > 2) {
                arguments = [components subarrayWithRange:NSMakeRange(2, [components count] - 2)];
            } else {
                arguments = [NSArray array];
            }

            NSString *output = [NSString string];
            [self runProcessAsAdministrator:command withArguments:arguments output:&output errorDescription:nil];
                
        }
    }
}

- (BOOL)runProcess:(NSString*)command {
    
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/bash"];
    [task setArguments:@[@"-c", command]];
    [task launch];
    
    return YES;
}

- (BOOL)runProcessAsAdministrator:(NSString*)scriptPath withArguments:(NSArray *)arguments output:(NSString **)output errorDescription:(NSString **)errorDescription {
    
    NSString *allArgs = [arguments componentsJoinedByString:@" "];
    NSString *fullScript = [NSString stringWithFormat:@"'%@' %@", scriptPath, allArgs];
    
    NSDictionary *errorInfo = [NSDictionary dictionary];
    NSString *script = [NSString stringWithFormat:@"do shell script \"%@\" with administrator privileges", fullScript];
    
    NSAppleScript *appleScript = [[NSAppleScript new] initWithSource:script];
    NSAppleEventDescriptor *eventResult = [appleScript executeAndReturnError:&errorInfo];
    
    // Check errorInfo
    if (!eventResult) {
        // See if the user wants to know
        if (errorDescription) {
            // Describe common errors
            if ([errorInfo valueForKey:NSAppleScriptErrorNumber]) {
                NSNumber *errorNumber = (NSNumber *)[errorInfo valueForKey:NSAppleScriptErrorNumber];
                if ([errorNumber intValue] == -128) {
                    *errorDescription = @"The administrator password is required to do this.";
                }
            }
            
            // Set error message from provided message
            if (*errorDescription == nil) {
                if ([errorInfo valueForKey:NSAppleScriptErrorMessage]) {
                    *errorDescription = (NSString *)[errorInfo valueForKey:NSAppleScriptErrorMessage];
                }
            }
        }
        
        return NO;
        
    } else {
        // Set output to the AppleScript's output
        *output = [eventResult stringValue];
        
        return YES;
    }
}

#pragma mark - Process

- (IBAction)startProcess:(id)sender {
    
    NSInteger tag = [(NSView *)sender tag];
    [[statusLabel objectAtIndex:tag] setTextColor:[NSColor greenColor]];
    [[statusLabel objectAtIndex:tag] setStringValue:@"Starting ..."];
    [self executeTask:[startCommand objectAtIndex:tag]];
    [[statusLabel objectAtIndex:tag] setStringValue:@"Started"];
}

- (IBAction)stopProcess:(id)sender {
    
    NSInteger tag = [(NSView *)sender tag];
    [[statusLabel objectAtIndex:tag] setTextColor:[NSColor redColor]];
    [[statusLabel objectAtIndex:tag] setStringValue:@"Stopping ..."];
    [self executeTask:[stopCommand objectAtIndex:tag]];
    [[statusLabel objectAtIndex:tag] setStringValue:@"Stopped"];
}

- (IBAction)restartProcess:(id)sender {
    
    [self stopProcess:sender];
    [self startProcess:sender];
}

@end
