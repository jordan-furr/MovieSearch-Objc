//
//  JEFMovie.m
//  MovieSearch-Objc
//
//  Created by Jordan Furr on 3/27/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

#import "JEFMovie.h"

@implementation JEFMovie

-(instancetype)initWithTitle:(NSString *)title rating:(NSNumber *)rating overview:(NSString *)overview imageString:(NSString * _Nullable)imageString
{
    self = [super init];
    
    if(self)
    {
        _title = title;
        _rating = rating;
        _overview = overview;
        _imageString = imageString;
    }
    return self;
}

-(instancetype)init
{
    return self;
    
}

@end

@implementation JEFMovie(JSONConvertable)

-(instancetype)initWithDict:(NSDictionary *)dict
{
    NSString *title = dict[@"title"];
    NSNumber *rating = dict[@"vote_average"];
    NSString *overview = dict[@"overview"];
    NSString * _Nullable imageString = dict[@"poster_path"];
    
    return [self initWithTitle:title rating:rating overview:overview imageString:imageString];
}

@end


