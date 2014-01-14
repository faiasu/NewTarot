//
//  Opning.m
//  NewTarot
//
//  Created by 福角 彰啓 on 13/10/19.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Opning.h"
#include "GameScene.h"
#include "start.h"

static NSString *btnStr[] = {@"占いボタン1.png",@"占いボタン2.png",@"CardListボタン.png"};

enum LayerEnum {
    kzBaseLayer = 0,
};


@implementation Opning
@synthesize baseLayer = baseLayer_;
// ベースのレイヤーを初期化
-(void)initBaseLayer {
    self.baseLayer = [CCLayer node];
    [self addChild:self.baseLayer z:kzBaseLayer];
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCSprite *player = [CCSprite spriteWithFile:@"起動画面.jpg"];
    player.position = CGPointMake(winSize.width / 2, winSize.height / 2);
//            player.position = ccp(player.contentSize.width/2, winSize.height/2);
//    player.scale=0.5;
    [self.baseLayer addChild:player];
    [self setBtn];

}

// 占いボタン１タップ時処理
-(void)tapHoroscope1 {
    //画面遷移のアニメーションをつける
    CCScene *scene = [GameScene node];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:scene]];        CCTransitionFade *tran = [CCTransitionFade transitionWithDuration:1.0 scene:scene withColor:ccc3(255, 255, 255)];
    [[CCDirector sharedDirector] replaceScene:tran];
 
}

-(void)tapHoroscope2 {
    //画面遷移のアニメーションをつける
    CCScene *scene = [start node];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:scene]];        //CCTransitionFade *tran = [CCTransitionFade transitionWithDuration:1.0 scene:scene withColor:ccc3(255, 255, 255)];
//    [[CCDirector sharedDirector] replaceScene:tran];
    
}

// メニューボタン生成
-(void)setBtn {

    CGSize winSize = [CCDirector sharedDirector].winSize;
    // ボタン生成
    CCMenuItemToggle* btnHoroscope1 = [CCMenuItemImage itemWithNormalImage:@"占いボタン1.png"
                                                             selectedImage:@"占いボタン1.png"
                                                                    target:self
                                                                  selector:@selector(tapHoroscope1)];
    
    
    CCMenuItemToggle* btnHoroscope2 = [CCMenuItemImage itemWithNormalImage:@"占いボタン2.png"
                                                             selectedImage:@"占いボタン2.png"
                                                                    target:self
                                                                  selector:@selector(tapHoroscope2)];
    
    CCMenuItemToggle* btnCardList = [CCMenuItemImage itemWithNormalImage:@"CardListボタン.png"
                                                           selectedImage:@"CardListボタン.png"
                                                                  target:nil
                                                                selector:@selector(tapCardList)];
    
    // 並べるボタンの順番を指定
    CCMenu* topMenu = [CCMenu menuWithItems:btnHoroscope1, btnHoroscope2, btnCardList, nil];
    topMenu.position = CGPointMake(winSize.width/2,winSize.height/2);
    [topMenu alignItemsVertically];
    [self.baseLayer addChild:topMenu];

    /*
    int btnCount = sizeof(btnStr) / sizeof(btnStr[0]);
    for(int i = 0; i < btnCount; i++) {
        CCMenuItemImage *start_bt = [CCMenuItemImage itemWithNormalImage:btnStr[i] selectedImage:btnStr[i] block:^(id sender){
            
            //画面遷移のアニメーションをつける
            CCScene *scene = [GameScene node];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:scene]];        CCTransitionFade *tran = [CCTransitionFade transitionWithDuration:1.0 scene:scene withColor:ccc3(255, 255, 255)];
            [[CCDirector sharedDirector] replaceScene:tran];
        }];       
    
        //ポジションの調整
        //    start_bt.position = CGPointMake(0, -200);        
        start_bt.position = CGPointMake(0,-(winSize.height / 10) *i);
        //CCMenuインスタンスを生成
        CCMenu *item = [CCMenu menuWithItems:start_bt, nil];
        
        //CCMenuを画面に表示
        [self.baseLayer addChild:item];
    }
*/
    
}
-(id)init{
    self = [super init];
    if (self) {
        [self initBaseLayer];
    }
    return self;
} 
@end
