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

static NSString * const baseURL = @"https://api.themoviedb.org/3/search/movie";
static NSString * const searchQuery = @"query";
static NSString * const imageBase = @"http://image.tmdb.org/t/p/w500";
static NSString * const apiQu = @"api_key";
static NSString * const apiKey = @"91f12a196d5f1c736169c6964e49d633";


@implementation JEFMovieController

+(void)fetchMovies:(NSString *)searchTerm completion:(void (^)(NSArray<JEFMovie *> * _Nonnull))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURL];
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:baseURL resolvingAgainstBaseURL:YES];
    NSURLQueryItem *queryq = [[NSURLQueryItem alloc] initWithName:searchQuery value:searchTerm];
    components.queryItems = @[queryq];
    NSURL *finalURL = components.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
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
           
           NSArray<NSDictionary *> *dataDict = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
           NSMutableArray *arrayofCards = [NSMutableArray new];
           
           for (NSDictionary *current in dataDict)
           {
               JEFCard *card = [[JEFCard alloc] initWithDict:current];
               [arrayofCards addObject:card];
           }
           completion(arrayofCards);
           //ompletion(arrayOfCountries);
           //check !json[NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
       }]resume];
    
}

+(void)fetchPoster:(JEFMovie *)movie completion:(void (^)(UIImage * _Nonnull))completion
{
    
}

@end
