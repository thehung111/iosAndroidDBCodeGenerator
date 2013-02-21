//
//  AppDelegate.m
//  ExampleDBApp
//
//  Created by Ngo The Hung on 20/2/13.
//  Copyright (c) 2013 NYP. All rights reserved.
//

#import "AppDelegate.h"

#import "FMDatabase.h"
#import "User.h"
#import "DBHelper.h"
#import "TestViewController.h"

@implementation AppDelegate

@synthesize databasePath;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self setupDatabase];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    TestViewController *viewController = [[TestViewController alloc] initWithNibName:@"TestViewController" bundle:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    
//    [self testInsert];
//    [self testUpdate];
//    [self testSave];
    
//    [self testDeleteUserByPK];
//    [self testDeleteAllUsers];
//
//    for(int i = 0; i < 50; i ++)
//    {
//        [self randInsert];
//    }
    
    [self testFinder];
    
    
    return YES;
}


#pragma mark - Test Methods
- (void) testFinder
{
    User* user = [DBHelper findUserByPK:5];
    NSLog(@"userId: %d, name:  %@, hp: %d, email : %@", user.userId, user.name, user.handphone, user.email );
    
    NSLog(@"User id 5 exists? %d", [DBHelper isUserExist:5]);
    NSLog(@"User id 2222 exists? %d", [DBHelper isUserExist:2222]);
    
    NSMutableArray* arr = [DBHelper findAllUsers];
    
    for(User* u in arr)
    {
        NSLog(@"-- userId: %d, name:  %@, hp: %d, email : %@", u.userId, u.name, u.handphone, u.email );
        
    }
    
}

- (void) randInsert
{
    User* user = [[User alloc]init];
    user.userId = (arc4random() % 1000);
    user.name = [NSString stringWithFormat:@"Hung%d", (arc4random() % 1000) ];
    user.handphone =  (arc4random() % 1000);
    user.email = [NSString stringWithFormat:@"thehung%d@yahoo.com", (arc4random() % 1000) ];
    
    
    [DBHelper saveUser:user];
}

- (void) testInsert
{
    User* user = [[User alloc]init];
    user.userId = 2;
    user.name = @"Hung";
    user.handphone =  12345678;
    user.email = @"thehung123456789@xxx.com";
    
    
    [DBHelper insertUser:user];
}

- (void) testUpdate
{
    User* user = [[User alloc]init];
    user.userId = 2;
    user.name = @"HungUpdate";
    user.handphone =  123456789;
    user.email = @"updatedThehung123456789@xxx.com";
    
    
    [DBHelper updateUser:user];
}


- (void) testSave
{
    // new user
    User* user = [[User alloc]init];
    user.userId = 3;
    user.name = @"3HungSave";
    user.handphone =  3456789;
    user.email = @"3SavedThehung123456789@xxx.com";
    
    [DBHelper saveUser:user];
    
    // existing user
    user.userId = 2;
    user.name = @"2HungUpdate";
    user.handphone =  22222;
    user.email = @"2SavedThehung123456789@xxx.com";
    [DBHelper saveUser:user];
}

- (void) testDeleteAllUsers
{
    [DBHelper deleteAllUsers];
}

- (void) testDeleteUserByPK
{
    [DBHelper deleteUserByPK:2];
}



# pragma mark - Class Methods
+ (AppDelegate *)sharedAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


# pragma mark - Setup Methods
- (void) setupDatabase{
    // copy pre-defined database to documents directory if not there on first start
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSString* dbName = @"test.db";
    self.databasePath = [documentDir stringByAppendingPathComponent:dbName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:self.databasePath])
    {
        
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
        [fileManager copyItemAtPath:databasePathFromApp toPath:self.databasePath error:nil];
        
        NSLog(@"Copy database succesfully to: %@", self.databasePath);
    }
    else
        NSLog(@"Database already exists at location: %@", self.databasePath);
    
    // test databse connection
    FMDatabase *db = [FMDatabase databaseWithPath:self.databasePath];
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        // something is wrong here
    }
    
    [db close];
    
}











# pragma mark - Unused generated methods
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
