//
//  HYViewController.m
//  HYPlateNumberKeyboard
//
//  Created by xtyHY on 03/19/2018.
//  Copyright (c) 2018 xtyHY. All rights reserved.
//

#import "HYViewController.h"
#import "HYPlateNumberKeyboard.h"
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface HYViewController ()<HYPlateNumberKeyboardDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) HYPlateNumberKeyboard *keyboard;
@property (nonatomic, strong) UIButton *submitBtn;

@end

@implementation HYViewController

#pragma mark - cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init
- (void)initData {
    
}

- (void)initUI {
    self.title = @"车牌号键盘";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //bind keyboard
    self.textField.inputView = self.keyboard;
    self.textField.inputAccessoryView = self.keyboard.toolBar;
    [self.textField reloadInputViews];
    
    self.keyboard.textfield = self.textField;
    
    //submitBtn
    [self.view addSubview:self.submitBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToHiddenKeyboard:)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - request
- (void)refreshData {
    
}

- (void)parseData:(NSDictionary *)dataDict {
    
}

#pragma mark - delegate
#pragma mark - HYPlateNumberKeyboardDelegate
- (void)HYPlateNumberKeyboard:(HYPlateNumberKeyboard *)keyboard
                   didChanged:(UITextField *)textfield {
    NSLog(@"Keyboard----->Changed: %@", textfield.text);
}

- (void)HYPlateNumberKeyboard:(HYPlateNumberKeyboard *)keyboard
                   clickClose:(UITextField *)textfield {
    NSLog(@"Keyboard----->Close: %@", textfield.text);
}

- (void)HYPlateNumberKeyboard:(HYPlateNumberKeyboard *)keyboard
                   clickDelete:(UITextField *)textfield {
    NSLog(@"Keyboard----->Delete: %@", textfield.text);
}

#pragma mark - public

#pragma mark - private
- (void)_showAlertWithText:(NSString *)text {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:text preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - action
- (void)clickSubmitBtn:(UIButton *)btn {
    [self.view endEditing:YES];
    
    if (self.textField.text.length) {
        [self _showAlertWithText:self.textField.text];
    } else {
        [self _showAlertWithText:@"请输入车牌号"];
    }
}

- (void)clickToHiddenKeyboard:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}

#pragma mark - properties
- (HYPlateNumberKeyboard *)keyboard {
    if (!_keyboard) {
        _keyboard = [HYPlateNumberKeyboard keyboard];
    }
    return _keyboard;
}

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc] initWithFrame:(CGRect){15, 280, ScreenWidth-30, 45}];
        _submitBtn.backgroundColor = [UIColor orangeColor];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _submitBtn.titleLabel.textColor = [UIColor whiteColor];
        [_submitBtn addTarget:self action:@selector(clickSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

@end
