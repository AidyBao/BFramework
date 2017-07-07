//
//  BScreenView.m
//  SubWayWifi
//
//  Created by bao_aidy on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BScreenView.h"
#import "UIcolortool.h"
#import "BDescriptionChildrenModel.h"

#define btnSpace 10//按钮之间的间隙
#define btnWidth 80//按钮宽度



@interface BScreenView()

@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIButton *selectedBtn;//记录头部按钮点击状态
@property (nonatomic,strong)UIButton *tempBtn;//临时按钮,用来计算按钮frame
@property (nonatomic,strong)NSMutableArray *buttonArray;//记录Button总数
@property (nonatomic,strong)UIView *selectedView;//按钮选中时的背景

@property (nonatomic,assign)NSUInteger catCode;

@end

@implementation BScreenView

-(UIView *)selectedView{
    if (!_selectedView) {
        _selectedView = [[UIView alloc]init];
        _selectedView.backgroundColor = [UIColor redColor];
    }
    return _selectedView;
}

-(NSMutableArray *)buttonArray{
    if (_buttonArray == nil) {
        _buttonArray = [[NSMutableArray alloc]init];
    }
    return _buttonArray;
}

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        [self addSubview:self.scrollView];
        
        
    }
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self layoutSubviews];
    }
    return self;
}


-(void)layoutSubviews{
    [self setupSubViews];
}

-(void)setupSubViews{
    
    //scrollView
    self.scrollView.x = 3.0;
    self.scrollView.y = 0;
    self.scrollView.width = self.width-self.scrollView.x;
    self.scrollView.height = self.height;
    
    
    [self.scrollView addSubview:self.selectedView];
   
    
    //根据数据添加Button
    CGFloat btnTotalWidth = 0;//按钮总宽度,用来计算ScrollView的ContentSize
    for (int j = 0; j<=self.dataArray.count; j++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = j;
        if (0 == j) {
            [btn setTitle:[NSString stringWithFormat:@"%@",self.categoryTitle] forState:UIControlStateNormal];
            self.catCode = 0;
        }else{
            
            BDescriptionChildrenModel *ChildrenModel = self.dataArray[j-1];
            self.catCode = ChildrenModel.catCode;
            
            NSString *titleStr = [NSString stringWithFormat:@"%@",ChildrenModel.catValue];
            [btn setTitle:titleStr forState:UIControlStateNormal];
        }
        CGSize btnSize = [btn.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20.0]}  context:nil].size;
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        btn.height = btnSize.height+5;
        btn.y = 0;
        
        //如果宽度小于40,将宽度调整为60
        if (btnSize.width<=40) {
            btn.width = 50;
        }else{
            btn.width = btnSize.width+btnSpace/2;
        }
        
        if (j == 0) {//第0个Button
            
            //设置选中时的背景
            self.selectedView.width = btn.width;
            self.selectedView.layer.cornerRadius = btn.height/2.0;
            self.selectedView.layer.masksToBounds = YES;
            self.selectedView.x = btnSpace;
            self.selectedView.y = 0;
            self.selectedView.height = btn.height;
            
            
            btn.selected = YES;//第0个Button默认被选中
            self.selectedBtn = btn;//记录第0个Button默认被选中
        }
        btn.x = CGRectGetMaxX(self.tempBtn.frame)+btnSpace;
        if (j==self.dataArray.count-1) {
            btnTotalWidth = CGRectGetMaxX(btn.frame);
        }
        [btn setTitleColor:[UIcolortool colorWithHexString:@"323233"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        self.tempBtn = btn;
        [self.scrollView addSubview:btn];
        [self.buttonArray addObject:btn];
        [btn addTarget:self action:@selector(buttonActin:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    self.scrollView.contentSize = CGSizeMake(btnTotalWidth+btnSpace, self.height);
}


-(void)buttonActin:(UIButton *)sender{
    
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
    
    int i = sender.tag;
    
    NSInteger catCode = 0;
    
    if (i != 0) {//Button不等于0的情况
        BDescriptionChildrenModel *model = self.dataArray[i-1];
        catCode = model.catCode;
    }else{//Button等于0的情况
        catCode = 0;
    }
    

    
    if ([self.delegate respondsToSelector:@selector(BScreenViewButtonAction:withCatcode:withScreenFlag:)]) {
        [self.delegate BScreenViewButtonAction:sender withCatcode:catCode withScreenFlag:self.flag];
    }
    
    //设置选中背景动画
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.selectedView.frame = CGRectMake(sender.frame.origin.x, 0, sender.width, sender.height) ;
                         self.selectedView.layer.cornerRadius = sender.height/2.0;
                         self.selectedView.layer.masksToBounds = YES;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:
                          0.3 animations:^{
 
                              CGFloat buttonX = sender.frame.origin.x;
                              CGFloat buttonWidth = sender.frame.size.width;
                              CGFloat scrollerWidth = self.scrollView.contentSize.width;
                              // 移动到中间
                              if (scrollerWidth > APP_BOUNDS_WIDTH &&                                   buttonX > APP_BOUNDS_WIDTH / 2.0f - buttonWidth / 2.0f &&scrollerWidth > buttonX + APP_BOUNDS_WIDTH / 2.0f + buttonWidth / 2.0f
                                  ) {
                                  if (sender.centerX-APP_BOUNDS_WIDTH/2<=APP_BOUNDS_WIDTH/4) {
                                      [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
                                  }else{
                                      self.scrollView.contentOffset = CGPointMake(sender.frame.origin.x - APP_BOUNDS_WIDTH / 2.0f + sender.frame.size.width / 2.0f, 0);
                                  }
                              } else if (buttonX < APP_BOUNDS_WIDTH / 2.0f - buttonWidth / 2.0f) { // 移动到开始
                                  self.scrollView.contentOffset = CGPointMake(0, 0);
                              } else if (scrollerWidth - buttonX < APP_BOUNDS_WIDTH / 2.0f + buttonWidth / 2.0f || buttonX + buttonWidth == scrollerWidth) {
                                  if (scrollerWidth > APP_BOUNDS_WIDTH) {
                                      self.scrollView.contentOffset = CGPointMake(scrollerWidth - APP_BOUNDS_WIDTH, 0); // 移动到末尾
                                  }
                              }
                          }];
                     }];
}

#pragma mark__将颜色转换为图片方法,此方法暂时不用
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


//-(void)setDataArray:(NSArray *)dataArray{
//    _dataArray = dataArray;
//    [self setupSubViews];
//    NSLog(@"self.buttonArray.count = %d",self.buttonArray.count);
//    for (UIButton *btn in self.buttonArray) {
//        
//            NSLog(@"%@",btn.titleLabel.text);
//    }
//    //重新布局
//    //[self setNeedsLayout];
//    
//}


-(NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSArray array];
        _dataArray=@[@"全部地区",@"历史剧",@"言情剧",@"内地",@"香港",@"台湾",@"武侠剧",@"韩国",@"古装剧",@"美国",@"俄罗斯",@"法国"];
    }
    return _dataArray;
}

@end
