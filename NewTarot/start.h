//
//  start.h
//  NewTarot
//
//  Created by 福角 彰啓 on 13/10/19.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface start : CCScene {
    CCLayer* baseLayer_;
    NSMutableArray *sprites_;

}
@property(nonatomic,retain)CCLayer* baseLayer;
@property(nonatomic,retain)NSMutableArray *sprites;
-(void)setBtn;
-(void)tapHoroscope1;
@end
