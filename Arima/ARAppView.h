//
//  ARAppView.h
//  Arima
//
//  Created by iMokhles on 20/08/16.
//
//

#import <UIKit/UIKit.h>
#import "Arima.hpp"

@interface ARAppView : UIView
{
    CGRect textRect;
    CGRect subRect;
    CGRect imageRect;
}
@property (nonatomic, retain) NSObject *objectTag;

@property (nonatomic, retain) NSString *imageTitle;
@property (nonatomic, retain) NSString *imageSubTitle;
@property (nonatomic, retain) NSURL *imageURL;
@property (nonatomic, retain) UIImage *image;
@property id currentItem;

- (id)initWithFrame:(CGRect)frame imageURL:(NSURL *)image title:(NSString *)imageTitle subTitle:(NSString *)imageSubTitle andApp:(id)item;
@end
