//
//  ARHelper.m
//  Arima
//
//  Created by iMokhles on 20/08/16.
//
//

#import "ARHelper.h"
#import "Arima.hpp"


@implementation ARHelper
+ (void)setup_Server {
    
    [Parse setLogLevel:PFLogLevelInfo];
    
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        
        configuration.applicationId = @"YOUR_PARSE_APP_ID";
        configuration.clientKey = @"YOUR_PARSE_CLIENt_ID";
        configuration.server = @"YOUR_PARSE_SERVER_URL";
        configuration.localDatastoreEnabled = YES;
    }]];
}

+ (UIView *)loginLogoView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 114)];
    headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, -20, width, 57)];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titleLabel.text = @"Arima Tweak";
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:45];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.shadowOffset = CGSizeMake(0, 1);
    titleLabel.numberOfLines = 1;
    titleLabel.center = CGPointMake(headerView.frame.size.width/2, headerView.frame.size.height/2);
    
    [headerView addSubview:titleLabel];
    return headerView;
}
+ (void)signupUserWithInfo:(NSDictionary *)userInfo fromtarget:(id)target completion:(iMBooleanResultBlock)completion {
    PFUser *newUser = [[PFUser alloc] init];
    
    // set user username
    newUser.username = userInfo[USER_USERNAME];
    
    // set user email
    newUser.email = userInfo[USER_EMAIL];
    
    // set user password
    newUser.password = userInfo[USER_PASS_WORD];
    
    // set user fullname
    newUser[USER_FULLNAME] = userInfo[USER_FULLNAME];
    
    // set user device push token
    newUser[USER_DEVICE_TOKEN] = [NSString stringWithFormat:@"%@",userInfo[USER_DEVICE_TOKEN]];
    
    // set user player id push token
    newUser[USER_DEVICE_PLAYER_ID] = [NSString stringWithFormat:@"%@",userInfo[USER_DEVICE_PLAYER_ID]];
    
    // set user image
//    newUser[USER_AVATAR] = [PFFile fileWithData:UIImagePNGRepresentation(userImage)];
    
    // start sign-up thread
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        completion(succeeded, error);
    }];
}

+ (void)loginOrSignUpFromTarget:(id)target {
    PFLogInViewController *loginPage = [[PFLogInViewController alloc] init];
    
    loginPage.delegate = target;
    loginPage.fields = PFLogInFieldsUsernameAndPassword  | PFLogInFieldsLogInButton | PFLogInFieldsSignUpButton;
    loginPage.logInView.logo = [ARHelper loginLogoView];
    [loginPage.logInView.logo setFrame:CGRectMake(0, 0, 140, 70)];
    
    loginPage.signUpController.delegate = target;
    loginPage.signUpController.fields = PFSignUpFieldsUsernameAndPassword  | PFSignUpFieldsEmail | PFSignUpFieldsSignUpButton | PFSignUpFieldsDismissButton;
    loginPage.signUpController.signUpView.logo = [ARHelper loginLogoView];
    [loginPage.signUpController.signUpView.logo setFrame:CGRectMake(0, 0, 140, 70)];
    dispatch_async(dispatch_get_main_queue(), ^{
        [target presentViewController:loginPage animated:NO completion:^{
        }];
    });
}

+ (void)showErrorMessageFrom:(UIViewController*)vc withError:(NSError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Arima Tweak" message:[NSString stringWithFormat:@"%@", error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [vc presentViewController:alert animated:YES completion:^{
            //
        }];
    });
}

+ (void)setMainRootViewController:(id)target {
    ARNavigationViewController *navigationController = [[ARNavigationViewController alloc] initWithRootViewController:target];
    ARMainViewController *mainViewController = nil;
    mainViewController = [[ARMainViewController alloc] initWithRootViewController:navigationController
                                                                presentationStyle:LGSideMenuPresentationStyleScaleFromLittle
                                                                             type:0];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    window.rootViewController = mainViewController;
    
    [UIView transitionWithView:window
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:nil
                    completion:nil];
}
@end
