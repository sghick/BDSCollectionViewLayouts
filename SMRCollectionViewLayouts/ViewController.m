//
//  ViewController.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/30.
//

#import "ViewController.h"

@interface DemoItem : NSObject

@property (copy  , nonatomic) NSString *name;
@property (copy  , nonatomic) NSString *cls;

+ (instancetype)itemWithName:(NSString *)name cls:(NSString *)cls;

@end

@implementation DemoItem

+ (instancetype)itemWithName:(NSString *)name cls:(NSString *)cls {
    DemoItem *item = [[DemoItem alloc] init];
    item.name = name;
    item.cls = cls;
    return item;
}

@end

@interface ViewController ()<
UITableViewDataSource,
UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray<DemoItem *> *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Layout";
    self.datas = @[
        [DemoItem itemWithName:@"默认" cls:@"SMRCVLayoutController"],
        [DemoItem itemWithName:@"环形" cls:@"SMRCVCircleLayoutController"],
        [DemoItem itemWithName:@"矩形" cls:@"SMRCVSquareLayoutController"],
        [DemoItem itemWithName:@"瀑布流" cls:@"SMRCVWaterfallLayoutController"],
        [DemoItem itemWithName:@"艺术墙" cls:@"SMRCVArtWallLayoutController"],
        [DemoItem itemWithName:@"滑动1" cls:@"SMRCVSliderStyle1LayoutController"],
        [DemoItem itemWithName:@"滑动2" cls:@"SMRCVSliderStyle2LayoutController"],
        [DemoItem itemWithName:@"滑动3" cls:@"SMRCVSliderStyle3LayoutController"],
        [DemoItem itemWithName:@"线形" cls:@"SMRCVLineLayoutController"],
        [DemoItem itemWithName:@"平均线形" cls:@"SMRCVAverageLayoutController"],
        [DemoItem itemWithName:@"弧线滑动" cls:@"SMRCVSliderArcLayoutController"],
    ];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DemoItem *item = self.datas[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@  %@", item.name, item.cls];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DemoItem *item = self.datas[indexPath.row];
    Class cls = NSClassFromString(item.cls);
    UIViewController *vc = [[cls alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Getters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = self.view.bounds;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, self.view.window.safeAreaInsets.bottom + 20, 0);
        
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

@end
