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
// CRUD for {{ClassName}}s

// insert/update
+ (BOOL) insert{{ClassName}}:({{ClassName}}*)entry
{
    if(entry == nil)
        return NO;
    
    FMDatabase* db = [self getWritableDatabase];
    [db open];
    
    BOOL success = NO;
    
    // insert
    success =  [db executeUpdate:@"INSERT INTO {{TABLE_NAME}} "
                "( {{COL_LIST}} ) VALUES "
                "( {{QUESTION_LIST}}  ) "
                ,  
                {{COL_VALUE_LIST}}
                
                ];
    
    
    [db close];
    
    return success;
}

+ (BOOL) update{{ClassName}}:({{ClassName}}*)entry
{
    if(entry == nil)
        return NO;
    
    FMDatabase* db = [self getWritableDatabase];
    [db open];
    
    BOOL success = NO;
    
    // update
    success =  [db executeUpdate:@"UPDATE {{TABLE_NAME}} SET "
                " {{UPDATE_COL_LIST}} "
                "WHERE {{pkDBCol}} = ?"
                , 
                {{UPDATE_COL_VALUE_LIST}}
                
                ];
    
    
    [db close];
    
    return success;

}

// check primary key, insert if not exist, update if exist
+ (BOOL) save{{ClassName}}:({{ClassName}}*)entry
{
    if(entry == nil )
        return NO;
    
    BOOL isExist = [self is{{ClassName}}Exist:entry.{{pkCol}}];
    if(isExist)
    {
        return [self update{{ClassName}}:entry];
    }
    else{
        return [self insert{{ClassName}}:entry];
    }
    
}

// deletion
+ (BOOL) deleteAll{{ClassName}}s
{
    FMDatabase* db = [self getWritableDatabase];
    [db open];
    
    BOOL success = [db executeUpdate:@"DELETE FROM {{TABLE_NAME}}"];
    
    [db close];
    
    return success;
}

+ (BOOL) delete{{ClassName}}ByPK:({{pkType}}) {{pkCol}}
{
    FMDatabase* db = [self getWritableDatabase];
    [db open];
    
    BOOL success = [db executeUpdate:@"DELETE FROM {{TABLE_NAME}} WHERE {{pkDBCol}} = ?", {{PK_VALUE}} ];
    [db close];
    
    return success;
}

+ (NSMutableArray*) query{{ClassName}}s: (NSString*)queryString withArgumentsInArray:(NSArray*)args
{
    NSMutableArray* arr = [[NSMutableArray alloc]init];
    FMDatabase* db = [self getReadableDatabase];
    [db open];
    
    FMResultSet *results = [db executeQuery:queryString withArgumentsInArray:args];
    
    while([results next])
    {
        {{ClassName}}* entry = [[{{ClassName}} alloc]init];
        
{{RETRIEVE_COL}}
               
        [arr addObject:entry];
        
    }
    
    [results close];
    
    [db close];
    
    return arr;
}

// query
+ (NSMutableArray*) query{{ClassName}}s: (NSString*)queryString
{
    return [self query{{ClassName}}s:queryString withArgumentsInArray:nil];
}

+ (NSMutableArray*) findAll{{ClassName}}s
{
    return [self query{{ClassName}}s:@"SELECT * FROM {{TABLE_NAME}}"];
}

+ ({{ClassName}}*) find{{ClassName}}ByPK:({{pkType}}){{pkCol}}
{
    NSArray* args =[ [NSArray alloc]initWithObjects:{{PK_VALUE}}, nil];
    NSMutableArray* results = [self query{{ClassName}}s:@"SELECT * FROM {{TABLE_NAME}} WHERE {{pkDBCol}} = ?" withArgumentsInArray:args];
    if(results.count > 0)
        return [results objectAtIndex:0];
    else
        return nil;
}

+ (BOOL) is{{ClassName}}Exist:({{pkType}}){{pkCol}}
{
    {{ClassName}}* entry = [self find{{ClassName}}ByPK:{{pkCol}}];
    if(entry!=nil)
        return YES;
    else
        return NO;
}


@end
