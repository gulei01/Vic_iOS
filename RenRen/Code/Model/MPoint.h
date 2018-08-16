//
//  MPoint.h
//  KYRR
//
//  Created by kyjun on 16/5/9.
//
//

#import <Foundation/Foundation.h>

@interface MPoint : NSObject

@property(nonatomic,copy) NSString* rowID;
/**
 *  "0"//商品状态；0上架：1下架
 */
@property(nonatomic,copy) NSString* status;
/**
 *  "1"//商品状态0删除；1正常
 */
@property(nonatomic,copy) NSString* close;
/**
 *  "1"//商品分类 1实物；2虚拟物品
 */
@property(nonatomic,copy) NSString* category;
/**
 *  库存
 */
@property(nonatomic,copy) NSString* stock;
/**
 *  积分
 */
@property(nonatomic,copy) NSString* points;
/**
 *  市场价格
 */
@property(nonatomic,copy) NSString* marketPrice;
/**
 *  商品名称
 */
@property(nonatomic,copy) NSString* goodsName;
/**
 *  默认图片
 */
@property(nonatomic,copy) NSString* defaultImg;
/**
 *  子标题
 */
@property(nonatomic,copy) NSString* subTitle;
/**
 *  关键字
 */
@property(nonatomic,copy) NSString* keyWords;
/**
 *  详情
 */
@property(nonatomic,copy) NSString* content;
/**
 *  创建时间
 */
@property(nonatomic,copy) NSString* createDate;
/**
 *  修改时间
 */
@property(nonatomic,copy) NSString* modifyDate;
/**
 *  销量
 */
@property(nonatomic,copy) NSString* sales;

@end

@interface MPointRecord : NSObject

@property(nonatomic,copy) NSString* rowID;
/**
 *  用户编号
 */
@property(nonatomic,copy) NSString* userID;
/**
 *  积分
 */
@property(nonatomic,copy) NSString* points;
/**
 *  积分类型
 */
@property(nonatomic,copy) NSString* type;
/**
 *  创建日期
 */
@property(nonatomic,copy) NSString* createDate;
/**
 *  备注
 */
@property(nonatomic,copy) NSString* mark;
/**
 *  类型名称
 */
@property(nonatomic,copy) NSString* typeName;

@end

@interface MPointExchange : NSObject

@property(nonatomic,copy) NSString* rowID;
/**
 *  商品ID
 */
@property(nonatomic,copy) NSString* goodsID;
@property(nonatomic,copy) NSString* goodsName;
/**
 *  兑换数量
 */
@property(nonatomic,copy) NSString* quantiry;
/**
 *  兑换日期
 */
@property(nonatomic,copy) NSString* createDate;
/**
 *  用户编号
 */
@property(nonatomic,copy) NSString* userID;
/**
 *  兑换积分
 */
@property(nonatomic,copy) NSString* points;
/**
 *  兑换订单状态 1:刚兑换待审核；2：审核通过；3：审核不通过 4：已兑换完成；
 */
@property(nonatomic,copy) NSString* status;
/**
 *  用户姓名
 */
@property(nonatomic,copy) NSString* userName;
/**
 *  用户电话
 */
@property(nonatomic,copy) NSString* phone;
/**
 *  收货地址
 */
@property(nonatomic,copy) NSString* address;
/**
 *  商品图片
 */
@property(nonatomic,copy) NSString* defaultImg;

@end

@interface MPointIndex : NSObject

@property(nonatomic,copy) NSString* topImg;
@property(nonatomic,copy) NSString* ruleUrl;
@property(nonatomic,copy) NSString* points;
@property(nonatomic,copy) NSString* title;
@property(nonatomic,strong) NSMutableArray* arrayData;

@end