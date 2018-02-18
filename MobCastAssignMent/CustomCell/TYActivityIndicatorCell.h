//
//  TYActivityIndicatorCell.h
//  MobCastAssignMent
//
//  Created by apple on 18/02/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYActivityIndicatorCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
+(NSString*)identifier;

@end
