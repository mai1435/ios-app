#import "RealmHelper.h"

#define CURRENT_REALM_SCHEMA_VERSION 1

@implementation RealmHelper

#pragma mark - Init


+ (NSString *)defaultRealmName
{
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    return [bundleIdentifier stringByAppendingString:@".default-realm"];        // Es: com.company.appname.default-realm
}

+ (void)setDefaultRealm
{
	[self initializeRealmForUserKey:[[self class] defaultRealmName] setAsDefault:YES];
}

+ (RLMRealm *)realmForUserKey:(NSString *)userKey
{
    return [self initializeRealmForUserKey:userKey setAsDefault:NO];
}

+ (RLMRealm *)initializeRealmForUserKey:(NSString *)userKey setAsDefault:(BOOL)setAsDefault
{
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    
    // File path and database name
    NSString *filePath = [NSString stringWithFormat:@"%@", config.fileURL];
    NSString *realmName = userKey;
    if (!realmName || [realmName isEqualToString:@""])
    {
        realmName = [[self class] defaultRealmName];
    }

    config.fileURL = [NSURL URLWithString:[[[filePath stringByDeletingLastPathComponent]
                                            stringByAppendingPathComponent:realmName]
                                           stringByAppendingPathExtension:@"realm"]];
    
    // Migration
    config.schemaVersion = CURRENT_REALM_SCHEMA_VERSION;
    // Set the block which will be called automatically when opening a Realm with a
    // schema version lower than the one set above
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        [[self class] migrateRealmWithMigration:migration oldSchemaVersion:oldSchemaVersion];
    };
    
    /*
#ifdef DEBUG
    [config setDeleteRealmIfMigrationNeeded:YES];
#endif
     */
    
    // Create/retrieve the Realm
    NSError *error = nil;
    RLMRealm *realm = [RLMRealm realmWithConfiguration:config error:&error];
    if (!realm || error)
    {
        // If the encryption key is wrong, `error` will say that it's an invalid database
        NSLog(@"Error opening realm: %@", error);
    }
    
    if (realm && realm.configuration)
    {
        if (setAsDefault)
        {
            // Set this Realm as default
            [RLMRealmConfiguration setDefaultConfiguration:config];
        }
    }
    else
    {
        return nil;
    }
    
    return realm;
}

#pragma mark - Migration


+ (void)migrateRealmWithMigration:(RLMMigration *)migration oldSchemaVersion:(uint64_t)oldSchemaVersion
{
    // We haven’t migrated anything yet, so oldSchemaVersion == 0
    NSInteger currentSchemaVersion = CURRENT_REALM_SCHEMA_VERSION;
    if (oldSchemaVersion < currentSchemaVersion)
    {
        // Nothing to do!
        // Realm will automatically detect new properties and removed properties
        // And will update the schema on disk automatically
		NSLog(@"Realm Migration from schema %d to schema %d", (int)oldSchemaVersion, (int)currentSchemaVersion);
        
        /*
         NSInteger schemaVersion = oldSchemaVersion;
         
         if (schemaVersion <= 1)     // 1 -> 2
         {
             // Do something...
             schemaVersion++;
         }
         if (schemaVersion <= 2)     // 2 -> 3
         {
             // Do something...
             schemaVersion++;
         }
         if (schemaVersion <= 3)     // 3 -> 4
         {
             // Do something...
             schemaVersion++;
         }
         // ...
         */
    }
}




#pragma mark - General


+ (void)deleteItem:(RLMObject *)item
{
    if (item && !item.isInvalidated)
    {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            [realm deleteObject:item];
        }];
    }
}

+ (void)deleteItems:(NSArray *)items
{
    if (items && items.count > 0)
    {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            [realm deleteObjects:items];
        }];
    }
}


+ (BOOL)storePosition:(RPosition *)position
{
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            [realm addObject:position];
        }];
        return YES;
}

+ (RLMResults<RPosition *> *)retrieveAllPositions
{
    RLMResults *res = [RPosition allObjects];
    // Sort results
    return [res sortedResultsUsingKeyPath:@"timestamp" ascending:YES];
}


@end
