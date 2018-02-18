//
//  MovieListVc.h
//  MobCastAssignMent
//
//  Created by apple on 18/02/18.
//  Copyright © 2018 apple. All rights reserved.
//
#import <UIKit/UIKit.h>
extern NSString *movieName;
extern NSString *lastSelectedTab;

@interface MovieListVc : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tblMovies;
@property (weak, nonatomic) IBOutlet UISearchBar *filterSearchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *movieSegment;

@end
