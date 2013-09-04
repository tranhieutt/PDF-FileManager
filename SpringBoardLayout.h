//
//  SpringBoardLayout.h
//  iPhoneHTTPServer
//
//  Created by Mac on 8/29/13.
//
//

#import <UIKit/UIKit.h>
@protocol SpringboardLayoutDelegate <UICollectionViewDelegateFlowLayout>
@required
- (BOOL) isDeletionModeActiveForCollectionView: (UICollectionView *)collectionView layout:
(UICollectionViewLayout *   ) collectionViewLayout;

@end    
@interface SpringBoardLayout : UICollectionViewFlowLayout

@end
