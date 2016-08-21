//
//  ARMainViewController.m
//  Arima
//
//  Created by iMokhles on 21/08/16.
//
//

#import "ARMainViewController.h"
#import "ARLeftViewController.h"
#import "Arima.hpp"

extern Database *globalDatabase;
extern CancelStatus cydiaStatus;
extern Cydia *cyAppDelegate;

static const UIActivityIndicatorViewStyle UIActivityIndicatorViewStyleWhiteSmall(static_cast<UIActivityIndicatorViewStyle>(3));
static const UIActivityIndicatorViewStyle UIActivityIndicatorViewStyleGraySmall(static_cast<UIActivityIndicatorViewStyle>(4));
static const UIActivityIndicatorViewStyle UIActivityIndicatorViewStyleWhiteTiny(static_cast<UIActivityIndicatorViewStyle>(5));

@interface ARMainViewController () {
    Database *database_;
    NSObject<CydiaDelegate> *updatedelegate_;
    bool updating_;
    UIActivityIndicatorView *indicator_;
}
@property (strong, nonatomic) ARLeftViewController *leftViewController;
@property (assign, nonatomic) NSUInteger type;
@end

@implementation ARMainViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
                         presentationStyle:(LGSideMenuPresentationStyle)style
                                      type:(NSUInteger)type
{
    self = [super initWithRootViewController:rootViewController];
    if (self)
    {
        _type = type;
        _leftViewController = [ARLeftViewController new];
        database_ = globalDatabase;
        indicator_ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteTiny];
        [indicator_ setOrigin:CGPointMake(kCFCoreFoundationVersionNumber >= 800 ? 2 : 4, 2)];
        
        if (type == 0)
        {
            [self setLeftViewEnabledWithWidth:240.f
                            presentationStyle:style
                         alwaysVisibleOptions:LGSideMenuAlwaysVisibleOnNone];
            
            self.leftViewStatusBarStyle = UIStatusBarStyleDefault;
            self.leftViewStatusBarVisibleOptions = LGSideMenuStatusBarVisibleOnNone;
            
            self.leftViewBackgroundColor = [UIColor ghostWhiteColor];
            _leftViewController.tableView.backgroundColor = [UIColor clearColor];
            
        }
        [_leftViewController.tableView reloadData];
        [self.leftView addSubview:_leftViewController.tableView];
    }
    return self;
}

- (NSArray *) navigationURLCollection {
    NSMutableArray *items([NSMutableArray array]);
    
    // XXX: Should this deal with transient view controllers?
    NSArray *stack = [self.rootViewController performSelector:@selector(navigationURLCollection)];
    if (stack != nil)
        [items addObject:stack];
    
    return items;
}

- (void) beginUpdate {
    if (updating_)
        return;
    
    [indicator_ startAnimating];
    
    [updatedelegate_ retainNetworkActivityIndicator];
    updating_ = true;
    
    [NSThread
     detachNewThreadSelector:@selector(performUpdate)
     toTarget:self
     withObject:nil
     ];
}

- (void) performUpdate {
    
    
//    [database_ updateWithStatus:cydiaStatus];
    
    [database_ update];
    [self
     performSelectorOnMainThread:@selector(completeUpdate)
     withObject:nil
     waitUntilDone:NO
     ];
    
}

- (void) stopUpdateWithSelector:(SEL)selector {
    updating_ = false;
    [updatedelegate_ releaseNetworkActivityIndicator];
    
//    UIViewController *controller([[self viewControllers] objectAtIndex:1]);
//    [[controller tabBarItem] setBadgeValue:nil];
    
    [indicator_ removeFromSuperview];
    [indicator_ stopAnimating];
    
    [updatedelegate_ performSelector:selector withObject:nil afterDelay:0];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) completeUpdate {
    if (!updating_)
        return;
    [self stopUpdateWithSelector:@selector(reloadData)];
}

- (void) cancelUpdate {
    [self stopUpdateWithSelector:@selector(updateDataAndLoad)];
}


- (void) cancelPressed {
    [self cancelUpdate];
}

- (BOOL) updating {
    return updating_;
}

- (bool) isSourceCancelled {
    return !updating_;
}

- (void) startSourceFetch:(NSString *)uri {
}

- (void) stopSourceFetch:(NSString *)uri {
}
- (void) setUpdateDelegate:(id)delegate {
    updatedelegate_ = delegate;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
