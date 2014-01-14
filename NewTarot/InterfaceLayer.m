//
//  InterfaceLayer.m
//  NewTarot
//
//  Created by 福角 彰啓 on 13/10/14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "InterfaceLayer.h"
#import "GameScene.h"

@interface InterfaceLayer()
    -(void)tapCard:(Card*)card sprite:(CCSprite*)sprite;
@end

@implementation InterfaceLayer
@synthesize temp = temp_;
-(void)onEnter {
    [[[CCDirector sharedDirector]touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(void)onExit {
    [[[CCDirector sharedDirector]touchDispatcher] removeDelegate:self];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {

    CGPoint locationInView = [touch locationInView:[touch view]];
    CGPoint location = [[CCDirector sharedDirector]convertToGL:locationInView];
    GameScene* gameScene = (GameScene*)[CCDirector sharedDirector].runningScene;
    // どのカードがタッチされたか判断する
    for(int i = 0; i < kCardCount; i++) {
        CCSprite* sprite = [gameScene.cardSprites objectAtIndex:i];
        Card* card = [gameScene.cards objectAtIndex:i];
        float h = sprite.contentSize.height * 0.06;
        float w = sprite.contentSize.width * 0.06;
        float x = sprite.position.x - w/2;
        float y = sprite.position.y - h/2;
        CGRect rect = CGRectMake(x,y,w,h);
        // カードの当たり判定
        if(CGRectContainsPoint(rect, location)) {
            // 前回選択カードと違うカードの場合は点滅停止＆フラグ解除
            if(i != gameScene.selectIndexNo && gameScene.selectIndexNo >= 0) {
                CCSprite* oldsprite = [gameScene.cardSprites objectAtIndex:gameScene.selectIndexNo];
                [self stopActionForSprite:oldsprite];
                Card* oldcard = [gameScene.cards objectAtIndex:i];
                oldcard.isSelected = false;
            }
            gameScene.selectIndexNo = i;
            NSLog(@"Hit %d" , i);
            [self tapCard:card sprite:sprite];
            break;
        }
    }
}

-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}

-(void)tapCard:(Card *)card sprite:(CCSprite *)sprite {
    
    if( !card.isSelected ) {
        id blink = [CCBlink actionWithDuration:1 blinks:1];
        id repeatForever = [CCRepeatForever actionWithAction:blink];
        [sprite runAction:repeatForever];
        card.isSelected = true;
    }
    else {
        [self stopActionForSprite:sprite];
        [self hideCard];
        sprite.visible =true;
        // 選択カードのアクション開始
        CGSize size = [[CCDirector sharedDirector] winSize];
        id actionBy = [CCMoveTo actionWithDuration:2  position: ccp(size.width /2 , size.height/2)];
        id actionBy2 = [CCScaleBy actionWithDuration:2 scaleX:4 scaleY:4];
        id action = [CCSpawn actions:actionBy2,actionBy,nil];
        [sprite runAction:action];
        
        // 半分めくる
        [self flipAction:sprite];
        // カードの裏表切り替え
        if ( !card.isFace ) {
            [sprite setTexture:[[CCTextureCache sharedTextureCache] addImage:card.type]];
            card.isFace = true;
        }
        else {
            [sprite setTexture:[[CCTextureCache sharedTextureCache] addImage:@"背面.jpg"]];
            card.isFace = false;
        }
        // もう半分めくる
        [self flipAction2:sprite];
        card.isSelected =false;
    }
}
-(void) hideCard {
    GameScene* gameScene = (GameScene*)[CCDirector sharedDirector].runningScene;
    for(int i = 0; i < kCardCount; i++) {
        CCSprite* sprite = [gameScene.cardSprites objectAtIndex:i];
        sprite.visible =false;
    }
 
}
-(void) stopActionForSprite: (CCSprite *)sprite {
    [sprite stopAllActions];
    sprite.visible = true;
}
-(void) flipAction:(CCSprite *)sprite {
    id camera = [CCOrbitCamera actionWithDuration:1.0 radius:1 deltaRadius:0 angleZ:0.0f deltaAngleZ:90.0f angleX:0 deltaAngleX:0];
//    id hide = [CCHide action ];  
//    id func = [CCCallFunc actionWithTarget:self selector:@selector(flipAction2)];
//    CCActionInterval* action = (CCActionInterval*)[CCSequence actions:camera, hide, func, NULL];  
    CCActionInterval* action = (CCActionInterval*)[CCSequence actions:camera,  NULL];  
    [sprite runAction:action];  
}

// 半分までひっくり返ったところで表面のカードのアクション  
-(void) flipAction2:(CCSprite *)sprite  {
    id camera = [CCOrbitCamera actionWithDuration:1.0 radius:1 deltaRadius:0 angleZ:270.0f deltaAngleZ:90.0f angleX:0 deltaAngleX:0];
    id action = (CCActionInterval*)[CCSequence actions: camera, NULL];  
    [sprite runAction:action];  
}

-(void)exeRevers:(CCSprite *)sprite
{
//    [sprite setTexture:[[CCTextureCache sharedTextureCache] addImage: cardimg]];
//    cardimg = @"背面.jpg";
    /*    CGPoint pos = self.position;
     [self initWithFile:cardimg];
     self.position = pos;
     */
}
@end
