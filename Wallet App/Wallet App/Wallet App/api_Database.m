//
//  api_Database.m
//  APITesting
//
//  Created by Taimur Mushtaq on 10/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "api_Database.h"
#import "NSData+AESCrypt.h"
@implementation api_Database

@synthesize  databasePath, databaseName, dataArray;

+(NSString *) getDatabasePath:(NSString *)dbName
{
    // Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
   // NSLog(@"path:%@",[documentsDir stringByAppendingPathComponent:dbName]);
    return [documentsDir stringByAppendingPathComponent:dbName];
}

+(void)checkAndCreateDB:(NSString *)dbName dbPath:(NSString *)dbPath
{
    BOOL success;
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	success = [fileManager fileExistsAtPath:dbPath];
	if(success)
    return;
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
	[fileManager copyItemAtPath:databasePathFromApp toPath:dbPath error:nil];
}
+(void)createTable:(NSString *)querry dbName:(NSString *)dbName
{
   sqlite3_stmt *createStmt = nil;
    sqlite3 *database;
    if (sqlite3_open([[self getDatabasePath:dbName] UTF8String], &database) == SQLITE_OK) {
        if (createStmt == nil)
            if (sqlite3_prepare_v2(database, [querry UTF8String], -1, &createStmt, NULL) != SQLITE_OK) {
                NSLog(@"Error querry : %@",querry);
            }
            sqlite3_exec(database, [querry UTF8String], NULL, NULL, NULL);
                NSLog(@"Table created querry : %@",querry);
        }
}


+(NSMutableArray *) selectDataFromDatabase:(NSString *)dbname query:(NSString *)query
{
    NSMutableArray *mainArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *subDic = [[NSMutableDictionary alloc] init];
    //NSLog(@"%@", query);
    //NSMutableArray *subArray = [[NSMutableArray alloc] init];
    
    NSString *dbPath = [api_Database getDatabasePath:dbname];
    [api_Database checkAndCreateDB:dbname dbPath:dbPath];
  //  NSLog(@"dbPath :%@", dbPath);
    sqlite3 *database;
    NSString * myRowData=[[NSString alloc] initWithFormat:@"%@",@""];
    
	const char *sqlStatement;
    int columnCounter=0;
	// Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) 
    {
        sqlStatement=[[NSString stringWithFormat:@"%@",query ] UTF8String];
        
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
        {
            columnCounter=sqlite3_column_count(compiledStatement);
            
			while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                for(int i=0;i<columnCounter;i++)
                {
                    //NSString * test = @"Test";
                    
                    NSString * test = ((char *)sqlite3_column_text(compiledStatement, i))  ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, i)] : @"";
                    NSString * colName = [NSString stringWithUTF8String:(char *)sqlite3_column_name(compiledStatement, i)];
                    myRowData = [myRowData stringByAppendingString:test];
                    
                    if(i != columnCounter )
                    {
                        [subDic setObject:myRowData forKey:colName];
                        myRowData = [[NSString alloc] initWithFormat:@""];
                    }
                }
                
                [mainArray addObject:subDic];
                subDic = nil;
                subDic = [[NSMutableDictionary alloc] init];
                
			}
            
		}
		
		sqlite3_finalize(compiledStatement);
	}
    
	sqlite3_close(database);
    return mainArray;
    
}

#pragma ALL DB METHODS FOR PART SECTION - by Tushar Navadiya

+(NSMutableDictionary *) selectSingleDataFromDatabase:(NSString *)dbname query:(NSString *)query
{
    NSMutableDictionary *subDic = [[NSMutableDictionary alloc] init];
    //NSLog(@"%@", query);
    //NSMutableArray *subArray = [[NSMutableArray alloc] init];
    
    NSString *dbPath = [api_Database getDatabasePath:dbname];
    [api_Database checkAndCreateDB:dbname dbPath:dbPath];
    
    sqlite3 *database;
    NSString * myRowData=[[NSString alloc] initWithFormat:@"%@",@""];
    
	const char *sqlStatement;
    int columnCounter=0;
	// Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        sqlStatement=[[NSString stringWithFormat:@"%@",query] UTF8String];
        
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            columnCounter=sqlite3_column_count(compiledStatement);
			while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                for(int i=0;i<columnCounter;i++)
                {
                    //NSString * test = @"Test";
                    
                    NSString * test = ((char *)sqlite3_column_text(compiledStatement, i))  ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, i)] : @"";
                    NSString * colName = [NSString stringWithUTF8String:(char *)sqlite3_column_name(compiledStatement, i)];
                    myRowData = [myRowData stringByAppendingString:test];
                    
                    if(i != columnCounter )
                    {
                        [subDic setObject:myRowData forKey:colName];
                        myRowData = [[NSString alloc] initWithFormat:@""];
                    }
                }
			}
		}
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
    return subDic;
}

#pragma END by Tushar Navadiya

+(BOOL)genericQueryforDatabase:(NSString *)dbname query:(NSString *)query
{
   NSLog(@"%@",query);
    NSString *dbPath = [api_Database getDatabasePath:dbname];
    [api_Database checkAndCreateDB:dbname dbPath:dbPath];
    
    BOOL resultCheck = false;
    
    sqlite3 *database;
    
	const char *sqlStatement;
    
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
        sqlStatement=[[NSString stringWithFormat:@"%@",query ] UTF8String];
        
		sqlite3_stmt *compiledStatement;
		
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
        {
            if(sqlite3_step(compiledStatement) == SQLITE_OK) 
            {
                resultCheck = false;
                
			}else
                
            {
                resultCheck = true;
            }
        }
        
		sqlite3_finalize(compiledStatement);
	}
    
	sqlite3_close(database);
    return resultCheck;
    
}

+(NSString *)NullSafeValue:(const char *)val{
    if (val == nil) {
        return @"";
    }else{
        return [NSString stringWithUTF8String:val];
    }
}
+(BOOL)validEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(NSString *)generateRandomnumber
{
    int randomID = arc4random() % 9000 + 1000;
    NSString *tmpstr = [NSString stringWithFormat:@"%d",randomID];
    return tmpstr;
}

//Encryption Methods
+(NSString *)encryptedString : (NSString *)strForEnrypt :(NSString *)key
{
    //Encryption
    NSData *value = [strForEnrypt dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [value AES128EncryptWithKey:key];
    //NSString *myString = [encryptedData base64EncodedStringWithOptions:NSUTF8StringEncoding];
    return [encryptedData base64EncodedStringWithOptions:NSUTF8StringEncoding];
}
+(NSString *)decryptedString : (NSString *)strForDecrypt :(NSString *)key
{
    //Decryption
    NSData *myData = [self base64DataFromString:strForDecrypt];
    NSData *decryptedData = [myData AES128DecryptWithKey:key];
    //NSString *myString2 = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    return [[NSString alloc] initWithData:decryptedData
                                 encoding:NSUTF8StringEncoding];
}
+ (NSData *)base64DataFromString: (NSString *)string
{
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[3];
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;
    
    if (string == nil){
        return [NSData data];
    }
    
    ixtext = 0;
    tempcstring = (const unsigned char *)[string UTF8String];
    lentext = [string length];
    theData = [NSMutableData dataWithCapacity: lentext];
    ixinbuf = 0;
    
    while (true){
        if (ixtext >= lentext){
            break;
        }
        
        ch = tempcstring [ixtext++];
        flignore = false;
        
        if ((ch >= 'A') && (ch <= 'Z')){
            ch = ch - 'A';
        } else if ((ch >= 'a') && (ch <= 'z')){
            ch = ch - 'a' + 26;
        } else if ((ch >= '0') && (ch <= '9')){
            ch = ch - '0' + 52;
        } else if (ch == '+'){
            ch = 62;
        } else if (ch == '=') {
            flendtext = true;
        } else if (ch == '/') {
            ch = 63;
        } else {
            flignore = true;
        }
        
        if (!flignore){
            short ctcharsinbuf = 3;
            Boolean flbreak = false;
            
            if (flendtext){
                if (ixinbuf == 0){
                    break;
                }
                
                if ((ixinbuf == 1) || (ixinbuf == 2)) {
                    ctcharsinbuf = 1;
                } else {
                    ctcharsinbuf = 2;
                }
                
                ixinbuf = 3;
                flbreak = true;
            }
            
            inbuf [ixinbuf++] = ch;
            
            if (ixinbuf == 4){
                ixinbuf = 0;
                
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                
                for (i = 0; i < ctcharsinbuf; i++) {
                    [theData appendBytes: &outbuf[i] length: 1];
                }
            }
            
            if (flbreak) {
                break;
            }
        }
    }
    
    return theData;
}
//    //Date Formater
//    @lazy var dateFormatter: NSDateFormatter = {
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateStyle = .MediumStyle
//        dateFormatter.timeStyle = .ShortStyle
//        return dateFormatter
//        }()
@end
