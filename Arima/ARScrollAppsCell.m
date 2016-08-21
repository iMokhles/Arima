//
//  ARScrollAppsCell.m
//  Arima
//
//  Created by iMokhles on 20/08/16.
//
//

#import "ARScrollAppsCell.h"

#define DISTANCE_BETWEEN_ITEMS  15.0
#define LEFT_PADDING            15.0
#define ITEM_WIDTH              60.0
#define TITLE_HEIGHT            40.0

@interface ARScrollAppsCell ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ARScrollAppsCell

- (void)configureWithTitle:(NSString *)title items:(NSMutableArray *)items {
    _titleLabel.text = title;
    
    CGSize pageSize = CGSizeMake(ITEM_WIDTH, _scrollView.frame.size.height);
    NSUInteger page = 0;
    
    for(ARAppView *item in items) {
        [item setFrame:CGRectMake(LEFT_PADDING + (pageSize.width + DISTANCE_BETWEEN_ITEMS) * page++, 0, pageSize.width, pageSize.height)];
        
        UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTapped:)];
        [item addGestureRecognizer:singleFingerTap];
        [_scrollView addSubview:item];
    }
    
    _scrollView.contentSize = CGSizeMake(LEFT_PADDING + (pageSize.width + DISTANCE_BETWEEN_ITEMS) * [items count], pageSize.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
//    [self setNeedsDisplay];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initialSetup];
    }
    
    return self;
}

//- (void)awakeFromNib {
//    [super awakeFromNib];
//
//    [self initialSetup];
//}

- (void)initialSetup {
    _showMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _showMoreButton.frame = CGRectMake(0, 0, 64, 21);
    _showMoreButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_showMoreButton setTitle:@"Show more >" forState:UIControlStateNormal];
    [_showMoreButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [_showMoreButton setBackgroundColor:[UIColor clearColor]];
    [_showMoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_showMoreButton addTarget:self action:@selector(showMoreTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_showMoreButton];
    [self showMoreButtonConstraints];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.font = [UIFont systemFontOfSize:17.0f];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.numberOfLines = 1;
    [self.contentView addSubview:_titleLabel];
    [self titleLabelConstraints];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(8, 44, 568, 140)];
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    _scrollView.scrollEnabled = YES;
    _scrollView.bounces = YES;
    _scrollView.bouncesZoom = YES;
    _scrollView.delaysContentTouches = YES;
    _scrollView.canCancelContentTouches = YES;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_scrollView];
    [self scrollViewConstraints];
}

- (void)showMoreButtonConstraints {
    NSLayoutConstraint *_showMoreButtonTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                         attribute:NSLayoutAttributeTrailing
                                                                                         relatedBy:NSLayoutRelationEqual
                                                                                            toItem:_showMoreButton
                                                                                         attribute:NSLayoutAttributeTrailing
                                                                                        multiplier:1
                                                                                          constant:14];
    [self.contentView addConstraint:_showMoreButtonTrailingConstraint];
    
    NSLayoutConstraint *_showMoreButtonWidthConstraint = [NSLayoutConstraint constraintWithItem:_showMoreButton
                                                                                      attribute:NSLayoutAttributeWidth
                                                                                      relatedBy:NSLayoutRelationEqual
                                                                                         toItem:nil
                                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                                     multiplier:1
                                                                                       constant:80];
    [_showMoreButton addConstraint:_showMoreButtonWidthConstraint];
    
    NSLayoutConstraint *_showMoreButtonHeightConstraint = [NSLayoutConstraint constraintWithItem:_showMoreButton
                                                                                       attribute:NSLayoutAttributeHeight
                                                                                       relatedBy:NSLayoutRelationEqual
                                                                                          toItem:nil
                                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                                      multiplier:1
                                                                                        constant:21];
    [_showMoreButton addConstraint:_showMoreButtonHeightConstraint];
    
    NSLayoutConstraint *_showMoreButtonTopConstraint = [NSLayoutConstraint constraintWithItem:_showMoreButton
                                                                                    attribute:NSLayoutAttributeTop
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.contentView
                                                                                    attribute:NSLayoutAttributeTop
                                                                                   multiplier:1
                                                                                     constant:8];
    [self.contentView addConstraint:_showMoreButtonTopConstraint];
    
//    NSLayoutConstraint *_showMoreButtonLeadingConstraint = [NSLayoutConstraint constraintWithItem:_showMoreButton
//                                                                                     attribute:NSLayoutAttributeLeading
//                                                                                     relatedBy:NSLayoutRelationEqual
//                                                                                        toItem:_titleLabel
//                                                                                     attribute:NSLayoutAttributeTrailing
//                                                                                    multiplier:1
//                                                                                      constant:8];
//    [self.contentView addConstraint:_showMoreButtonLeadingConstraint];
}

- (void)titleLabelConstraints {
    NSLayoutConstraint *_titleLabelLeadingConstraint = [NSLayoutConstraint constraintWithItem:_titleLabel
                                                                                      attribute:NSLayoutAttributeLeading
                                                                                      relatedBy:NSLayoutRelationEqual
                                                                                         toItem:self.contentView
                                                                                      attribute:NSLayoutAttributeLeading
                                                                                     multiplier:1
                                                                                       constant:8];
    [self.contentView addConstraint:_titleLabelLeadingConstraint];
    
    NSLayoutConstraint *_titleLabelTopConstraint = [NSLayoutConstraint constraintWithItem:_titleLabel
                                                                                  attribute:NSLayoutAttributeTop
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.contentView
                                                                                  attribute:NSLayoutAttributeTop
                                                                                 multiplier:1
                                                                                   constant:8];
    
    [self.contentView addConstraint:_titleLabelTopConstraint];
    
    NSLayoutConstraint *_titleLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_titleLabel
                                                                                     attribute:NSLayoutAttributeHeight
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:nil
                                                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                                                    multiplier:1
                                                                                      constant:21];
    [_titleLabel addConstraint:_titleLabelHeightConstraint];
    
    NSLayoutConstraint *_titleLabelTrailingConstraint = [NSLayoutConstraint constraintWithItem:_titleLabel
                                                                                    attribute:NSLayoutAttributeTrailing
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:_showMoreButton
                                                                                    attribute:NSLayoutAttributeLeading
                                                                                   multiplier:1
                                                                                     constant:8];
    [self.contentView addConstraint:_titleLabelTrailingConstraint];
    
}

- (void)scrollViewConstraints {
    NSLayoutConstraint *_scrollViewButtonTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                         attribute:NSLayoutAttributeTrailing
                                                                                         relatedBy:NSLayoutRelationEqual
                                                                                            toItem:_scrollView
                                                                                         attribute:NSLayoutAttributeTrailing
                                                                                        multiplier:1
                                                                                          constant:8];
    [self.contentView addConstraint:_scrollViewButtonTrailingConstraint];
    
    NSLayoutConstraint *_scrollViewLeadingConstraint = [NSLayoutConstraint constraintWithItem:_scrollView
                                                                                    attribute:NSLayoutAttributeLeading
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.contentView
                                                                                    attribute:NSLayoutAttributeLeading
                                                                                   multiplier:1
                                                                                     constant:8];
    [self.contentView addConstraint:_scrollViewLeadingConstraint];
    
    NSLayoutConstraint *_scrollViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                       attribute:NSLayoutAttributeBottom
                                                                                       relatedBy:NSLayoutRelationEqual
                                                                                          toItem:_scrollView
                                                                                       attribute:NSLayoutAttributeBottom
                                                                                      multiplier:1
                                                                                        constant:8];
    [self.contentView addConstraint:_scrollViewBottomConstraint];
    
    NSLayoutConstraint *_scrollViewHeightConstraint = [NSLayoutConstraint constraintWithItem:_scrollView
                                                                                   attribute:NSLayoutAttributeHeight
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:nil
                                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                                  multiplier:1
                                                                                    constant:145];
    [_scrollView addConstraint:_scrollViewHeightConstraint];
}

- (void)itemTapped:(UITapGestureRecognizer *)recognizer {
    ARAppView *item = (ARAppView *)recognizer.view;
    
    if (item != nil) {
        self.itemTappedBlock(self, item);
    }
}

- (void)showMoreTapped:(UIButton *)sender {
    self.showAllTappedBlock(self, sender);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
