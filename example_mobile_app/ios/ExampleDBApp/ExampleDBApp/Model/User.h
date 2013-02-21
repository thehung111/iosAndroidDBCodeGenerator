//
// User.h
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    
    int userId ;
    NSString* name ;
    int handphone ;
    NSString* email ;
    
    
}

@property(assign, nonatomic) int userId ;
@property(strong, nonatomic) NSString* name ;
@property(assign, nonatomic) int handphone ;
@property(strong, nonatomic) NSString* email ;


@end