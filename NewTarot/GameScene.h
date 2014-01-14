//
//  GameScene.h
//  NewTarot
//
//  Created by 福角 彰啓 on 13/10/14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Card.h"

// 横列配列(列によって数が違う)
#define kCardCol [NSArray arrayWithObjects: [NSNumber numberWithInteger:6],[NSNumber numberWithInteger:5],[NSNumber numberWithInteger:5],[NSNumber numberWithInteger:6],nil] 

// 縦列数
#define kCardRow (4)

// タロットのカード枚数
#define kCardCount (22)

@class InterfaceLayer;

@interface GameScene : CCScene {
    NSMutableArray *cards_;
    CCLayer *baseLayer_;
    InterfaceLayer *interfaceLayer_;
    NSMutableArray *cardSprites_;
    int selectIndexNo_;
}
@property (nonatomic, retain)NSMutableArray *cards;
@property (nonatomic, retain)CCLayer *baseLayer;
@property (nonatomic, retain)InterfaceLayer *interfaceLayer;
@property (nonatomic, retain)NSMutableArray *cardSprites;
@property int selectIndexNo;
@end
