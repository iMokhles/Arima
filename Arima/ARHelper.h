//
//  ARHelper.h
//  Arima
//
//  Created by iMokhles on 20/08/16.
//
//

#import <Foundation/Foundation.h>
#import "Arima.hpp"

typedef void (^iMBooleanResultBlock)(BOOL succeeded, NSError *error);
typedef void (^iMBooleanWithoutErrorResultBlock)(BOOL succeeded);
typedef void (^iMBooleanWithArrayResultBlock)(BOOL succeeded, NSArray *objects);
typedef void (^iMIntegerResultBlock)(int number);

@interface ARHelper : NSObject
+ (void)setup_Server;

// SignUp/Login
+ (void)loginOrSignUpFromTarget:(id)target;
+ (void)signupUserWithInfo:(NSDictionary *)userInfo fromtarget:(id)target completion:(iMBooleanResultBlock)completion;

// Likes
+ (void)likePost:(PFObject *)post byUser:(PFUser *)user withBlock:(iMBooleanResultBlock)compeltion;
+ (void)disLikePost:(PFObject *)post byUser:(PFUser *)user withBlock:(iMBooleanResultBlock)compeltion;

// checks
+ (void)isAppInstalledByCurrentUser:(PFObject *)object withBlock:(iMBooleanWithoutErrorResultBlock)compeltion;
+ (void)isAppFavoritedByCurrentUser:(PFObject *)object withBlock:(iMBooleanWithoutErrorResultBlock)compeltion;
+ (void)isAppExisteOnServer:(Package *)package withBlock:(iMBooleanWithoutErrorResultBlock)compeltion;
+ (void)isPostLikedByCurrentUser:(PFObject *)object withBlock:(iMBooleanWithoutErrorResultBlock)compeltion;
+ (void)isThisUser:(PFUser *)firstUser followThisUser:(PFUser *)secondUser withBlock:(iMBooleanWithArrayResultBlock)compeltion;

// get
+ (void)getFavoritesForUser:(PFUser *)user withBlock:(iMIntegerResultBlock)compeltion;
+ (void)getInstallationsForUser:(PFUser *)user withBlock:(iMIntegerResultBlock)compeltion;
+ (void)getFollowersForUser:(PFUser *)user withBlock:(iMIntegerResultBlock)compeltion;
+ (void)getFollowingForUser:(PFUser *)user withBlock:(iMIntegerResultBlock)compeltion;
+ (void)getAllPostsForUser:(PFUser *)user limit:(NSNumber *)limit skip:(NSNumber *)skip withBlock:(iMBooleanWithArrayResultBlock)compeltion;
+ (void)getAllPostsForUserFollowers:(PFUser *)user limit:(NSNumber *)limit skip:(NSNumber *)skip withBlock:(iMBooleanWithArrayResultBlock)compeltion;
+ (void)getActivitiesForUser:(PFUser *)user withBlock:(iMBooleanWithArrayResultBlock)compeltion;

// private methods
+ (void)showErrorMessageFrom:(UIViewController*)vc withError:(NSError *)error;
+ (void)setMainRootViewController:(id)target;
@end
