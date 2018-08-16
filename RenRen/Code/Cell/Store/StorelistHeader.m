//
//  StorelistHeader.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/26.
//
//

#import "StorelistHeader.h"

@interface StorelistHeader ()



@end

@implementation StorelistHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.searchBar];
    }
    return self;
}


-(UISearchBar *)searchBar{
    if(!_searchBar){
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44.f);       
        _searchBar.placeholder =  @"请输入店铺名称";
       _searchBar.showsCancelButton = YES;
        UIImage* searchBarBg = [WMHelper makeImageWithColor:[UIColor whiteColor] width:0.1 height:32.f];
        [_searchBar setBackgroundImage:searchBarBg];
        [_searchBar setBackgroundColor:[UIColor whiteColor]];
        [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
        UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
        searchField.textColor = [UIColor grayColor];
        searchField.backgroundColor = [UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1.0];
        [searchField setValue:[UIColor colorWithRed:213/255.f green:213/255.f blue:213/255.f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
        searchField.layer.masksToBounds = YES;
        searchField.layer.cornerRadius = 5.f;
    }
    return _searchBar;
}

@end
