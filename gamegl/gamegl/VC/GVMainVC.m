//
//  GVMainVC.m
//  gamegl
//
//  Created by mac04 on 2019/5/21.
//  Copyright © 2019 game. All rights reserved.
//

#import "GVMainVC.h"
#import "GVHeaderCell.h"
#import "GVCommonCell.h"
#import "GVVideoCell.h"
#import "GVBossCell.h"
#import "GVGLCell.h"
#import "commonItem.h"
#import "GVNavigationVC.h"
#import "CommonWKWebVC.h"
#import "ODRefreshControl.h"
#import "GVCommonShowVC.h"
#import "GVGLVC.h"
#import "gvlistItme.h"
#import "GVVideoPlayVC.h"

static NSString *str = @"cell";
@interface GVMainVC ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong)UITableView*myTableView;
@property(nonatomic,strong)NSArray*titleArry;
@end

@implementation GVMainVC

-(NSArray*)titleArry{
    if(!_titleArry){
        _titleArry = @[@"游戏职业",@"游戏攻略",@"精品视频",@"强力BOSS",@"精美地图",@"绝世神兵",@"极品神戒"];
    }
    return _titleArry;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"传奇霸业-攻略大全";
    self.view.backgroundColor = [UIColor whiteColor];
    _myTableView = ({
       UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = YES;
        [tableView registerClass:[GVHeaderCell class] forCellReuseIdentifier:GVHeaderCell_MemberCell];
        [tableView registerNib:[UINib nibWithNibName:@"GVVideoCell" bundle:nil] forCellReuseIdentifier:GVVideoCell_MemberCell];
        [tableView registerNib:[UINib nibWithNibName:@"GVCommonCell" bundle:nil] forCellReuseIdentifier:GVCommonCell_MemberCell];
        [tableView registerNib:[UINib nibWithNibName:@"GVBossCell" bundle:nil] forCellReuseIdentifier:GVBossCell_MemberCell];
        [tableView registerNib:[UINib nibWithNibName:@"GVGLCell" bundle:nil] forCellReuseIdentifier:GVGLCell_MemberCell];
        
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:str];
        tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:tableView];
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView;
    });

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage: [self reSizeImage:[UIImage imageNamed:@"home.png"] toSize:CGSizeMake(20,20 )] landscapeImagePhone: [self reSizeImage:[UIImage imageNamed:@"home.png"] toSize:CGSizeMake(20,20 )] style:UIBarButtonItemStyleDone target:self action:@selector(presentLeftMenuViewController:)];
}

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [reSizeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [refreshControl endRefreshing];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArry.count + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
          return [GVHeaderCell cellHeight];
    }else if (indexPath.section == 1 ){
        return 130;
    }else if (indexPath.section == 2) {
        return 250 ;
    }else if (indexPath.section == 4){
        return 350;
    }else if (indexPath.section == 3){
        return 130;
    }else{
        return 150;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.textAlignment = NSTextAlignmentLeft;
    myLabel.textColor =  [UIColor whiteColor];
    myLabel.frame = CGRectMake(10, 5, self.view.bounds.size.width, 30);
    myLabel.font = [UIFont boldSystemFontOfSize:16];
    myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.alpha = 0.7;
    headerView.backgroundColor = [UIColor getColor:@"fb9c0a"];
    [headerView addSubview:myLabel];
    
    return headerView;
}
- ( NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        return self.titleArry[section-1];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  section?40:0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *cell;
   
    if (indexPath.section == 0) {
        NSArray *imageNames = @[@"header1.png",@"header2.png",@"header3.png"];
        NSArray*urls = @[@"http://www.9game.cn/rxbyzb/3002743.html",@"http://www.9game.cn/rxbyzb/2936874.html",@"http://www.9game.cn/rxbyzb/2930749.html"];
        cell = [tableView dequeueReusableCellWithIdentifier:GVHeaderCell_MemberCell forIndexPath:indexPath];
        GVHeaderCell*gvcell = (GVHeaderCell*)cell;
        [gvcell setImageArry:imageNames];
        gvcell.myblock = ^(NSInteger index) {
            CommonWKWebVC*vc = [[CommonWKWebVC alloc]init];
            vc.url = urls[index];
            [self.navigationController pushViewController:vc animated:YES];
        };
    }else if (indexPath.section == 1){ //游戏职业
        cell = [tableView dequeueReusableCellWithIdentifier:GVCommonCell_MemberCell forIndexPath:indexPath];
        GVCommonCell *common = (GVCommonCell*)cell;
        NSArray*titles = @[@"战士",@"法师",@"道士"];
        NSArray*images = @[[UIImage imageNamed:@"职业-战士.png"],[UIImage imageNamed:@"职业-法师.png"],[UIImage imageNamed:@"职业-道士.png"]];
        [common setItemA:[self dataArry:titles andimageA :images]];
        common.myblock = ^(NSInteger index) {
            [self showcommVc:index titleA:titles imageName:[NSString stringWithFormat:@"d10%ld",index+1]showAnimal:NO content:[self lolcontent]];
        };
        
    }else if (indexPath.section == 2){//游戏攻略
        cell= (GVGLCell *)[[[NSBundle mainBundle]loadNibNamed:GVGLCell_MemberCell owner:self options:nil]  lastObject];
        NSArray*titleArr = @[@"最新攻略",@"热门攻略",@"官方攻略",@"大神攻略"];
        GVGLCell*glcell = (GVGLCell*)cell;
        glcell.myblock = ^(NSInteger index) {
            GVGLVC*vc = [[GVGLVC alloc]init];
            vc.mytitle = titleArr[index];
            vc.items = [self getGVListItemWithIndex:index];
            [self.navigationController pushViewController:vc animated:YES];
        };
        
    }else if(indexPath.section == 3){//精品视频
        cell = [tableView dequeueReusableCellWithIdentifier:GVVideoCell_MemberCell forIndexPath:indexPath];
        GVVideoCell*video = (GVVideoCell*)cell;
        NSArray*path = @[@"2019051301.mp4",@"2019051302.mp4"];
        video.myblock = ^(NSInteger index) {
            GVVideoPlayVC*playvc = [[GVVideoPlayVC alloc]init];
            playvc.path = path[index];
             NSString *pathurl = [[NSBundle mainBundle] pathForResource:path[index] ofType:nil];
            NSLog(@"pathurl = %@",pathurl);
            [self.navigationController pushViewController:playvc animated:YES];
        };
        
    }else if (indexPath.section == 4){//强力Boss
        cell = [tableView dequeueReusableCellWithIdentifier:GVBossCell_MemberCell forIndexPath:indexPath];
        GVBossCell *bossccell = (GVBossCell*)cell;
        bossccell.myblock = ^(NSInteger index, NSArray *titles) {
            [self showcommVc:index titleA:titles imageName:[NSString stringWithFormat:@"boss_%ld",index+1]showAnimal:NO content:[self bosscontent]];
        };

    }else if(indexPath.section == 5){ //精美地图
        cell = [tableView dequeueReusableCellWithIdentifier:GVCommonCell_MemberCell forIndexPath:indexPath];
        GVCommonCell *common = (GVCommonCell*)cell;
        NSArray*titles = @[@"热血战场",@"火龙神殿",@"迷失大陆"];
        NSArray*images = @[[UIImage imageNamed:@"maps_1.png"],[UIImage imageNamed:@"maps_2.png"],[UIImage imageNamed:@"maps_3.png"]];
        [common setItemA:[self dataArry:titles andimageA :images]];
        common.myblock = ^(NSInteger index) {
            [self showcommVc:index titleA:titles imageName:[NSString stringWithFormat:@"maps_%ld",index+1]showAnimal:NO content:[self mapscontent]];
        };
        
    }else if (indexPath.section == 6){//绝世神兵
        cell = [tableView dequeueReusableCellWithIdentifier:GVCommonCell_MemberCell forIndexPath:indexPath];
        GVCommonCell *common = (GVCommonCell*)cell;
        NSArray*titles = @[@"创世刀",@"创世剑",@"创世仗"];
        NSArray*images = @[[UIImage imageNamed:@"rare_1.png"],[UIImage imageNamed:@"rare_2.png"],[UIImage imageNamed:@"rare_3.png"]];
        [common setItemA:[self dataArry:titles andimageA:images]];
        
        common.myblock = ^(NSInteger index) {
            [self showcommVc:index titleA:titles imageName:[NSString stringWithFormat:@"rare_r%ld",index+1]showAnimal:YES content:[self rarecontent]];
        };
    }else{//极品神戒
        cell = [tableView dequeueReusableCellWithIdentifier:GVCommonCell_MemberCell forIndexPath:indexPath];
        GVCommonCell *common = (GVCommonCell*)cell;
        NSArray*titles =@[@"神盾戒指",@"幻舞戒指",@"护身戒指"];
        NSArray*images = @[[UIImage imageNamed:@"ring_1.png"],[UIImage imageNamed:@"ring_2.png"],[UIImage imageNamed:@"ring_3.png"]];
        [common setItemA:[self dataArry:titles andimageA:images]];
        
        common.myblock = ^(NSInteger index) {
            [self showcommVc:index titleA:titles imageName:[NSString stringWithFormat:@"ring_%ld",index+1] showAnimal:YES content:[self ringcontent]];
        };

    }
    return cell;
}

-(NSArray*)getGVListItemWithIndex:(NSInteger)index{
    
    NSMutableArray*timearry = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i<20; i++) {
        int day = arc4random() % 29;
        int month = arc4random() % 11;
        NSString*time = [NSString stringWithFormat:@"2019年%d月%d日",month+1,day+1];
        [timearry addObject:time];
    }
    
    NSArray *dashen = @[@"《热血霸业》之极限挑战",@"《热血霸业》之人在塔在",
                        @"《热血霸业》六道轮回介绍",@"《热血霸业》模拟攻城",
                        @"《热血霸业》锁妖塔介绍", @"《热血霸业》泉水采集",
                        @"《热血霸业》入门必看", @"《热血霸业》祖玛教主",
                        @"《热血霸业》沙城boss",@"《热血霸业》世界领主",
                        @"《热血霸业》卧龙山庄",@"《热血霸业》野外PK",
                       ];
    NSArray*dashenurl = @[@"http://www.9game.cn/rxbyzb/2991363.html",
                          @"http://www.9game.cn/rxbyzb/2991357.html",
                          @"http://www.9game.cn/rxbyzb/2895891.html",
                          @"http://www.9game.cn/rxbyzb/2895876.html",
                          @"http://www.9game.cn/rxbyzb/2895612.html",
                          @"http://www.9game.cn/rxbyzb/2991363.html",
                          @"http://www.9game.cn/rxbyzb/2991357.html",
                          @"http://www.9game.cn/rxbyzb/2895891.html",
                          @"http://www.9game.cn/rxbyzb/2895876.html",
                          @"http://www.9game.cn/rxbyzb/2895612.html",
                          @"http://www.9game.cn/rxbyzb/2991363.html",
                          @"http://www.9game.cn/rxbyzb/2991357.html",
                          @"http://www.9game.cn/rxbyzb/2895891.html",
                          @"http://www.9game.cn/rxbyzb/2895876.html",
                          @"http://www.9game.cn/rxbyzb/2895612.html",
                          ];
    NSArray*new = @[
                   @"《热血霸业》玛法大陆之三英雄传说", @"《热血霸业》沙城boss",
                   @"《热血霸业》七日登录介绍",@"《热血霸业》-boss首杀",
                   @"《《热血霸业》新手开局攻略",@"《热血霸业》之六道轮回",
                   @"《热血霸业》之人在塔在", @"《热血霸业》之神兽系统",
                   @"《热血霸业》之天降珍宝",@"《热血霸业》装备强化",
                   @"《热血霸业》装备神铸",@"《热血霸业》神装挑战",
                   @"《热血霸业》无双大战", @"《热血霸业》竞技场",
                   ];
    NSArray *newURL = @[@"http://www.9game.cn/rxbyzb/2917241.html",
                        @"http://www.9game.cn/rxbyzb/2895820.html",
                        @"http://www.9game.cn/rxbyzb/2895844.html",
                        @"http://www.9game.cn/rxbyzb/2895831.html",
                        @"http://www.9game.cn/rxbyzb/2895449.html",
                        @"http://www.9game.cn/rxbyzb/2917241.html",
                        @"http://www.9game.cn/rxbyzb/2895820.html",
                        @"http://www.9game.cn/rxbyzb/2895844.html",
                        @"http://www.9game.cn/rxbyzb/2895831.html",
                        @"http://www.9game.cn/rxbyzb/2895449.html",
                        @"http://www.9game.cn/rxbyzb/2917241.html",
                        @"http://www.9game.cn/rxbyzb/2895820.html",
                        @"http://www.9game.cn/rxbyzb/2895844.html",
                        @"http://www.9game.cn/rxbyzb/2895831.html",
                        @"http://www.9game.cn/rxbyzb/2895449.html",
                       ];
    NSArray*hot = @[
                        @"《热血霸业》比武岛争锋",@"《热血霸业》大宴群雄",
                        @"《热血霸业》封禁之地",@"《热血霸业》技能攻略",
                        @"《热血霸业》神盾攻略",@"《热血霸业》尸王殿",
                        @"《热血霸业》之宝石攻略",@"《热血霸业》之地宫玩法",
                        @"《热血霸业》之挖矿寻宝",@"《热血霸业》之装备升品",
                        @"《热血霸业》之装备洗练",@"《热血霸业》神魂攻略",
                        @"《热血霸业》天宫挑战",@"《热血霸业》跨服3V3",];
    NSArray*guanfang =@[
                        @"《热血霸业》特色玩法之天降珍宝", @"《热血霸业》开局攻略",
                        @"《热血霸业》开服庆典-全服boss首杀", @"《热血霸业》之六道轮回",
                        @"《热血霸业》福利-在线礼包", @"《热血霸业》福利-每日签到",
                        @"《热血霸业》福利-礼包兑换",@"《热血霸业》福利-离线经验",
                        @"《热血霸业》福利-等级礼包",@"《热血霸业》沙城争霸介绍",
                        @"《热血霸业》投保功能攻略",@"《热血霸业》攻略 祝福油作用和分类介绍",
                        ];
    
    NSArray*guanfangurl = @[@"http://www.9game.cn/rxbyzb/2984191.html",
                            @"http://www.9game.cn/rxbyzb/2984190.html",
                            @"http://www.9game.cn/rxbyzb/2984189.html",
                            @"http://www.9game.cn/rxbyzb/2935222.html",
                            @"http://www.9game.cn/rxbyzb/2896387.html",
                            @"http://www.9game.cn/rxbyzb/2896368.html",
                            @"http://www.9game.cn/rxbyzb/2896364.html",
                            @"http://www.9game.cn/rxbyzb/2896358.html",
                            @"http://www.9game.cn/rxbyzb/2896286.html",
                            @"http://www.9game.cn/rxbyzb/2895803.html",
                            @"http://www.9game.cn/rxbyzb/2895462.html",
                            @"http://www.9game.cn/rxbyzb/2894835.html",
                            @"http://www.9game.cn/rxbyzb/2984191.html",
                            @"http://www.9game.cn/rxbyzb/2984190.html",
                            @"http://www.9game.cn/rxbyzb/2984189.html",
                            @"http://www.9game.cn/rxbyzb/2935222.html",
                            @"http://www.9game.cn/rxbyzb/2896387.html",
                            @"http://www.9game.cn/rxbyzb/2896368.html",
                            @"http://www.9game.cn/rxbyzb/2896364.html",
                            @"http://www.9game.cn/rxbyzb/2896358.html",
                     
                            ];
    NSMutableArray*arry = [NSMutableArray arrayWithCapacity:20];
    for (int i = 0; i<dashen.count; i++) {
        gvlistItme*item = nil;
        if (index == 0) {
            item = [[gvlistItme alloc]initWith:new[i] andTime:timearry[i] andURL:newURL[i]];
        }else if (index == 1){
            item = [[gvlistItme alloc]initWith:hot[i] andTime:timearry[i] andURL:guanfangurl[i]];
        }else if (index == 2){
            item = [[gvlistItme alloc]initWith:guanfang[i] andTime:timearry[i] andURL:guanfangurl[i]];

        }else if (index == 3){
            item = [[gvlistItme alloc]initWith:dashen[i] andTime:timearry[i] andURL:dashenurl[i]];
        }
     
        [arry addObject:item];
    }
    return arry;
}

-(NSArray*)bosscontent{
    NSMutableArray*arry = [NSMutableArray arrayWithCapacity:3];
    NSString*ring1 = @"<pclass="">祖玛教主</p><p>玛法大陆的三大教主之一，雄才大略的祖玛教主。他热爱自己的族人，以振兴祖玛教为己任。在人类和半兽人数百年的战争中，祖玛教一直处于中立状态，两不相帮。但老谋深算的赤月恶魔不会放过如此强有力的帮手，在他的引诱下，祖玛教主喝下‘能增强力量’的恶魔之血，如今在他空空如也的头脑中，除了杀戮已经不剩下任何东西了……</p><p class="">祖玛教主：<span class="">四星</span></p><p class="">出没地点：<span class="">祖玛寺庙</span></p></p><p class="">物品掉落：</p><p class="">裁决、骨玉、龙纹剑、战神盔甲级别衣服、祖玛级别饰品、井中月、血饮、无极棍、顶级魔法书、魔血套组件、虹魔套组件、黑铁头盔、祝福油、祖玛头像等。</p>";
    NSString*ring2 = @"<p class="">双头血魔</p><p>不知是生吞了多少活人，这只双头血魔浑身散发出令人胆寒的血腥之气，但它似乎保留着一些曾为人类时的记忆，在无人可吃的时候呆呆发怔，抚摸着自己两只又光又圆的怪头喃喃自语道：西瓜……</p><p class="">祖玛教主：<span class="">三星</span></p><p class="">出没地点：<span class="">金刚殿</span></p></p><p class="">物品掉落：</p><p class="">裁决、骨玉、龙纹剑、战神盔甲级别衣服、祖玛级别饰品、井中月、血饮、无极棍、顶级魔法书、魔血套组件、虹魔套组件、黑铁头盔、祝福油、祖玛头像等</p>";
    NSString*ring3 = @"<p class="">双头金刚</p><p>天生自带盔甲，一身皮肉坚韧无比，虽然长了两只脑袋却毫无智商可言，最喜欢看到东西在自己面前碎裂，如果不是自行碎裂，便是经由它铁钳一般的双手。</p><p class="">祖玛教主：<span class="">三星</span></p><p class="">出没地点：<span class="">金刚殿</span></p></p><p class="">物品掉落：</p><p class="">赤月级首饰、井中月、赤影、血饮、无极棍、战神盔甲级别衣服、沃玛级别饰品、炼狱、追魂、魔杖、银蛇、次顶级魔法书、顶级魔法书、祈祷套组件、魔血套组件、虹魔套组件、黑铁头盔、祝福油等。</p>";
    NSString*ring4 = @"<p class="">尸王</p><p>来历成迷的尸王，当年为追赶逃亡的幽冥海的比奇老城主之子。被苍月神女所救后被她惊世骇俗的美貌所吸引，急切的表明了自己的身份及非她不娶的信念。然而苍月神女拒绝了他。他偏执的认为是自己不够强大于是决心独自挑战赤月恶魔...直到二十年后，苍月岛上，一个身形彪悍，相貌丑陋，不能人言的尸王出现了...</p><p class="">祖玛教主：<span class="">五星</spanp class="">出没地点：<span class="">苍月岛</span></pp class="">物品掉落：</p><p class="">开天、破天、玄天、镇天之一、苍月级爆炎剑诀级技能书、凤凰级别衣服之一、雷霆级别腰带宝图之一、裁决级武器、赤月级首饰之一、逐日剑法级技能书卷轴之一、祖玛级装备、魔法盾级技能书、祝福油；尸王之血（可用于完成史诗任务及兑换装备宝图）</p>";
    NSString*ring5 = @"<p class="">魔龙教主</p><p>魔龙城昔日德高望重的大长老，在魔龙岭三条神龙堕落为魔龙之后，仍不愿放弃信仰，饮下魔龙之魔龙永世的仆从。</p><p class="">祖玛教主：<span class="">三星</span></p><p class="">出没地点：<lass="">赤月魔穴</span></p></p><p class="">物品掉落：p class="">47级技能书卷轴（战士-逐日剑法卷轴、法师-流星火雨卷轴、道士-噬血术卷轴、刺客-火镰狂舞级衣服（如：天魔神甲）、赤月级头盔（如：圣战头盔）、裁决、龙爪手、骨玉、龙纹剑、战神盔甲级别衣服、圣战级别饰品、祖玛级别饰品、特殊效果饰品、井中月、赤影、血饮、无极棍、顶级魔法书、魔血套组件、虹魔套组件、黑铁头盔等。</p>";
    NSString*ring6 = @"<p class="">触龙神</p><p>触龙神并非龙族，而是蜈蚣洞中遭到黑暗侵蚀，而膨胀变异的邪恶蜈蚣。当超过二十丈高的庞然大物突兀地破土而出，百足挥舞，狰狞之状让天地为之变色。触龙神入蜈 蚣洞寻宝的英雄们增添了更大的困难，法术对它造成的伤害微乎其微，幸而战士的刀斧尚 能大显神威。</p><p class="">祖玛教主：<span class="">三星</span></p><p class="">出没地点：<span class="">死亡峡谷</sp></p><p class="">物品掉落：</p><p class="">赤月级首饰影、血饮、无极棍、战神盔甲级别衣服、沃玛级别饰品、炼狱、追魂、魔杖、银蛇、次顶级魔法书、顶级魔法书、祈祷套组件、魔血套组件、虹铁头盔、祝福油等</p>";
    [arry addObject:ring1];
    [arry addObject:ring2];
    [arry addObject:ring3];
    [arry addObject:ring4];
    [arry addObject:ring5];
    [arry addObject:ring6];
    return arry;
}

-(NSArray*)lolcontent{
    NSMutableArray*arry = [NSMutableArray arrayWithCapacity:3];
    NSString*ring1 = @"<p><span style=\"color:#ff8800;\">道士职业</span>，在野外刷怪的时候我设置自动<a style=\"color: rgb(26, 113, 222);\">挂机</a>的技能为只使用群毒术，群毒术是一个群攻技能，切命中怪物后会持续掉血，实乃野外刷怪，杀人越货之利器啊。当然如果你装备不足以支撑你单人在野外刷怪，只适合建议你在<a class='keyword-tag' data-statis='text:txt_newsdetail-798435_keyword_po-4_other-22037'>挂机</a>技能中将自己的治愈术加进去，保证自己的生命值能得到回复，当然这样不可避免的回增加MP的消耗，建议购买蓝瓶或者魔晶石回复自己的MP。</p><p style=\"text-align: center; text-indent: 0px;\"><img src= style=\"border: none;\"></p><p align=\"center\">​</p>";
    NSString*ring2 = @"<p><span style=\"color:#ff8800;\">战士职业</span>，由于这时候战士还没有群攻技能，刷怪速度很慢的，但是，我觉得战士职业在后期还是很强的，也是很好玩的一个职业，不应该被放弃掉，所以建议玩家可以和其他职业<a  style=\"color: rgb(26, 113, 222);\">组队</a>刷怪，这样也就提升了自己的升级速度。</p><p style=\"text-align: center; text-indent: 0px;\"><img src=\"\" style=\"border: none;\"></p><p align=\"center\">​</p>";
    NSString*ring3 = @"<p><span style=\"color:#ff8800;\">法师职业</span>，法师职业的群攻技能是火墙术，但是在40级的时候你貌似还没获得该技能，所以如果你愿意，可以去商场买一本技能书学习，然后你就可以在地上放满火墙，怪物被烧得持续掉血，刷怪速度那叫一个快啊。当然，如果你不买技能书，想在后面自己刷，那这时候建议你在挂机技能中<a style=\"color: rgb(26, 113, 222);\">放置</a>两个技能，一个是火球术，一个是雷电术，虽然是单体攻击，但是这两个技能都是远程的，刷怪速度还是很快的。</p><p style=\"text-align: center; text-indent: 0px;\"><img src=\"\" style=\"border: none;\"></p><p align=\"center\">​</p> ";
    [arry addObject:ring2];
    [arry addObject:ring3];
    [arry addObject:ring1];
    return arry;
}

-(NSArray*)mapscontent{
    NSMutableArray*arry = [NSMutableArray arrayWithCapacity:3];
    NSString*ring1 = @"<p class="">热血战场</p><p>玛法大陆上，再没有哪个地方能比热血战场更恐怖了，无论是白天还是夜晚，长长上空永远只有一轮血红的月亮，像一只渴望鲜血的恶魔之眼逼视着战场中的一切生物，这里遍布魔蛛、变异巨人，并疯狂地繁衍着，带着瘟疫瘴气迅速侵蚀着周围的大地。这里有着无数的玩家在此处争夺各种boss。</p><p class="">Boss：战场恶魔</p>";
    NSString*ring2 = @"<p class="">火龙神殿</p><p>翻越盟重沙漠东南部的山脉，便可进入名为“火龙神殿”的殿堂。传说在英雄纪元时，此地居住三条神龙。然而，随着玛法大陆陷入纷争，魔气摧毁了原本神迹一般的山岭，高大的神庙坍塌为废墟，神龙也堕落为如今的魔龙。</p><p class="">Boss：火龙王 火龙守卫</p>";
    NSString*ring3 = @"<p class="">迷失大陆</p><p>很久以前，先民尚未领悟五龙卫之力，无法抵御半兽人，只能节节败退，一直来到大陆的最南端。他们以此为根据地，展开最后的反攻，最终将半兽人全部驱逐，为了纪念此地，便取名为‘迷失大陆’。</p><p class="">Boss：困惑魔王</p>";
    [arry addObject:ring1];
    [arry addObject:ring2];
    [arry addObject:ring3];
    return arry;
}


-(NSArray*)rarecontent{
    NSMutableArray*arry = [NSMutableArray arrayWithCapacity:3];
    NSString*ring1 = @"<li><p class="">创世刀</p><p>昔日龙卫对抗神殿火龙所用的武器，采用神龙帝国秘术，以极地寒铁铸炼而成，不但拥有强大的攻击力，更隐藏着强大的上古力量，唯有强者才配持有它！</p><p class="">技能：消耗一定魔法值，释放剑阵对范围内的所有敌人造成一定伤害（伤害量由释放者攻击高低所决定），技能使用间隔5分钟。</p></li>";
    NSString*ring2 = @"<li><p class="">创世剑</p><p>《神兵谱》如此记载着：“要铸就创世剑，必先饱尝鲜血”。因铸造之法极为邪恶，龙卫圣战明令禁止打造此剑。而自创世刀下落不明、火龙再现后，创世剑终重现于世。</p><p class="">技能：攻击时有一定几率吸取敌方鲜血。</p></li>";
    NSString*ring3 = @"<li><p class="">创世杖</p><p>一出世就击杀了虹魔教主的神兵利器，但它随后便令持有者陷入了疯狂，杀人无数。五龙卫出手方让玛法大陆免于灾难。神兵伏主，意志不坚者无法拥有它。</p><p class="">技能：提高所有魔法伤害及治疗效果。</p></li>";
    [arry addObject:ring1];
    [arry addObject:ring2];
    [arry addObject:ring3];
    return arry;
}


-(NSArray*)ringcontent{
    NSMutableArray*arry = [NSMutableArray arrayWithCapacity:3];
    NSString*ring1 = @"<li><p class="">神盾戒指</p><p>世人常将它和护身戒指混淆，但它的作用似乎更神奇一些。佩戴者可以使用神盾护体技能，抵挡住致命伤害。</p><p class="">技能：可释放神盾护体，10秒钟内所收到的伤害降低30%，冷却1分钟。</p></li>";
    NSString*ring2 = @"<li><p class="">幻舞戒指</p><p>就像被密封起来的狂风，它将提高佩戴者的攻击速度。佩戴者可以使用幻舞之影技能，大幅提高攻击及施法速度。</p><p class="">技能：可释放幻舞之影，10秒钟内提高攻击及施法速度30%，冷却1分钟。</p></li>";
    NSString*ring3 = @"<li><p class="">护身戒指</p><p>它确实能抵挡伤害，但相应的也要付出一定的代价。佩戴者可消耗魔法来抵挡所承受的伤害，抵挡值视戒指等级而定。</p><p class="">技能：可释魔法护身，消耗1点魔法来抵挡1点伤害，无冷却，魔法为空后不生效。</p></li>";
    [arry addObject:ring1];
    [arry addObject:ring2];
    [arry addObject:ring3];
    return arry;
}

-(void)showcommVc:(NSInteger)index titleA:(NSArray*)titleA imageName:(NSString*)str showAnimal:(BOOL)isshow content:(NSArray*)conarry{
    GVCommonShowVC*show = [[GVCommonShowVC alloc]init];
    show.titles = titleA[index];
    
    for (NSString*title in titleA) {
        if ([title containsString:@"战士"]||[title containsString:@"法师"]||[title containsString:@"道士"]) {
            show.ishowImageView = YES;
        }else{
            show.ishowImageView = NO;
        }
    }
    NSMutableArray*arry = [NSMutableArray array];
    if (isshow) {
        for (int i = 0; i < 6; i++) {
            NSString*imagename = [NSString stringWithFormat:@"%@_%d.png",str,i+1];
            UIImage*image = [UIImage imageNamed:imagename];
            [arry addObject:image];
        }
    }else{
        [arry addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",str]]];
    }
   
    show.imageArr = arry;
    if (conarry.count) {
        show.html = conarry[index];
    }
    [self.navigationController pushViewController:show animated:YES];

}

-(NSArray*)dataArry :(NSArray*)titlenames andimageA: (NSArray*)imageA{
    NSMutableArray *arry =[[NSMutableArray alloc]initWithCapacity:4];
    commonItem*item1 = [[commonItem alloc]initWith:titlenames[0] andImage:imageA[0]];
    commonItem*item2 = [[commonItem alloc]initWith:titlenames[1] andImage:imageA[1]];
    commonItem*item3 = [[commonItem alloc]initWith:titlenames[2] andImage:imageA[2]];
    
    [arry addObject:item1];
    [arry addObject:item2];
    [arry addObject:item3];
    
    return arry;
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
