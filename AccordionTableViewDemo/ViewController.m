//
//  ViewController.m
//  AccordionTableViewDemo
//
//  Created by Wang Xuyang on 5/16/13.
//  Copyright (c) 2013 Arthur Wang. All rights reserved.
//

#import "ViewController.h"
#import "DemoCell.h"

#define ContentPlaceHolder @"木兰！！！"

@interface ViewController () {
    UITableView *_tableView;
    CGFloat _heightOfGrid;
    NSIndexPath *_lastIndexPath;
    DemoCell *_contentCell;
    NSMutableArray *_arr;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _arr = [@[@"唧唧复唧唧",@"木兰当户织",@"不闻机杼声",@"惟闻女叹息",@"问女何所思",@"问女何所忆",
             @"女亦无所思",@"女亦无所忆",@"昨夜见军帖",@"可汗大点兵",@"军书十二卷",@"卷卷有爷名",
             @"阿爷无大儿",@"木兰无长兄",@"愿为市鞍马",@"从此替爷征",@"东市买骏马",@"西市买鞍貉",
             @"南市买辔头",@"北市买长鞭",@"旦辞爷娘去",@"暮至黄河边",@"不闻爷娘唤女声",@"但闻黄河流水鸣溅溅",
             @"但辞黄河去",@"暮宿黑山头",@"不闻爷娘唤女声",@"但闻燕山胡骑鸣啾啾",@"万里赴戎机",
             @"关山度若飞",@"朔气传金析",@"寒光照铁衣",@"将军百战死",@"壮士十年归",@"归来见天子",@"天子坐明堂",
             @"策勋十二转",@"赏赐百千强",@"可汗问所欲",@"木兰不用尚书郎",@"愿驰千里足",@"送儿还故乡",
             @"爷娘闻女来",@"出郭相扶将",@"阿姊闻妹来",@"当户理红妆",@"小弟闻姊来",@"磨刀霍霍向猪羊",
             @"开我东阁门",@"坐我西阁床",@"脱我战时袍",@"着我旧时裳",@"当窗理云鬓",@"对镜贴花黄",
             @"出门看伙伴",@"伙伴皆惊惶",@"同行十二年",@"不知木兰是女郎",
             @"雄兔脚扑朔",@"雌兔眼迷离",@"双兔傍地走",@"安能辨我是雄雌"] mutableCopy];
    
    _lastIndexPath = nil;
    
    _contentCell = [[DemoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:nil];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-20)
                                              style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 是要添加的新行
    if (_lastIndexPath && indexPath.section == _lastIndexPath.section && indexPath.row == _lastIndexPath.row+1) {
        return _contentCell;
    }
    
    static NSString *CellIdentifier = @"acordionTitleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    cell.textLabel.text = [_arr objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 是要添加的新行
    if (_lastIndexPath && indexPath.section == _lastIndexPath.section && indexPath.row == _lastIndexPath.row+1) {
        _heightOfGrid = [_contentCell updateWithInfo:[_arr objectAtIndex:indexPath.row]];
        return _heightOfGrid;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)newIndexPath
{
    // 打开新的
    if (!_lastIndexPath) {
        [_arr insertObject:ContentPlaceHolder atIndex:newIndexPath.row+1];
        _lastIndexPath = newIndexPath;
        NSIndexPath *contentIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row+1 inSection:newIndexPath.section];
        [_tableView insertRowsAtIndexPaths:@[contentIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        //        [_tableView reloadRowsAtIndexPaths:@[self.appendIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    // 关闭旧的
    else if (_lastIndexPath.row == newIndexPath.row && _lastIndexPath.section == newIndexPath.section) {
        _lastIndexPath = nil;
        [_arr removeObjectAtIndex:newIndexPath.row + 1];
        
        NSIndexPath *contentIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row+1 inSection:newIndexPath.section];
        [_tableView deleteRowsAtIndexPaths:@[contentIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        //        [_tableView reloadRowsAtIndexPaths:@[contentIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    // 打开新的且关闭旧的
    else if (_lastIndexPath.row != newIndexPath.row || _lastIndexPath.section != newIndexPath.section) {
        int idx = [_arr indexOfObject:ContentPlaceHolder];
        [_arr removeObjectAtIndex:idx];
        
        [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:newIndexPath.section]]
                          withRowAnimation:UITableViewRowAnimationFade];
        
        if (newIndexPath.row > idx) {
            _lastIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row-1 inSection:newIndexPath.section];
        } else {
            _lastIndexPath = newIndexPath;
        }
        NSIndexPath *contentIndexPath = [NSIndexPath indexPathForRow:_lastIndexPath.row+1 inSection:newIndexPath.section];
        [_arr insertObject:ContentPlaceHolder atIndex:contentIndexPath.row];
        [_tableView insertRowsAtIndexPaths:@[contentIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
