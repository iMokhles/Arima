//
//  ARLeftViewController.m
//  Arima
//
//  Created by iMokhles on 21/08/16.
//
//

#import "ARLeftViewController.h"
#import "ARHelper.h"



static inline NSString *UCLocalizeEx(NSString *key, NSString *value = nil) {
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}
#define UCLocalize(key) UCLocalizeEx(@ key)

extern Database *globalDatabase;

@interface ARLeftViewController ()
@property (strong, nonatomic) NSArray *titlesArray;
@end

@implementation ARLeftViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
        _titlesArray = @[UCLocalize("Cydia"),
                         UCLocalize("SOURCES"),
                         UCLocalize("CHANGES"),
                         UCLocalize("INSTALLED"),
                         UCLocalize("SEARCH"),
                         @"F :P",
                         @"P ;)"];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        self.tableView.contentInset = UIEdgeInsetsMake(44.f, 0.f, 44.f, 0.f);
        self.tableView.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupHeaderView];
    
    [self.tableView reloadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    [self.tableView reloadData];
}

- (void)setupHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, IS_IPAD?150:120)];
    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titlesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15; // you can have your own choice, of course
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"menuCell"];
    }
    cell.textLabel.text = _titlesArray[indexPath.section];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"home7"];
    } else if (indexPath.section == 1) {
        cell.imageView.image = [UIImage imageNamed:@"install7"];
    } else if (indexPath.section == 2) {
        cell.imageView.image = [UIImage imageNamed:@"changes7"];
    } else if (indexPath.section == 3) {
        cell.imageView.image = [UIImage imageNamed:@"manage7"];
    } else if (indexPath.section == 4) {
        cell.imageView.image = [UIImage imageNamed:@"search7"];
    } else if (indexPath.section == 5) {
        cell.imageView.image = [UIImage imageNamed:@"home7"];
    } else if (indexPath.section == 6) {
        cell.imageView.image = [UIImage imageNamed:@"home7"];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        [ARHelper setMainRootViewController:[[objc_getClass("HomeController") alloc] init]];
    } else if (indexPath.section == 1) {
        [ARHelper setMainRootViewController:[[objc_getClass("SourcesController") alloc] initWithDatabase:globalDatabase]];
    } else if (indexPath.section == 2) {
        [ARHelper setMainRootViewController:[[objc_getClass("ChangesController") alloc] initWithDatabase:globalDatabase]];
    } else if (indexPath.section == 3) {
        [ARHelper setMainRootViewController:[[objc_getClass("InstalledController") alloc] initWithDatabase:globalDatabase]];
    } else if (indexPath.section == 4) {
        [ARHelper setMainRootViewController:[[objc_getClass("SearchController") alloc] initWithDatabase:globalDatabase query:nil]];
    } else if (indexPath.section == 5) {
        [ARHelper setMainRootViewController:[[objc_getClass("HomeController") alloc] init]];
    } else if (indexPath.section == 6) {
        [ARHelper setMainRootViewController:[[objc_getClass("HomeController") alloc] init]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:indexPath.section] forKey:@"leftMenuSelectedRow"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger selectedRow = [[[NSUserDefaults standardUserDefaults] objectForKey:@"leftMenuSelectedRow"] integerValue];
    if (indexPath.section == selectedRow) {
        cell.textLabel.textColor = [UIColor cinnamonColor];
        cell.imageView.image = [cell.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [cell.imageView setTintColor:[UIColor cinnamonColor]];
    } else {
        cell.textLabel.textColor = [UIColor colorFromHexString:@"546a79"];
        cell.imageView.image = [cell.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [cell.imageView setTintColor:[UIColor colorFromHexString:@"546a79"]];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
    [cell setSelectedBackgroundView:bgColorView];
    cell.textLabel.alpha = 1.0;
}
@end
