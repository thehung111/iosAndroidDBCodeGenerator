//
//  DBHelper.h
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "User.h"

@interface DBHelper : NSObject
{
    
}

// please override these 2 methods to get the sqlite database
+ (FMDatabase*) getReadableDatabase;
+ (FMDatabase*) getWritableDatabase;

// CRUD for User

// insert/update
+ (BOOL) insertUser:(User*)entry;
+ (BOOL) updateUser:(User*)entry;

// check primary key, insert if not exist, update if exist
+ (BOOL) saveUser:(User*)entry;

// deletion
+ (BOOL) deleteAllUsers;
+ (BOOL) deleteUserByPK:(int) userId;

// query
+ (NSMutableArray*) queryUsers: (NSString*)queryString withArgumentsInArray:(NSArray*)args;
+ (NSMutableArray*) queryUsers: (NSString*)queryString;
+ (NSMutableArray*) findAllUsers;
+ (User*) findUserByPK:(int)userId;
+ (BOOL) isUserExist:(int)userId;


@end