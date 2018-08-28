//
//  CharacterCollectionViewCell.m
//  MarvelCharacters
//
//  Created by Michele Mola on 27/08/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

#import "CharacterCollectionViewCell.h"
#import "Character.h"

@implementation CharacterCollectionViewCell

- (void)setCharacter:(Character *)character {
  _character = character;
  
  self.name.text = character.name;
  [self downloadImageWithUrl:character.thumbnailURL];

}

- (void) downloadImageWithUrl:(NSURL*)url {
  NSURLSession *session = [NSURLSession sharedSession];
  
  NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
  
  NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    NSData *data = [NSData dataWithContentsOfURL:location];
    UIImage *image = [UIImage imageWithData:data];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      self.imageView.image = image;
    });
    
  }];
  
  [task resume];
}

@end
