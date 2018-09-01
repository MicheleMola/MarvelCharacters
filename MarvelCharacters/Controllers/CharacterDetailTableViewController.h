//
//  CharacterDetailTableViewController.h
//  MarvelCharacters
//
//  Created by Michele Mola on 28/08/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Character;

@interface CharacterDetailTableViewController : UITableViewController

@property (strong, nonatomic) Character *character;
@property (strong, nonatomic) UIImage *image;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;


@end
