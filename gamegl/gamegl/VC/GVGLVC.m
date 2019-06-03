//
//  GVGLVC.m
//  gamegl
//
//  Created by mac04 on 2019/5/23.
//  Copyright © 2019 game. All rights reserved.
//

#import "GVGLVC.h"
#import "GVGLListCell.h"
#import "CommonWKWebVC.h"
#import "gvlistItme.h"

@interface GVGLVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*myTableview;
@end

@implementation GVGLVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.mytitle;
    _myTableview = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
    

        [tableView registerNib:[UINib nibWithNibName:@"GVGLListCell" bundle:nil] forCellReuseIdentifier:GVGLListCell_MemberCell];
        tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:tableView];
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView;
    });
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GVGLListCell*cell = [tableView dequeueReusableCellWithIdentifier:GVGLListCell_MemberCell forIndexPath:indexPath];
    [cell setItem:self.items[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CommonWKWebVC*wc = [[CommonWKWebVC alloc]init];
    gvlistItme*item = (gvlistItme*)self.items[indexPath.row];
    wc.url = item.url;
    [self.navigationController pushViewController:wc animated:YES];
}
@end
