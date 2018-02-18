//
//  NetworkClient.h
//  MobCastAssignMent
//
//  Created by apple on 17/02/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkClient : NSObject

-(void)apiGetRequest:(NSString *)url andCompletionHandler:(void(^)(id result,NSURLResponse *response, NSError *error))completionHandler;

-(void)fetchListOfMoviesRequest:(NSMutableDictionary *)inpParam  andCompletionHandler:(void(^)(id result,NSURLResponse *response, NSError *error))completionHandler;

-(void)fetchMovieDetailsRequest:(NSMutableDictionary *)inpParam  andCompletionHandler:(void(^)(id result,NSURLResponse *response, NSError *error))completionHandler;

-(NSString *)docDirFilePath:(NSString *)strForPathComponet;
-(NSData *)fetchDataFromDocDir:(NSString *)pathComponent;
@end
