# OMTextView

带占位文本的TextView的第一个版本，临时写的比较粗糙，如果有大神觉得有哪儿实现的方法不好的地方还请提出来。

![img](https://github.com/olderMonster/OMTextView/blob/master/Untitled.gif) 

使用方法：
` `` 
- (void)viewDidLoad {
[super viewDidLoad];

self.view.backgroundColor = [UIColor whiteColor];
[self.view addSubview:self.adviceTextView];

}

- (void)viewWillLayoutSubviews{
[super viewWillLayoutSubviews];

self.adviceTextView.frame = CGRectMake(10, 30, self.view.bounds.size.width - 20, 100);

}


#pragma mark -- getters and setters
- (OMTextView *)adviceTextView{
if (_adviceTextView == nil) {
_adviceTextView = [[OMTextView alloc]init];
_adviceTextView.layer.masksToBounds = YES;
_adviceTextView.layer.cornerRadius = 2;
_adviceTextView.layer.borderColor = [UIColor grayColor].CGColor;
_adviceTextView.layer.borderWidth = 1.0f;
_adviceTextView.omPlaceholder = @"123124142";
}
return _adviceTextView;
}

` `` 
