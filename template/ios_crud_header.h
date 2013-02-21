//
//  DBHelper.h
//  

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "{{ClassName}}.h"

@interface DBHelper : NSObject
{
    
}

// please override these 2 methods to get the sqlite database
+ (FMDatabase*) getReadableDatabase;
+ (FMDatabase*) getWritableDatabase;

// CRUD for {{ClassName}}

// insert/update
+ (BOOL) insert{{ClassName}}:({{ClassName}}*)entry;
+ (BOOL) update{{ClassName}}:({{ClassName}}*)entry;

// check primary key, insert if not exist, update if exist
+ (BOOL) save{{ClassName}}:({{ClassName}}*)entry;

// deletion
+ (BOOL) deleteAll{{ClassName}}s;
+ (BOOL) delete{{ClassName}}ByPK:({{pkType}}) {{pkCol}};

// query
+ (NSMutableArray*) query{{ClassName}}s: (NSString*)queryString withArgumentsInArray:(NSArray*)args;
+ (NSMutableArray*) query{{ClassName}}s: (NSString*)queryString; 
+ (NSMutableArray*) findAll{{ClassName}}s;
+ ({{ClassName}}*) find{{ClassName}}ByPK:({{pkType}}){{pkCol}};
+ (BOOL) is{{ClassName}}Exist:({{pkType}}){{pkCol}};


@end
