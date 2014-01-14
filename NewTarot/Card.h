//
//  Card.h
//  NewTarot
//
//  Created by 福角 彰啓 on 13/10/14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCardTypeCount (4)
@interface Card : NSObject {
    NSString *type_;
    bool isFace_;
    bool isSelected_;
}
@property (nonatomic, assign)NSString *type;
@property (nonatomic, assign)bool isFace;
@property (nonatomic, assign)bool isSelected;

@end
