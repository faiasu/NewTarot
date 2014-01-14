//
//  start.m
//  NewTarot
//
//  Created by 福角 彰啓 on 13/10/19.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "start.h"
#include "GameScene.h"

static NSString *str[] = {@"文章その１",@"文章２行目",@"文章3行目"};

enum LayerEnum {
    kzBaseLayer = 0,
};


@implementation start
@synthesize baseLayer = baseLayer_;
@synthesize sprites = sprites_;
// ベースのレイヤーを初期化
-(void)initBaseLayer {
    self.baseLayer = [CCLayer node];
    [self addChild:self.baseLayer z:kzBaseLayer];
    CCLabelTTF *score_label;
    score_label = [CCLabelTTF labelWithString:@"ようこそ占いの館へ。" fontName:@"Marker Felt" fontSize:32];
    CGSize size = [[CCDirector sharedDirector] winSize];
    score_label.position =  ccp( size.width /2 , size.height -100 );
    [self.baseLayer addChild:score_label];
    id fade = [CCFadeIn actionWithDuration:3.0f];
    id callFunc = [CCCallFunc actionWithTarget:self selector:@selector(dispstr)];
    id action = (CCActionInterval*)[CCSequence actions: fade,callFunc, NULL];  
    [score_label runAction:action];  
    

}
- (void)dispstr
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    for (int i =0; i< (sizeof(str)/sizeof(str[0]));i++) {
        CCLabelTTF *label = [CCLabelTTF labelWithString:str[i] fontName:@"Marker Felt" fontSize:(16)];
        label.visible =false;
        label.position =  ccp( size.width /2 , size.height -130-(20*i) );
        [self.baseLayer addChild:label];
        id show = [CCShow action];
        id fade = [CCFadeIn actionWithDuration:1.0f];
        id delay = [CCDelayTime actionWithDuration:1.0f*i];
//        id callFunc = [CCCallFunc actionWithTarget:self selector:@selector(dispBtn)];
        id action = (CCActionInterval*)[CCSequence actions: delay, show,fade, NULL];  
        [label runAction:action];  
    }
    [self dispBtn];
}
-(void)dispBtn
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCMenuItemToggle* btnNext = [CCMenuItemImage itemWithNormalImage:@"運勢を選択.png"
                                                       selectedImage:@"運勢を選択.png"
                                                              target:self
                                                            selector:@selector(tapNext)];
    CCMenu* menu = [CCMenu menuWithItems:btnNext, nil];
    menu.position = CGPointMake(size.width/2,size.height/2);
    [menu alignItemsVertically];
    [self.baseLayer addChild:menu];
   
}

// 占いボタン１タップ時処理
-(void)tapNext {
    //画面遷移のアニメーションをつける
    CCScene *scene = [GameScene node];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:scene]];        CCTransitionFade *tran = [CCTransitionFade transitionWithDuration:1.0 scene:scene withColor:ccc3(255, 255, 255)];
    [[CCDirector sharedDirector] replaceScene:tran];
    
}
-(id)init{
    self = [super init];
    if (self) {
        [self initBaseLayer];
    }
    return self;
} 
@end
