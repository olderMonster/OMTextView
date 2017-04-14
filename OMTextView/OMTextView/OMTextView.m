//
//  OMTextView.m
//  OMTextView
//
//  Created by 印聪 on 2017/4/14.
//  Copyright © 2017年 tima. All rights reserved.
//

#import "OMTextView.h"
#import <objc/runtime.h>
@interface OMTextView()

@property (nonatomic , strong)UILabel *placeholderLabel;

@end

@implementation OMTextView

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL origilaSEL = @selector(setFont:);
        
        SEL hook_SEL = @selector(omsetFont:);
        
        //交换方法
        Method origilalMethod = class_getInstanceMethod(self, origilaSEL);
        
        
        Method hook_method = class_getInstanceMethod(self, hook_SEL);
        
        
        class_addMethod(self,
                        origilaSEL,
                        class_getMethodImplementation(self, origilaSEL),
                        method_getTypeEncoding(origilalMethod));
        
        class_addMethod(self,
                        hook_SEL,
                        class_getMethodImplementation(self, hook_SEL),
                        method_getTypeEncoding(hook_method));
        
        method_exchangeImplementations(class_getInstanceMethod(self, origilaSEL), class_getInstanceMethod(self, hook_SEL));
        
    });
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.placeholderLabel];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //这里需要解决左边距与上边距写死的问题
    //是否可以通过runtime获取textView的文本（label）的frame。然后根据该frame设置占位文字的(x,y)
    if (nil != self.omPlaceholder) {
        CGFloat left = 3;
        CGFloat width = self.bounds.size.width - left*2;
        CGFloat top = 5;
        CGFloat height = self.bounds.size.height -2*top;
        CGRect textRect = [self.placeholderLabel.text boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.placeholderLabel.font} context:nil];
        self.placeholderLabel.frame = CGRectMake(left, top, width, textRect.size.height);
    }

}


- (void)textDidChange{
    
    if (nil != self.text && ![self.text isEqualToString:@""]) {
        self.placeholderLabel.hidden = YES;
    }else{
        self.placeholderLabel.hidden = NO;
    }
}

- (void)omsetFont:(UIFont *)font{
    
    self.placeholderLabel.font = font;
    [self omsetFont:font];
}


#pragma mark -- getters and seters
- (UILabel *)placeholderLabel{
    if (_placeholderLabel == nil) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.textColor = [UIColor grayColor];
        _placeholderLabel.font = [UIFont systemFontOfSize:15];
        _placeholderLabel.numberOfLines = 0;
        [_placeholderLabel sizeToFit];
    }
    return _placeholderLabel;
}


- (void)setOmPlaceholder:(NSString *)omPlaceholder{
    _omPlaceholder = omPlaceholder;
    self.placeholderLabel.text = omPlaceholder;
}


- (void)dealloc{
    
    //移除监听者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
