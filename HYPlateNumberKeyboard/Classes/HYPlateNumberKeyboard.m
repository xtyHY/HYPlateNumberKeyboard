//
//  HYPlateNumberKeyboard.m
//  PlateNumberKeyboard
//
//  Created by 寰宇 on 2018/3/19.
//

#import "HYPlateNumberKeyboard.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define RGB(r, g, b) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1]

//一行显示7个
#define alineCount 7
//单个格子宽和高
#define singleW (ScreenWidth-(alineCount+1)*1)/alineCount
#define singleH 42

@interface HYPlateNumberKeyboard ()<UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>

@property (nonatomic, assign) BOOL bAlphabet;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIToolbar *toolBar;

@end

static NSArray<NSString *> *provinces;
static NSArray<NSString *> *alphabets;

@implementation HYPlateNumberKeyboard

#pragma mark - init
+ (instancetype)keyboard {
    static HYPlateNumberKeyboard *keyboard;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        keyboard = [[HYPlateNumberKeyboard alloc] init];
        provinces = @[@"京", @"津", @"沪", @"渝", @"冀", @"豫", @"鲁",
                      @"晋", @"陕", @"皖", @"苏", @"浙", @"鄂", @"湘",
                      @"赣", @"闽", @"粤", @"桂", @"琼", @"川", @"贵",
                      @"云", @"辽", @"吉", @"黑", @"蒙", @"甘", @"宁",
                      @"青", @"新", @"藏"];
        alphabets = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G",
                      @"H", @"J", @"K", @"L", @"M", @"N", @"P",
                      @"Q", @"R", @"S", @"T", @"U", @"V", @"W",
                      @"X", @"Y", @"Z", @"1", @"2", @"3", @"4",
                      @"5", @"6", @"7", @"8", @"9", @"0", @"挂"];
    });
    return keyboard;
}

- (instancetype)init {
    self = [super initWithFrame:(CGRect){0, 0, ScreenWidth, 20 + 5 * singleH + (5+1)*1}];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGRect collectionRect = self.collectionView.frame;
        self.collectionView.frame = (CGRect){collectionRect.origin.x, collectionRect.origin.y, collectionRect.size.width, 5 * singleH + (5+1)*1};
        [self.collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"keyboardCell"];
        [self addSubview:self.collectionView];
        
        self.toolBar.barTintColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self reloadKeyboard];
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSInteger lastLineNum = self.dataArr.count%7;
    return self.dataArr.count + (lastLineNum ? 7-lastLineNum : 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"keyboardCell" forIndexPath:indexPath];
    if (!cell.contentView.subviews.count) {
        UIButton *btn = [[UIButton alloc] initWithFrame:(CGRect){0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height}];
        [btn setTitleColor:RGB(55, 55, 55) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tintColor = [UIColor colorWithWhite:1 alpha:0.9];
        btn.userInteractionEnabled = NO;
        [cell.contentView addSubview:btn];
    }
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    UIButton *btn = nil;
    for (UIButton *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            btn = view;
            break;
        }
    }
    
    if (indexPath.row >= self.dataArr.count) {
        [btn setTitle:@"" forState:UIControlStateNormal];
        return cell;
    }
    
    NSString *text = self.dataArr[indexPath.row];
    [btn setTitle:text forState:UIControlStateNormal];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.dataArr.count) {
        return;
    }
    
//    NSLog(@"---%@\n", self.dataArr[indexPath.row]);

    //普通牌照7位，新能源绿牌8位
    if (self.textfield.text.length>=8) {
        [self.textfield.text substringToIndex:8];
        [self.textfield endEditing:YES];
        return;
    }
    
    NSString *string = self.dataArr[indexPath.row];
    self.textfield.text = [self.textfield.text stringByAppendingString:string];
    if (self.textfield.text.length==1) {//>1切换成字母键盘
        [self reloadKeyboard];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(HYPlateNumberKeyboard:didChanged:)]) {
        [self.delegate HYPlateNumberKeyboard:self
                                  didChanged:self.textfield];
    }
}
#pragma mark - private
- (void)reloadKeyboard {
    self.bAlphabet = self.textfield.text.length;
    [self.collectionView reloadData];
}

#pragma mark - public

#pragma mark - action
- (void)clickClose:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(HYPlateNumberKeyboard:clickClose:)]) {
        [self.delegate HYPlateNumberKeyboard:self
                                  clickClose:self.textfield];
    }
    
    [self.textfield resignFirstResponder];
}

- (void)clickDelete:(id)sender {
    
    if (self.textfield.text.length) {
        self.textfield.text = [self.textfield.text substringToIndex:self.textfield.text.length-1];
        if (!self.textfield.text.length) {//==0时切换成省份键盘
            [self reloadKeyboard];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(HYPlateNumberKeyboard:didChanged:)]) {
            [self.delegate HYPlateNumberKeyboard:self
                                      didChanged:self.textfield];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(HYPlateNumberKeyboard:clickDelete:)]) {
        [self.delegate HYPlateNumberKeyboard:self
                                 clickDelete:self.textfield];
    }
}

#pragma mark - property
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        layout.sectionInset = (UIEdgeInsets){1, 1, 1, 1};
        
        layout.itemSize = (CGSize){singleW, singleH};
        _collectionView = [[UICollectionView alloc] initWithFrame:(CGRect){0, 0, ScreenWidth, 0} collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = RGB(231, 231, 231);
    }
    return _collectionView;
}

- (UIToolbar *)toolBar {
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:(CGRect){0, 0, ScreenWidth, 50}];
        _toolBar.backgroundColor = [UIColor whiteColor];
        _toolBar.tintColor = RGB(55, 55, 55);
        
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(clickClose:)];
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(clickDelete:)];
        UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithTitle:@"请输入车牌" style:UIBarButtonItemStylePlain target:nil action:nil];
        
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        _toolBar.items = @[item1, space, item3, space, item2];
    }
    return _toolBar;
}

- (NSArray<NSString *> *)dataArr {
    return self.bAlphabet ? alphabets : provinces;
}

- (BOOL)canBecomeFirstResponder{ //想作为Keyboard必须实现并return YES
    return YES;
}

@end

