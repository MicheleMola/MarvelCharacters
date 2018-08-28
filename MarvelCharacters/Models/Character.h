//
//  Character.h
//  MarvelCharacters
//
//  Created by Michele Mola on 27/08/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Character : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *thumbnailURL;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSURL *detailURL;

+ (instancetype) characterWithDictionary:(NSDictionary *) dictionary;

@end
