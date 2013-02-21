//
//  AppDelegate.h
//  ExampleDBApp
//
//  Created by Ngo The Hung on 20/2/13.
//  Copyright (c) 2013 NYP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString *databasePath;
}


+ (AppDelegate *)sharedAppDelegate;
- (void) setupDatabase;

@property (strong, nonatomic) NSString *databasePath;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;

@end
