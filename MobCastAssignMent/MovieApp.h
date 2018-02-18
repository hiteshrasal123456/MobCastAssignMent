//
//  MovieApp.h
//  MobCastAssignMent
//
//  Created by apple on 17/02/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkClient.h"
@interface MovieApp : NSObject
@property (strong, nonatomic)NetworkClient *networkClient;
@end
