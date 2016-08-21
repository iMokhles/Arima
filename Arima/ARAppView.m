//
//  ARAppView.m
//  Arima
//
//  Created by iMokhles on 20/08/16.
//
//

#import "ARAppView.h"

@implementation ARAppView

- (id)initWithFrame:(CGRect)frame imageURL:(NSURL *)image title:(NSString *)imageTitle subTitle:(NSString *)imageSubTitle andApp:(id)item
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUserInteractionEnabled:YES];
        
        
        self.imageTitle = imageTitle;
        self.imageSubTitle = imageSubTitle;
        self.imageURL = image;
        self.currentItem = item;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:image placeholderImage:[UIImage imageNamed:@"unknown"]];
        imageRect = CGRectMake(0.0, 0.0, 60.0, 60.0);
        [imageView setFrame:imageRect];
        
        
        CALayer *roundCorner = [imageView layer];
        [roundCorner setMasksToBounds:YES];
        [roundCorner setCornerRadius:15.0];
        //        [roundCorner setBorderColor:[UIColor blackColor].CGColor];
        //        [roundCorner setBorderWidth:1.0];
        
        UILabel *title = [[UILabel alloc] init];
        textRect = CGRectMake(0.0, imageRect.origin.y + imageRect.size.height + 4.0, 60, 20.0);
        [title setFrame:textRect];
        
        [title setBackgroundColor:[UIColor clearColor]];
        [title setTextColor:[UIColor darkGrayColor]];
        [title setFont:[UIFont boldSystemFontOfSize:10.0]];
        [title setTextAlignment:NSTextAlignmentCenter];
        [title setOpaque: NO];
        [title setText:imageTitle];
        title.numberOfLines=3;
        title.lineBreakMode=NSLineBreakByWordWrapping;
        [title sizeToFit];
        [title setFrame:CGRectMake(0, textRect.origin.y, 60, title.frame.size.height)];
        
        UILabel *subTitle = [[UILabel alloc] init];
        subRect = CGRectMake(0.0, textRect.origin.y + title.frame.size.height + 3.0, 60.0, 20.0);
        [subTitle setFrame:subRect];
        
        [subTitle setBackgroundColor:[UIColor clearColor]];
        [subTitle setTextColor:[UIColor darkGrayColor]];
        [subTitle setFont:[UIFont systemFontOfSize:8]];
        [subTitle setOpaque: NO];
        [subTitle setTextAlignment:NSTextAlignmentCenter];
        [subTitle setText:[NSString stringWithFormat:@"%@", imageSubTitle]];
        subTitle.numberOfLines=0;
        subTitle.lineBreakMode=NSLineBreakByWordWrapping;
        [subTitle sizeToFit];
        [subTitle setFrame:CGRectMake(0, subRect.origin.y, 60, subTitle.frame.size.height)];
        
        [self addSubview:imageView];
        [self addSubview:title];
        [self addSubview:subTitle];
        
        //        title.center = CGPointMake(title.center.x, title.center.y);
        
    }
    
    return self;
}
@end
