//
//  SKCandleDataBuilder.m
//  IndCalculator
//
//  Created by Ryan Wang on 15/04/2017.
//  Copyright © 2017 aelam. All rights reserved.
//

#import "SKCandleDataBuilder.h"

@implementation SKCandleDataBuilder

+ (NSArray <CandleChartDataEntry *> *)candles {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"candle" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSArray *candleNumbers = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSMutableArray <CandleChartDataEntry *> *candles = (NSMutableArray <CandleChartDataEntry *> *)[NSMutableArray array];
    for (NSArray *numbers in candleNumbers) {
        CandleChartDataEntry *stick = [[CandleChartDataEntry alloc] init];
        stick.open = [numbers[1] doubleValue];
        stick.high = [numbers[2] doubleValue];
        stick.low = [numbers[3] doubleValue];
        stick.close = [numbers[4] doubleValue];
        
        [candles addObject:stick];
    }
    
    return candles;
}

@end
