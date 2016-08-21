//
//  Arima.h
//  Arima
//
//  Created by iMokhles on 20/08/16.
//
//

#ifndef Arima_h
#define Arima_h


#import "UIImageView+WebCache.h"

@protocol FetchDelegate
- (bool) isSourceCancelled;
- (void) startSourceFetch:(NSString *)uri;
- (void) stopSourceFetch:(NSString *)uri;
@end


@class Database;

typedef struct CydiaStatus {
    /*function pointer*/void* _vptr$pkgAcquireStatus;
    struct timeval Time;
    struct timeval StartTime;
    double LastBytes;
    double CurrentCPS;
    double CurrentBytes;
    double TotalBytes;
    double FetchedBytes;
    unsigned long ElapsedTime;
    unsigned long TotalItems;
    unsigned long CurrentItems;
    BOOL Update;
    BOOL MorePulses;
    BOOL cancelled_;
} CydiaStatus;

typedef struct CancelStatus {
    struct timeval _field2;
    struct timeval _field3;
    double _field4;
    double _field5;
    double _field6;
    double _field7;
    double _field8;
    unsigned long _field9;
    unsigned long _field10;
    unsigned long _field11;
    _Bool _field12;
    _Bool _field13;
    _Bool _field14;
} CancelStatus;

@interface UIViewController (Cydia)
- (void) unloadData;
- (void) reloadData;
- (BOOL) hasLoaded;
@end

@interface UIProgressHUD : UIView
- (void) hide;
- (void) setText:(NSString *)text;
- (void) showInView:(UIView *)view;
@end

@interface UIScroller : UIView
- (CGSize) contentSize;
- (void) setDirectionalScrolling:(BOOL)directional;
- (void) setEventMode:(NSInteger)mode;
- (void) setOffset:(CGPoint)offset;
- (void) setScrollDecelerationFactor:(float)factor;
- (void) setScrollHysteresis:(float)hysteresis;
- (void) setScrollerIndicatorStyle:(UIScrollViewIndicatorStyle)style;
- (void) setThumbDetectionEnabled:(BOOL)enabled;
@end

@interface UIView (Apple)
- (UIScroller *) _scroller;
- (void) setClipsSubviews:(BOOL)clips;
- (void) setEnabledGestures:(NSInteger)gestures;
- (void) setFixedBackgroundPattern:(BOOL)fixed;
- (void) setGestureDelegate:(id)delegate;
- (void) setNeedsDisplayOnBoundsChange:(BOOL)needs;
- (void) setValue:(NSValue *)value forGestureAttribute:(NSInteger)attribute;
- (void) setZoomScale:(float)scale duration:(double)duration;
- (void) _setZoomScale:(float)scale duration:(double)duration;
- (void) setOrigin:(CGPoint)origin;
@end

@interface MIMEAddress : NSObject
- (NSString *) name;
- (NSString *) address;
@end

@class Source;
@interface Source : NSObject
- (NSString *) depictionForPackage:(NSString *)package;
- (NSString *) supportForPackage:(NSString *)package;
- (NSString *) rooturi;
- (NSString *) distribution;
- (NSString *) type;
- (NSString *) key;
- (NSString *) host;
- (NSString *) name;
- (NSString *) shortDescription;
- (NSString *) label;
- (NSString *) origin;
- (NSString *) version;
- (NSString *) defaultIcon;
- (NSURL *) iconURL;
- (BOOL) trusted;
@end

@class Package;


@protocol DatabaseDelegate
- (void) repairWithSelector:(SEL)selector;
- (void) setConfigurationData:(NSString *)data;
@end

@interface Database : NSObject
+ (Database *) sharedInstance;
- (unsigned) era;
- (Package *) packageWithName:(NSString *)name;
- (NSArray *) packages;
- (NSArray *) sources;
- (void) configure;
- (bool) prepare;
- (void) perform;
- (bool) upgrade;
- (void) update;
- (void) updateWithStatus:(CancelStatus)arg1 ;
- (void) setDelegate:(NSObject<DatabaseDelegate> *)delegate;
- (bool) delocked;

// new
- (CancelStatus)currentStatus;
@end

@interface CyteViewController : UIViewController
- (void) unloadData;
- (void) reloadData;
- (BOOL) hasLoaded;
- (NSURL *) navigationURL;
@end

@interface CyteWebViewController : CyteViewController
- (void) reloadURLWithCache:(BOOL)cache;
@end

@interface CydiaWebViewController : CyteWebViewController
@end

@interface HomeController : CydiaWebViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, iCarouselDataSource, iCarouselDelegate>

- (UIBarButtonItem *) leftButton;

// new ( arima )
- (void)arima_openSource:(Source *)source;
- (void)arima_configureTableViewHeader;
- (void)arima_SetupOurHomeTableView;
- (void)arima_setupOurArries;
- (UIBarButtonItem *)arima_setupTopBarButtons;
- (UIBarButtonItem *)arima_setupTopMenuBarButtons;
@end

@interface SectionsController : CyteViewController
- (void) setDelegate:(id)delegate;
- (id) initWithDatabase:(Database *)database source:(Source *)source;
@end

@interface CYPackageController : CydiaWebViewController <UITableViewDelegate, UITableViewDataSource> {
    Package *package_;
    NSString *name_;
    bool commercial_;
}
- (id) initWithDatabase:(Database *)database forPackage:(NSString *)name withReferrer:(NSString *)referrer;

// new
- (void)arima_SetupOurPackageDescriptionTableView;
- (void)arima_configureTableViewHeader;
@end

@interface SourcesController : CyteViewController
- (id) initWithDatabase:(Database *)database;
- (void) updateButtonsForEditingStatusAnimated:(BOOL)animated;
@end

@interface PackageListController : CyteViewController
- (id) initWithDatabase:(Database *)database title:(NSString *)title;
@end

@interface FilteredPackageListController : PackageListController
- (id) initWithDatabase:(Database *)database title:(NSString *)title filter:(id)filter;

- (void) setFilter:(id)filter;
- (void) setSorter:(id)sorter;

@end

@interface ChangesController : FilteredPackageListController
- (id) initWithDatabase:(Database *)database;

- (void) setLeftBarButtonItem;
@end

@interface InstalledController : FilteredPackageListController
- (id) initWithDatabase:(Database *)database;
- (void) queueStatusDidChange;
@end

@interface SearchController : FilteredPackageListController
- (id) initWithDatabase:(Database *)database query:(NSString *)query;
@end

@interface ConfirmationController : CydiaWebViewController
- (id) initWithDatabase:(Database *)database;
@end


@interface Cydia : UIApplication
- (void) loadData;
- (void) returnToCydia;
- (void) saveState;
- (void) retainNetworkActivityIndicator;
- (void) releaseNetworkActivityIndicator;
- (void) clearPackage:(Package *)package;
- (void) installPackage:(Package *)package;
- (void) installPackages:(NSArray *)packages;
- (void) removePackage:(Package *)package;
- (void) beginUpdate;
- (BOOL) updating;
- (bool) requestUpdate;
- (void) distUpgrade;
- (void) cancelUpdate;
- (void) loadData;
- (void) updateData;
- (void) _saveConfig;
- (void) syncData;
- (void) addSource:(NSDictionary *)source;
- (void) addTrivialSource:(NSString *)href;
- (void) showActionSheet:(UIActionSheet *)sheet fromItem:(UIBarButtonItem *)item;
- (void) reloadDataWithInvocation:(NSInvocation *)invocation;
- (void)setupViewControllers;
- (void) lockSuspend;
- (void) reloadData;
// new
- (UIWindow *)window;
@end

@protocol CydiaDelegate
- (void) returnToCydia;
- (void) saveState;
- (void) retainNetworkActivityIndicator;
- (void) releaseNetworkActivityIndicator;
- (void) clearPackage:(Package *)package;
- (void) installPackage:(Package *)package;
- (void) installPackages:(NSArray *)packages;
- (void) removePackage:(Package *)package;
- (void) beginUpdate;
- (BOOL) updating;
- (bool) requestUpdate;
- (void) distUpgrade;
- (void) loadData;
- (void) updateData;
- (void) _saveConfig;
- (void) syncData;
- (void) addSource:(NSDictionary *)source;
- (BOOL) addTrivialSource:(NSString *)href;
- (void) showActionSheet:(UIActionSheet *)sheet fromItem:(UIBarButtonItem *)item;
- (void) reloadDataWithInvocation:(NSInvocation *)invocation;
@end

@interface AppCacheController : CydiaWebViewController
@end

#endif /* Arima_h */
