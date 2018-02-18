//
//  MovieApp.m
//  MobCastAssignMent
//
//  Created by apple on 17/02/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "MovieApp.h"

@implementation MovieApp
-(instancetype)init {
    self = [super init];
    if (self != nil) {
        
        self.networkClient   =  [[NetworkClient alloc]init];
    }
    return self;
}
@end
