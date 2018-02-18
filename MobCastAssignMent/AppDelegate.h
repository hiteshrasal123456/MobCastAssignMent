//
//  AppDelegate.h
//  MobCastAssignMent
//
//  Created by apple on 17/02/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieApp.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic)MovieApp *movieApp;

#define movieAppdelegate ((AppDelegate *)[[UIApplication sharedApplication]delegate])
@end

