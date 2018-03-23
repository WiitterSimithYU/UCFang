//
//  ViewController.m
//  UCFang
//
//  Created by 先锋张 on 2018/3/22.
//  Copyright © 2018年 先锋张. All rights reserved.
//

#import "ViewController.h"
#define ScreenHeight        self.view.frame.size.height
#define ScreenWidth         self.view.frame.size.width
#define CScreenWidth        [[UIScreen mainScreen] bounds].size.width
#define CScreenHeight       [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIView *headView;
@property(nonatomic, strong)UIView *headContenView;
@property(nonatomic, strong)UITextField *headSearchTF;

@property(nonatomic, strong)UIView *headTitleView;
@property(nonatomic, strong)UITextField *titleSearchTF;
@property(nonatomic, strong)UILabel *titleSearchLabel;
@property(nonatomic, strong)UIView *titleButtonView;

@property(nonatomic, strong)UCScrollView *contentScrolllView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.contentScrolllView];
    [self.view addSubview:self.headView];
}

#pragma mark--- CustomView
- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CScreenWidth, 220)];
        _headView.backgroundColor = [[UIColor blueColor]colorWithAlphaComponent:.3];
        [_headView addSubview:self.headContenView];
        [_headView addSubview:self.headTitleView];
    }
    return _headView;
}

- (UIView *)headTitleView{
    if (!_headTitleView) {
        _headTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, CScreenWidth, _headView.frame.size.height-20)];
        _headTitleView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _headTitleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        
        _titleSearchTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 74, CScreenWidth-20, 44)];
        _titleSearchTF.placeholder  = @"搜索感性趣的东西";
        _titleSearchTF.borderStyle = UITextBorderStyleRoundedRect;
        _titleSearchTF.alpha = 0;
        _titleSearchTF.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
        [_headTitleView addSubview:_titleSearchTF];
        _titleSearchLabel = [[UILabel alloc] initWithFrame:CGRectMake(-90, 78, 90, 35)];
        _titleSearchLabel.text = @"UC头条";
        _titleSearchLabel.textColor = [UIColor blackColor];
        _titleSearchLabel.font = [UIFont systemFontOfSize:24];
        _titleSearchLabel.textAlignment  =NSTextAlignmentCenter;
        _titleSearchLabel.alpha = 0;
        [_headTitleView addSubview:_titleSearchLabel];
        
        _titleButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, _headView.frame.size.height-64, CScreenWidth, 44)];
        _titleButtonView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        NSArray *titleArr =@[@"关注",@"推荐",@"视频",@"两会",@"无锡",@"新时代"];
        for (int i=0; i<titleArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(CScreenWidth/titleArr.count*i, 4, CScreenWidth/titleArr.count, 35);
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            [_titleButtonView addSubview:btn];
        }
        _titleButtonView.alpha = 0;
        [_headTitleView addSubview:_titleButtonView];
        
    }
    return _headTitleView;
}


- (UIView *)headContenView{
    if (!_headContenView) {
        _headContenView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, CScreenWidth, _headView.frame.size.height-20)];
        _headContenView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        UILabel *weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 24, 200, 40)];
        weatherLabel.text = @"滨湖区 小雨-中雨\n空气 差";
        weatherLabel.numberOfLines = 0;
        weatherLabel.textColor = [UIColor whiteColor];
        weatherLabel.font = [UIFont systemFontOfSize:15];
        weatherLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [_headContenView addSubview:weatherLabel];
        _headSearchTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 74, CScreenWidth-20, 44)];
        _headSearchTF.placeholder  = @"输入搜索内容";
        _headSearchTF.borderStyle = UITextBorderStyleRoundedRect;
        _headSearchTF.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.3];
        [_headContenView addSubview:_headSearchTF];
        
        NSArray *nameArr = @[@"网址",@"小说",@"视频",@"奇趣",@"漫画"];
        for (int i=0; i<nameArr.count; i++) {
            UCButton *btn = [UCButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:nameArr[i] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"pic0"] forState:UIControlStateNormal];
            btn.frame = CGRectMake(CScreenWidth/5*i, _headContenView.frame.size.height-70, CScreenWidth/5, 65);
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            [_headContenView addSubview:btn];
        }
    }
    return _headContenView;
}
- (UCScrollView *)contentScrolllView{
    if (!_contentScrolllView) {
        _contentScrolllView = [[UCScrollView alloc] initWithFrame:CGRectMake(0, 0, CScreenWidth, CScreenHeight-44)];
        _contentScrolllView.contentSize = CGSizeMake(CScreenWidth, CScreenHeight-44+200);
        _contentScrolllView.delegate = self;
        _contentScrolllView.tag = 1000;
    }
    return _contentScrolllView;
}
#pragma mark----UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offSetY = scrollView.contentOffset.y;
    NSLog(@"===%f",offSetY);
    if (scrollView.tag==1000) {
        if (offSetY>=200) {
            scrollView.contentOffset = CGPointMake(0, 200);
        }else if(offSetY>-20){
            NSLog(@"11111");
            CGFloat index = (offSetY+20)/220;
            [UIView animateWithDuration:0.05 animations:^{
                _headView.frame = CGRectMake(0, 0, CScreenWidth, 220-112*(index));
                _headView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:.3*(1-index)];
                _headContenView.alpha = (1-index*2.5);
                _headSearchTF.frame = CGRectMake(10+100*index, 74-70*index, CScreenWidth-20-100*index, 44);
                _titleSearchTF.frame = _headSearchTF.frame;
                _titleSearchLabel.frame =CGRectMake(-90+100*index, 78-70*index, 90, 35);
                if (index>0.3) {
                    _headTitleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:(index-0.4)/0.6];
                    _titleSearchLabel.alpha =(index-0.4)/0.6;
                    _titleButtonView.alpha =(index-0.4)/0.6;
                    _titleSearchTF.alpha =(index-0.2)/0.6;
                }else{
                    _headTitleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];;
                    _titleSearchLabel.alpha = 0;
                    _titleButtonView.alpha =0;
                    _titleSearchTF.alpha = 0;
                }
            }];
        }
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY>70&&offSetY<=220) {
        [scrollView setContentOffset:CGPointMake(0, 200) animated:YES];
    }

    if (offSetY>-20&&offSetY<=70) {
        [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
    }
}
@end
@interface UCScrollView()<UIGestureRecognizerDelegate>


@end
@implementation UCScrollView
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
@end
@implementation UCButton
- (instancetype )initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat btnHeight = self.frame.size.height-10;
    self.imageView.center = CGPointMake(self.frame.size.width/2, btnHeight*2/3/2+5);
    self.imageView.bounds = CGRectMake(0, 0, btnHeight*2/3-5, btnHeight*2/3-5);
    self.titleLabel.frame = CGRectMake(0, btnHeight*2/3+5, self.frame.size.width, btnHeight/3);
}
@end
