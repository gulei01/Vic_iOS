//
//  VerticallyAlignedLabel.h
//  KYRR
//
//  Created by kuyuZJ on 16/7/12.
//
//

#import <UIKit/UIKit.h>

typedef enum VerticalAlignment {
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;


@interface VerticallyAlignedLabel : UILabel {
@private
    VerticalAlignment verticalAlignment_;
}

@property (nonatomic, assign) VerticalAlignment verticalAlignment;


@end
