//
//  NSData+AESCrypt.h
//
//  AES128Encryption + Base64Encoding
//

#import <Foundation/Foundation.h>

@interface NSData (AESCrypt)

- (NSData *)AES128EncryptWithKey:(NSString *)key;
- (NSData*)AES128DecryptWithKey:(NSString *)key;
- (NSString *)base64Encoding;
- (NSData *)base64DataFromString: (NSString *)string;
@end
