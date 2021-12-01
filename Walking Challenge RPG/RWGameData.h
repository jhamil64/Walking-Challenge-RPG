#import <Foundation/Foundation.h>

@interface RWGameData : NSObject

@property (assign, nonatomic) int gold;


+(instancetype)sharedGameData;
-(void)reset;

@end

