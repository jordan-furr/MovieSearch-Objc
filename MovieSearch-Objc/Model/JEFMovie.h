//
//  JEFMovie.h
//  MovieSearch-Objc
//
//  Created by Jordan Furr on 3/27/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JEFMovie : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic) NSNumber *rating;
@property (nonatomic, copy, readonly) NSString *overview;
@property (nonatomic, copy, readonly) NSString *imageString;

-(instancetype)initWithTitle:(NSString *) title rating:(NSNumber *) rating overview:(NSString *) overview imageString:(NSString *)imageString;

@end

@interface JEFMovie (JSONConvertable)

-(instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
