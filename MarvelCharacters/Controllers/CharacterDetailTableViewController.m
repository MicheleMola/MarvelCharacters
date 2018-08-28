//
//  CharacterDetailTableViewController.m
//  MarvelCharacters
//
//  Created by Michele Mola on 28/08/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

#import "CharacterDetailTableViewController.h"
#import "Character.h"
#import <SafariServices/SafariServices.h>

@interface CharacterDetailTableViewController () <SFSafariViewControllerDelegate>

@end

@implementation CharacterDetailTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  if (self.character) {
    [self downloadImageWithUrl:self.character.thumbnailURL];
    self.nameLabel.text = self.character.name;
    self.descriptionTextView.text = self.character.desc;
    
    if ([self.character.desc length] == 0) {
      self.descriptionTextView.text = @"No Description Available";
    }
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)moreDetailPressed:(UIButton *)sender {
  if (self.character) {
    SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:self.character.detailURL];
    svc.delegate = self;
    [self presentViewController:svc animated:YES completion:nil];
  }
}

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
  [self dismissViewControllerAnimated:true completion:nil];
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
