//
//  GeneralID.m
//
//  Copyright (c) 2013 Ha Minh Vuong
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#import "GeneralID.h"

@implementation GeneralID

+ (id)generateID
{
    uuid_t id_t;
    id i = [NSUUID UUID];
    [i getUUIDBytes:id_t];
    id result = [[self alloc] initWithData:[NSData dataWithBytes:id_t length:16]];
    return result;
}

- (id)init
{
    return [[self class] generateID];
}

- (id)initWithUUIDString:(NSString *)uuidString
{
    if (self = [super init]) {
        id uuid = [[NSUUID alloc] initWithUUIDString:uuidString];
        _ID = [[self class] getDataFromUUID:uuid];
    }
    return self;
}

- (id)initWithGUIDString:(NSString *)guidString
{
    if (self = [super init]) {
        _ID = [[self class] guidDataFromString:guidString];
    }
    return self;
}

- (id)initWithData:(NSData *)data
{
    if (self = [super init]) {
        NSAssert([data length] == 16, @"Invalid data.");
        _ID = data;
    }
    return self;
}

- (NSString *)GUIDString
{
    return [[self class] guidStringFromData:self.ID];
}

- (NSString *)UUIDString
{
    id uuid = [[NSUUID alloc] initWithUUIDBytes:[self.ID bytes]];
    return [uuid UUIDString];
}

#pragma mark - Private

+ (NSData *)getDataFromUUID:(id)UUID
{
    uuid_t id_t;
    [UUID getUUIDBytes:id_t];
    NSData *result = [NSData dataWithBytes:id_t length:16];
    return result;
}

+ (NSString *)guidStringFromData:(NSData *)data
{
    NSAssert([data length] == 16, @"Invalid data.");
    const UInt8 *bytes = [data bytes];
    NSString *result = [NSString stringWithFormat:@"%02X%02X%02X%02X-%02X%02X-%02X%02X-%02X%02X-%02X%02X%02X%02X%02X%02X",
                        bytes[3],bytes[2],bytes[1],bytes[0],bytes[5],bytes[4],bytes[7],bytes[6],
                        bytes[8],bytes[9],bytes[10],bytes[11],bytes[12],bytes[13],bytes[14],bytes[15]];
    return result;
}

+ (NSData *)guidDataFromString:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSAssert([string length] == 32, @"Invalid ID.");
    NSMutableArray *bytes = [NSMutableArray arrayWithCapacity:16];
    for (NSUInteger i = 0; i < 32; i += 2) {
        NSString *str = [string substringWithRange:NSMakeRange(i, 2)];
        [bytes addObject:str];
    }
    bytes = [NSMutableArray arrayWithObjects:bytes[3],bytes[2],bytes[1],bytes[0],bytes[5],bytes[4],bytes[7],bytes[6],
             bytes[8],bytes[9],bytes[10],bytes[11],bytes[12],bytes[13],bytes[14],bytes[15], nil];
    string = [bytes componentsJoinedByString:@""];
    
    NSMutableData *result = [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    for (NSUInteger i = 0; i < [string length]/2; i++) {
        byte_chars[0] = [string characterAtIndex:i*2];
        byte_chars[1] = [string characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [result appendBytes:&whole_byte length:1];
    }
    
    return [NSData dataWithData:result];
}

@end
