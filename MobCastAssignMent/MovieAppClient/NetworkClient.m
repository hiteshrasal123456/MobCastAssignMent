//
//  NetworkClient.m
//  MobCastAssignMent
//
//  Created by apple on 17/02/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "NetworkClient.h"


#define BaseUrl @"http://www.omdbapi.com/?"
#define ApiKey @"da50ac10"

@implementation NetworkClient
#pragma mark - Get Method
-(void)apiGetRequest:(NSString *)url andCompletionHandler:(void (^)(id, NSURLResponse *, NSError *))completionHandler{
    NSDictionary *headers = @{ @"content-type": @"application/json"
                               };
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                    NSLog(@"%@", httpResponse);
                                                    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    completionHandler(result,response,error);
                                                }];
    [dataTask resume];
}


#pragma mark - Api request methods

-(void)fetchListOfMoviesRequest:(NSMutableDictionary *)inpParam andCompletionHandler:(void (^)(id, NSURLResponse *, NSError *))completionHandler{
    NSString *movies = [inpParam valueForKey:@"movies"];
    int page = [[inpParam valueForKey:@"currentPage"] intValue];
    
    [self apiGetRequest:[NSString stringWithFormat:@"%@s=%@&page=%d&apikey=%@",BaseUrl,movies,page,ApiKey] andCompletionHandler:^(id result, NSURLResponse *response, NSError *error) {
        completionHandler(result,response,error);

    }];
}

-(void)fetchMovieDetailsRequest:(NSMutableDictionary *)inpParam andCompletionHandler:(void (^)(id, NSURLResponse *, NSError *))completionHandler{
    NSString *movieId = [inpParam valueForKey:@"movieId"];

    [self apiGetRequest:[NSString stringWithFormat:@"%@i=%@&apikey=%@",BaseUrl,movieId,ApiKey] andCompletionHandler:^(id result, NSURLResponse *response, NSError *error) {
        completionHandler(result,response,error);
        
    }];
}
#pragma msrk - store and fetch data using document directory
-(NSString *)docDirFilePath:(NSString *)strForPathComponet{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    NSString *filePath =[documentDirectory stringByAppendingPathComponent:strForPathComponet];
    return filePath;
}
-(NSData *)fetchDataFromDocDir:(NSString *)pathComponent{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedJSonPath = [documentsDirectory stringByAppendingPathComponent:pathComponent];
    NSData * data = [NSData dataWithContentsOfFile:savedJSonPath];
    return data;
}
@end
