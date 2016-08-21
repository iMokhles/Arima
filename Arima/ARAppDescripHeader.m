//
//  ARAppDescripHeader.m
//  Arima
//
//  Created by iMokhles on 20/08/16.
//
//

#import "ARAppDescripHeader.h"
@interface Package : NSObject
- (BOOL) uninstalled;
- (BOOL) upgradableAndEssential:(BOOL)essential;
- (BOOL) essential;
- (BOOL) broken;
- (BOOL) unfiltered;
- (BOOL) visible;
- (BOOL) half;
- (BOOL) halfConfigured;
- (BOOL) halfInstalled;
- (BOOL) hasMode;
- (bool) isCommercial;
- (NSString *) latest;
- (NSString *) installed;
- (NSString *) section;
- (NSString *) simpleSection;
- (NSString *) longSection;
- (NSString *) shortSection;
- (NSString *) uri;
- (MIMEAddress *) maintainer;
- (size_t) size;
- (NSString *) longDescription;
- (NSString *) shortDescription;
- (unichar) index;
- (time_t) seen;
- (uint32_t) rank;
- (NSString *) id;
- (NSString *) name;
- (UIImage *) icon;
- (NSString *) homepage;
- (NSString *) depiction;
- (MIMEAddress *) author;
- (NSString *) support;
- (NSArray *) files;
- (NSArray *) warnings;
- (NSArray *) applications;
- (NSString *) primaryPurpose;
- (NSArray *) purposes;
- (Source *) source;
- (NSString *)tweakVersion;
- (NSArray *) downgrades;
@end
@interface ARAppDescripHeader ()
@property (nonatomic, strong) UIImageView *imageViewIcon;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *idLabel;
@property (strong, nonatomic) UILabel *versionLabel;
@property (strong, nonatomic) UILabel *shotDescriptionLabel;
@end

@implementation ARAppDescripHeader

- (void)configureWithPackage:(Package *)package {
    NSLog(@"******** Package: %@ - %@ - %@", package.support, package.author.name, package.homepage);
    _imageViewIcon.image = package.icon;
    _titleLabel.text = package.name;
    _idLabel.text = package.id;
    _versionLabel.text = [NSString stringWithFormat:@"%@", package.tweakVersion];
    _shotDescriptionLabel.text = package.shortDescription;
    [self setNeedsDisplay];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialSetup];
    }
    
    return self;
}

- (void)initialSetup {
    _imageViewIcon = [[UIImageView alloc] init];
    _imageViewIcon.layer.masksToBounds = YES;
    _imageViewIcon.layer.borderColor = [UIColor pastelBlueColor].CGColor;
    _imageViewIcon.layer.borderWidth = 1.5f;
    _imageViewIcon.layer.cornerRadius = 18;
    _imageViewIcon.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_imageViewIcon];
    [self addIconViewConstraints];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.numberOfLines = 1;
    [self addSubview:_titleLabel];
    [self addTitleConstraints];
    
    _idLabel = [[UILabel alloc] init];
    _idLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _idLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
    _idLabel.textColor = [UIColor darkGrayColor];
    _idLabel.textAlignment = NSTextAlignmentLeft;
    _idLabel.numberOfLines = 1;
    [self addSubview:_idLabel];
    [self addIdConstrains];
    
    _versionLabel = [[UILabel alloc] init];
    _versionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _versionLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
    _versionLabel.textColor = [UIColor darkGrayColor];
    _versionLabel.textAlignment = NSTextAlignmentLeft;
    _versionLabel.numberOfLines = 1;
    [self addSubview:_versionLabel];
    [self addVersionConstrains];
    
    _shotDescriptionLabel = [[UILabel alloc] init];
    _shotDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _shotDescriptionLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
    _shotDescriptionLabel.textColor = [UIColor darkGrayColor];
    _shotDescriptionLabel.textAlignment = NSTextAlignmentLeft;
    _shotDescriptionLabel.numberOfLines = 1;
    [self addSubview:_shotDescriptionLabel];
    [self addDescriptionConstrains];
    
}

- (void)addIconViewConstraints {
    NSLayoutConstraint *_titleLabelLeadingConstraint = [NSLayoutConstraint constraintWithItem:_imageViewIcon
                                                                                    attribute:NSLayoutAttributeLeading
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self
                                                                                    attribute:NSLayoutAttributeLeading
                                                                                   multiplier:1
                                                                                     constant:IS_IPAD?20:10];
    [self addConstraint:_titleLabelLeadingConstraint];
    
    NSLayoutConstraint *_titleLabelTopConstraint = [NSLayoutConstraint constraintWithItem:_imageViewIcon
                                                                                attribute:NSLayoutAttributeTop
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeTop
                                                                               multiplier:1
                                                                                 constant:IS_IPAD?20:10];
    
    [self addConstraint:_titleLabelTopConstraint];
    
    NSLayoutConstraint *_imageViewIconWidthConstraint = [NSLayoutConstraint constraintWithItem:_imageViewIcon
                                                                                      attribute:NSLayoutAttributeWidth
                                                                                      relatedBy:NSLayoutRelationEqual
                                                                                         toItem:nil
                                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                                     multiplier:1
                                                                                       constant:IS_IPAD?90:60];
    [_imageViewIcon addConstraint:_imageViewIconWidthConstraint];
    
    NSLayoutConstraint *_imageViewIconHeightConstraint = [NSLayoutConstraint constraintWithItem:_imageViewIcon
                                                                                   attribute:NSLayoutAttributeHeight
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:nil
                                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                                  multiplier:1
                                                                                    constant:IS_IPAD?90:60];
    [_imageViewIcon addConstraint:_imageViewIconHeightConstraint];
}

- (void)addTitleConstraints {
    NSLayoutConstraint *_titleLabelTrailingConstraint = [NSLayoutConstraint constraintWithItem:_titleLabel
                                                                                    attribute:NSLayoutAttributeTrailing
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self
                                                                                    attribute:NSLayoutAttributeTrailing
                                                                                   multiplier:1
                                                                                     constant:IS_IPAD?-76:-10];
    [self addConstraint:_titleLabelTrailingConstraint];
    
    NSLayoutConstraint *_titleLabelTopConstraint = [NSLayoutConstraint constraintWithItem:_titleLabel
                                                                                attribute:NSLayoutAttributeTop
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeTop
                                                                               multiplier:1
                                                                                 constant:IS_IPAD?22:12];
    
    [self addConstraint:_titleLabelTopConstraint];
    
    NSLayoutConstraint *_titleLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_titleLabel
                                                                                   attribute:NSLayoutAttributeHeight
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:nil
                                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                                  multiplier:1
                                                                                    constant:25];
    [_titleLabel addConstraint:_titleLabelHeightConstraint];
    
    NSLayoutConstraint *_titleLabelLeadingConstraint = [NSLayoutConstraint constraintWithItem:_titleLabel
                                                                                     attribute:NSLayoutAttributeLeading
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:_imageViewIcon
                                                                                     attribute:NSLayoutAttributeTrailing
                                                                                    multiplier:1
                                                                                      constant:8];
    [self addConstraint:_titleLabelLeadingConstraint];
}
- (void)addIdConstrains {
    NSLayoutConstraint *_titleLabelTrailingConstraint = [NSLayoutConstraint constraintWithItem:_idLabel
                                                                                     attribute:NSLayoutAttributeTrailing
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:self
                                                                                     attribute:NSLayoutAttributeTrailing
                                                                                    multiplier:1
                                                                                      constant:IS_IPAD?-76:-10];
    [self addConstraint:_titleLabelTrailingConstraint];
    
    NSLayoutConstraint *_titleLabelTopConstraint = [NSLayoutConstraint constraintWithItem:_idLabel
                                                                                attribute:NSLayoutAttributeTop
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeTop
                                                                               multiplier:1
                                                                                 constant:IS_IPAD?43:31];
    
    [self addConstraint:_titleLabelTopConstraint];
    
    NSLayoutConstraint *_titleLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_idLabel
                                                                                   attribute:NSLayoutAttributeHeight
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:nil
                                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                                  multiplier:1
                                                                                    constant:25];
    [_idLabel addConstraint:_titleLabelHeightConstraint];
    
    NSLayoutConstraint *_titleLabelLeadingConstraint = [NSLayoutConstraint constraintWithItem:_idLabel
                                                                                    attribute:NSLayoutAttributeLeading
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:_imageViewIcon
                                                                                    attribute:NSLayoutAttributeTrailing
                                                                                   multiplier:1
                                                                                     constant:8];
    [self addConstraint:_titleLabelLeadingConstraint];
}
- (void)addVersionConstrains {
    NSLayoutConstraint *_titleLabelTrailingConstraint = [NSLayoutConstraint constraintWithItem:_versionLabel
                                                                                     attribute:NSLayoutAttributeTrailing
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:self
                                                                                     attribute:NSLayoutAttributeTrailing
                                                                                    multiplier:1
                                                                                      constant:IS_IPAD?-76:-10];
    [self addConstraint:_titleLabelTrailingConstraint];
    
    NSLayoutConstraint *_titleLabelTopConstraint = [NSLayoutConstraint constraintWithItem:_versionLabel
                                                                                attribute:NSLayoutAttributeTop
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeTop
                                                                               multiplier:1
                                                                                 constant:IS_IPAD?62:50];
    
    [self addConstraint:_titleLabelTopConstraint];
    
    NSLayoutConstraint *_titleLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_versionLabel
                                                                                   attribute:NSLayoutAttributeHeight
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:nil
                                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                                  multiplier:1
                                                                                    constant:25];
    [_versionLabel addConstraint:_titleLabelHeightConstraint];
    
    NSLayoutConstraint *_titleLabelLeadingConstraint = [NSLayoutConstraint constraintWithItem:_versionLabel
                                                                                    attribute:NSLayoutAttributeLeading
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:_imageViewIcon
                                                                                    attribute:NSLayoutAttributeTrailing
                                                                                   multiplier:1
                                                                                     constant:8];
    [self addConstraint:_titleLabelLeadingConstraint];
}
- (void)addDescriptionConstrains {
    NSLayoutConstraint *_titleLabelTrailingConstraint = [NSLayoutConstraint constraintWithItem:_shotDescriptionLabel
                                                                                     attribute:NSLayoutAttributeTrailing
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:self
                                                                                     attribute:NSLayoutAttributeTrailing
                                                                                    multiplier:1
                                                                                      constant:IS_IPAD?-76:-10];
    [self addConstraint:_titleLabelTrailingConstraint];
    
    NSLayoutConstraint *_titleLabelTopConstraint = [NSLayoutConstraint constraintWithItem:_shotDescriptionLabel
                                                                                attribute:NSLayoutAttributeTop
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeTop
                                                                               multiplier:1
                                                                                 constant:IS_IPAD?81:69];
    
    [self addConstraint:_titleLabelTopConstraint];
    
    NSLayoutConstraint *_titleLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_shotDescriptionLabel
                                                                                   attribute:NSLayoutAttributeHeight
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:nil
                                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                                  multiplier:1
                                                                                    constant:25];
    [_shotDescriptionLabel addConstraint:_titleLabelHeightConstraint];
    
    NSLayoutConstraint *_titleLabelLeadingConstraint = [NSLayoutConstraint constraintWithItem:_shotDescriptionLabel
                                                                                    attribute:NSLayoutAttributeLeading
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:_imageViewIcon
                                                                                    attribute:NSLayoutAttributeTrailing
                                                                                   multiplier:1
                                                                                     constant:8];
    [self addConstraint:_titleLabelLeadingConstraint];
}
@end
