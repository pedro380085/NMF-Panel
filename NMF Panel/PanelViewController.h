//
//  PanelViewController.h
//  NMF Panel
//
//  Created by Pedro Góes on 07/02/14.
//  Copyright (c) 2014 Estúdio Trilha. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PanelViewController : NSViewController

@property (strong, nonatomic) IBOutlet NSTextField *nginxStatus;
@property (strong, nonatomic) IBOutlet NSTextField *mysqlStatus;
@property (strong, nonatomic) IBOutlet NSTextField *phpStatus;

@end
