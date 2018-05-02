#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSDate (Additions)

+(NSDate *)dateFromString:(NSString *)dateString format:(const NSString *)format;
+(NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format timezone:(NSString *)tz;
+(NSString *)stringFromDate:(NSDate *)dateValue format:(const NSString *)format;
+(NSDate *)dateFromString:(NSString *)dateString style:(NSDateFormatterStyle)style;
+(NSString *)stringFromDate:(NSDate *)dateValue style:(NSDateFormatterStyle)style;

-(NSString *)description;
-(NSString *)descriptionWithLocale:(id)locale;

-(NSString *)localizedDate:(NSTimeZone *)timezone;
-(NSString *)localizedDateAndTime:(NSTimeZone *)timezone;
-(NSString *)localizedShortDayOfWeek;
-(NSString *)localizedMonth;
-(NSString *)localizedHour:(NSTimeZone *)timezone;
-(NSString *)shortLocalizedDateAndTimeAlaWhatsApp;

-(NSComparisonResult)compareYMD:(NSDate *)other;
-(NSDate*)clearHMS;
-(NSDate*)endOfDay;

-(NSDate*)addDays: (NSInteger)days;

- (NSInteger)daysBetween:(NSDate *)otherDate;
- (NSInteger)monthsBetween:(NSDate *)otherDate;

-(NSDate*)firstDayOfWeekAsDate;
-(NSDate*)lastDayOfWeekAsDate;


-(NSInteger)day;
-(NSInteger)month;
-(NSInteger)year;

-(NSDate*)addMonths: (NSInteger)months;

-(NSDate*)firstDayOfMonthAsDate;
-(NSDate*)lastDayOfMonthAsDate;

-(NSInteger)daysInMonth;


-(NSDate*)firstDayOfWeekOfMonthAsDateGoingInPreviousMonthIfNeeded;
-(NSDate*)lastDayOfWeekOfMonthAsDateGoingInNextMonthIfNeeded;
@end
