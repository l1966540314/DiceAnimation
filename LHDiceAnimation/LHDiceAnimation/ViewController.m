//
//  ViewController.m
//  LHDiceAnimation
//
//  Created by ma c on 2018/6/11.
//  Copyright © 2018年 LIUHAO. All rights reserved.
//

#import "ViewController.h"
#import "LHDiceAnimationView.h"
#import <Masonry.h>
#import "ZXSingletonPlayer.h"
@interface ViewController ()
@property(nonatomic,weak)LHDiceAnimationView *diceView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    LHDiceAnimationView *diceView = [[LHDiceAnimationView alloc] initWithDiceNum:ThreeDice];
    [self.view addSubview:diceView];
    [diceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    self.diceView = diceView;
    self.diceView.userInteractionEnabled = NO;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.diceView diceBegainAnimals];
    
    NSString *fileURL = [[NSBundle mainBundle] pathForResource:@"rotate" ofType:@"mp3"];
    [[ZXSingletonPlayer shareInstance] setSourceFromFile:fileURL error:nil];
    [[ZXSingletonPlayer shareInstance] play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
