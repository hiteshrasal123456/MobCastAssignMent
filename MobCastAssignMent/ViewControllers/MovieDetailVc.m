//
//  MovieDetailVc.m
//  MobCastAssignMent
//
//  Created by apple on 18/02/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "MovieDetailVc.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "DejalActivityView.h"
@interface MovieDetailVc ()

@end

@implementation MovieDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Movie Details";
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading" width:100];
    
    
    
    [self detailApiRequest:[_detailDict valueForKey:@"imdbID"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)detailApiRequest:(NSString *)idForMovieDetail{
    NSMutableDictionary *inpDict = [[NSMutableDictionary alloc] init];
    [inpDict setValue:idForMovieDetail forKey:@"movieId"];
    [movieAppdelegate.movieApp.networkClient fetchMovieDetailsRequest:inpDict andCompletionHandler:^(id result, NSURLResponse *response, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [DejalKeyboardActivityView removeViewAnimated:YES];
                NSLog(@"error is %@",error.localizedDescription);
            });
        }
        else{
            NSLog(@"result is %@",(NSDictionary *)result);
            dispatch_async(dispatch_get_main_queue(), ^{
                [DejalKeyboardActivityView removeViewAnimated:YES];
                NSDictionary *respDict = (NSDictionary *)result;
                _lblTitle.text = [NSString stringWithFormat:@"Name : %@",[respDict valueForKey:@"Title"]];
                _lblRelease.text = [NSString stringWithFormat:@"Released : %@",[respDict valueForKey:@"Released"]];
                _lblDirector.text = [NSString stringWithFormat:@"Director : %@",[respDict valueForKey:@"Director"]];
                _lblWriter.text = [NSString stringWithFormat:@"Writer : %@",[respDict valueForKey:@"Writer"]];
                _lblActor.text = [NSString stringWithFormat:@"Actors : %@",[respDict valueForKey:@"Actors"]];
                _lblLanguage.text = [NSString stringWithFormat:@"Language : %@",[respDict valueForKey:@"Language"]];
                _lblCountry.text = [NSString stringWithFormat:@"Country : %@",[respDict valueForKey:@"Country"]];
                _lblGenre.text = [NSString stringWithFormat:@"Genre : %@",[respDict valueForKey:@"Genre"]];
                _lblDuration.text = [NSString stringWithFormat:@"Runtime : %@",[respDict valueForKey:@"Runtime"]];
                NSURL *imgUrl = [NSURL URLWithString:[respDict valueForKey:@"Poster"]];
                [_imgMoviePostar sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"No_Image_Available"]];
            });
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
