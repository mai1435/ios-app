#import <Foundation/Foundation.h>
#import "RPosition.h"

@interface RealmHelper : NSObject


+ (void)setDefaultRealm;
+ (RLMRealm *)realmForUserKey:(NSString *)userKey;
+ (RLMRealm *)initializeRealmForUserKey:(NSString *)userKey setAsDefault:(BOOL)setAsDefault;
+ (NSData *)realmKey;

+ (NSString *)deviceToken;

+ (void)deleteRealmForUserKey:(NSString *)userKey;
+ (void)deleteItem:(RLMObject *)item;
+ (void)deleteItems:(NSArray *)items;

+ (BOOL)storePosition:(RPosition *)position;

+ (RLMResults<RPosition *> *)retrieveAllPositions;

@end
