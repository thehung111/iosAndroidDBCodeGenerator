//
//  DBHelper.m
//

#import "DBHelper.h"
#import "AppDelegate.h"

@implementation DBHelper


#pragma mark - Setup Database
// please override these 2 methods to get the sqlite database
+ (FMDatabase*) getReadableDatabase
{
    /* example implementation */
    AppDelegate* sharedDelegate = [AppDelegate sharedAppDelegate];
    FMDatabase* db = [FMDatabase databaseWithPath:sharedDelegate.databasePath];
    return db;
}

+ (FMDatabase*) getWritableDatabase
{
    /* example implementation */
    AppDelegate* sharedDelegate = [AppDelegate sharedAppDelegate];
    FMDatabase* db = [FMDatabase databaseWithPath:sharedDelegate.databasePath];
    return db;
}


#pragma mark - CRUD
// CRUD for Users

// insert/update
+ (BOOL) insertUser:(User*)entry
{
    if(entry == nil)
        return NO;
    
    FMDatabase* db = [self getWritableDatabase];
    [db open];
    
    BOOL success = NO;
    
    // insert
    success =  [db executeUpdate:@"INSERT INTO User "
                "( userId,name,handphone,email ) VALUES "
                "( ?,?,?,?  ) "
                ,
                [NSNumber numberWithInt: entry.userId], entry.name, [NSNumber numberWithInt: entry.handphone], entry.email
                
                ];
    
    
    [db close];
    
    return success;
}

+ (BOOL) updateUser:(User*)entry
{
    if(entry == nil)
        return NO;
    
    FMDatabase* db = [self getWritableDatabase];
    [db open];
    
    BOOL success = NO;
    
    // update
    success =  [db executeUpdate:@"UPDATE User SET "
                " name = ? ,handphone = ? ,email = ?  "
                "WHERE userId = ?"
                ,
                entry.name, [NSNumber numberWithInt: entry.handphone], entry.email, [NSNumber numberWithInt: entry.userId]
                
                ];
    
    
    [db close];
    
    return success;
    
}

// check primary key, insert if not exist, update if exist
+ (BOOL) saveUser:(User*)entry
{
    if(entry == nil )
        return NO;
    
    BOOL isExist = [self isUserExist:entry.userId];
    if(isExist)
    {
        return [self updateUser:entry];
    }
    else{
        return [self insertUser:entry];
    }
    
}

// deletion
+ (BOOL) deleteAllUsers
{
    FMDatabase* db = [self getWritableDatabase];
    [db open];
    
    BOOL success = [db executeUpdate:@"DELETE FROM User"];
    
    [db close];
    
    return success;
}

+ (BOOL) deleteUserByPK:(int) userId
{
    FMDatabase* db = [self getWritableDatabase];
    [db open];
    
    BOOL success = [db executeUpdate:@"DELETE FROM User WHERE userId = ?",  [NSNumber numberWithInt: userId] ];
    [db close];
    
    return success;
}

+ (NSMutableArray*) queryUsers: (NSString*)queryString withArgumentsInArray:(NSArray*)args
{
    NSMutableArray* arr = [[NSMutableArray alloc]init];
    FMDatabase* db = [self getReadableDatabase];
    [db open];
    
    FMResultSet *results = [db executeQuery:queryString withArgumentsInArray:args];
    
    while([results next])
    {
        User* entry = [[User alloc]init];
        
        entry.userId = [results intForColumn:@"userId"];
        entry.name = [results stringForColumn:@"name"];
        entry.handphone = [results intForColumn:@"handphone"];
        entry.email = [results stringForColumn:@"email"];
        
        
        [arr addObject:entry];
        
    }
    
    [results close];
    
    [db close];
    
    return arr;
}

// query
+ (NSMutableArray*) queryUsers: (NSString*)queryString
{
    return [self queryUsers:queryString withArgumentsInArray:nil];
}

+ (NSMutableArray*) findAllUsers
{
    return [self queryUsers:@"SELECT * FROM User"];
}

+ (User*) findUserByPK:(int)userId
{
    NSArray* args =[ [NSArray alloc]initWithObjects: [NSNumber numberWithInt: userId], nil];
    NSMutableArray* results = [self queryUsers:@"SELECT * FROM User WHERE userId = ?" withArgumentsInArray:args];
    if(results.count > 0)
        return [results objectAtIndex:0];
    else
        return nil;
}

+ (BOOL) isUserExist:(int)userId
{
    User* entry = [self findUserByPK:userId];
    if(entry!=nil)
        return YES;
    else
        return NO;
}


@end