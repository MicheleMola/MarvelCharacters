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
    
    character.desc = [NSString stringWithString:[dictionary valueForKey:@"description"]];
    
    NSArray *urlsDict = [dictionary valueForKey:@"urls"];
    NSString *detail = [urlsDict[0] objectForKey:@"url"];
    character.detailURL = [NSURL URLWithString:detail];
    
    //NSLog(@"%@", [urlsDict[0] objectForKey:@"url"]);
  }
  
  return character;
}

@end
