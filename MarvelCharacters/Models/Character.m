//
//  Character.m
//  MarvelCharacters
//
//  Created by Michele Mola on 27/08/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

#import "Character.h"

@implementation Character

+ (instancetype)characterWithDictionary:(NSDictionary *)dictionary {
  
  Character *character = [[Character alloc] init];
  
  if (character) {
    character.name = [NSString stringWithString:[dictionary valueForKey:@"name"]];
    
    NSString *path = [NSString stringWithString:[dictionary valueForKeyPath:@"thumbnail.path"]];
    NSString *extension = [NSString stringWithString:[dictionary valueForKeyPath:@"thumbnail.extension"]];
    NSString *imageURL = [NSString stringWithFormat:@"%@.%@", path, extension];
    
    character.thumbnailURL = [NSURL URLWithString:imageURL];
    
    NSLog(@"%@", character.thumbnailURL);
  }
  
  return character;
}

@end
