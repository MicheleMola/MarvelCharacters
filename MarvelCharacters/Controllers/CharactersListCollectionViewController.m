//
//  CharactersListCollectionViewController.m
//  MarvelCharacters
//
//  Created by Michele Mola on 27/08/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

#import "CharactersListCollectionViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "Character.h"
#import "CharacterCollectionViewCell.h"
#import "CharacterDetailTableViewController.h"
#import "SVProgressHUD.h"

@interface CharactersListCollectionViewController ()

@property (strong, nonatomic) NSMutableArray *characters;

@end

@implementation CharactersListCollectionViewController

static NSString * const reuseIdentifier = @"CharacterCell";

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.characters = [NSMutableArray array];

  [self getCharacters:0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getCharacters:(NSInteger *)offset {
  [SVProgressHUD show];
  NSURLSession *session = [NSURLSession sharedSession];
  
  // Generate MD5 from Timestamp
  NSString * timestamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
  NSString *publicKey = @"2f3f553f47ccae03a0c0c244b628b9d8";
  NSString *privateKey = @"560ca1b5e7c0ab0ce499e5ba0801e7310d75b518";
  
  NSString *myHash = [self generateMD5:[NSString stringWithFormat:@"%@%@%@", timestamp, privateKey, publicKey]];
  
  // URL Components
  NSURLComponents *components = [NSURLComponents componentsWithString:@"https://gateway.marvel.com:443/v1/public/characters"];
  NSURLQueryItem *ts = [NSURLQueryItem queryItemWithName:@"ts" value:timestamp];
  NSURLQueryItem *hash = [NSURLQueryItem queryItemWithName:@"hash" value:myHash];
  NSURLQueryItem *apiKey = [NSURLQueryItem queryItemWithName:@"apikey" value:publicKey];
  
  NSString *inToStr = [NSString stringWithFormat: @"%ld", (long)offset];
  NSURLQueryItem *offse = [NSURLQueryItem queryItemWithName:@"offset" value:inToStr];
  
  components.queryItems = @[ ts, apiKey, hash, offse ];
  NSURL *url = components.URL;
  
  NSURLSessionDownloadTask *task = [session downloadTaskWithURL: url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    if (error != nil) {
      [self showAlert:error.localizedDescription];
      [SVProgressHUD dismiss];
      return;
    }
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:location];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSArray *dictionaries = [dictionary valueForKeyPath:@"data.results"];
    
    for(NSDictionary *dict in dictionaries) {
      
      Character *character = [Character characterWithDictionary:dict];
      
      [self.characters addObject:character];
      
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.collectionView reloadData];
      [SVProgressHUD dismiss];
    });
    
  }];
  [task resume];
}

- (void)showAlert:(NSString *) message {
  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert" message:message preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
  
  [alert addAction:defaultAction];
  [self presentViewController:alert animated:YES completion:nil];
}

- (NSString *) generateMD5:(NSString *) input {
  const char *cStr = [input UTF8String];
  unsigned char digest[16];
  CC_MD5( cStr, strlen(cStr), digest );
  
  NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
  
  for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    [output appendFormat:@"%02x", digest[i]];
  
  return  output;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"showDetail"]) {
    NSIndexPath *selectedIndexPath = [self.collectionView indexPathsForSelectedItems][0];
    
    Character *character = self.characters[selectedIndexPath.row];
    CharacterDetailTableViewController *characterDetailTableViewController = segue.destinationViewController;
    
    characterDetailTableViewController.character = character;
  }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return [self.characters count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  CharacterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
  
  // Configure the cell
  Character *character = [self.characters objectAtIndex:indexPath.row];
  cell.character = character;
  
  return cell;
}



#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == [self.characters count]-1) {
    NSInteger *offset = indexPath.row + 1;
    
    [self getCharacters:offset];
  }
  
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(170, 240);
}

@end
