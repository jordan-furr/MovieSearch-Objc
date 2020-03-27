//
//  JEFMovieController.m
//  MovieSearch-Objc
//
//  Created by Jordan Furr on 3/27/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

#import "JEFMovieController.h"
#import "JEFMovie.h"
#import <UIKit/UIKit.h>

static NSString * const baseURLString = @"https://api.themoviedb.org/3/search/movie";
static NSString * const searchQuery = @"query";
static NSString * const imageBase = @"http://image.tmdb.org/t/p/w500";
static NSString * const apiQu = @"api_key";
static NSString * const apiKey = @"91f12a196d5f1c736169c6964e49d633";


@implementation JEFMovieController

+(void)fetchMovies:(NSString *)searchTerm completion:(void (^)(NSArray<JEFMovie *> *))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:baseURL resolvingAgainstBaseURL:YES];
    NSURLQueryItem *queryq = [[NSURLQueryItem alloc] initWithName:searchQuery value:searchTerm];
    NSURLQueryItem *apiQuery = [[NSURLQueryItem alloc] initWithName:apiQu value:apiKey];
    components.queryItems = @[queryq, apiQuery
    ];
    NSURL *finalURL = components.URL;
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error) {
            NSLog(@"Error fetching movies from searchterm: %@", error);
            completion(nil);
            return;
        }
        
        if (!data){
            NSLog(@"Error fethcing movie data from search term: %@", error);
            completion(nil);
            return;
        }
        
        NSDictionary *resultsDict = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
        
        if (!resultsDict || ![resultsDict isKindOfClass:[NSDictionary class]]){
            NSLog(@"Error fetching json dictionary: %@", error);
            completion(nil);
            return;
        }
        NSMutableArray *arrayofMovies = [NSMutableArray new];
        NSArray<NSDictionary *> *movieResults = resultsDict[@"results"];
        
        
        for (NSDictionary *current in movieResults)
        {
            JEFMovie *movie = [[JEFMovie alloc] initWithDict:current];
            [arrayofMovies addObject:movie];
        }
        completion(arrayofMovies);
    }]resume];
    
}

+(void)fetchPoster:(JEFMovie *)movie completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:imageBase];
    NSURL *imageURL = [baseURL URLByAppendingPathComponent:movie.imageString];
    
    NSLog(@"%@", imageURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError *  _Nullable error) {
        if(error) {
            NSLog(@"Error fetching pokemon from searchterm: %@", error);
            completion(nil);
            return;
        }
        
        if (!data){
            NSLog(@"Error fethcing pokemon data from search term: %@", error);
            completion(nil);
            return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        completion(image);
    }]resume];
}

@end
