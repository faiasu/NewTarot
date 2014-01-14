//
//  GameScene.m
//  NewTarot
//
//  Created by 福角 彰啓 on 13/10/14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "InterfaceLayer.h"
#include "Opning.h"
#define kShuffleCount (100)
static 
static NSString *cardStr[] = {@"死神.jpg",@"節制.jpg",@"愚者.jpg",@"女教皇.jpg",@"1.jpg",@"5.jpg",@"8.jpg",@"12.jpg",@"13.jpg",@"15.jpg",@"16.jpg",@"21.jpg"};
enum LayerEnum {
    kzBaseLayer = 0,
    kzInterfaceLayer = 5,
    kzCardSprite = 10,
    };
@interface GameScene()
-(void) initCards;
-(void) initBaseLayer;
-(void) initCardSprites;
-(void) initInterfaceLayer;
@end

@implementation GameScene
@synthesize cards = cards_;
@synthesize baseLayer = baseLayer_;
@synthesize interfaceLayer = interfaceLayer_;
@synthesize cardSprites = cardSprites_;
@synthesize selectIndexNo = selectIndexNo_;

-(void)dealloc {
    [self.cards release];
    [self.baseLayer release];
    [self.cardSprites release];
    [self.interfaceLayer release];
    [super dealloc];
}

-(void) initCards {
    NSString *types[kCardCount];
    for (int i=0; i <kCardCount; i++) {
        types[i] =  cardStr[ i %  kCardTypeCount];
//        types[i] =  cardStr[ i / (kCardCount / kCardTypeCount)];
    }
        // シャツフルする
    for (int i = 0; i < kShuffleCount; i++) {
        int indexl = random() % kCardCount;
        int index2 = random() % kCardCount;
        NSString *tmp = types[indexl] ;
        types[indexl] = types[index2] ;
        types[index2] = tmp;
    }
    // Cardオブジェク卜の配列を初期化
    self.cards = [NSMutableArray array] ;
    for (int i = 0; i < kCardCount; i++) {
        Card* card = [[[Card alloc] init] autorelease] ;
        card.type = types[i];
        card.isFace = false;
        card.isSelected =false;
        [self.cards addObject:card];
    }
}

-(void)initBaseLayer {
    self.baseLayer = [CCLayer node];
    [self addChild:self.baseLayer z:kzBaseLayer];
}

-(void)initCardSprites {
    self.cardSprites = [NSMutableArray array];
    CGSize winSize = [CCDirector sharedDirector].winSize;
    for (int y = 0; y < kCardRow; y++) {
        for (int x = 0; x < [[kCardCol objectAtIndex:y] intValue]; x++) {
            CCSprite *card = [CCSprite spriteWithFile:@"背面.jpg"] ;
            card.scale = 0.06;
            card.position = CGPointMake(((winSize.width / [[kCardCol objectAtIndex:y] intValue]) * (x+0.5)),//+ (card.contentSize.width * 0.08 * x) ),
                                        ((winSize.height -120) / (kCardRow)) *(y+0.5)+50);//+ ((card.contentSize.height * 0.08 * y)));
//            card.position = ccp(card.contentSize.width * (x + 0.5f) ,
//                                card.contentSize.height * (y + 0.5f));
            [self.baseLayer addChild:card z :kzCardSprite] ;
            [self.cardSprites addObject:card] ;
        }
    }
}

- (void)initBtnSprites {
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCMenuItemToggle* btnTop = [CCMenuItemImage itemWithNormalImage:@"タイトルに戻る.png"
                                                       selectedImage:@"タイトルに戻る.png"
                                                              target:self
                                                            selector:@selector(tapTitle)];
    btnTop.scale = 0.6;
    CCMenu* topMenu = [CCMenu menuWithItems:btnTop, nil];
    topMenu.position = CGPointMake((size.width/3)*2.3,size.height-40);
    [topMenu alignItemsVertically];
    [self.baseLayer addChild:topMenu];
    
    CCMenuItemToggle* btnSelected = [CCMenuItemImage itemWithNormalImage:@"カードを選択.png"
                                                      selectedImage:@"カードを選択.png"
                                                             target:self
                                                           selector:@selector(tapSelected)];
    btnSelected.scale = 0.6;
    CCMenu* underMenu = [CCMenu menuWithItems:btnSelected, nil];
    underMenu.position = CGPointMake((size.width/3)*2.3,20);
    [underMenu alignItemsVertically];
    [self.baseLayer addChild:underMenu];
}
-(void)tapTitle {
    //画面遷移のアニメーションをつける
    CCScene *scene = [Opning node];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:scene]];        CCTransitionFade *tran = [CCTransitionFade transitionWithDuration:1.0 scene:scene withColor:ccc3(255, 255, 255)];
    [[CCDirector sharedDirector] replaceScene:tran];
    
}
-(void)initInterfaceLayer {
    self.interfaceLayer = [InterfaceLayer node];
    [self addChild:self.interfaceLayer z:kzInterfaceLayer];
}

-(id)init{
    self = [super init];
    if (self) {
        self.selectIndexNo = -10;
        [self initCards];
        [self initBaseLayer];
        [self initCardSprites];
        [self initBtnSprites];
        [self initInterfaceLayer];
    }
    return self;
}
@end
