//
//  ARMainViewController.h
//  Arima
//
//  Created by iMokhles on 21/08/16.
//
//

#import "LGSideMenuController.h"

@interface ARMainViewController : LGSideMenuController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
                         presentationStyle:(LGSideMenuPresentationStyle)style
                                      type:(NSUInteger)type;

- (NSArray *) navigationURLCollection;
- (void) beginUpdate;
- (BOOL) updating;
- (void) cancelUpdate;
- (void) setUpdateDelegate:(id)delegate;
@end
