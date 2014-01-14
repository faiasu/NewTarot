//
//  InterfaceLayer.h
//  NewTarot
//
//  Created by 福角 彰啓 on 13/10/14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface InterfaceLayer : CCLayer {
    CCSprite* temp_;
}
@property (nonatomic, retain)CCSprite *temp;
-(void) flipAction:(CCSprite *)sprite;
-(void) flipAction2:(CCSprite *)sprite;

@end
