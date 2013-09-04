//
//  ImageViewController.h
//  PDFFileManager
//
//  Created by HieuCoder on 9/4/13.
//
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *share;
-(void) initImageView:(NSData * )imageData;
@end
