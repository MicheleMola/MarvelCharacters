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
#import "ImageController.h"

@interface CharacterDetailTableViewController () <SFSafariViewControllerDelegate>

@end

@implementation CharacterDetailTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setupGesture];
  
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"showImage"]) {
    
    ImageController *imageController = segue.destinationViewController;
    imageController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    imageController.image = self.image;
  }
}

- (void)setupGesture {
  UITapGestureRecognizer *showImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImage)];
  showImage.numberOfTapsRequired = 1;
  
  [self.imageView addGestureRecognizer:showImage];
  
}

- (void)showImage {
  [self performSegueWithIdentifier:@"showImage" sender:self];
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
    
    if (error != nil) {
      return;
    }
    
    NSData *data = [NSData dataWithContentsOfURL:location];
    UIImage *image = [UIImage imageWithData:data];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      self.imageView.image = image;
      self.image = image;
    });
    
  }];
  
  [task resume];
}

@end
