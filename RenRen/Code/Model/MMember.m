//
//  MMember.m
//  KYRR
//
//  Created by kyjun on 15/11/2.
//
//

#import "MMember.h"

@implementation MMember

-(instancetype)initWithItem:(NSDictionary *)item{
    self = [super init];
    if(self){
        self.userID = [item objectForKey:@"uid"];
        self.userName = [item objectForKey:@"uname"];
        self.passWord = [item objectForKey:@"passwd"];
        self.loginType = [item objectForKey:@"login_type"];
        self.avatar = [item objectForKey:@"outsrc"];
        self.openID = [item objectForKey:@"openid"];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
         self.userID = [aDecoder decodeObjectForKey:@"userID"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.passWord = [aDecoder decodeObjectForKey:@"passWord"];
        self.loginType = [aDecoder decodeObjectForKey:@"loginType"];
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.openID = [aDecoder decodeObjectForKey:@"openID"];
         self.isLogin = [[aDecoder decodeObjectForKey:@"isLogin"] boolValue];
        return self;
    }else{
        return nil;
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
     [aCoder encodeObject:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.passWord forKey:@"passWord"];
    [aCoder encodeObject:self.loginType forKey:@"loginType"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.openID forKey:@"openID"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.isLogin] forKey:@"isLogin"];
    
}

-(NSString *)avatar{
    if([WMHelper isEmptyOrNULLOrnil:_avatar])
        return kDefaultImage;
    return _avatar;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"userID:%@ userName:%@ passWord:%@ loginType:%@ avatar:%@ openID:%@",self.userID,self.userName,self.passWord,self.loginType,self.avatar,self.openID];
}

-(NSString *)userID{
    if([WMHelper isEmptyOrNULLOrnil:_userID]){
        return  @"";
    }
    return _userID;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString:@"uid"]){
            _userID = value;
        }else if ([key isEqualToString:@"uname"]){
            _userName = value;
        }else if ([key isEqualToString:@"passwd"]){
            _passWord = value;
        }else if ([key isEqualToString:@"login_type"]){
            _loginType = value;
        }else if ([key isEqualToString:@"outsrc"]){
            _avatar = value;
        }else if ([key isEqualToString:@"openid"]){
            _openID = value;
        }
    }
}

@end
