//
//  Opning.h
//  NewTarot
//
//  Created by 福角 彰啓 on 13/10/19.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Opning : CCScene {
    CCLayer* baseLayer_;    
}
@property(nonatomic,retain)CCLayer* baseLayer;
-(void)setBtn;
-(void)tapHoroscope1;
@end
