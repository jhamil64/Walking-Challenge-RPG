//
//  RWGameData.m
//  Walking Challenge RPG
//
//  Created by Chibi on 2021/11/30.
//

#import "RWGameData.h"

@implementation RWGameData

+ (instancetype)sharedGameData {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

-(void)reset
{
    self.gold = 0;
}


@end
