
// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos

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
    
    // XXX: this elaborate mess is what Apple is using to determine this? :(
    // XXX: do we care if the user has to intervene? maybe that's ok?
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

%hook Cydia
- (void) applicationDidFinishLaunching:(id)unused {
    [ARHelper setup_Server];
    %orig;
    [self setupViewControllers];
    [cyAppDelegate requestUpdate];
    appcache__ = MSHookIvar<AppCacheController *>(self, "appcache_");
}
- (void) reloadDataWithInvocation:(NSInvocation *)invocation {
    cyAppDelegate = self;
    %orig;
    globalDatabase = MSHookIvar<Database *>(self, "database_");
    packages__ = [globalDatabase packages];
    sources__ = [globalDatabase sources];
    
    
}

- (void) saveState {
    [[NSDictionary dictionaryWithObjectsAndKeys:
      @"InterfaceState", [kMainViewController navigationURLCollection],
      @"LastClosed", [NSDate date],
      @"InterfaceIndex", [NSNumber numberWithInt:[[[NSUserDefaults standardUserDefaults] objectForKey:@"leftMenuSelectedRow"] intValue]],
      nil] writeToFile:@ SavedState_ atomically:YES];
    
    [self _saveConfig];
}
%new
- (UIWindow *)window {
    UIWindow *window__ = MSHookIvar<UIWindow *>(self, "window_");
    return window__;
}

- (void)setupViewControllers {
    %orig;
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
//    [cyAppDelegate reloadDataWithInvocation:nil];
}
- (void) disemulate {
    %orig;
    [self setupViewControllers];
}

- (void) distUpgrade {
    NSLog(@"*********** distUpgrade");
    %orig;
}
- (bool) perform {
     NSLog(@"*********** HERE");
    
    if ([kMainViewController updating])
        [kMainViewController cancelUpdate];
    
    if (![globalDatabase prepare])
        return false;
    
    ConfirmationController *page([[objc_getClass("ConfirmationController") alloc] initWithDatabase:globalDatabase]);
//    [page setDelegate:self];
    UINavigationController *confirm_([[UINavigationController alloc] initWithRootViewController:page]);
    
    if (IS_IPAD)
        [confirm_ setModalPresentationStyle:UIModalPresentationFormSheet];
    
   
    [kMainViewController presentModalViewController:confirm_ animated:YES];
    
    return true;
}

- (void) beginUpdate {
    [kMainViewController beginUpdate];
}

- (void) cancelUpdate {
    [kMainViewController cancelUpdate];
}

- (BOOL) updating {
    return [kMainViewController updating];
    
}
- (void) unloadData {
    [kMainViewController unloadData];
}
- (UIProgressHUD *) addProgressHUD {
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
- (void) applicationWillResignActive:(UIApplication *)application {
    %orig;
    if ([kMainViewController updating])
        [kMainViewController cancelUpdate];
}
- (void) applicationDidEnterBackground:(UIApplication *)application {
    %orig;
    Backgrounded_ = [NSDate date];
    [self saveState];
}
- (void) applicationWillEnterForeground:(UIApplication *)application {
    %orig;
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
%end

%hook Database
- (void)updateWithStatus:(CancelStatus)arg1 {
    NSLog(@"********* CANCELSTATUS OOOH\n\n\n\n\n\n\n\n\n");
    %orig;
    cydiaStatus = arg1;
}
%new
- (CancelStatus)currentStatus {
    return MSHookIvar<CancelStatus>(self, "status_");
}
%end

%hook ChangesController

- (void) setLeftBarButtonItem {
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
- (void) upgradeButtonClicked {
    NSLog(@"*********** upgradeButtonClicked");
    [cyAppDelegate distUpgrade];
    [[self navigationItem] setRightBarButtonItem:nil animated:YES];
}
- (void) refreshButtonClicked {
     NSLog(@"*********** refreshButtonClicked");
    if ([cyAppDelegate requestUpdate])
        [self setLeftBarButtonItem];
}
- (void) cancelButtonClicked {
    [cyAppDelegate cancelUpdate];
}
%end

%hook SourcesController
- (void) refreshButtonClicked {
    [cyAppDelegate requestUpdate];
    [self updateButtonsForEditingStatusAnimated:YES];
}
- (void) updateButtonsForEditingStatusAnimated:(BOOL)animated {
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
- (void) cancelButtonClicked {
    [cyAppDelegate cancelUpdate];
}
%end

%hook UIWindow

- (void)setRootViewController:(id)arg1 {
    %orig;
    NSLog(@"********** %@", arg1);
}
%end
%hook HomeController

- (void)viewWillAppear:(BOOL)animated {
    %orig;
}
- (void) loadView {
    [self arima_setupOurArries];
    %orig;
    [self arima_SetupOurHomeTableView];
}

- (void) applyRightButton {
    %orig;
    UIBarButtonItem *origReloadButton = self.navigationItem.rightBarButtonItem;
    [self.navigationItem setRightBarButtonItems:@[origReloadButton, [self arima_setupTopBarButtons]] animated:YES];
    [[self navigationItem] setTitle:UCLocalize("HOME")];
}

- (void) applyLeftButton {
    %orig;
//    UIBarButtonItem *origAboutButton = self.leftButton;
//    [self.navigationItem setLeftBarButtonItems:@[origAboutButton, [self arima_setupTopMenuBarButtons]] animated:YES];
//    [[self navigationItem] setTitle:UCLocalize("HOME")];
}
%new
- (UIBarButtonItem *)arima_setupTopMenuBarButtons {
    UIBarButtonItem* menuBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(openMenu)];
    return menuBarButton;
}
%new
- (UIBarButtonItem *)arima_setupTopBarButtons {
    UIButton *InfoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [InfoButton addTarget:self action:@selector(infoButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* infoBarButton = [[UIBarButtonItem alloc] initWithCustomView:InfoButton];
    return infoBarButton;
}

%new
- (void)openMenu {
    [kMainViewController showLeftViewAnimated:YES completionHandler:nil];
}
%new
- (void)infoButtonTapped {
    
}
%new
- (void)arima_setupOurArries {
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
%new
- (void)arima_SetupOurHomeTableView {
    
    homeTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStyleGrouped];
    [homeTableView setAutoresizingMask:UIViewAutoresizingFlexibleBoth];
    [homeTableView setDataSource:self];
    [homeTableView setDelegate:self];
    [homeTableView setAllowsSelection:NO];
    [self setView:homeTableView];
    
    [self arima_configureTableViewHeader];
    
}
%new
- (void)arima_configureTableViewHeader {
    ARScrollHeader *view = [[ARScrollHeader alloc] initWithFrame:CGRectMake(0, 0, 0, 200.0f)];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 60)];
//    label.text = @"Arima";
//    label.font = [UIFont systemFontOfSize:60 weight:UIFontWeightLight];
//    label.backgroundColor = [UIColor clearColor];
//    label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
//    [label sizeToFit];
//    label.center = CGPointMake(view.frame.size.width  / 2, 10);
//    label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
//    [view addSubview:label];
    
    _carousel = [[iCarousel alloc] initWithFrame:view.bounds];
    _carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _carousel.type = iCarouselTypeRotary;
    _carousel.delegate = self;
    _carousel.dataSource = self;
    [view addSubview:_carousel];
    
    homeTableView.tableHeaderView = view;
    [_carousel reloadData];
}
%new
- (void)viewDidAppear:(BOOL)animated {
    
    [homeTableView reloadData];
    if ([PFUser currentUser] == nil) {
        [ARHelper loginOrSignUpFromTarget:self];
    }
}

#pragma mark -
#pragma mark - LogIn Delegate
%new
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [logInController dismissViewControllerAnimated:YES completion:^{
        user[USER_DEVICE_ID] = [[iMoDevTools sharedInstance] imo_deviceUDIDValue];
        user[USER_CATG] = @"ArimaTweak";
        user[@"imei_user_device"] = [[iMoDevTools sharedInstance] imo_deviceSysVersion];
        user[@"product_user_device"] = [[iMoDevTools sharedInstance] imo_deviceHardware];
        [user saveInBackground];
    }];
}
%new
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    [ARHelper showErrorMessageFrom:logInController withError:error];
}
%new
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [logInController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - SignUp Delegate
%new
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [signUpController dismissViewControllerAnimated:YES completion:^{
        user[USER_DEVICE_ID] = [[iMoDevTools sharedInstance] imo_deviceUDIDValue];
        user[USER_CATG] = @"ArimaTweak";
        user[@"imei_user_device"] = [[iMoDevTools sharedInstance] imo_deviceSysVersion];
        user[@"product_user_device"] = [[iMoDevTools sharedInstance] imo_deviceHardware];
        [user saveInBackground];
    }];
}
%new
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    [ARHelper showErrorMessageFrom:signUpController withError:error];
}
%new
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    [signUpController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark -
#pragma mark UITableViewDataSource/UITableViewDelegate
%new
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return allSections.count;
}
%new
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 1;
}
%new
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15; // you can have your own choice, of course
}
%new
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}
%new
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 203;
}
%new
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Arima for Cydia";
}
%new
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
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
%new
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 5)
        return 21; // you can have your own choice, of course
    return 17.5;
}
%new
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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

%new
- (void)arima_openSource:(Source *)source {
    SectionsController *controller = [[objc_getClass("SectionsController") alloc] initWithDatabase:globalDatabase source:source];
    [controller setDelegate:cyAppDelegate];
    [[self navigationController] pushViewController:controller animated:YES];
}
#pragma mark -
#pragma mark iCarouselDataSource/iCarouselDelegate
%new
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 10;
}
%new
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
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
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    label.text = [NSString stringWithFormat:@"Tweak %ld", (long)index];
    
    return view;
}
%new
- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}
%new
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    
}
%end

#pragma mark - PackageDescriptionPage
%hook CYPackageController
- (void)viewWillAppear:(BOOL)arg1 {
    %orig;
    [[self navigationItem] setTitle:UCLocalize("DETAILS")];
    currentPackage = [globalDatabase packageWithName:MSHookIvar<NSString *>(self, "name_")];//MSHookIvar<Package *>(self, "package_");
    [self arima_configureTableViewHeader];
    [packageDescriptionTableView reloadData];
}
- (void)loadView {
    %orig;
    [self arima_SetupOurPackageDescriptionTableView];
    [packageDescriptionTableView reloadData];
}

%new
- (void)arima_SetupOurPackageDescriptionTableView {
    
    packageDescriptionTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStyleGrouped];
    [packageDescriptionTableView setAutoresizingMask:UIViewAutoresizingFlexibleBoth];
    [packageDescriptionTableView setDataSource:self];
    [packageDescriptionTableView setDelegate:self];
    [packageDescriptionTableView setAllowsSelection:NO];
    [self setView:packageDescriptionTableView];
}
%new
- (void)arima_configureTableViewHeader {
    ARAppDescripHeader *view = [[ARAppDescripHeader alloc] initWithFrame:CGRectMake(0, 0, 0, 125.0f)];
    packageDescriptionTableView.tableHeaderView = view;
    [view configureWithPackage:currentPackage];
    
}
%new
- (void)viewDidAppear:(BOOL)animated {
    
    [homeTableView reloadData];
}
#pragma mark -
#pragma mark UITableViewDataSource/UITableViewDelegate
%new
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
%new
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 1;
}
%new
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15; // you can have your own choice, of course
}
%new
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}
%new
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 203;
}
%new
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
%new
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 5)
        return 21; // you can have your own choice, of course
    return 17.5;
}
%new
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *generalCellID = [NSString stringWithFormat:@"packageCellID_S%1ldR%1ld",(long)indexPath.section,(long)indexPath.row];
    ARScrollAppsCell *cell = [tableView dequeueReusableCellWithIdentifier:generalCellID];
    if (cell==nil) {
        cell = [[ARScrollAppsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:generalCellID];
    }
//    NSString *sectionTitle = [allSections objectAtIndex:indexPath.section];
    
    [cell configureWithTitle:@"Test 1" items:nil];
    [cell setItemTappedBlock:^(ARScrollAppsCell *itemCell, ARAppView *itemView) {

    }];
    [cell setShowAllTappedBlock:^(ARScrollAppsCell *itemCell, UIButton *showButton) {
        
    }];
    return cell;
}
%end

#pragma mark - add Package version
%hook Package
%new
- (NSString *)tweakVersion {
    
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];
    [task setArguments:[NSArray arrayWithObjects: @"-c", [NSString stringWithFormat:@"apt-cache show %@ | grep 'Version'", self.id], nil]];
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];
    [task launch];
    NSData *data = [[[task standardOutput] fileHandleForReading] readDataToEndOfFile];
    NSString *version = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
//    NSString *subString = [version substringFromIndex:[version length] - 8];
    return version;
}
%end
// :D
%hook UITableView
%new
- (void) dispatchEvent:(NSString *)event {
    NSLog(@"dispatchEvent:%@", event);
}
%new
- (void) loadRequest:(NSURLRequest *)request {
    NSLog(@"loadRequest:%@", request);
}
%end

%hook UIView
%new
- (void) dispatchEvent:(NSString *)event {
    NSLog(@"dispatchEvent:%@", event);
}
%new
- (void) loadRequest:(NSURLRequest *)request {
    NSLog(@"loadRequest:%@", request);
}
%end