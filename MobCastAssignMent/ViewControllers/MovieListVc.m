//
//  MovieListVc.m
//  MobCastAssignMent
//
//  Created by apple on 18/02/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "MovieListVc.h"
#import "MovieListCell.h"
#import "TYActivityIndicatorCell.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "MovieDetailVc.h"
#import "DejalActivityView.h"


@interface MovieListVc ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UISearchBarDelegate>{
    int currentPage;
    BOOL isLoadingMore;
    BOOL isFilter;
    BOOL isHistoryClicked;
    BOOL isAllMovies;
    
    TYActivityIndicatorCell *detailsHeader;
    NSMutableArray *allMoviesArray;
    NSMutableArray *allHistoryArray;
    NSMutableArray *filterRecordsArray;
    NSMutableArray *searchHistoryArray;
    
}

@end
NSString *movieName=@"";
NSString *lastSelectedTab=@"";
@implementation MovieListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"List Of Movies";
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading" width:100];
    isAllMovies = YES;
    lastSelectedTab = @"AllMovies";
    movieName =  @"All movies";
    currentPage = 1;
    self.filterSearchBar = [[UISearchBar alloc] init];
    self.filterSearchBar.showsCancelButton = YES;
    self.filterSearchBar.delegate = self;
    // Do any additional setup after loading the view.
    UINib *movieListNib = [UINib nibWithNibName:@"MovieListCell" bundle:nil];
    [_tblMovies registerNib:movieListNib forCellReuseIdentifier:@"MovieListVcIdef"];
    allMoviesArray = [[NSMutableArray alloc] init];
    allHistoryArray = [[NSMutableArray alloc] init];
    searchHistoryArray = [[NSMutableArray alloc] init];
    filterRecordsArray = [[NSMutableArray alloc] init];
    [self fetchMovieList:movieName];
    [_tblMovies reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableViewDelegateMethods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    if (isFilter) {
        return [filterRecordsArray count];
    }else if (isHistoryClicked) {
        if (allHistoryArray.count > 0) {
            return [allHistoryArray count];
        }else{
            return 0;
        }
    }
    else{
        if (allMoviesArray.count > 0) {
            return [allMoviesArray count];
        }else{
            return 0;
        }
    }
    
   
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieListVcIdef"];
    
    cell.mainView.layer.cornerRadius = 4.0;
    cell.mainView.layer.shadowOffset = CGSizeMake(0, 0);
    cell.mainView.layer.shadowRadius = 5;
    cell.mainView.layer.shadowOpacity = 0.5;
    
    if (isFilter) {
        NSURL *imgUrl = [NSURL URLWithString:[(NSDictionary *)[filterRecordsArray objectAtIndex:indexPath.row] valueForKey:@"Poster"]];
        [cell.posterImg sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"No_Image_Available"]];
        
        
        
        cell.lblName.text =[NSString stringWithFormat:@"Name : %@",[(NSDictionary *)[filterRecordsArray objectAtIndex:indexPath.row] valueForKey:@"Title"]];
        cell.lblYear.text =[NSString stringWithFormat:@"Year Of Release : %@",[(NSDictionary *)[filterRecordsArray objectAtIndex:indexPath.row] valueForKey:@"Year"]];
    }else if (isHistoryClicked) {
        NSURL *imgUrl = [NSURL URLWithString:[(NSDictionary *)[allHistoryArray objectAtIndex:indexPath.row] valueForKey:@"Poster"]];
        [cell.posterImg sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"No_Image_Available"]];
        
        
        
        cell.lblName.text =[NSString stringWithFormat:@"Name : %@",[(NSDictionary *)[allHistoryArray objectAtIndex:indexPath.row] valueForKey:@"Title"]];
        cell.lblYear.text =[NSString stringWithFormat:@"Year Of Release : %@",[(NSDictionary *)[allHistoryArray objectAtIndex:indexPath.row] valueForKey:@"Year"]];
    }
    else{
        NSURL *imgUrl = [NSURL URLWithString:[(NSDictionary *)[allMoviesArray objectAtIndex:indexPath.row] valueForKey:@"Poster"]];
        [cell.posterImg sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"No_Image_Available"]];
        
        
        
        cell.lblName.text =[NSString stringWithFormat:@"Name : %@",[(NSDictionary *)[allMoviesArray objectAtIndex:indexPath.row] valueForKey:@"Title"]];
        cell.lblYear.text =[NSString stringWithFormat:@"Year Of Release : %@",[(NSDictionary *)[allMoviesArray objectAtIndex:indexPath.row] valueForKey:@"Year"]];
    }
    
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieDetailVc *movieDetailsVcObj = [self.storyboard instantiateViewControllerWithIdentifier:@"MovieDetailVc"];
    if (isFilter) {
        movieDetailsVcObj.detailDict = [filterRecordsArray objectAtIndex:indexPath.row];
    }else if (isHistoryClicked) {
        movieDetailsVcObj.detailDict = [allHistoryArray objectAtIndex:indexPath.row];
    }
        else{
       movieDetailsVcObj.detailDict = [allMoviesArray objectAtIndex:indexPath.row];
    }
    
    
    [self.navigationController pushViewController:movieDetailsVcObj animated:YES];
    
    
}
#pragma mark - ScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    float reload_distance = 15;
    if(y > h + reload_distance)
    {
        
        if (!isHistoryClicked) {
            if (!isLoadingMore) {
                if(detailsHeader  == nil){
                    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TYActivityIndicatorCell" owner:self options:nil];
                    detailsHeader = [topLevelObjects objectAtIndex:0];
                    _tblMovies.tableFooterView = detailsHeader;
                    _tblMovies.tableFooterView.hidden = NO;
                }
                //TODO call api
                currentPage = currentPage+1;
                [self fetchMovieList:movieName];
            }else{
                _tblMovies.tableFooterView.hidden = YES;
            }
        }
        
        
    }
}

#pragma mark - Api request methods
-(void)fetchMovieList:(NSString *)movieName{
    NSMutableDictionary *inpDict = [[NSMutableDictionary alloc] init];
    [inpDict setValue:movieName forKey:@"movies"];
    [inpDict setValue:[NSNumber numberWithInt:currentPage] forKey:@"currentPage"];

    [movieAppdelegate.movieApp.networkClient fetchListOfMoviesRequest:inpDict andCompletionHandler:^(id result, NSURLResponse *response, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
            [DejalKeyboardActivityView removeViewAnimated:YES];
            NSLog(@"error is %@",error.localizedDescription);
                 });
        }
        else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [DejalKeyboardActivityView removeViewAnimated:YES];
                NSDictionary *respDict = (NSDictionary *)result;
                
                if ([[respDict valueForKey:@"Response"] isEqualToString:@"True"]) {
                    NSMutableArray *recordsArray = [[NSMutableArray alloc] init];
                    recordsArray = [respDict valueForKey:@"Search"];
                    if (isFilter) {
                        [filterRecordsArray addObjectsFromArray:recordsArray];
                        
                        [searchHistoryArray addObjectsFromArray:filterRecordsArray];
                        NSMutableDictionary *historyDict =[[NSMutableDictionary alloc] init];
                        [historyDict setValue:searchHistoryArray forKey:@"list"];
                        [self saveHistoryRecords:historyDict];
                    }else{
                        [allMoviesArray addObjectsFromArray:recordsArray];
                    }
                    [_tblMovies reloadData];
                }else{
                    isLoadingMore = YES;
                    NSLog(@"No records");
                }
            });
        }
    }];
}
#pragma mark - UISearchBarDelegate

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    NSString *searchText = [searchBar.text stringByReplacingCharactersInRange:range
                                                              withString: text];
    
    BOOL isPressedBackspaceAfterSingleSpaceSymbol = [text isEqualToString:@""];
    
    if (searchText.length == 1 && ! isPressedBackspaceAfterSingleSpaceSymbol) {
        searchBar.text = searchText;
        return NO;
    }
    
    return ([searchBar.text length] + [text length] - range.length <= 50);
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    NSString *movieName= searchBar.text;
    if (movieName.length == 1) {
        movieName = @"All movies";
        isFilter = NO;
        lastSelectedTab = @"AllMovies";
        [self fetchMovieList:movieName];
    }else{
        isFilter = YES;
        if (filterRecordsArray.count > 0) {
            [filterRecordsArray removeAllObjects];
        }
        
        lastSelectedTab = @"filterMovies";
        [self fetchMovieList:movieName];
    }
    
    
    [searchBar resignFirstResponder];
}

-(void)saveHistoryRecords:(NSDictionary *)recordDict{
    NSData *historyData = [NSJSONSerialization dataWithJSONObject:recordDict options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *saveJsonPath = [movieAppdelegate.movieApp.networkClient docDirFilePath:@"historyRecords.json"];
    [historyData writeToFile:saveJsonPath atomically:YES];
}

- (IBAction)segmentAction:(id)sender {
    switch (self.movieSegment.selectedSegmentIndex) {
        case 0:{
            dispatch_async(dispatch_get_main_queue(), ^{
                isHistoryClicked = NO;
                if ([lastSelectedTab isEqualToString:@"AllMovies"]) {
                    isAllMovies = YES;
                }
                if ([lastSelectedTab isEqualToString:@"filterMovies"]) {
                    isFilter = YES;
                }
                [_tblMovies reloadData];
            });
        }
        break;
        case 1:{
            isHistoryClicked = YES;
            if ([lastSelectedTab isEqualToString:@"AllMovies"]) {
                isAllMovies = NO;
            }
            if ([lastSelectedTab isEqualToString:@"filterMovies"]) {
                isFilter = NO;
            }
            
             NSData *data = [movieAppdelegate.movieApp.networkClient fetchDataFromDocDir:@"historyRecords.json"];
            
            if (data != nil) {
                NSMutableDictionary *savedDict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                if (allHistoryArray.count > 0) {
                    [allHistoryArray removeAllObjects];
                }
                [allHistoryArray addObjectsFromArray:[savedDict valueForKey:@"list"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tblMovies reloadData];
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tblMovies reloadData];
                });
            }
            
            
        }
        break;
        
        default:
        break;
    }
}

@end
