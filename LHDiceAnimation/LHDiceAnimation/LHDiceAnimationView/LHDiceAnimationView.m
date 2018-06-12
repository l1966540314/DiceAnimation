//
//  LHDiceAnimationView.m
//  LHDiceAnimation
//
//  Created by ma c on 2018/6/11.
//  Copyright © 2018年 LIUHAO. All rights reserved.
//

#import "LHDiceAnimationView.h"
#import <Masonry.h>
#import "LHDiceAnimationView+Tools.h"
#import "ZXSingletonPlayer.h"
@interface LHDiceAnimationView()<CAAnimationDelegate>
//显示图片
@property(nonatomic,strong)UIImageView *diceOne;
@property(nonatomic,strong)UIImageView *diceTwo;
@property(nonatomic,strong)UIImageView *diceThree;
//动画图片
@property(nonatomic,strong)UIImageView *animDiceOne;
@property(nonatomic,strong)UIImageView *animDiceTwo;
@property(nonatomic,strong)UIImageView *animDiceThree;
@end
@implementation LHDiceAnimationView
#pragma mark - #1初始化方法
- (instancetype)initWithDiceNum:(DiceNum)diceNum
{
    self = [super init];
    if (self) {
        [self addSubview:self.animDiceThree];
        [self addSubview:self.animDiceTwo];
        [self addSubview:self.animDiceOne];
        [self addSubview:self.diceOne];
        [self addSubview:self.diceTwo];
        [self addSubview:self.diceThree];
        [self setDiceNums:diceNum];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self addSubview:self.animDiceThree];
    [self addSubview:self.animDiceTwo];
    [self addSubview:self.animDiceOne];
    [self addSubview:self.diceOne];
    [self addSubview:self.diceTwo];
    [self addSubview:self.diceThree];
}
#pragma mark - #1结束时的移动动画
-(void)diceEndAnimalWithMovePoint:(CGPoint)point
{
    [_diceOne.layer addAnimation:[self addDiceEndAnimalWithPoint:point] forKey:@"Position_Scale"];
    
    [_diceTwo.layer addAnimation:[self addDiceEndAnimalWithPoint:point] forKey:@"Position_Scale"];
    
    [_diceThree.layer addAnimation:[self addDiceEndAnimalWithPoint:point] forKey:@"Position_Scale"];
}
#pragma mark - #2添加返回组动画 #way:diceEndAnimalWithMovePoint
-(CAAnimationGroup *)addDiceEndAnimalWithPoint:(CGPoint)point
{
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"position";
    anim.toValue = [NSValue valueWithCGPoint:point];
    CABasicAnimation *anim2 = [CABasicAnimation animation];
    anim2.keyPath = @"transform.scale";
    anim2.toValue = @0;
    CAAnimationGroup *group = [CAAnimationGroup animation];
    //会自动执行animations数组当中所有的动画对象
    group.animations = @[anim,anim2];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.duration = 1.0f;
    group.delegate = self;
    return group;
}
#pragma mark - #1开始动画
-(void)diceBegainAnimals
{
    _diceOne.hidden = YES;
    _diceTwo.hidden = YES;
    _diceThree.hidden = YES;
    [_diceOne.layer removeAllAnimations];
    [_diceTwo.layer removeAllAnimations];
    [_diceThree.layer removeAllAnimations];
    
    _animDiceOne.hidden = NO;
    [_animDiceOne startAnimating];
    
    _animDiceTwo.hidden = NO;
    [_animDiceTwo startAnimating];
    
    if(_diceNums == ThreeDice){
        _animDiceThree.hidden = NO;
        [_animDiceThree startAnimating];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self addRandomPositonAnimal];
    });
}
#pragma mark - #2移动动画 #way:diceBegainAnimals
-(void)addRandomPositonAnimal
{
    CGPoint animOne = _animDiceOne.center;
    CGPoint animTwo = _animDiceTwo.center;
    
    
    CAKeyframeAnimation *animationOne = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animationOne.values = [self diceAnimalPathWithBasePath:animOne withPointsCount:6 withMaxDistance:animOne.x];
    animationOne.duration = 1.36f;
    animationOne.delegate = self;
    animationOne.removedOnCompletion = NO;
    [_animDiceOne.layer addAnimation:animationOne forKey:@"position"];

    CAKeyframeAnimation *animationTwo = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animationTwo.values = [self diceAnimalPathWithBasePath:animTwo withPointsCount:6 withMaxDistance:animOne.x];
    animationTwo.duration = 1.36f;
    animationTwo.delegate = self;
    animationTwo.removedOnCompletion = NO;
    [_animDiceTwo.layer addAnimation:animationTwo forKey:@"position"];

    if(_diceNums == ThreeDice)
    {
        CGPoint animThree = _animDiceThree.center;
        CAKeyframeAnimation *animationThree = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animationThree.values = [self diceAnimalPathWithBasePath:animThree withPointsCount:6 withMaxDistance:animOne.x];
        animationThree.duration = 1.36f;
        animationThree.delegate = self;
        animationThree.removedOnCompletion = NO;
        [_animDiceThree.layer addAnimation:animationThree forKey:@"position"];
    }
}

#pragma mark - #1diceNums Set方法
-(void)setDiceNums:(DiceNum)diceNums
{
    _diceNums = diceNums;
    
    if(diceNums == TwoDice)
    {
        [self.diceOne mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(100.0f);
            make.centerX.mas_equalTo(-60.0f);
            make.centerY.mas_equalTo(0);
        }];
        [self.diceTwo mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(100.0f);
            make.centerX.mas_equalTo(60.0f);
            make.centerY.mas_equalTo(0);
        }];
        [self.animDiceOne mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(100.0f);
            make.centerX.mas_equalTo(-60.0f);
            make.centerY.mas_equalTo(0);
        }];
        [self.animDiceTwo mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(100.0f);
            make.centerX.mas_equalTo(60.0f);
            make.centerY.mas_equalTo(0);
        }];
    }else if (diceNums == ThreeDice)
    {
        [self.diceOne mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(100.0f);
            make.centerX.mas_equalTo(-60.0f);
            make.centerY.mas_equalTo(-50.0f);
        }];
        [self.diceTwo mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(100.0f);
            make.centerX.mas_equalTo(60.0f);
            make.centerY.mas_equalTo(-50.0f);
        }];
        [self.diceThree mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(100.0f);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(50.0f);
        }];
        [self.animDiceOne mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(100.0f);
            make.centerX.mas_equalTo(-60.0f);
            make.centerY.mas_equalTo(-50.0f);
        }];
        [self.animDiceTwo mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(100.0f);
            make.centerX.mas_equalTo(60.0f);
            make.centerY.mas_equalTo(-50.0f);
        }];
        [self.animDiceThree mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(100.0f);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(50.0f);
        }];
    }
}
#pragma mark - #1代理CAAnimationDelegate
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if([_animDiceOne.layer animationForKey:@"position"] == anim || [_animDiceTwo.layer animationForKey:@"position"] == anim || [_animDiceThree.layer animationForKey:@"position"] == anim)
    {
        [self stopAllDiceAnimal];
        
        [self makeNewRandNumber];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *fileURL = [[NSBundle mainBundle] pathForResource:@"location" ofType:@"mp3"];
            [[ZXSingletonPlayer shareInstance] setSourceFromFile:fileURL error:nil];
            [[ZXSingletonPlayer shareInstance] play];
            [self diceEndAnimalWithMovePoint:CGPointMake(100, 500)];
        });
        
        
    }
    
    if([_diceOne.layer animationForKey:@"Position_Scale"] == anim || [_diceTwo.layer animationForKey:@"Position_Scale"] == anim || [_diceThree.layer animationForKey:@"Position_Scale"] == anim)
    {
        [_diceOne.layer removeAllAnimations];
        [_diceTwo.layer removeAllAnimations];
        [_diceThree.layer removeAllAnimations];
        
        _diceOne.hidden = YES;
        _diceTwo.hidden = YES;
        _diceThree.hidden = YES;
    }
}
#pragma mark - #2停止动画 #way:animationDidStop
-(void)stopAllDiceAnimal
{
    [_animDiceOne stopAnimating];
    [_animDiceOne.layer removeAllAnimations];
    
    [_animDiceTwo stopAnimating];
    [_animDiceTwo.layer removeAllAnimations];
    
    [_animDiceThree stopAnimating];
    [_animDiceThree.layer removeAllAnimations];
    
    _animDiceOne.hidden = YES;
    _animDiceTwo.hidden = YES;
    _animDiceThree.hidden = YES;
}
#pragma mark - #3产生随机数 #way:animationDidStop
-(void)makeNewRandNumber
{
    NSMutableArray *randomNum = [self getRandomNumbers:3 length:6];
    
    _diceOne.hidden = NO;
    _diceTwo.hidden = NO;
    _diceThree.hidden = NO;
    
    _diceOne.image = [UIImage imageNamed:[NSString stringWithFormat:@"dice%@.png",randomNum[0]]];
    _diceTwo.image = [UIImage imageNamed:[NSString stringWithFormat:@"dice%@.png",randomNum[1]]];
    _diceThree.image = [UIImage imageNamed:[NSString stringWithFormat:@"dice%@.png",randomNum[2]]];
    
    if(self.diceAnimalStopBlock)
    {
        self.diceAnimalStopBlock(randomNum);
    }
}
#pragma mark - #1懒加载
-(UIImageView *)diceOne
{
    if(_diceOne == nil)
    {
        _diceOne = [[UIImageView alloc] init];
        _diceOne.hidden = YES;
    }
    return _diceOne;
}

-(UIImageView *)diceTwo
{
    if(_diceTwo == nil)
    {
        _diceTwo = [[UIImageView alloc] init];
        _diceTwo.hidden = YES;
    }
    return _diceTwo;
}

-(UIImageView *)diceThree
{
    if(_diceThree == nil)
    {
        _diceThree = [[UIImageView alloc] init];
        _diceThree.hidden = YES;
    }
    return _diceThree;
}
-(UIImageView *)animDiceOne
{
    if(_animDiceOne == nil)
    {
        _animDiceOne = [[UIImageView alloc] init];
        _animDiceOne.hidden = YES;
        _animDiceOne.animationDuration = 0.25;
    }
    _animDiceOne.animationImages = [self diceAimalImages:4];
    return _animDiceOne;
}
-(UIImageView *)animDiceTwo
{
    if(_animDiceTwo == nil)
    {
        _animDiceTwo = [[UIImageView alloc] init];
        _animDiceTwo.hidden = YES;
        _animDiceTwo.animationDuration = 0.25;
    }
    _animDiceTwo.animationImages = [self diceAimalImages:4];
    return _animDiceTwo;
}
-(UIImageView *)animDiceThree
{
    if(_animDiceThree == nil)
    {
        _animDiceThree = [[UIImageView alloc] init];
        _animDiceThree.hidden = YES;
        _animDiceThree.animationDuration = 0.25;
    }
    _animDiceThree.animationImages = [self diceAimalImages:4];
    return _animDiceThree;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
