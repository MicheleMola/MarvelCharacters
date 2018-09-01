//
//  ImageController.m
//  MarvelCharacters
//
//  Created by Michele Mola on 01/09/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

#import "ImageController.h"

@interface ImageController ()

@end

@implementation ImageController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setupGestures];
  
  if (self.image) {
    self.imageView.image = self.image;
  }
}

- (void)setupGestures {
  UITapGestureRecognizer *dismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
  
  dismiss.numberOfTapsRequired = 1;
  
  [self.view addGestureRecognizer:dismiss];
  
  UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToDismiss)];
  swipe.direction = UISwipeGestureRecognizerDirectionRight;
  [self.view addGestureRecognizer:swipe];
}

- (void)dismiss {
  
  [UIView animateWithDuration:0.5 animations:^{
    self.view.transform = CGAffineTransformMakeScale(0.01, 0.01);
    self.view.alpha = 0.0;
  } completion:^(BOOL finished) {
    [self dismissViewControllerAnimated:YES completion:nil];
  }];
}

- (void)swipeToDismiss {
  [UIView animateWithDuration:0.5 animations:^{
    self.view.transform = CGAffineTransformMakeTranslation(400, 0);
  } completion:^(BOOL finished) {
    [self dismissViewControllerAnimated:YES completion:nil];
  }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
