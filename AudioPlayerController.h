//
//  AudioPlayerController.h
//  PDFFileManager
//
//  Created by ios15 on 9/3/13.
//
//

#import <UIKit/UIKit.h>

@interface AudioPlayerController : UIView
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UISlider *progressBar;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;

+ (id)initWithFilePath: (NSURL*) path;
@end
