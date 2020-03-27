//
//  JEFMovieController.h
//  MovieSearch-Objc
//
//  Created by Jordan Furr on 3/27/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class JEFMovie;

NS_ASSUME_NONNULL_BEGIN

@interface JEFMovieController : NSObject

+(void)fetchMovies:(NSString *) searchTerm completion:(void(^)(NSArray<JEFMovie *> *))completion;
+(void)fetchPoster:(JEFMovie *) movie completion:(void(^)(UIImage * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
