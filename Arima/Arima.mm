#line 1 "/Users/iMokhles/Desktop/Desktop/Apps/Arima/Arima/Arima.xm"




#import "Arima.hpp"
#import "ARScrollAppsCell.h"
#import "ARScrollHeader.h"
#import "ARAppDescripHeader.h"
#import "ARHelper.h"
#import <NSTask.h>
#include <apt-pkg/acquire.h>
#include <apt-pkg/acquire-item.h>
#include <apt-pkg/algorithms.h>
#include <apt-pkg/cachefile.h>
#include <apt-pkg/clean.h>
#include <apt-pkg/configuration.h>
#include <apt-pkg/debindexfile.h>
#include <apt-pkg/debmetaindex.h>
#include <apt-pkg/error.h>
#include <apt-pkg/init.h>
#include <apt-pkg/mmap.h>
#include <apt-pkg/pkgrecords.h>
#include <apt-pkg/sha1.h>
#include <apt-pkg/sourcelist.h>
#include <apt-pkg/sptr.h>
#include <apt-pkg/strutl.h>
#include <apt-pkg/tagfile.h>



static inline NSString *UCLocalizeEx(NSString *key, NSString *value = nil) {
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}
#define UCLocalize(key) UCLocalizeEx(@ key)
static const NSUInteger UIViewAutoresizingFlexibleBoth(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
#define SavedState_ "/var/mobile/Library/Caches/com.saurik.Cydia/SavedState.plist"


static bool IsReachable(const char *name) {
    SCNetworkReachabilityFlags flags; {
        SCNetworkReachabilityRef reachability(SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, name));
        SCNetworkReachabilityGetFlags(reachability, &flags);
        CFRelease(reachability);
    }
    
    
    
    return
    (flags & kSCNetworkReachabilityFlagsReachable) != 0 && (
                                                            (flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0 || (
                                                                                                                             (flags & kSCNetworkReachabilityFlagsConnectionOnDemand) != 0 ||
                                                                                                                             (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0
                                                                                                                             ) && (flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0 ||
                                                            (flags & kSCNetworkReachabilityFlagsIsWWAN) != 0
                                                            )
    ;
}

@interface Package : NSObject
- (pkgCache::PkgIterator) iterator;
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
- (NSArray *) downgrades;
@end



UITableView *homeTableView;
UITableView *packageDescriptionTableView;
NSArray *allSections;
NSArray *allPackagesArray;
NSArray *allSourcesArray;
iCarousel *_carousel;

NSArray *sources__;
NSArray *packages__;
Database *globalDatabase;
unsigned era_;
NSDate *Backgrounded_;
Cydia *cyAppDelegate;
Package *currentPackage;
AppCacheController *appcache__;
CancelStatus cydiaStatus;

#include <logos/logos.h>
#include <substrate.h>
@class ChangesController; @class UITableView; @class Cydia; @class CYPackageController; @class Database; @class UIView; @class UIWindow; @class HomeController; @class SourcesController; @class Package; 
static void (*_logos_orig$_ungrouped$Cydia$applicationDidFinishLaunching$)(Cydia*, SEL, id); static void _logos_method$_ungrouped$Cydia$applicationDidFinishLaunching$(Cydia*, SEL, id); static void (*_logos_orig$_ungrouped$Cydia$reloadDataWithInvocation$)(Cydia*, SEL, NSInvocation *); static void _logos_method$_ungrouped$Cydia$reloadDataWithInvocation$(Cydia*, SEL, NSInvocation *); static void (*_logos_orig$_ungrouped$Cydia$saveState)(Cydia*, SEL); static void _logos_method$_ungrouped$Cydia$saveState(Cydia*, SEL); static UIWindow * _logos_method$_ungrouped$Cydia$window(Cydia*, SEL); static void (*_logos_orig$_ungrouped$Cydia$setupViewControllers)(Cydia*, SEL); static void _logos_method$_ungrouped$Cydia$setupViewControllers(Cydia*, SEL); static void (*_logos_orig$_ungrouped$Cydia$disemulate)(Cydia*, SEL); static void _logos_method$_ungrouped$Cydia$disemulate(Cydia*, SEL); static void (*_logos_orig$_ungrouped$Cydia$distUpgrade)(Cydia*, SEL); static void _logos_method$_ungrouped$Cydia$distUpgrade(Cydia*, SEL); static bool (*_logos_orig$_ungrouped$Cydia$perform)(Cydia*, SEL); static bool _logos_method$_ungrouped$Cydia$perform(Cydia*, SEL); static void (*_logos_orig$_ungrouped$Cydia$beginUpdate)(Cydia*, SEL); static void _logos_method$_ungrouped$Cydia$beginUpdate(Cydia*, SEL); static void (*_logos_orig$_ungrouped$Cydia$cancelUpdate)(Cydia*, SEL); static void _logos_method$_ungrouped$Cydia$cancelUpdate(Cydia*, SEL); static BOOL (*_logos_orig$_ungrouped$Cydia$updating)(Cydia*, SEL); static BOOL _logos_method$_ungrouped$Cydia$updating(Cydia*, SEL); static void (*_logos_orig$_ungrouped$Cydia$unloadData)(Cydia*, SEL); static void _logos_method$_ungrouped$Cydia$unloadData(Cydia*, SEL); static UIProgressHUD * (*_logos_orig$_ungrouped$Cydia$addProgressHUD)(Cydia*, SEL); static UIProgressHUD * _logos_method$_ungrouped$Cydia$addProgressHUD(Cydia*, SEL); static void (*_logos_orig$_ungrouped$Cydia$applicationWillResignActive$)(Cydia*, SEL, UIApplication *); static void _logos_method$_ungrouped$Cydia$applicationWillResignActive$(Cydia*, SEL, UIApplication *); static void (*_logos_orig$_ungrouped$Cydia$applicationDidEnterBackground$)(Cydia*, SEL, UIApplication *); static void _logos_method$_ungrouped$Cydia$applicationDidEnterBackground$(Cydia*, SEL, UIApplication *); static void (*_logos_orig$_ungrouped$Cydia$applicationWillEnterForeground$)(Cydia*, SEL, UIApplication *); static void _logos_method$_ungrouped$Cydia$applicationWillEnterForeground$(Cydia*, SEL, UIApplication *); static void (*_logos_orig$_ungrouped$Database$updateWithStatus$)(Database*, SEL, CancelStatus); static void _logos_method$_ungrouped$Database$updateWithStatus$(Database*, SEL, CancelStatus); static CancelStatus _logos_method$_ungrouped$Database$currentStatus(Database*, SEL); static void (*_logos_orig$_ungrouped$ChangesController$setLeftBarButtonItem)(ChangesController*, SEL); static void _logos_method$_ungrouped$ChangesController$setLeftBarButtonItem(ChangesController*, SEL); static void (*_logos_orig$_ungrouped$ChangesController$upgradeButtonClicked)(ChangesController*, SEL); static void _logos_method$_ungrouped$ChangesController$upgradeButtonClicked(ChangesController*, SEL); static void (*_logos_orig$_ungrouped$ChangesController$refreshButtonClicked)(ChangesController*, SEL); static void _logos_method$_ungrouped$ChangesController$refreshButtonClicked(ChangesController*, SEL); static void (*_logos_orig$_ungrouped$ChangesController$cancelButtonClicked)(ChangesController*, SEL); static void _logos_method$_ungrouped$ChangesController$cancelButtonClicked(ChangesController*, SEL); static void (*_logos_orig$_ungrouped$SourcesController$refreshButtonClicked)(SourcesController*, SEL); static void _logos_method$_ungrouped$SourcesController$refreshButtonClicked(SourcesController*, SEL); static void (*_logos_orig$_ungrouped$SourcesController$updateButtonsForEditingStatusAnimated$)(SourcesController*, SEL, BOOL); static void _logos_method$_ungrouped$SourcesController$updateButtonsForEditingStatusAnimated$(SourcesController*, SEL, BOOL); static void (*_logos_orig$_ungrouped$SourcesController$cancelButtonClicked)(SourcesController*, SEL); static void _logos_method$_ungrouped$SourcesController$cancelButtonClicked(SourcesController*, SEL); static void (*_logos_orig$_ungrouped$UIWindow$setRootViewController$)(UIWindow*, SEL, id); static void _logos_method$_ungrouped$UIWindow$setRootViewController$(UIWindow*, SEL, id); static void (*_logos_orig$_ungrouped$HomeController$viewWillAppear$)(HomeController*, SEL, BOOL); static void _logos_method$_ungrouped$HomeController$viewWillAppear$(HomeController*, SEL, BOOL); static void (*_logos_orig$_ungrouped$HomeController$loadView)(HomeController*, SEL); static void _logos_method$_ungrouped$HomeController$loadView(HomeController*, SEL); static void (*_logos_orig$_ungrouped$HomeController$applyRightButton)(HomeController*, SEL); static void _logos_method$_ungrouped$HomeController$applyRightButton(HomeController*, SEL); static void (*_logos_orig$_ungrouped$HomeController$applyLeftButton)(HomeController*, SEL); static void _logos_method$_ungrouped$HomeController$applyLeftButton(HomeController*, SEL); static UIBarButtonItem * _logos_method$_ungrouped$HomeController$arima_setupTopMenuBarButtons(HomeController*, SEL); static UIBarButtonItem * _logos_method$_ungrouped$HomeController$arima_setupTopBarButtons(HomeController*, SEL); static void _logos_method$_ungrouped$HomeController$openMenu(HomeController*, SEL); static void _logos_method$_ungrouped$HomeController$infoButtonTapped(HomeController*, SEL); static void _logos_method$_ungrouped$HomeController$arima_setupOurArries(HomeController*, SEL); static void _logos_method$_ungrouped$HomeController$arima_SetupOurHomeTableView(HomeController*, SEL); static void _logos_method$_ungrouped$HomeController$arima_configureTableViewHeader(HomeController*, SEL); static void _logos_method$_ungrouped$HomeController$viewDidAppear$(HomeController*, SEL, BOOL); static void _logos_method$_ungrouped$HomeController$logInViewController$didLogInUser$(HomeController*, SEL, PFLogInViewController *, PFUser *); static void _logos_method$_ungrouped$HomeController$logInViewController$didFailToLogInWithError$(HomeController*, SEL, PFLogInViewController *, NSError *); static void _logos_method$_ungrouped$HomeController$logInViewControllerDidCancelLogIn$(HomeController*, SEL, PFLogInViewController *); static void _logos_method$_ungrouped$HomeController$signUpViewController$didSignUpUser$(HomeController*, SEL, PFSignUpViewController *, PFUser *); static void _logos_method$_ungrouped$HomeController$signUpViewController$didFailToSignUpWithError$(HomeController*, SEL, PFSignUpViewController *, NSError *); static void _logos_method$_ungrouped$HomeController$signUpViewControllerDidCancelSignUp$(HomeController*, SEL, PFSignUpViewController *); static NSInteger _logos_method$_ungrouped$HomeController$numberOfSectionsInTableView$(HomeController*, SEL, UITableView *); static NSInteger _logos_method$_ungrouped$HomeController$tableView$numberOfRowsInSection$(HomeController*, SEL, UITableView *, NSInteger); static CGFloat _logos_method$_ungrouped$HomeController$tableView$heightForHeaderInSection$(HomeController*, SEL, UITableView *, NSInteger); static UIView * _logos_method$_ungrouped$HomeController$tableView$viewForHeaderInSection$(HomeController*, SEL, UITableView *, NSInteger); static CGFloat _logos_method$_ungrouped$HomeController$tableView$heightForRowAtIndexPath$(HomeController*, SEL, UITableView *, NSIndexPath *); static NSString * _logos_method$_ungrouped$HomeController$tableView$titleForHeaderInSection$(HomeController*, SEL, UITableView *, NSInteger); static UIView * _logos_method$_ungrouped$HomeController$tableView$viewForFooterInSection$(HomeController*, SEL, UITableView *, NSInteger); static CGFloat _logos_method$_ungrouped$HomeController$tableView$heightForFooterInSection$(HomeController*, SEL, UITableView *, NSInteger); static UITableViewCell * _logos_method$_ungrouped$HomeController$tableView$cellForRowAtIndexPath$(HomeController*, SEL, UITableView *, NSIndexPath *); static void _logos_method$_ungrouped$HomeController$arima_openSource$(HomeController*, SEL, Source *); static NSInteger _logos_method$_ungrouped$HomeController$numberOfItemsInCarousel$(HomeController*, SEL, iCarousel *); static UIView * _logos_method$_ungrouped$HomeController$carousel$viewForItemAtIndex$reusingView$(HomeController*, SEL, iCarousel *, NSInteger, UIView *); static CATransform3D _logos_method$_ungrouped$HomeController$carousel$itemTransformForOffset$baseTransform$(HomeController*, SEL, iCarousel *, CGFloat, CATransform3D); static void _logos_method$_ungrouped$HomeController$carousel$didSelectItemAtIndex$(HomeController*, SEL, iCarousel *, NSInteger); static void (*_logos_orig$_ungrouped$CYPackageController$viewWillAppear$)(CYPackageController*, SEL, BOOL); static void _logos_method$_ungrouped$CYPackageController$viewWillAppear$(CYPackageController*, SEL, BOOL); static void (*_logos_orig$_ungrouped$CYPackageController$loadView)(CYPackageController*, SEL); static void _logos_method$_ungrouped$CYPackageController$loadView(CYPackageController*, SEL); static void _logos_method$_ungrouped$CYPackageController$arima_SetupOurPackageDescriptionTableView(CYPackageController*, SEL); static void _logos_method$_ungrouped$CYPackageController$arima_configureTableViewHeader(CYPackageController*, SEL); static void _logos_method$_ungrouped$CYPackageController$viewDidAppear$(CYPackageController*, SEL, BOOL); static NSInteger _logos_method$_ungrouped$CYPackageController$numberOfSectionsInTableView$(CYPackageController*, SEL, UITableView *); static NSInteger _logos_method$_ungrouped$CYPackageController$tableView$numberOfRowsInSection$(CYPackageController*, SEL, UITableView *, NSInteger); static CGFloat _logos_method$_ungrouped$CYPackageController$tableView$heightForHeaderInSection$(CYPackageController*, SEL, UITableView *, NSInteger); static UIView * _logos_method$_ungrouped$CYPackageController$tableView$viewForHeaderInSection$(CYPackageController*, SEL, UITableView *, NSInteger); static CGFloat _logos_method$_ungrouped$CYPackageController$tableView$heightForRowAtIndexPath$(CYPackageController*, SEL, UITableView *, NSIndexPath *); static UIView * _logos_method$_ungrouped$CYPackageController$tableView$viewForFooterInSection$(CYPackageController*, SEL, UITableView *, NSInteger); static CGFloat _logos_method$_ungrouped$CYPackageController$tableView$heightForFooterInSection$(CYPackageController*, SEL, UITableView *, NSInteger); static UITableViewCell * _logos_method$_ungrouped$CYPackageController$tableView$cellForRowAtIndexPath$(CYPackageController*, SEL, UITableView *, NSIndexPath *); static NSString * _logos_method$_ungrouped$Package$tweakVersion(Package*, SEL); static void _logos_method$_ungrouped$UITableView$dispatchEvent$(UITableView*, SEL, NSString *); static void _logos_method$_ungrouped$UITableView$loadRequest$(UITableView*, SEL, NSURLRequest *); static void _logos_method$_ungrouped$UIView$dispatchEvent$(UIView*, SEL, NSString *); static void _logos_method$_ungrouped$UIView$loadRequest$(UIView*, SEL, NSURLRequest *); 

#line 121 "/Users/iMokhles/Desktop/Desktop/Apps/Arima/Arima/Arima.xm"

static void _logos_method$_ungrouped$Cydia$applicationDidFinishLaunching$(Cydia* self, SEL _cmd, id unused) {
    [ARHelper setup_Server];
    _logos_orig$_ungrouped$Cydia$applicationDidFinishLaunching$(self, _cmd, unused);
    [self setupViewControllers];
    [cyAppDelegate requestUpdate];
    appcache__ = MSHookIvar<AppCacheController *>(self, "appcache_");
}
static void _logos_method$_ungrouped$Cydia$reloadDataWithInvocation$(Cydia* self, SEL _cmd, NSInvocation * invocation) {
    cyAppDelegate = self;
    _logos_orig$_ungrouped$Cydia$reloadDataWithInvocation$(self, _cmd, invocation);
    globalDatabase = MSHookIvar<Database *>(self, "database_");
    packages__ = [globalDatabase packages];
    sources__ = [globalDatabase sources];
    
    
}

static void _logos_method$_ungrouped$Cydia$saveState(Cydia* self, SEL _cmd) {
    [[NSDictionary dictionaryWithObjectsAndKeys:
      @"InterfaceState", [kMainViewController navigationURLCollection],
      @"LastClosed", [NSDate date],
      @"InterfaceIndex", [NSNumber numberWithInt:[[[NSUserDefaults standardUserDefaults] objectForKey:@"leftMenuSelectedRow"] intValue]],
      nil] writeToFile:@ SavedState_ atomically:YES];
    
    [self _saveConfig];
}

static UIWindow * _logos_method$_ungrouped$Cydia$window(Cydia* self, SEL _cmd) {
    UIWindow *window__ = MSHookIvar<UIWindow *>(self, "window_");
    return window__;
}

static void _logos_method$_ungrouped$Cydia$setupViewControllers(Cydia* self, SEL _cmd) {
    _logos_orig$_ungrouped$Cydia$setupViewControllers(self, _cmd);
    NSInteger selectedRow = [[[NSUserDefaults standardUserDefaults] objectForKey:@"leftMenuSelectedRow"] integerValue];
    if (selectedRow) {
        if (selectedRow == 0) {
            [ARHelper setMainRootViewController:[[objc_getClass("HomeController") alloc] init]];
        } else if (selectedRow == 1) {
            [ARHelper setMainRootViewController:[[objc_getClass("SourcesController") alloc] initWithDatabase:globalDatabase]];
        } else if (selectedRow == 2) {
            [ARHelper setMainRootViewController:[[objc_getClass("ChangesController") alloc] initWithDatabase:globalDatabase]];
        } else if (selectedRow == 3) {
            [ARHelper setMainRootViewController:[[objc_getClass("InstalledController") alloc] initWithDatabase:globalDatabase]];
        } else if (selectedRow == 4) {
            [ARHelper setMainRootViewController:[[objc_getClass("SearchController") alloc] initWithDatabase:globalDatabase query:nil]];
        } else if (selectedRow == 5) {
            [ARHelper setMainRootViewController:[[objc_getClass("HomeController") alloc] init]];
        } else if (selectedRow == 6) {
            [ARHelper setMainRootViewController:[[objc_getClass("HomeController") alloc] init]];
        }
    } else {
        [ARHelper setMainRootViewController:[[objc_getClass("HomeController") alloc] init]];
    }
    [kMainViewController setUpdateDelegate:self];

}
static void _logos_method$_ungrouped$Cydia$disemulate(Cydia* self, SEL _cmd) {
    _logos_orig$_ungrouped$Cydia$disemulate(self, _cmd);
    [self setupViewControllers];
}

static void _logos_method$_ungrouped$Cydia$distUpgrade(Cydia* self, SEL _cmd) {
    NSLog(@"*********** distUpgrade");
    _logos_orig$_ungrouped$Cydia$distUpgrade(self, _cmd);
}
static bool _logos_method$_ungrouped$Cydia$perform(Cydia* self, SEL _cmd) {
     NSLog(@"*********** HERE");
    
    if ([kMainViewController updating])
        [kMainViewController cancelUpdate];
    
    if (![globalDatabase prepare])
        return false;
    
    ConfirmationController *page([[objc_getClass("ConfirmationController") alloc] initWithDatabase:globalDatabase]);

    UINavigationController *confirm_([[UINavigationController alloc] initWithRootViewController:page]);
    
    if (IS_IPAD)
        [confirm_ setModalPresentationStyle:UIModalPresentationFormSheet];
    
   
    [kMainViewController presentModalViewController:confirm_ animated:YES];
    
    return true;
}

static void _logos_method$_ungrouped$Cydia$beginUpdate(Cydia* self, SEL _cmd) {
    [kMainViewController beginUpdate];
}

static void _logos_method$_ungrouped$Cydia$cancelUpdate(Cydia* self, SEL _cmd) {
    [kMainViewController cancelUpdate];
}

static BOOL _logos_method$_ungrouped$Cydia$updating(Cydia* self, SEL _cmd) {
    return [kMainViewController updating];
    
}
static void _logos_method$_ungrouped$Cydia$unloadData(Cydia* self, SEL _cmd) {
    [kMainViewController unloadData];
}
static UIProgressHUD * _logos_method$_ungrouped$Cydia$addProgressHUD(Cydia* self, SEL _cmd) {
    UIProgressHUD *hud = [[UIProgressHUD alloc] init];
    [hud setAutoresizingMask:UIViewAutoresizingFlexibleBoth];
    
    [self.window setUserInteractionEnabled:NO];
    
    UIViewController *target(kMainViewController);
    if (UIViewController *modal = [target modalViewController])
        target = modal;
        
        [hud showInView:[target view]];
    
    [self lockSuspend];
    return hud;
}
static void _logos_method$_ungrouped$Cydia$applicationWillResignActive$(Cydia* self, SEL _cmd, UIApplication * application) {
    _logos_orig$_ungrouped$Cydia$applicationWillResignActive$(self, _cmd, application);
    if ([kMainViewController updating])
        [kMainViewController cancelUpdate];
}
static void _logos_method$_ungrouped$Cydia$applicationDidEnterBackground$(Cydia* self, SEL _cmd, UIApplication * application) {
    _logos_orig$_ungrouped$Cydia$applicationDidEnterBackground$(self, _cmd, application);
    Backgrounded_ = [NSDate date];
    [self saveState];
}
static void _logos_method$_ungrouped$Cydia$applicationWillEnterForeground$(Cydia* self, SEL _cmd, UIApplication * application) {
    _logos_orig$_ungrouped$Cydia$applicationWillEnterForeground$(self, _cmd, application);
    if (Backgrounded_ == nil)
        return;
    
    NSTimeInterval interval([Backgrounded_ timeIntervalSinceNow]);
    if ([globalDatabase delocked])
        [self reloadData];
    
    if (interval <= -(15*60)) {
        if (IsReachable("cydia.saurik.com")) {
            [kMainViewController beginUpdate];
            [appcache__ reloadURLWithCache:YES];
        }
    }
    
}



static void _logos_method$_ungrouped$Database$updateWithStatus$(Database* self, SEL _cmd, CancelStatus arg1) {
    NSLog(@"********* CANCELSTATUS OOOH\n\n\n\n\n\n\n\n\n");
    _logos_orig$_ungrouped$Database$updateWithStatus$(self, _cmd, arg1);
    cydiaStatus = arg1;
}

static CancelStatus _logos_method$_ungrouped$Database$currentStatus(Database* self, SEL _cmd) {
    return MSHookIvar<CancelStatus>(self, "status_");
}




static void _logos_method$_ungrouped$ChangesController$setLeftBarButtonItem(ChangesController* self, SEL _cmd) {
    if ([cyAppDelegate updating]) {
        [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc]
                                                      initWithTitle:UCLocalize("CANCEL")
                                                      style:UIBarButtonItemStyleDone
                                                      target:self
                                                      action:@selector(cancelButtonClicked)
                                                      ] animated:YES];
    } else {
        [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc]
                                                      initWithTitle:UCLocalize("REFRESH")
                                                      style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(refreshButtonClicked)
                                                      ] animated:YES];
    }
}
static void _logos_method$_ungrouped$ChangesController$upgradeButtonClicked(ChangesController* self, SEL _cmd) {
    NSLog(@"*********** upgradeButtonClicked");
    [cyAppDelegate distUpgrade];
    [[self navigationItem] setRightBarButtonItem:nil animated:YES];
}
static void _logos_method$_ungrouped$ChangesController$refreshButtonClicked(ChangesController* self, SEL _cmd) {
     NSLog(@"*********** refreshButtonClicked");
    if ([cyAppDelegate requestUpdate])
        [self setLeftBarButtonItem];
}
static void _logos_method$_ungrouped$ChangesController$cancelButtonClicked(ChangesController* self, SEL _cmd) {
    [cyAppDelegate cancelUpdate];
}



static void _logos_method$_ungrouped$SourcesController$refreshButtonClicked(SourcesController* self, SEL _cmd) {
    [cyAppDelegate requestUpdate];
    [self updateButtonsForEditingStatusAnimated:YES];
}
static void _logos_method$_ungrouped$SourcesController$updateButtonsForEditingStatusAnimated$(SourcesController* self, SEL _cmd, BOOL animated) {
    BOOL editing([MSHookIvar<UITableView *>(self, "list_") isEditing]);
    
    if (editing) {
        [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc]
                                                      initWithTitle:UCLocalize("ADD")
                                                      style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(addButtonClicked)
                                                      ] animated:animated];
    } else if ([cyAppDelegate updating]) {
        [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc]
                                                      initWithTitle:UCLocalize("CANCEL")
                                                      style:UIBarButtonItemStyleDone
                                                      target:self
                                                      action:@selector(cancelButtonClicked)
                                                      ] animated:animated];
    } else {
        [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc]
                                                      initWithTitle:UCLocalize("REFRESH")
                                                      style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(refreshButtonClicked)
                                                      ] animated:animated];
    }
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc]
                                                   initWithTitle:(editing ? UCLocalize("DONE") : UCLocalize("EDIT"))
                                                   style:(editing ? UIBarButtonItemStyleDone : UIBarButtonItemStylePlain)
                                                   target:self
                                                   action:@selector(editButtonClicked)
                                                   ] animated:animated];
}
static void _logos_method$_ungrouped$SourcesController$cancelButtonClicked(SourcesController* self, SEL _cmd) {
    [cyAppDelegate cancelUpdate];
}




static void _logos_method$_ungrouped$UIWindow$setRootViewController$(UIWindow* self, SEL _cmd, id arg1) {
    _logos_orig$_ungrouped$UIWindow$setRootViewController$(self, _cmd, arg1);
    NSLog(@"********** %@", arg1);
}



static void _logos_method$_ungrouped$HomeController$viewWillAppear$(HomeController* self, SEL _cmd, BOOL animated) {
    _logos_orig$_ungrouped$HomeController$viewWillAppear$(self, _cmd, animated);
}
static void _logos_method$_ungrouped$HomeController$loadView(HomeController* self, SEL _cmd) {
    [self arima_setupOurArries];
    _logos_orig$_ungrouped$HomeController$loadView(self, _cmd);
    [self arima_SetupOurHomeTableView];
}

static void _logos_method$_ungrouped$HomeController$applyRightButton(HomeController* self, SEL _cmd) {
    _logos_orig$_ungrouped$HomeController$applyRightButton(self, _cmd);
    UIBarButtonItem *origReloadButton = self.navigationItem.rightBarButtonItem;
    [self.navigationItem setRightBarButtonItems:@[origReloadButton, [self arima_setupTopBarButtons]] animated:YES];
    [[self navigationItem] setTitle:UCLocalize("HOME")];
}

static void _logos_method$_ungrouped$HomeController$applyLeftButton(HomeController* self, SEL _cmd) {
    _logos_orig$_ungrouped$HomeController$applyLeftButton(self, _cmd);



}

static UIBarButtonItem * _logos_method$_ungrouped$HomeController$arima_setupTopMenuBarButtons(HomeController* self, SEL _cmd) {
    UIBarButtonItem* menuBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(openMenu)];
    return menuBarButton;
}

static UIBarButtonItem * _logos_method$_ungrouped$HomeController$arima_setupTopBarButtons(HomeController* self, SEL _cmd) {
    UIButton *InfoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [InfoButton addTarget:self action:@selector(infoButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* infoBarButton = [[UIBarButtonItem alloc] initWithCustomView:InfoButton];
    return infoBarButton;
}


static void _logos_method$_ungrouped$HomeController$openMenu(HomeController* self, SEL _cmd) {
    [kMainViewController showLeftViewAnimated:YES completionHandler:nil];
}

static void _logos_method$_ungrouped$HomeController$infoButtonTapped(HomeController* self, SEL _cmd) {
    
}

static void _logos_method$_ungrouped$HomeController$arima_setupOurArries(HomeController* self, SEL _cmd) {
    allSections = @[@"Top Sources", @"Top Free Tweaks", @"Top Paid Tweaks", @"Top Free Themes", @"Top Paid Themes", @"Top Rated Tweaks"];
    NSMutableArray *allSources = [NSMutableArray new];
    
    for (Source *source in sources__) {
        ARAppView *item = [[ARAppView alloc] initWithFrame:CGRectZero imageURL:source.iconURL title:source.name subTitle:source.shortDescription andApp:source];
        if (![allSources containsObject:item]) {
            [allSources addObject:item];
        }
    }
    if (allSourcesArray.count == 0) {
        allSourcesArray = [allSources copy];
    }
}

static void _logos_method$_ungrouped$HomeController$arima_SetupOurHomeTableView(HomeController* self, SEL _cmd) {
    
    homeTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStyleGrouped];
    [homeTableView setAutoresizingMask:UIViewAutoresizingFlexibleBoth];
    [homeTableView setDataSource:self];
    [homeTableView setDelegate:self];
    [homeTableView setAllowsSelection:NO];
    [self setView:homeTableView];
    
    [self arima_configureTableViewHeader];
    
}

static void _logos_method$_ungrouped$HomeController$arima_configureTableViewHeader(HomeController* self, SEL _cmd) {
    ARScrollHeader *view = [[ARScrollHeader alloc] initWithFrame:CGRectMake(0, 0, 0, 200.0f)];









    
    _carousel = [[iCarousel alloc] initWithFrame:view.bounds];
    _carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _carousel.type = iCarouselTypeRotary;
    _carousel.delegate = self;
    _carousel.dataSource = self;
    [view addSubview:_carousel];
    
    homeTableView.tableHeaderView = view;
    [_carousel reloadData];
}

static void _logos_method$_ungrouped$HomeController$viewDidAppear$(HomeController* self, SEL _cmd, BOOL animated) {
    
    [homeTableView reloadData];
    if ([PFUser currentUser] == nil) {
        [ARHelper loginOrSignUpFromTarget:self];
    }
}

#pragma mark -
#pragma mark - LogIn Delegate

static void _logos_method$_ungrouped$HomeController$logInViewController$didLogInUser$(HomeController* self, SEL _cmd, PFLogInViewController * logInController, PFUser * user) {
    [logInController dismissViewControllerAnimated:YES completion:^{
        user[USER_DEVICE_ID] = [[iMoDevTools sharedInstance] imo_deviceUDIDValue];
        user[USER_CATG] = @"ArimaTweak";
        user[@"imei_user_device"] = [[iMoDevTools sharedInstance] imo_deviceSysVersion];
        user[@"product_user_device"] = [[iMoDevTools sharedInstance] imo_deviceHardware];
        [user saveInBackground];
    }];
}

static void _logos_method$_ungrouped$HomeController$logInViewController$didFailToLogInWithError$(HomeController* self, SEL _cmd, PFLogInViewController * logInController, NSError * error) {
    [ARHelper showErrorMessageFrom:logInController withError:error];
}

static void _logos_method$_ungrouped$HomeController$logInViewControllerDidCancelLogIn$(HomeController* self, SEL _cmd, PFLogInViewController * logInController) {
    [logInController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - SignUp Delegate

static void _logos_method$_ungrouped$HomeController$signUpViewController$didSignUpUser$(HomeController* self, SEL _cmd, PFSignUpViewController * signUpController, PFUser * user) {
    [signUpController dismissViewControllerAnimated:YES completion:^{
        user[USER_DEVICE_ID] = [[iMoDevTools sharedInstance] imo_deviceUDIDValue];
        user[USER_CATG] = @"ArimaTweak";
        user[@"imei_user_device"] = [[iMoDevTools sharedInstance] imo_deviceSysVersion];
        user[@"product_user_device"] = [[iMoDevTools sharedInstance] imo_deviceHardware];
        [user saveInBackground];
    }];
}

static void _logos_method$_ungrouped$HomeController$signUpViewController$didFailToSignUpWithError$(HomeController* self, SEL _cmd, PFSignUpViewController * signUpController, NSError * error) {
    [ARHelper showErrorMessageFrom:signUpController withError:error];
}

static void _logos_method$_ungrouped$HomeController$signUpViewControllerDidCancelSignUp$(HomeController* self, SEL _cmd, PFSignUpViewController * signUpController) {
    [signUpController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark -
#pragma mark UITableViewDataSource/UITableViewDelegate


static NSInteger _logos_method$_ungrouped$HomeController$numberOfSectionsInTableView$(HomeController* self, SEL _cmd, UITableView * tableView) {
    return allSections.count;
}


static NSInteger _logos_method$_ungrouped$HomeController$tableView$numberOfRowsInSection$(HomeController* self, SEL _cmd, UITableView * tableView, NSInteger sectionIndex) {
    return 1;
}


static CGFloat _logos_method$_ungrouped$HomeController$tableView$heightForHeaderInSection$(HomeController* self, SEL _cmd, UITableView * tableView, NSInteger section) {
    return 15; 
}


static UIView * _logos_method$_ungrouped$HomeController$tableView$viewForHeaderInSection$(HomeController* self, SEL _cmd, UITableView * tableView, NSInteger section) {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}


static CGFloat _logos_method$_ungrouped$HomeController$tableView$heightForRowAtIndexPath$(HomeController* self, SEL _cmd, UITableView * tableView, NSIndexPath * indexPath) {
    return 203;
}


static NSString * _logos_method$_ungrouped$HomeController$tableView$titleForHeaderInSection$(HomeController* self, SEL _cmd, UITableView * tableView, NSInteger section) {
    return @"Arima for Cydia";
}


static UIView * _logos_method$_ungrouped$HomeController$tableView$viewForFooterInSection$(HomeController* self, SEL _cmd, UITableView * tableView, NSInteger section) {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 21)];
    label.text = @"Copyrights 2016, Mokhlas Hussein (iMokhles) all rights reserved";
    label.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    [label sizeToFit];
    label.center = CGPointMake(tableView.frame.size.width  / 2, tableView.frame.size.height / 2);
    label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    if (section == 5)
        return label;
    
    return [UIView new];
}


static CGFloat _logos_method$_ungrouped$HomeController$tableView$heightForFooterInSection$(HomeController* self, SEL _cmd, UITableView * tableView, NSInteger section) {
    if (section == 5)
        return 21; 
    return 17.5;
}


static UITableViewCell * _logos_method$_ungrouped$HomeController$tableView$cellForRowAtIndexPath$(HomeController* self, SEL _cmd, UITableView * tableView, NSIndexPath * indexPath) {
    NSString *generalCellID = [NSString stringWithFormat:@"generalCellID_S%1ldR%1ld",(long)indexPath.section,(long)indexPath.row];
    ARScrollAppsCell *cell = [tableView dequeueReusableCellWithIdentifier:generalCellID];
    if (cell==nil) {
        cell = [[ARScrollAppsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:generalCellID];
    }
    NSString *sectionTitle = [allSections objectAtIndex:indexPath.section];
    if (indexPath.section == 0) {
        [cell configureWithTitle:sectionTitle items:[allSourcesArray mutableCopy]];
        [cell setItemTappedBlock:^(ARScrollAppsCell *itemCell, ARAppView *itemView) {
            [self arima_openSource:(Source *)itemView.currentItem];
        }];
        [cell setShowAllTappedBlock:^(ARScrollAppsCell *itemCell, UIButton *showButton) {
            
        }];
    } else if (indexPath.section == 1) {
        [cell configureWithTitle:sectionTitle items:nil];
        [cell setItemTappedBlock:^(ARScrollAppsCell *itemCell, ARAppView *itemView) {
            [self arima_openSource:(Source *)itemView.currentItem];
        }];
        [cell setShowAllTappedBlock:^(ARScrollAppsCell *itemCell, UIButton *showButton) {
            
        }];
    } else if (indexPath.section == 2) {
        [cell configureWithTitle:sectionTitle items:nil];
        [cell setItemTappedBlock:^(ARScrollAppsCell *itemCell, ARAppView *itemView) {
            [self arima_openSource:(Source *)itemView.currentItem];
        }];
        [cell setShowAllTappedBlock:^(ARScrollAppsCell *itemCell, UIButton *showButton) {
            
        }];
    } else if (indexPath.section == 3) {
        [cell configureWithTitle:sectionTitle items:nil];
        [cell setItemTappedBlock:^(ARScrollAppsCell *itemCell, ARAppView *itemView) {
            [self arima_openSource:(Source *)itemView.currentItem];
        }];
        [cell setShowAllTappedBlock:^(ARScrollAppsCell *itemCell, UIButton *showButton) {
            
        }];
    } else if (indexPath.section == 4) {
        [cell configureWithTitle:sectionTitle items:nil];
        [cell setItemTappedBlock:^(ARScrollAppsCell *itemCell, ARAppView *itemView) {
            [self arima_openSource:(Source *)itemView.currentItem];
        }];
        [cell setShowAllTappedBlock:^(ARScrollAppsCell *itemCell, UIButton *showButton) {
            
        }];
    } else if (indexPath.section == 5) {
        [cell configureWithTitle:sectionTitle items:nil];
        [cell setItemTappedBlock:^(ARScrollAppsCell *itemCell, ARAppView *itemView) {
            [self arima_openSource:(Source *)itemView.currentItem];
        }];
        [cell setShowAllTappedBlock:^(ARScrollAppsCell *itemCell, UIButton *showButton) {
            
        }];
    }
    return cell;
}


static void _logos_method$_ungrouped$HomeController$arima_openSource$(HomeController* self, SEL _cmd, Source * source) {
    SectionsController *controller = [[objc_getClass("SectionsController") alloc] initWithDatabase:globalDatabase source:source];
    [controller setDelegate:cyAppDelegate];
    [[self navigationController] pushViewController:controller animated:YES];
}
#pragma mark -
#pragma mark iCarouselDataSource/iCarouselDelegate


static NSInteger _logos_method$_ungrouped$HomeController$numberOfItemsInCarousel$(HomeController* self, SEL _cmd, iCarousel * carousel) {
    return 10;
}


static UIView * _logos_method$_ungrouped$HomeController$carousel$viewForItemAtIndex$reusingView$(HomeController* self, SEL _cmd, iCarousel * carousel, NSInteger index, UIView * view) {
    UILabel *label = nil;
    
    
    if (view == nil)
    {
        CGRect viewRect = CGRectMake(0, 0, 320.0f, 190.0f);
        if (IS_IPAD) {
            viewRect = CGRectMake(0, 0, 530.0f, 190.0f);
        }
        
        view = [[UIView alloc] initWithFrame:viewRect];
        view.backgroundColor = [UIColor pastelBlueColor];
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor icebergColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:40];
        label.tag = 1;
        [view addSubview:label];
        
    }
    else
    {
        
        label = (UILabel *)[view viewWithTag:1];
    }
    label.text = [NSString stringWithFormat:@"Tweak %ld", (long)index];
    
    return view;
}


static CATransform3D _logos_method$_ungrouped$HomeController$carousel$itemTransformForOffset$baseTransform$(HomeController* self, SEL _cmd, iCarousel * carousel, CGFloat offset, CATransform3D transform) {
    
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}

static void _logos_method$_ungrouped$HomeController$carousel$didSelectItemAtIndex$(HomeController* self, SEL _cmd, iCarousel * carousel, NSInteger index) {
    
}


#pragma mark - PackageDescriptionPage

static void _logos_method$_ungrouped$CYPackageController$viewWillAppear$(CYPackageController* self, SEL _cmd, BOOL arg1) {
    _logos_orig$_ungrouped$CYPackageController$viewWillAppear$(self, _cmd, arg1);
    [[self navigationItem] setTitle:UCLocalize("DETAILS")];
    currentPackage = [globalDatabase packageWithName:MSHookIvar<NSString *>(self, "name_")];
    [self arima_configureTableViewHeader];
    [packageDescriptionTableView reloadData];
}
static void _logos_method$_ungrouped$CYPackageController$loadView(CYPackageController* self, SEL _cmd) {
    _logos_orig$_ungrouped$CYPackageController$loadView(self, _cmd);
    [self arima_SetupOurPackageDescriptionTableView];
    [packageDescriptionTableView reloadData];
}


static void _logos_method$_ungrouped$CYPackageController$arima_SetupOurPackageDescriptionTableView(CYPackageController* self, SEL _cmd) {
    
    packageDescriptionTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStyleGrouped];
    [packageDescriptionTableView setAutoresizingMask:UIViewAutoresizingFlexibleBoth];
    [packageDescriptionTableView setDataSource:self];
    [packageDescriptionTableView setDelegate:self];
    [packageDescriptionTableView setAllowsSelection:NO];
    [self setView:packageDescriptionTableView];
}

static void _logos_method$_ungrouped$CYPackageController$arima_configureTableViewHeader(CYPackageController* self, SEL _cmd) {
    ARAppDescripHeader *view = [[ARAppDescripHeader alloc] initWithFrame:CGRectMake(0, 0, 0, 125.0f)];
    packageDescriptionTableView.tableHeaderView = view;
    [view configureWithPackage:currentPackage];
    
}

static void _logos_method$_ungrouped$CYPackageController$viewDidAppear$(CYPackageController* self, SEL _cmd, BOOL animated) {
    
    [homeTableView reloadData];
}
#pragma mark -
#pragma mark UITableViewDataSource/UITableViewDelegate


static NSInteger _logos_method$_ungrouped$CYPackageController$numberOfSectionsInTableView$(CYPackageController* self, SEL _cmd, UITableView * tableView) {
    return 3;
}


static NSInteger _logos_method$_ungrouped$CYPackageController$tableView$numberOfRowsInSection$(CYPackageController* self, SEL _cmd, UITableView * tableView, NSInteger sectionIndex) {
    return 1;
}


static CGFloat _logos_method$_ungrouped$CYPackageController$tableView$heightForHeaderInSection$(CYPackageController* self, SEL _cmd, UITableView * tableView, NSInteger section) {
    return 15; 
}


static UIView * _logos_method$_ungrouped$CYPackageController$tableView$viewForHeaderInSection$(CYPackageController* self, SEL _cmd, UITableView * tableView, NSInteger section) {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}


static CGFloat _logos_method$_ungrouped$CYPackageController$tableView$heightForRowAtIndexPath$(CYPackageController* self, SEL _cmd, UITableView * tableView, NSIndexPath * indexPath) {
    return 203;
}


static UIView * _logos_method$_ungrouped$CYPackageController$tableView$viewForFooterInSection$(CYPackageController* self, SEL _cmd, UITableView * tableView, NSInteger section) {
    return [UIView new];
}


static CGFloat _logos_method$_ungrouped$CYPackageController$tableView$heightForFooterInSection$(CYPackageController* self, SEL _cmd, UITableView * tableView, NSInteger section) {
    if (section == 5)
        return 21; 
    return 17.5;
}


static UITableViewCell * _logos_method$_ungrouped$CYPackageController$tableView$cellForRowAtIndexPath$(CYPackageController* self, SEL _cmd, UITableView * tableView, NSIndexPath * indexPath) {
    NSString *generalCellID = [NSString stringWithFormat:@"packageCellID_S%1ldR%1ld",(long)indexPath.section,(long)indexPath.row];
    ARScrollAppsCell *cell = [tableView dequeueReusableCellWithIdentifier:generalCellID];
    if (cell==nil) {
        cell = [[ARScrollAppsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:generalCellID];
    }

    
    [cell configureWithTitle:@"Test 1" items:nil];
    [cell setItemTappedBlock:^(ARScrollAppsCell *itemCell, ARAppView *itemView) {

    }];
    [cell setShowAllTappedBlock:^(ARScrollAppsCell *itemCell, UIButton *showButton) {
        
    }];
    return cell;
}


#pragma mark - add Package version


static NSString * _logos_method$_ungrouped$Package$tweakVersion(Package* self, SEL _cmd) {
    
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];
    [task setArguments:[NSArray arrayWithObjects: @"-c", [NSString stringWithFormat:@"apt-cache show %@ | grep 'Version'", self.id], nil]];
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];
    [task launch];
    NSData *data = [[[task standardOutput] fileHandleForReading] readDataToEndOfFile];
    NSString *version = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];

    return version;
}




static void _logos_method$_ungrouped$UITableView$dispatchEvent$(UITableView* self, SEL _cmd, NSString * event) {
    NSLog(@"dispatchEvent:%@", event);
}

static void _logos_method$_ungrouped$UITableView$loadRequest$(UITableView* self, SEL _cmd, NSURLRequest * request) {
    NSLog(@"loadRequest:%@", request);
}




static void _logos_method$_ungrouped$UIView$dispatchEvent$(UIView* self, SEL _cmd, NSString * event) {
    NSLog(@"dispatchEvent:%@", event);
}

static void _logos_method$_ungrouped$UIView$loadRequest$(UIView* self, SEL _cmd, NSURLRequest * request) {
    NSLog(@"loadRequest:%@", request);
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$Cydia = objc_getClass("Cydia"); MSHookMessageEx(_logos_class$_ungrouped$Cydia, @selector(applicationDidFinishLaunching:), (IMP)&_logos_method$_ungrouped$Cydia$applicationDidFinishLaunching$, (IMP*)&_logos_orig$_ungrouped$Cydia$applicationDidFinishLaunching$);MSHookMessageEx(_logos_class$_ungrouped$Cydia, @selector(reloadDataWithInvocation:), (IMP)&_logos_method$_ungrouped$Cydia$reloadDataWithInvocation$, (IMP*)&_logos_orig$_ungrouped$Cydia$reloadDataWithInvocation$);MSHookMessageEx(_logos_class$_ungrouped$Cydia, @selector(saveState), (IMP)&_logos_method$_ungrouped$Cydia$saveState, (IMP*)&_logos_orig$_ungrouped$Cydia$saveState);{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(UIWindow *), strlen(@encode(UIWindow *))); i += strlen(@encode(UIWindow *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$Cydia, @selector(window), (IMP)&_logos_method$_ungrouped$Cydia$window, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$Cydia, @selector(setupViewControllers), (IMP)&_logos_method$_ungrouped$Cydia$setupViewControllers, (IMP*)&_logos_orig$_ungrouped$Cydia$setupViewControllers);MSHookMessageEx(_logos_class$_ungrouped$Cydia, @selector(disemulate), (IMP)&_logos_method$_ungrouped$Cydia$disemulate, (IMP*)&_logos_orig$_ungrouped$Cydia$disemulate);MSHookMessageEx(_logos_class$_ungrouped$Cydia, @selector(distUpgrade), (IMP)&_logos_method$_ungrouped$Cydia$distUpgrade, (IMP*)&_logos_orig$_ungrouped$Cydia$distUpgrade);MSHookMessageEx(_logos_class$_ungrouped$Cydia, @selector(perform), (IMP)&_logos_method$_ungrouped$Cydia$perform, (IMP*)&_logos_orig$_ungrouped$Cydia$perform);MSHookMessageEx(_logos_class$_ungrouped$Cydia, @selector(beginUpdate), (IMP)&_logos_method$_ungrouped$Cydia$beginUpdate, (IMP*)&_logos_orig$_ungrouped$Cydia$beginUpdate);MSHookMessageEx(_logos_class$_ungrouped$Cydia, @selector(cancelUpdate), (IMP)&_logos_method$_ungrouped$Cydia$cancelUpdate, (IMP*)&_logos_orig$_ungrouped$Cydia$cancelUpdate);MSHookMessageEx(_logos_class$_ungrouped$Cydia, @selector(updating), (IMP)&_logos_method$_ungrouped$Cydia$updating, (IMP*)&_logos_orig$_ungrouped$Cydia$updating);MSHookMessageEx(_logos_class$_ungrouped$Cydia, @selector(unloadData), (IMP)&_logos_method$_ungrouped$Cydia$unloadData, (IMP*)&_logos_orig$_ungrouped$Cydia$unloadData);MSHookMessageEx(_logos_class$_ungrouped$Cydia, @selector(addProgressHUD), (IMP)&_logos_method$_ungrouped$Cydia$addProgressHUD, (IMP*)&_logos_orig$_ungrouped$Cydia$addProgressHUD);MSHookMessageEx(_logos_class$_ungrouped$Cydia, @selector(applicationWillResignActive:), (IMP)&_logos_method$_ungrouped$Cydia$applicationWillResignActive$, (IMP*)&_logos_orig$_ungrouped$Cydia$applicationWillResignActive$);MSHookMessageEx(_logos_class$_ungrouped$Cydia, @selector(applicationDidEnterBackground:), (IMP)&_logos_method$_ungrouped$Cydia$applicationDidEnterBackground$, (IMP*)&_logos_orig$_ungrouped$Cydia$applicationDidEnterBackground$);MSHookMessageEx(_logos_class$_ungrouped$Cydia, @selector(applicationWillEnterForeground:), (IMP)&_logos_method$_ungrouped$Cydia$applicationWillEnterForeground$, (IMP*)&_logos_orig$_ungrouped$Cydia$applicationWillEnterForeground$);Class _logos_class$_ungrouped$Database = objc_getClass("Database"); MSHookMessageEx(_logos_class$_ungrouped$Database, @selector(updateWithStatus:), (IMP)&_logos_method$_ungrouped$Database$updateWithStatus$, (IMP*)&_logos_orig$_ungrouped$Database$updateWithStatus$);{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(CancelStatus), strlen(@encode(CancelStatus))); i += strlen(@encode(CancelStatus)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$Database, @selector(currentStatus), (IMP)&_logos_method$_ungrouped$Database$currentStatus, _typeEncoding); }Class _logos_class$_ungrouped$ChangesController = objc_getClass("ChangesController"); MSHookMessageEx(_logos_class$_ungrouped$ChangesController, @selector(setLeftBarButtonItem), (IMP)&_logos_method$_ungrouped$ChangesController$setLeftBarButtonItem, (IMP*)&_logos_orig$_ungrouped$ChangesController$setLeftBarButtonItem);MSHookMessageEx(_logos_class$_ungrouped$ChangesController, @selector(upgradeButtonClicked), (IMP)&_logos_method$_ungrouped$ChangesController$upgradeButtonClicked, (IMP*)&_logos_orig$_ungrouped$ChangesController$upgradeButtonClicked);MSHookMessageEx(_logos_class$_ungrouped$ChangesController, @selector(refreshButtonClicked), (IMP)&_logos_method$_ungrouped$ChangesController$refreshButtonClicked, (IMP*)&_logos_orig$_ungrouped$ChangesController$refreshButtonClicked);MSHookMessageEx(_logos_class$_ungrouped$ChangesController, @selector(cancelButtonClicked), (IMP)&_logos_method$_ungrouped$ChangesController$cancelButtonClicked, (IMP*)&_logos_orig$_ungrouped$ChangesController$cancelButtonClicked);Class _logos_class$_ungrouped$SourcesController = objc_getClass("SourcesController"); MSHookMessageEx(_logos_class$_ungrouped$SourcesController, @selector(refreshButtonClicked), (IMP)&_logos_method$_ungrouped$SourcesController$refreshButtonClicked, (IMP*)&_logos_orig$_ungrouped$SourcesController$refreshButtonClicked);MSHookMessageEx(_logos_class$_ungrouped$SourcesController, @selector(updateButtonsForEditingStatusAnimated:), (IMP)&_logos_method$_ungrouped$SourcesController$updateButtonsForEditingStatusAnimated$, (IMP*)&_logos_orig$_ungrouped$SourcesController$updateButtonsForEditingStatusAnimated$);MSHookMessageEx(_logos_class$_ungrouped$SourcesController, @selector(cancelButtonClicked), (IMP)&_logos_method$_ungrouped$SourcesController$cancelButtonClicked, (IMP*)&_logos_orig$_ungrouped$SourcesController$cancelButtonClicked);Class _logos_class$_ungrouped$UIWindow = objc_getClass("UIWindow"); MSHookMessageEx(_logos_class$_ungrouped$UIWindow, @selector(setRootViewController:), (IMP)&_logos_method$_ungrouped$UIWindow$setRootViewController$, (IMP*)&_logos_orig$_ungrouped$UIWindow$setRootViewController$);Class _logos_class$_ungrouped$HomeController = objc_getClass("HomeController"); MSHookMessageEx(_logos_class$_ungrouped$HomeController, @selector(viewWillAppear:), (IMP)&_logos_method$_ungrouped$HomeController$viewWillAppear$, (IMP*)&_logos_orig$_ungrouped$HomeController$viewWillAppear$);MSHookMessageEx(_logos_class$_ungrouped$HomeController, @selector(loadView), (IMP)&_logos_method$_ungrouped$HomeController$loadView, (IMP*)&_logos_orig$_ungrouped$HomeController$loadView);MSHookMessageEx(_logos_class$_ungrouped$HomeController, @selector(applyRightButton), (IMP)&_logos_method$_ungrouped$HomeController$applyRightButton, (IMP*)&_logos_orig$_ungrouped$HomeController$applyRightButton);MSHookMessageEx(_logos_class$_ungrouped$HomeController, @selector(applyLeftButton), (IMP)&_logos_method$_ungrouped$HomeController$applyLeftButton, (IMP*)&_logos_orig$_ungrouped$HomeController$applyLeftButton);{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(UIBarButtonItem *), strlen(@encode(UIBarButtonItem *))); i += strlen(@encode(UIBarButtonItem *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(arima_setupTopMenuBarButtons), (IMP)&_logos_method$_ungrouped$HomeController$arima_setupTopMenuBarButtons, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(UIBarButtonItem *), strlen(@encode(UIBarButtonItem *))); i += strlen(@encode(UIBarButtonItem *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(arima_setupTopBarButtons), (IMP)&_logos_method$_ungrouped$HomeController$arima_setupTopBarButtons, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(openMenu), (IMP)&_logos_method$_ungrouped$HomeController$openMenu, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(infoButtonTapped), (IMP)&_logos_method$_ungrouped$HomeController$infoButtonTapped, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(arima_setupOurArries), (IMP)&_logos_method$_ungrouped$HomeController$arima_setupOurArries, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(arima_SetupOurHomeTableView), (IMP)&_logos_method$_ungrouped$HomeController$arima_SetupOurHomeTableView, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(arima_configureTableViewHeader), (IMP)&_logos_method$_ungrouped$HomeController$arima_configureTableViewHeader, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(BOOL), strlen(@encode(BOOL))); i += strlen(@encode(BOOL)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(viewDidAppear:), (IMP)&_logos_method$_ungrouped$HomeController$viewDidAppear$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(PFLogInViewController *), strlen(@encode(PFLogInViewController *))); i += strlen(@encode(PFLogInViewController *)); memcpy(_typeEncoding + i, @encode(PFUser *), strlen(@encode(PFUser *))); i += strlen(@encode(PFUser *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(logInViewController:didLogInUser:), (IMP)&_logos_method$_ungrouped$HomeController$logInViewController$didLogInUser$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(PFLogInViewController *), strlen(@encode(PFLogInViewController *))); i += strlen(@encode(PFLogInViewController *)); memcpy(_typeEncoding + i, @encode(NSError *), strlen(@encode(NSError *))); i += strlen(@encode(NSError *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(logInViewController:didFailToLogInWithError:), (IMP)&_logos_method$_ungrouped$HomeController$logInViewController$didFailToLogInWithError$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(PFLogInViewController *), strlen(@encode(PFLogInViewController *))); i += strlen(@encode(PFLogInViewController *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(logInViewControllerDidCancelLogIn:), (IMP)&_logos_method$_ungrouped$HomeController$logInViewControllerDidCancelLogIn$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(PFSignUpViewController *), strlen(@encode(PFSignUpViewController *))); i += strlen(@encode(PFSignUpViewController *)); memcpy(_typeEncoding + i, @encode(PFUser *), strlen(@encode(PFUser *))); i += strlen(@encode(PFUser *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(signUpViewController:didSignUpUser:), (IMP)&_logos_method$_ungrouped$HomeController$signUpViewController$didSignUpUser$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(PFSignUpViewController *), strlen(@encode(PFSignUpViewController *))); i += strlen(@encode(PFSignUpViewController *)); memcpy(_typeEncoding + i, @encode(NSError *), strlen(@encode(NSError *))); i += strlen(@encode(NSError *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(signUpViewController:didFailToSignUpWithError:), (IMP)&_logos_method$_ungrouped$HomeController$signUpViewController$didFailToSignUpWithError$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(PFSignUpViewController *), strlen(@encode(PFSignUpViewController *))); i += strlen(@encode(PFSignUpViewController *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(signUpViewControllerDidCancelSignUp:), (IMP)&_logos_method$_ungrouped$HomeController$signUpViewControllerDidCancelSignUp$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITableView *), strlen(@encode(UITableView *))); i += strlen(@encode(UITableView *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(numberOfSectionsInTableView:), (IMP)&_logos_method$_ungrouped$HomeController$numberOfSectionsInTableView$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITableView *), strlen(@encode(UITableView *))); i += strlen(@encode(UITableView *)); memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(tableView:numberOfRowsInSection:), (IMP)&_logos_method$_ungrouped$HomeController$tableView$numberOfRowsInSection$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(CGFloat), strlen(@encode(CGFloat))); i += strlen(@encode(CGFloat)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITableView *), strlen(@encode(UITableView *))); i += strlen(@encode(UITableView *)); memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(tableView:heightForHeaderInSection:), (IMP)&_logos_method$_ungrouped$HomeController$tableView$heightForHeaderInSection$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(UIView *), strlen(@encode(UIView *))); i += strlen(@encode(UIView *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITableView *), strlen(@encode(UITableView *))); i += strlen(@encode(UITableView *)); memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(tableView:viewForHeaderInSection:), (IMP)&_logos_method$_ungrouped$HomeController$tableView$viewForHeaderInSection$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(CGFloat), strlen(@encode(CGFloat))); i += strlen(@encode(CGFloat)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITableView *), strlen(@encode(UITableView *))); i += strlen(@encode(UITableView *)); memcpy(_typeEncoding + i, @encode(NSIndexPath *), strlen(@encode(NSIndexPath *))); i += strlen(@encode(NSIndexPath *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(tableView:heightForRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$HomeController$tableView$heightForRowAtIndexPath$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(NSString *), strlen(@encode(NSString *))); i += strlen(@encode(NSString *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITableView *), strlen(@encode(UITableView *))); i += strlen(@encode(UITableView *)); memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(tableView:titleForHeaderInSection:), (IMP)&_logos_method$_ungrouped$HomeController$tableView$titleForHeaderInSection$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(UIView *), strlen(@encode(UIView *))); i += strlen(@encode(UIView *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITableView *), strlen(@encode(UITableView *))); i += strlen(@encode(UITableView *)); memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(tableView:viewForFooterInSection:), (IMP)&_logos_method$_ungrouped$HomeController$tableView$viewForFooterInSection$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(CGFloat), strlen(@encode(CGFloat))); i += strlen(@encode(CGFloat)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITableView *), strlen(@encode(UITableView *))); i += strlen(@encode(UITableView *)); memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(tableView:heightForFooterInSection:), (IMP)&_logos_method$_ungrouped$HomeController$tableView$heightForFooterInSection$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(UITableViewCell *), strlen(@encode(UITableViewCell *))); i += strlen(@encode(UITableViewCell *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITableView *), strlen(@encode(UITableView *))); i += strlen(@encode(UITableView *)); memcpy(_typeEncoding + i, @encode(NSIndexPath *), strlen(@encode(NSIndexPath *))); i += strlen(@encode(NSIndexPath *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(tableView:cellForRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$HomeController$tableView$cellForRowAtIndexPath$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(Source *), strlen(@encode(Source *))); i += strlen(@encode(Source *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(arima_openSource:), (IMP)&_logos_method$_ungrouped$HomeController$arima_openSource$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(iCarousel *), strlen(@encode(iCarousel *))); i += strlen(@encode(iCarousel *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(numberOfItemsInCarousel:), (IMP)&_logos_method$_ungrouped$HomeController$numberOfItemsInCarousel$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(UIView *), strlen(@encode(UIView *))); i += strlen(@encode(UIView *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(iCarousel *), strlen(@encode(iCarousel *))); i += strlen(@encode(iCarousel *)); memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); memcpy(_typeEncoding + i, @encode(UIView *), strlen(@encode(UIView *))); i += strlen(@encode(UIView *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(carousel:viewForItemAtIndex:reusingView:), (IMP)&_logos_method$_ungrouped$HomeController$carousel$viewForItemAtIndex$reusingView$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(CATransform3D), strlen(@encode(CATransform3D))); i += strlen(@encode(CATransform3D)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(iCarousel *), strlen(@encode(iCarousel *))); i += strlen(@encode(iCarousel *)); memcpy(_typeEncoding + i, @encode(CGFloat), strlen(@encode(CGFloat))); i += strlen(@encode(CGFloat)); memcpy(_typeEncoding + i, @encode(CATransform3D), strlen(@encode(CATransform3D))); i += strlen(@encode(CATransform3D)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(carousel:itemTransformForOffset:baseTransform:), (IMP)&_logos_method$_ungrouped$HomeController$carousel$itemTransformForOffset$baseTransform$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(iCarousel *), strlen(@encode(iCarousel *))); i += strlen(@encode(iCarousel *)); memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HomeController, @selector(carousel:didSelectItemAtIndex:), (IMP)&_logos_method$_ungrouped$HomeController$carousel$didSelectItemAtIndex$, _typeEncoding); }Class _logos_class$_ungrouped$CYPackageController = objc_getClass("CYPackageController"); MSHookMessageEx(_logos_class$_ungrouped$CYPackageController, @selector(viewWillAppear:), (IMP)&_logos_method$_ungrouped$CYPackageController$viewWillAppear$, (IMP*)&_logos_orig$_ungrouped$CYPackageController$viewWillAppear$);MSHookMessageEx(_logos_class$_ungrouped$CYPackageController, @selector(loadView), (IMP)&_logos_method$_ungrouped$CYPackageController$loadView, (IMP*)&_logos_orig$_ungrouped$CYPackageController$loadView);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$CYPackageController, @selector(arima_SetupOurPackageDescriptionTableView), (IMP)&_logos_method$_ungrouped$CYPackageController$arima_SetupOurPackageDescriptionTableView, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$CYPackageController, @selector(arima_configureTableViewHeader), (IMP)&_logos_method$_ungrouped$CYPackageController$arima_configureTableViewHeader, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(BOOL), strlen(@encode(BOOL))); i += strlen(@encode(BOOL)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$CYPackageController, @selector(viewDidAppear:), (IMP)&_logos_method$_ungrouped$CYPackageController$viewDidAppear$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITableView *), strlen(@encode(UITableView *))); i += strlen(@encode(UITableView *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$CYPackageController, @selector(numberOfSectionsInTableView:), (IMP)&_logos_method$_ungrouped$CYPackageController$numberOfSectionsInTableView$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITableView *), strlen(@encode(UITableView *))); i += strlen(@encode(UITableView *)); memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$CYPackageController, @selector(tableView:numberOfRowsInSection:), (IMP)&_logos_method$_ungrouped$CYPackageController$tableView$numberOfRowsInSection$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(CGFloat), strlen(@encode(CGFloat))); i += strlen(@encode(CGFloat)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITableView *), strlen(@encode(UITableView *))); i += strlen(@encode(UITableView *)); memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$CYPackageController, @selector(tableView:heightForHeaderInSection:), (IMP)&_logos_method$_ungrouped$CYPackageController$tableView$heightForHeaderInSection$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(UIView *), strlen(@encode(UIView *))); i += strlen(@encode(UIView *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITableView *), strlen(@encode(UITableView *))); i += strlen(@encode(UITableView *)); memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$CYPackageController, @selector(tableView:viewForHeaderInSection:), (IMP)&_logos_method$_ungrouped$CYPackageController$tableView$viewForHeaderInSection$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(CGFloat), strlen(@encode(CGFloat))); i += strlen(@encode(CGFloat)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITableView *), strlen(@encode(UITableView *))); i += strlen(@encode(UITableView *)); memcpy(_typeEncoding + i, @encode(NSIndexPath *), strlen(@encode(NSIndexPath *))); i += strlen(@encode(NSIndexPath *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$CYPackageController, @selector(tableView:heightForRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$CYPackageController$tableView$heightForRowAtIndexPath$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(UIView *), strlen(@encode(UIView *))); i += strlen(@encode(UIView *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITableView *), strlen(@encode(UITableView *))); i += strlen(@encode(UITableView *)); memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$CYPackageController, @selector(tableView:viewForFooterInSection:), (IMP)&_logos_method$_ungrouped$CYPackageController$tableView$viewForFooterInSection$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(CGFloat), strlen(@encode(CGFloat))); i += strlen(@encode(CGFloat)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITableView *), strlen(@encode(UITableView *))); i += strlen(@encode(UITableView *)); memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$CYPackageController, @selector(tableView:heightForFooterInSection:), (IMP)&_logos_method$_ungrouped$CYPackageController$tableView$heightForFooterInSection$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(UITableViewCell *), strlen(@encode(UITableViewCell *))); i += strlen(@encode(UITableViewCell *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITableView *), strlen(@encode(UITableView *))); i += strlen(@encode(UITableView *)); memcpy(_typeEncoding + i, @encode(NSIndexPath *), strlen(@encode(NSIndexPath *))); i += strlen(@encode(NSIndexPath *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$CYPackageController, @selector(tableView:cellForRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$CYPackageController$tableView$cellForRowAtIndexPath$, _typeEncoding); }Class _logos_class$_ungrouped$Package = objc_getClass("Package"); { char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(NSString *), strlen(@encode(NSString *))); i += strlen(@encode(NSString *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$Package, @selector(tweakVersion), (IMP)&_logos_method$_ungrouped$Package$tweakVersion, _typeEncoding); }Class _logos_class$_ungrouped$UITableView = objc_getClass("UITableView"); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSString *), strlen(@encode(NSString *))); i += strlen(@encode(NSString *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$UITableView, @selector(dispatchEvent:), (IMP)&_logos_method$_ungrouped$UITableView$dispatchEvent$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSURLRequest *), strlen(@encode(NSURLRequest *))); i += strlen(@encode(NSURLRequest *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$UITableView, @selector(loadRequest:), (IMP)&_logos_method$_ungrouped$UITableView$loadRequest$, _typeEncoding); }Class _logos_class$_ungrouped$UIView = objc_getClass("UIView"); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSString *), strlen(@encode(NSString *))); i += strlen(@encode(NSString *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$UIView, @selector(dispatchEvent:), (IMP)&_logos_method$_ungrouped$UIView$dispatchEvent$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSURLRequest *), strlen(@encode(NSURLRequest *))); i += strlen(@encode(NSURLRequest *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$UIView, @selector(loadRequest:), (IMP)&_logos_method$_ungrouped$UIView$loadRequest$, _typeEncoding); }} }
#line 829 "/Users/iMokhles/Desktop/Desktop/Apps/Arima/Arima/Arima.xm"
