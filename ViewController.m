//
//  ViewController.m
//  iPhoneHTTPServer
//
//  Created by Mac on 8/29/13.
//
//

#import "ViewController.h"
#import "Icon.h"
#import "SpringBoardLayout.h"
#import "FileManager.h"
#import "ReaderViewController.h"
#import "Web_ViewController.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <math.h>
#import <QuartzCore/QuartzCore.h>
#import "AudioPlayerController.h"
//#import "RNFrostedSidebar.h"
#import "ImageViewController.h"
@interface ViewController ()
{
    BOOL isDeletionModelActive;
    NSTimer *timer;
    FileManager *fm;
    int tmpCount;
}

@end

@implementation ViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        self.title = @"NEW";
//    }
//    return self;
//}
- (void)initFileManager
{
    fm                 = [[FileManager alloc]init];
    _fileManager       = [NSFileManager defaultManager];
    _paths             =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _documentDirectory = [_paths objectAtIndex:0];
    _url = [[NSURL alloc] initFileURLWithPath:_documentDirectory];
  
    _itemsInApps       = [fm contentOfAppBundle:_url]; // return url full of anywayfile
    tmpCount           = _itemsInApps.count;


}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initFileManager];
    [self.collectionView registerClass:[Icon class]
            forCellWithReuseIdentifier:@"ICON"];
    self.collectionView.backgroundColor = [UIColor darkGrayColor];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self
                                                                                           action:@selector(activateDeletionMode:)];
    longPress.delegate                      = self;
    [self.collectionView addGestureRecognizer:longPress];

    UITapGestureRecognizer  *tap            = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                     action:@selector(endDeletionMode:)];// tap to end deletion mode
    tap.delegate  = self;
    [self.collectionView addGestureRecognizer:tap];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
}
- (void) showIpAddressWithPort: (NSString *) port
{
    NSString *ip = [self getIPAddress];
    ip = [ip stringByAppendingFormat:@": %@ ----- Server Started", port];
    UILabel *ipLb = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320, 30)];
    ipLb.text = ip;
    [self.view addSubview:ipLb];
}
//- (NSInteger    )numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 8;
//}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _itemsInApps.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Icon *icon = [collectionView dequeueReusableCellWithReuseIdentifier:@"ICON" forIndexPath:indexPath  ];
    
    
    NSURL *filePath    = [_itemsInApps objectAtIndex:indexPath.row];
    
    NSString *fileName = [filePath lastPathComponent];
    NSData *data       = [NSData dataWithContentsOfURL:filePath];
    NSArray *array     = [fileName componentsSeparatedByString:@"."];
    NSString *format   = array[array.count - 1];
    format = [format lowercaseString];
    if([format isEqualToString:@"png"] ||
       [format isEqualToString:@"jpg"] ||
       [format isEqualToString:@"jpeg"])
    {
        icon.imageView.image                          = [UIImage imageWithData:data];
       
    } else if ([format isEqualToString:@"pdf"])
      {
        icon.imageView.image                          = [UIImage imageNamed:@"pdf_file.png"];
      }
    else if ([format isEqualToString:@"html"])
      {
        icon.imageView.image                          = [UIImage imageNamed:@"HTML.png"];
      }
    else if ([format isEqualToString:@"mp3"])
    {
        icon.imageView.image                          = [UIImage imageNamed:@"audio file.png"];
    }
    icon.imageView.layer.cornerRadius = 10.0f;
    
    
     icon.label.text = fileName;
    [icon.deleteButton addTarget:self
                          action:@selector(delete:)
                forControlEvents:UIControlEventTouchUpInside];
    return  icon;
}
- (BOOL) isDeletionModeActiveForCollectionView:(UICollectionView *)collectionView
                                        layout:(UICollectionViewLayout*)collectionViewLayout
{
    return isDeletionModelActive;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - delete for button
- (void)delete:(UIButton *  )sender
{
    
    NSIndexPath *indexPath                             = [self.collectionView indexPathForCell:(Icon *) sender.superview.superview];
    
    NSURL *filePathAtCell                              = [_itemsInApps objectAtIndex:indexPath.row];
    NSString *fileName                                 = [filePathAtCell lastPathComponent];
    NSString *pathFileName                             = [_documentDirectory stringByAppendingPathComponent:fileName];
    [_fileManager removeItemAtPath:pathFileName error:nil];
    
    [_itemsInApps removeObjectAtIndex:indexPath.row];
    [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    
  //  _itemsInApps = [fm contentOfAppBundle:_url];
   // [self.collectionView reloadData];
    
}
#pragma mark- gesture- recognitiong action method// Xac nhan tinh nang gestureRecognizer
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint touchPoint                                 = [touch locationInView:self.collectionView];
    NSIndexPath *indexPath                             = [self.collectionView indexPathForItemAtPoint:touchPoint];
    if (indexPath && [gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        return NO;
    }
    return YES;
}
- (void)activateDeletionMode : (UILongPressGestureRecognizer*)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        NSIndexPath *indexPath                        = [self.collectionView indexPathForItemAtPoint:[longPress locationInView:self.collectionView]];
        NSLog(@" %@",indexPath);
        if (indexPath)
        {
            isDeletionModelActive                     = YES;
            SpringBoardLayout *layout                 = (SpringBoardLayout *) self.collectionView.collectionViewLayout;
            [layout invalidateLayout];
        }
        
        
    }
}
- (void)endDeletionMode : (UITapGestureRecognizer *) tap
{
    if (isDeletionModelActive)
    {
        NSIndexPath *indexPath                        = [self.collectionView indexPathForItemAtPoint:[tap locationInView:self.collectionView]] ;
        if (!indexPath)
        {
            isDeletionModelActive = NO;
            SpringBoardLayout *layout                 = (SpringBoardLayout *)self.collectionView.collectionViewLayout;
            [layout invalidateLayout];
        }
    }
}
#pragma mark - new ViewController

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath //Caution! Mistake if use diddeselect
{
    
    

    NSURL *filePath                                  = [_itemsInApps objectAtIndex:indexPath.row];  // change type frm NSSTring to NSURL
    NSString *fileName                               = [filePath lastPathComponent];
    NSLog(@"file Name %@",fileName);
    // Get type file
    NSArray *array                                   = [fileName componentsSeparatedByString:@"."];
    NSString *format                                 = array[array.count - 1];
    format                                           = [format lowercaseString];
    
    if([format isEqualToString:@"png"] || [format isEqualToString:@"jpg"] || [format isEqualToString:@"jpeg"])
    {
        ImageViewController  *imageViewController    = [[ImageViewController alloc]init];
        NSData  *data                                = [NSData dataWithContentsOfURL:filePath];
        imageViewController.modalTransitionStyle     =  UIModalTransitionStyleCoverVertical;
        [self presentViewController:imageViewController animated:YES completion:^{
            [imageViewController initImageView:data];
        }];
        
    } else if ([format isEqualToString:@"pdf"])
        {
             NSString *newFilePath = [[NSString stringWithFormat:@"%@",filePath]substringFromIndex:16];
             newFilePath = [newFilePath stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@" %@",newFilePath    );
             ReaderDocument     *document                      = [[ReaderDocument alloc] initWithFilePath:newFilePath password:nil];
            if (document != nil)
             {
                 ReaderViewController *readerViewController    = [[ReaderViewController alloc] initWithReaderDocument:document];
                 readerViewController.delegate                 = self;
                 readerViewController.modalTransitionStyle     = UIModalTransitionStyleCrossDissolve;
                 readerViewController.modalPresentationStyle   = UIModalPresentationCurrentContext;
                 [self presentViewController:readerViewController animated:NO completion:nil];
             }
        }
     else if  ([format isEqualToString:@"html"])
        {
        
        Web_ViewController *webViewController       = [[Web_ViewController alloc]init];
        webViewController.view.frame                = [UIScreen mainScreen].bounds;
        
//        
//        UIToolbar *toolbar                         = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, webViewController.view.frame.size.width, 48)];
//        [toolbar setBackgroundImage:[UIImage imageNamed:@"dark.jpg"]
//                 forToolbarPosition:UIToolbarPositionTop
//                         barMetrics:UIBarMetricsDefault];
//        UIImage* inputImage                        =     [UIImage imageNamed:@"back.png"];
//        CGRect frameInput                          =     CGRectMake(0, 0, inputImage.size.width, inputImage.size.height);
//        UIButton *inputButton                      =     [[UIButton alloc] initWithFrame:frameInput];
//        [inputButton setBackgroundImage:inputImage
//                               forState:UIControlStateNormal];
//        
//        [inputButton addTarget:self
//                        action:@selector(dismiss)
//              forControlEvents:UIControlEventTouchUpInside];
//            
//        UIBarButtonItem *inputButtonItem           =      [[UIBarButtonItem alloc] initWithCustomView:inputButton];
//            UIBarButtonItem *replyButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:webViewController action:@selector(dismiss)];
//            
//        self.navigationItem.leftBarButtonItem      =      replyButton;
//        //[webViewController.view addSubview:inputButton];
        webViewController.modalTransitionStyle     = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:webViewController
                           animated:YES completion:
         ^{
             NSString *newFilePath = [[[NSString stringWithFormat:@"%@",filePath] substringFromIndex:16]
                                      stringByReplacingOccurrencesOfString:@"%20"
                                      withString:@" "];
             [webViewController initWebview:newFilePath];
         }];
    }
     else if  ([format isEqualToString:@"mp3"])
     {
         NSLog(@"MP3 FILE");
         
         AudioPlayerController *audioPlayer = [AudioPlayerController initWithFilePath:filePath];
         audioPlayer.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
         audioPlayer.alpha = 0.0f;
         [self.view addSubview:audioPlayer];
         [UIView animateWithDuration:1.0f animations:^{
             audioPlayer.alpha = 1.0f;
         }];
     }

}


- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dismisst
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dismissReaderViewController:(ReaderViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) handleTimer: (NSTimer*) timer
{
    _itemsInApps = [fm contentOfAppBundle:_url];
    int off = _itemsInApps.count - tmpCount;
    if(off >0 ){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"%d file have been added!!!", off] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
//    else if(off < 0)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"%d file have been deleted!!!", abs(off)] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
    tmpCount = _itemsInApps.count;
    [self.collectionView reloadData];
}
- (void) displayMessage: (NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
- (NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}
@end
