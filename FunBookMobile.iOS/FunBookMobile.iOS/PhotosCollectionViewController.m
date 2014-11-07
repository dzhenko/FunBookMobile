//
//  PhotosCollectionViewController.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/7/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "PhotosCollectionViewController.h"
#import "PhotosCollectionViewCell.h"
#import "Photo.h"
#import "PictureDataTransformer.h"
#import "CoreDataHelper.h"
#import "PhotoDetailsViewController.h"

@interface PhotosCollectionViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSMutableArray *photos;

@end

@implementation PhotosCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(NSMutableArray *) albums{
    if (!_albums) _albums = [[NSMutableArray alloc] init];
    return _albums;
}

-(NSMutableArray *)photos{
    if (!_photos) {
        _photos = [[NSMutableArray alloc] init];
    }
    return _photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchAlbumData];
    
    [self attachLognPressGesture];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    NSSet *unorderedPhotos = self.album.photos;
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    NSArray *sortedPhotos = [unorderedPhotos sortedArrayUsingDescriptors:@[dateDescriptor]];
    self.photos = [sortedPhotos mutableCopy];
    
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    Photo *photo = self.photos[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageView.image = photo.image;
    
    return cell;
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) image = info[UIImagePickerControllerOriginalImage];
    
    [self.photos addObject:[self photoFromImage:image]];
    
    [self.collectionView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailsSegue"]) {
        if ([segue.destinationViewController isKindOfClass:[PhotoDetailsViewController class]]) {
            PhotoDetailsViewController *targetVc = segue.destinationViewController;
            NSIndexPath *path = [[self.collectionView indexPathsForSelectedItems] lastObject];
            
            Photo *selectedPhoto = self.photos[path.row];
            targetVc.photo = selectedPhoto;
        }
    }
}

#pragma mark - Private Methods

-(Photo *)photoFromImage:(UIImage *)image{
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:[CoreDataHelper managedObjectContext]];
    photo.image = image;
    photo.date = [NSDate date];
    photo.album = self.album;
    
    NSError *error = nil;
    if (![[photo managedObjectContext] save:&error]) {
        NSLog(@"%@", error);
    }
    
    return photo;
}

- (IBAction)cameraBtnPressed:(UIBarButtonItem *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint p = [gestureRecognizer locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    if (indexPath == nil){
        NSLog(@"couldn't find index path");
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Successfully selected photo" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        // get the cell at indexPath (the one you long pressed)
        PhotosCollectionViewCell *cell = (PhotosCollectionViewCell *)
        [self.collectionView cellForItemAtIndexPath:indexPath];
        
        self.cellForCreate = cell;
        [self performSegueWithIdentifier:@"unwindBackToCreatePicture" sender:self];
    }
}

-(Album *)albumWithName:(NSString *)name{
    NSManagedObjectContext *context = [CoreDataHelper managedObjectContext];
    
    Album *album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    album.name = name;
    album.date = [NSDate date];
    
    NSError *error = nil;
    if (![context save:&error]) {
        // we have an error!
        NSLog(@"%@", error);
    }
    return album;
}

-(void)attachLognPressGesture{
    UILongPressGestureRecognizer *lpgr
    = [[UILongPressGestureRecognizer alloc]
       initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = .5; //seconds
    lpgr.delegate = self;
    lpgr.delaysTouchesBegan = YES;
    [self.collectionView addGestureRecognizer:lpgr];
}

-(void)fetchAlbumData{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]];
    
    NSError *error = nil;
    
    NSArray *fetchedAlbums = [[CoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    self.albums = [fetchedAlbums mutableCopy];
    
    self.album = self.albums[self.albums.count - 1];
}

@end
