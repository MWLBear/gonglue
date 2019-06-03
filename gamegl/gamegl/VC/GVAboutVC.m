//
//  GVAboutVC.m
//  gamegl
//
//  Created by mac04 on 2019/5/20.
//  Copyright © 2019 game. All rights reserved.
//

#import "GVAboutVC.h"
#import "CommonWKWebVC.h"

@interface GVAboutVC ()
@property (weak, nonatomic) IBOutlet UIButton *urlBtn;

@end

@implementation GVAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";

    [self.urlBtn addTarget:self action:@selector(urlBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)urlBtnClick{
    CommonWKWebVC*vc = [[CommonWKWebVC alloc]init];
    vc.url = self.urlBtn.titleLabel.text;
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 40;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
