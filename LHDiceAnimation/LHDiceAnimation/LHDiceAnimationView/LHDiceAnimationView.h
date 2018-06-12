//
//  LHDiceAnimationView.h
//  LHDiceAnimation
//
//  Created by ma c on 2018/6/11.
//  Copyright © 2018年 LIUHAO. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, DiceNum) {
    TwoDice,
    ThreeDice
};
typedef void(^diceAnimalDidStop)(NSMutableArray *diceNumbers);
@interface LHDiceAnimationView : UIView
//骰子个数
@property(nonatomic,assign)DiceNum diceNums;
//结束
@property(nonatomic,strong)diceAnimalDidStop diceAnimalStopBlock;
//初始化方法
- (instancetype)initWithDiceNum:(DiceNum)diceNum;
//开始动画
-(void)diceBegainAnimals;
//移除动画
-(void)diceEndAnimalWithMovePoint:(CGPoint)point;
@end
