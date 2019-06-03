//
//  GVLeftMenuViewController.m
//  gamegl
//
//  Created by mac04 on 2019/5/20.
//  Copyright © 2019 game. All rights reserved.
//

#import "GVLeftMenuVC.h"
#import "GVController.h"
#import "GVRightVC.h"
#import "GVSetingVC.h"
#import "GVMainVC.h"
#import "GVNavigationVC.h"

@interface GVLeftMenuVC ()
@property (strong, readwrite, nonatomic) UITableView *tableView;

@end

@implementation GVLeftMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 5) / 2.0f, self.view.frame.size.width, 54 * 5) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController setContentViewController:[[GVNavigationVC alloc] initWithRootViewController:[[GVMainVC alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
        {
            NSString * url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",@"1462993763"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            [self.sideMenuViewController hideMenuViewController];
            break;
            
        }
        case 2:{
            GVSetingVC* GVSetingVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"GVSetingVC"];
            [self.sideMenuViewController setContentViewController:[[GVNavigationVC alloc] initWithRootViewController:GVSetingVC]];
            [self.sideMenuViewController hideMenuViewController];
            
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.highlightedTextColor = [UIColor blackColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    NSArray *titles = @[@"主页", @"给个好评", @"设置"];
//    NSArray *images = @[@"IconHome", @"IconProfile", @"IconSettings"];
    cell.textLabel.text = titles[indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}


@end
