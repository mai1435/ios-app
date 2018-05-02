#import "NSDate+Additions.h"

// as per:
// https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/DataFormatting/Articles/dfDateFormatting10_4.html#//apple_ref/doc/uid/TP40002369-SW1
// use a static/sigletons to improve efficiency


const NSString *kNSDateFormatISO8601 = @"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ";	// ISO-8601 http://www.w3.org/TR/NOTE-datetime


@implementation NSDate (Additions)


+(NSCalendar*)sharedGregorianCalendar;
{
    // If the calendars aren't already set up, create them and cache them for reuse.
    static NSCalendar * calendar = nil;

    if (calendar == nil)
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];

    return calendar;
}


+(NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format
{
	static NSDateFormatter *dateFormatter = nil;
	@synchronized (self)
	{
		if (dateFormatter == nil)
		{
			dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setLocale: [NSLocale currentLocale]];
			[dateFormatter setTimeZone: [NSTimeZone systemTimeZone]];
		}
	}
	if (format != nil)
		[dateFormatter setDateFormat:format];
	else
		[dateFormatter setDateStyle: NSDateFormatterLongStyle];
    NSDate *dateValue = [dateFormatter dateFromString:dateString];
    return dateValue;
}

+(NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format timezone:(NSString *)tz
{
	static NSDateFormatter *dateFormatter = nil;
	@synchronized (self)
	{
		if (dateFormatter == nil)
		{
			dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setLocale: [NSLocale currentLocale]];
		}
	}
	NSTimeZone *timezone = [NSTimeZone timeZoneWithAbbreviation:tz];
	if (timezone == nil)
		timezone = [NSTimeZone systemTimeZone];
	[dateFormatter setTimeZone: timezone];
	if (format != nil)
		[dateFormatter setDateFormat:format];
	else
		[dateFormatter setDateStyle: NSDateFormatterLongStyle];
	NSDate *dateValue = [dateFormatter dateFromString:dateString];
	return dateValue;
}

+(NSString *)stringFromDate:(NSDate *)dateValue format:(NSString *)format
{
	static NSDateFormatter *dateFormatter = nil;
	@synchronized (self)
	{
		if (dateFormatter == nil)
		{
			dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setLocale: [NSLocale currentLocale]];
			[dateFormatter setTimeZone: [NSTimeZone systemTimeZone]];
		}
	}
	if (format != nil)
		[dateFormatter setDateFormat:format];
	else
		[dateFormatter setDateStyle:NSDateFormatterLongStyle];
    NSString *dateString = [dateFormatter stringFromDate:dateValue];
    return dateString;
}

+(NSDate *)dateFromString:(NSString *)dateString style:(NSDateFormatterStyle)style
{
	static NSDateFormatter *dateFormatter = nil;
	@synchronized (self)
	{
		if (dateFormatter == nil)
		{
			dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setLocale: [NSLocale currentLocale]];
			[dateFormatter setTimeZone: [NSTimeZone systemTimeZone]];
		}
	}
	[dateFormatter setDateStyle:style];
    NSDate *dateValue = [dateFormatter dateFromString:dateString];
    return dateValue;
}

+(NSString *)stringFromDate:(NSDate *)dateValue style:(NSDateFormatterStyle)style
{
	static NSDateFormatter *dateFormatter = nil;
	@synchronized (self)
	{
		if (dateFormatter == nil)
		{
			dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setLocale: [NSLocale currentLocale]];
			[dateFormatter setTimeZone: [NSTimeZone systemTimeZone]];
		}
	}
	[dateFormatter setDateStyle:style];
    NSString *dateString = [dateFormatter stringFromDate:dateValue];
    return dateString;
}

-(NSString *)description
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss z"];
    return [dateFormatter stringFromDate:self];
}

-(NSString *)descriptionWithLocale:(id)locale
{
    if (locale == nil)
        return [self description];
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
        [dateFormatter setLocale:locale];
        return [dateFormatter stringFromDate:self];
    }
}

-(NSString *)localizedDate:(NSTimeZone *)timezone
{
	// If the date formatters aren't already set up, create them and cache them for reuse.
	static NSDateFormatter *dateFormatter = nil;
	if (dateFormatter == nil)
	{
		dateFormatter = [[NSDateFormatter alloc] init];
		
		[dateFormatter setDateStyle: NSDateFormatterFullStyle];
		[dateFormatter setTimeStyle: NSDateFormatterNoStyle];
	}
	NSTimeZone *localTimezone = [NSTimeZone localTimeZone];
	dateFormatter.timeZone = timezone ?: localTimezone;
	dateFormatter.doesRelativeDateFormatting = [dateFormatter.timeZone isEqual:localTimezone];
	NSString *formattedDateString = [dateFormatter stringFromDate:self].capitalizedString;
	if ([dateFormatter.timeZone.abbreviation isEqual:localTimezone.abbreviation] == NO)
		formattedDateString = [NSString stringWithFormat:@"%@ %@", formattedDateString, timezone.abbreviation];
	return  formattedDateString;
}

-(NSString *)localizedDateAndTime:(NSTimeZone *)timezone
{
	// If the date formatters aren't already set up, create them and cache them for reuse.
	static NSDateFormatter *dateFormatter = nil;
	if (dateFormatter == nil)
	{
		dateFormatter = [[NSDateFormatter alloc] init];
		
		[dateFormatter setDateStyle: NSDateFormatterFullStyle];
		[dateFormatter setTimeStyle: NSDateFormatterMediumStyle];
	}
	NSTimeZone *localTimezone = [NSTimeZone localTimeZone];
	dateFormatter.timeZone = timezone ?: localTimezone;
	dateFormatter.doesRelativeDateFormatting = [dateFormatter.timeZone isEqual:localTimezone];
	NSString *formattedDateString = [dateFormatter stringFromDate:self].capitalizedString;
	if ([dateFormatter.timeZone.abbreviation isEqual:localTimezone.abbreviation] == NO)
		formattedDateString = [NSString stringWithFormat:@"%@ %@", formattedDateString, timezone.abbreviation];
	return  formattedDateString;
}

-(NSString *)localizedShortDayOfWeek
{
	// If the date formatters aren't already set up, create them and cache them for reuse.
	static NSDateFormatter *dowFormatter = nil;
	
	if (dowFormatter == nil) {
		dowFormatter = [[NSDateFormatter alloc] init];
		[dowFormatter setDateFormat: @"EEE"];
	}
	NSString *dayOfWeek = [dowFormatter stringFromDate: self];
	
	return dayOfWeek.capitalizedString;
}

-(NSString *)localizedMonth
{
	// If the date formatters aren't already set up, create them and cache them for reuse.
	
	static NSDateFormatter *monthFormatter = nil;
	
	if (monthFormatter == nil) {
		monthFormatter = [[NSDateFormatter alloc] init];
		[monthFormatter setDateFormat: @"MMMM"];
	}
	
	NSString *month = [monthFormatter stringFromDate: self];
	
	return month.capitalizedString;
}

-(NSString *)localizedHour:(NSTimeZone *)timezone
{
	// If the date formatters aren't already set up, create them and cache them for reuse.
	static NSDateFormatter *hourFormatter = nil;
	if (hourFormatter == nil)
	{
		hourFormatter = [[NSDateFormatter alloc] init];
		
		[hourFormatter setDateStyle: NSDateFormatterNoStyle];
		[hourFormatter setTimeStyle: NSDateFormatterShortStyle];
		
	}
	NSTimeZone *localTimezone = [NSTimeZone localTimeZone];
	hourFormatter.timeZone = timezone ?: localTimezone;
	NSString *formattedDateString = [hourFormatter stringFromDate: self];
	return  formattedDateString;
}

-(NSString*)shortLocalizedDateAndTimeAlaWhatsApp
{
	/*
	 ** se è today metti solo ora
	 ** se è ieri o metti "ieri" o metti "yesterday"
	 ** poi per i 6 giorni precedenti metti il giorno della settimana
	 ** prima ancora (ma sempre stesso anno) metti la data nel formato 01 jul at 19:36 (quindi giorno in cifre, mese con tre lettere secondo traduzione) ed ora
	 ** se cambia anno metterai anche l'anno prima
	 */
	
	NSDate *today = [NSDate date];// not optimal, but in this way we take no risks..
	NSString *hour = [self localizedHour:nil];
	NSString *locFormat = NSLocalizedString(@"%@ @ %@", nil);
	
	if ([self compareYMD: today] == NSOrderedSame)
	{
		return  hour;
	}
	
	NSDate * yesterday = [today addDays: -1];
	if ([self compareYMD: yesterday] == NSOrderedSame)
	{
		return [NSString stringWithFormat: locFormat, NSLocalizedString(@"Yesterday", nil), hour];
	}
	NSString *formattedDateString;
	NSInteger days = [today daysBetween: self];
	if (days >= -6)
	{
		return [NSString stringWithFormat: locFormat, [self localizedShortDayOfWeek], hour];
	}
	
	// If the date formatters aren't already set up, create them and cache them for reuse.
	static NSDateFormatter *whatsAppFormatter = nil;
	
	if (whatsAppFormatter == nil)
	{
		whatsAppFormatter = [[NSDateFormatter alloc] init];
	}
	
	NSInteger currYear = [today year];
	NSInteger year = [self year];
	if (currYear == year)
		[whatsAppFormatter setDateFormat:@"dd MMMM"];
	else
		[whatsAppFormatter setDateFormat:@"dd MMMM yyyy"];
	
	formattedDateString = [whatsAppFormatter stringFromDate: self];
	
	formattedDateString  = [NSString stringWithFormat: locFormat, formattedDateString.capitalizedString, [self localizedHour:nil]];
	return  formattedDateString;
}

#pragma mark comparing dates using Y/M/d:

-(NSComparisonResult)compareYMD:(NSDate *)other
{
    //typedef NS_ENUM(NSInteger, NSComparisonResult) {NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending};
    
    if (other == nil){
        // never here...
        return NSOrderedAscending;  // fake ...
    }
    
    NSCalendar * comparisonCalendar = [NSCalendar currentCalendar];
    NSDateComponents* components1 = [comparisonCalendar
                                components: NSCalendarUnitDay |
                                kCFCalendarUnitMonth |
                                kCFCalendarUnitYear
                                fromDate: self];
    
    NSDateComponents* components2 = [comparisonCalendar
                                components: NSCalendarUnitDay |
                                kCFCalendarUnitMonth |
                                kCFCalendarUnitYear
                                fromDate: other];
    
    NSInteger year1 = [components1 year];
    NSInteger month1 = [components1 month];
    NSInteger day1 = [components1 day];
    
    NSInteger year2 = [components2 year];
    NSInteger month2 = [components2 month];
    NSInteger day2 = [components2 day];
    
    // use some math:
    NSInteger n1 = year1 * 2000 + month1 * 100 + day1;
    NSInteger n2 = year2 * 2000 + month2 * 100 + day2;
    
    if (n1 > n2)
        return NSOrderedDescending;
    
    if (n1 < n2)
        return NSOrderedAscending;
    
    
    return NSOrderedSame;
}

-(NSDate*)clearHMS
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
	
    NSDateComponents *components = [calendar
                                    components: NSCalendarUnitDay |
                                    kCFCalendarUnitMonth |
                                    kCFCalendarUnitYear
                                    fromDate: self];
    
    // we do clear hh:m:ss as we do not asked for them.
    //    NSInteger year = [components month];
    //    NSInteger month = [components month];
    //    NSInteger day = [components day];
    
    NSDate* d = [calendar dateFromComponents:components];
	/*
	NSDateComponents *components = [[NSCalendar currentCalendar]
									components: NSCalendarUnitHour |
									kCFCalendarUnitMinute |
									kCFCalendarUnitSecond
									fromDate: self];

	NSTimeInterval hms = components.hour * 60 * 60 + components.minute * 60 + components.second;
	NSDate *d = [self dateByAddingTimeInterval:-hms];
	*/
    
    return d;
}




-(NSDate*)addDays: (NSInteger)days
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents*  components = [cal components:
                                     NSCalendarUnitYear |
                                     NSCalendarUnitMonth |
                                     NSCalendarUnitDay |
                                     NSCalendarUnitWeekday
                                           fromDate: self];
    
    //NSInteger weekday = components.weekday;
    //    NSInteger year = [components month];
    //    NSInteger month = [components month];
    //    NSInteger day = [components day];
    
    // we do clear hh:m:ss as we do not asked for them.
    
    components.day += days;
    NSDate* day = [cal dateFromComponents: components];
    return day;
}

-(NSDate*)endOfDay
{
    NSCalendar * clearAndSetHMSCalendar = [NSCalendar currentCalendar];
    
    NSDateComponents* components = [clearAndSetHMSCalendar
                               components: NSCalendarUnitDay |
                               kCFCalendarUnitMonth |
                               kCFCalendarUnitYear
                               fromDate: self];
    
    //    NSInteger year = [components month];
    //    NSInteger month = [components month];
    //    NSInteger day = [components day];
    // force hh:mm:ss :
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    
    NSDate* d = [clearAndSetHMSCalendar dateFromComponents: components];
    return d;
}


#pragma mark on week:



-(NSDate*)firstDayOfWeekAsDate;
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    [cal setTimeZone:[NSTimeZone localTimeZone]];

    NSDateComponents*  components = [cal components:
                                NSCalendarUnitYear |
                                NSCalendarUnitMonth |
                                NSCalendarUnitDay |
                                NSCalendarUnitWeekday
                                      fromDate: self];

    NSInteger weekday = components.weekday;
    NSTimeInterval delta = weekday-2;   // monday is 2
    if (weekday == 1)  // Sunday
        delta = 6;
    
    //    NSInteger year = [components month];
    //    NSInteger month = [components month];
    //    NSInteger day = [components day];
    
    // we do clear hh:m:ss as we do not asked for them.
    
    // go back:
    components.day -=delta;
    NSDate* firstDayOfWeek = [cal dateFromComponents: components];
//was:    NSDate * firstDayOfWeek = [cleaned dateByAddingTimeInterval: -delta * ONE_DAY]; // wrong!
    return firstDayOfWeek;
}


-(NSDate*)lastDayOfWeekAsDate;
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    [cal setTimeZone:[NSTimeZone localTimeZone]];

    NSDateComponents*  components = [cal components:
                                NSCalendarUnitYear |
                                NSCalendarUnitMonth |
                                NSCalendarUnitDay |
                                NSCalendarUnitWeekday
                                      fromDate: self];
 
    // NSInteger day = [components day];
    NSInteger weekday = [components weekday]; // monday is 2, so wed is 4.
    NSTimeInterval delta = (7 - weekday)+1;
    if (weekday == 1)  // Sunday
        delta = 0;
    

    // go back:
    components.day += delta;
    NSDate* lastDayOfWeek = [cal dateFromComponents: components];
    //was: NSDate * lastDayOfWeek = [cleaned dateByAddingTimeInterval: delta * ONE_DAY]; wrong!
    
    return lastDayOfWeek;
}


#pragma mark month/day


-(NSInteger)day;
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    
    NSDateComponents*  components = [cal components:
                                     // NSCalendarUnitYear |
                                     // NSCalendarUnitMonth |
                                     NSCalendarUnitDay
                                     // NSCalendarUnitWeekday
                                           fromDate: self];
    NSInteger day = [components day];
    return day;
}


-(NSInteger)month;
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    
    NSDateComponents*  components = [cal components:
                                     // NSCalendarUnitYear |
                                     NSCalendarUnitMonth
                                     // NSCalendarUnitDay
                                     //NSCalendarUnitWeekday
                                           fromDate: self];
    //NSInteger day = [components day];
    
    NSInteger month = [components month];
    return month;
}

#pragma mark on month:




-(NSDate*)addMonths: (NSInteger)months
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents*  components = [cal components:
                                     NSCalendarUnitYear |
                                     NSCalendarUnitMonth |
                                     NSCalendarUnitDay |
                                     NSCalendarUnitWeekday
                                           fromDate: self];
    
    //NSInteger weekday = components.weekday;
    //    NSInteger year = [components month];
    //    NSInteger month = [components month];
    //    NSInteger day = [components day];
    
    // we do clear hh:m:ss as we do not asked for them.
    
    components.month += months;
    NSDate* day = [cal dateFromComponents: components];
    return day;
}


-(NSDate*)firstDayOfMonthAsDate;
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    [cal setTimeZone:[NSTimeZone localTimeZone]];
    NSDateComponents*  components = [cal components:
                                NSCalendarUnitYear |
                               NSCalendarUnitMonth
                               // NSCalendarUnitDay
                                //NSCalendarUnitWeekday
                                      fromDate: self];
    //NSInteger day = [components day];

    [components setDay: 1];
    NSDate * firstDayOfMonth = [cal dateFromComponents : components];
    return firstDayOfMonth;
}


-(NSDate*)lastDayOfMonthAsDate;
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    [cal setTimeZone:[NSTimeZone localTimeZone]];

    NSDateComponents*  components = [cal components:
                                     NSCalendarUnitYear |
                                     NSCalendarUnitMonth|
                                     NSCalendarUnitDay
                                           fromDate: self];
	
    NSRange daysRange = [cal
                         rangeOfUnit: NSCalendarUnitDay
                         inUnit: NSCalendarUnitMonth
                         forDate: self];
    
    // daysRange.length will contain the number of the last day
    // of the month containing curDate
    NSInteger lastDay = daysRange.length;
	
    [components setDay:lastDay];
    
    NSDate * lastDayOfMonth = [cal dateFromComponents:components];
    
    return lastDayOfMonth;
}


-(NSInteger)daysInMonth;
{
    NSCalendar * cal = [NSCalendar currentCalendar];
/*
    NSDateComponents*  components = [cal components:
                                     // NSCalendarUnitYear |
                                     NSCalendarUnitMonth|
                                     NSCalendarUnitDay
                                     //NSCalendarUnitWeekday
                                           fromDate: self];
*/
    NSRange daysRange = [cal
                         rangeOfUnit: NSCalendarUnitDay // was: NSDayCalendarUnit
                         inUnit: NSCalendarUnitMonth // was: NSMonthCalendarUnit
                         forDate: self];
    
    // daysRange.length will contain the number of the last day
    // of the month containing curDate
    NSInteger lastDay = daysRange.length;
    return lastDay;
}





-(NSDate *)firstDayOfWeekOfMonthAsDateGoingInPreviousMonthIfNeeded
{
    NSDate * firstDayOfMonth = [self firstDayOfMonthAsDate];
    firstDayOfMonth = [firstDayOfMonth firstDayOfWeekAsDate];
    return firstDayOfMonth;
}

-(NSDate *)lastDayOfWeekOfMonthAsDateGoingInNextMonthIfNeeded
{
    NSDate * lastDayOfMonth = [self lastDayOfMonthAsDate];
    lastDayOfMonth = [lastDayOfMonth lastDayOfWeekAsDate];
	
    return lastDayOfMonth;
}

// positive if otherDate > self
// note: between today and today it gives back 0.
// modified form original code.
- (NSInteger)daysBetween:(NSDate *)otherDate;
{
    NSUInteger unitFlags = NSCalendarUnitDay;
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = self.timeIntervalSince1970 > otherDate.timeIntervalSince1970
		? [calendar components:unitFlags fromDate:self.endOfDay toDate: otherDate.clearHMS options:0]
		: [calendar components:unitFlags fromDate:self.clearHMS toDate: otherDate.endOfDay options:0];
    // original code was: return components.day+1;
//#warning ROB: OKKIO, ho rimesso il +1 ma questa funzione è usata in parecchi posti, bisogna fare un regression test
	return components.day /*+ (components.day > 0 ? 1 : -1)*/;
}

// positive if otherDate > self
// note: between today and today it gives back 0.
// modified form original code.
- (NSInteger)monthsBetween:(NSDate *)otherDate;
{
    NSUInteger unitFlags = NSCalendarUnitMonth;
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:unitFlags fromDate:self toDate: otherDate options:0];
    return components.month;
}

-(NSInteger)year;
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    
    NSDateComponents*  components = [cal components:
                                     NSCalendarUnitYear
                                     // NSCalendarUnitMonth
                                     // NSCalendarUnitDay
                                     //NSCalendarUnitWeekday
                                           fromDate: self];
    
    NSInteger year = [components year];
    return year;
}

@end
