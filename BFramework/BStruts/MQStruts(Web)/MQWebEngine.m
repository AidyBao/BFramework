//
//  MQWebEngine.m
//  YDHYK
//
//  Created by screson on 2016/11/21.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "MQWebEngine.h"
#import "MQCommonEngine.h"

@interface MQWebEngine ()<UIWebViewDelegate,UIScrollViewDelegate>
{
    CGFloat offsetY;
    BOOL bShow;
    BOOL trackingScroll;
    NSURL    * contentURL;
    NSString * contentString;
    NSURL    * baseURL;
    NSString * sTitle;
    BOOL isAnimating;
}

@property (nonatomic,strong) UIView   * currentProgress;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *closeButtonWidth;// 0 37

@property (weak, nonatomic) IBOutlet UIButton *btnClose;

@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *navContentView;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (weak, nonatomic) IBOutlet UIView *progressBack;
@property (weak, nonatomic) IBOutlet UIButton *btnRefresh;

@end

@implementation MQWebEngine

- (instancetype)init{
    if (self = [super init]) {
        [self setHidesBottomBarWhenPushed:true];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    sTitle = title;
    if (self.lbTitle) {
        self.lbTitle.text = title;
    }
}

- (void)loadContentWithURL:(NSURL *)url{
    contentURL = url;
    if (self.webView) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:contentURL]];
    }
}


- (void)loadContentWithHTMLString:(NSString *)htmlString baseURL:(NSURL *)bURL{
    contentString = htmlString;
    baseURL = bURL;
    if (self.webView) {
        if ([contentString respondsToSelector:@selector(length)]) {
            [self.webView loadHTMLString:contentString baseURL:baseURL];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:true];
    if (!self.webView.isLoading) {
        if (contentURL) {
            [self.webView loadRequest:[NSURLRequest requestWithURL:contentURL]];
        }
        if ([contentString respondsToSelector:@selector(length)]) {
            [self.webView loadHTMLString:contentString baseURL:baseURL];
        }
    }
    [self.lbTitle setText:sTitle];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [_progressBack addSubview:self.currentProgress];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.btnBack setImage:[NSBundle mq_navBackImage] forState:UIControlStateNormal];
    [self.navView setBackgroundColor:[UIColor mq_navbarColor]];
    [self.navContentView setBackgroundColor:[UIColor mq_navbarColor]];
    [self.lbTitle setFont:[UIFont mq_titleFontWithSize:mq_navBarTitleFontSize()]];
    [self.webView setBackgroundColor:MQWHITE_COLOR];
    [self.webView.scrollView setDelegate:self];
//    [self.webView setScalesPageToFit:true];
    
    [_btnRefresh setHidden:true];
    [_closeButtonWidth setConstant:0];
    bShow = true;
    offsetY = 0;
    trackingScroll = true;
    isAnimating = false;
    [self.progressBack setBackgroundColor:[UIColor mq_navbarColor]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    if ([_webView canGoBack]) {
        [_webView goBack];
    }else{
        if (self.navigationController) {
            [self.navigationController popViewControllerAnimated:true];
        }else{
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }
}

- (IBAction)closeAction:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:true];
    }else{
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

- (IBAction)refreshAction:(id)sender {
    [self setProgress:0];
    isAnimating = false;
    [self.webView stopLoading];
    if ([contentString respondsToSelector:@selector(length)] && ![self.webView canGoBack]) {
        [self.webView loadHTMLString:contentString baseURL:baseURL];
    }else{
        [self.webView reload];
    }
}

#pragma mark WebView Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self startLoadingProgressAnimation];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (webView.canGoBack) {
        [_closeButtonWidth setConstant:37];
        [_btnClose setHidden:false];
    }else{
        [_closeButtonWidth setConstant:0];
        [_btnClose setHidden:true];
    }
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//
//    return true;
//}

- (void)startLoadingProgressAnimation{
    if (isAnimating) {
        return;
    }
    isAnimating = true;
    [self setProgress:0.0];
    [_btnRefresh setHidden:true];
    [UIView animateWithDuration:2 animations:^{
        [self setProgress:0.8];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            [self setProgress:1.0];
        } completion:^(BOOL finished) {
            [self setProgress:0];
            isAnimating = false;
            [_btnRefresh setHidden:false];
        }];
    }];
}


#pragma mark ScrollView Delegate


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    trackingScroll = false;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    trackingScroll = true;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!trackingScroll) {
        return;
    }
    CGFloat tempY = scrollView.contentOffset.y;
    if (offsetY <= 0) {
        offsetY = tempY;
        return ;
    }
    if (offsetY >= 20) {
        if (tempY > offsetY) {
            [self hideTopView:true];
        }else{
            [self hideTopView:false];
        }
    }else{
        [self hideTopView:false];
    }
    offsetY = tempY;
}


#pragma mark -  显示和隐藏Nav
- (void)hideTopView:(BOOL)hide{
    if (bShow != hide) {
        return;
    }
    if (hide) {
        [UIView animateWithDuration:0.35 animations:^{
            _topHeight.constant = 20;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            bShow = false;
        }];
    }else{
        [UIView animateWithDuration:0.35 animations:^{
            _topHeight.constant = 64;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            bShow = true;
        }];
    }
}


#pragma mark - progress

- (UIView *)currentProgress{
    if (!_currentProgress) {
        _currentProgress = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 2)];
//        [_currentProgress setBackgroundColor:MQRGB_COLOR(53, 167, 144)];
        [_currentProgress setBackgroundColor:[UIColor blueColor]];
    }
    return _currentProgress;
}

- (void)setProgress:(CGFloat)value{
    value = value >= 1 ? 1 : value;
    value = value <= 0 ? 0 : value;
    CGFloat width = MQ_BOUNDS_WIDTH * value;
    [self.currentProgress setFrame:CGRectMake(0, 0, width, 2)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
