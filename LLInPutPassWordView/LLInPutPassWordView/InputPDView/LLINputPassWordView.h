//
//  LLINputPassWordView.h
//  BusinessAreaPlat
//
//  Created by 李龙 on 15/5/12.
//
//

#import <UIKit/UIKit.h>
@class LLINputPassWordView;



typedef void (^BlockOtherName) (NSString * pwString);
typedef void (^cancleBlock)();
typedef void (^cancleBlock)();

@interface LLINputPassWordView : UIView

@property (weak, nonatomic) UITextField *myPassWordTF;

/**
 *  快速构造方法
 *
 *  @return LLINputPassWordView
 */
+(instancetype)getSharedInPutPassWordView;
/**
 *  显示这儿view
 */
-(void)show;
/**
 *  隐藏这个view
 */
-(void)dismiss;

//---------  定义 block 属性 和方法
@property (nonatomic, copy) BlockOtherName returnTextBlock;
@property (nonatomic,assign) cancleBlock myCanncelBlock;

/**
 返回输入的密码
 */
- (void)returnText:(BlockOtherName)block;

/**取消按钮*/
-(void)canncelShowInputPWView:(void (^)()) canncelDeal;


@end
