//
//  MovieDetailVc.h
//  MobCastAssignMent
//
//  Created by apple on 18/02/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailVc : UIViewController
@property(strong,nonatomic) NSMutableDictionary *detailDict;
@property (weak, nonatomic) IBOutlet UIImageView *imgMoviePostar;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblRelease;
@property (weak, nonatomic) IBOutlet UILabel *lblDirector;
@property (weak,nonatomic) IBOutlet UILabel *lblWriter;
@property (weak,nonatomic) IBOutlet UILabel *lblActor;
@property(weak,nonatomic) IBOutlet UILabel *lblDuration;
@property(weak,nonatomic) IBOutlet UILabel *lblGenre;
@property(weak,nonatomic) IBOutlet UILabel *lblLanguage;
@property(weak,nonatomic) IBOutlet UILabel *lblCountry;

@end
