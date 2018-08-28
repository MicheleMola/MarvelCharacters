//
//  CharacterCollectionViewCell.h
//  MarvelCharacters
//
//  Created by Michele Mola on 27/08/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Character;

@interface CharacterCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) Character *character;


@end
