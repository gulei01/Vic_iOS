//
//  MOrderPay.m
//  KYRR
//
//  Created by kyjun on 16/1/7.
//
//

#import "MOrderPay.h"

@implementation MOrderPay

+(void)payWithAlipay:(NSString *)orderID price:(double)price complete:(void (^)(NSInteger, NSString *))complete{
    
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    
    
    /*饕餮
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = AlipayPartner;
    NSString *seller = AlipaySeller;
    NSString *privateKey = AlipayPrivateKey;
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    AlipayOrder *order = [[AlipayOrder alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = orderID; //订单ID（由商家自行制定）
    order.productName = @"外卖郎 订单"; //商品标题
    order.productDescription = @"外卖郎 订单"; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",price]; //商品价格
    order.notifyURL =  @"http://wm.wm0530.com/Mobile/Tpay/notifyurl"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"com.wanmei.waimailanguser";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
   // NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"",
                       orderSpec, signedString];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSInteger flag = [[resultDic objectForKey:@"resultStatus"]integerValue];
           /* if(flag == 9000){
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPaySuccess object:orderID];
            }else if(flag == 4000){
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPayFailure object:[resultDic objectForKey:@"memo"]];
            }else {
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPayUserCancel object:[resultDic objectForKey:@"memo"]];
            }*/
            //NSLog(@"%@",resultDic);
               complete(flag,[resultDic objectForKey:@"memo"]);
        }];
        
    }
 
}

+(void)payWithWeiXin:(NSString *)orderID price:(NSInteger)price{
    
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc];
    //初始化支付签名对象
    [req init:kWXAPP_ID mch_id:kWXPay_partnerid];
    //设置密钥
    [req setKey:kWXPay_partnerid_secret];
    
    //获取到实际调起微信支付的参数后，在app端调起支付
     ;
    NSMutableDictionary *dict = [req sendPay:orderID price:price];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:debug
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        //NSLog(@"%@\n\n",[req getDebugifo]);
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        [WXApi sendReq:req];
    }
}

@end
