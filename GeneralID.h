//
//  GeneralID.h
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


#import <Foundation/Foundation.h>

@interface GeneralID : NSObject


#pragma mark - Inits

///
/// Generate a general ID object with a random ID.
/// @return A general ID object with a random ID.
///
+ (id)generateID;

///
/// Initialize a general ID object with a random ID.
/// @return A general ID object wtih a random ID.
///
- (id)init;

///
/// Returns a general ID created by GUID string.
/// @param guidString A GUID string.
/// @return A general ID from GUID string.
///
- (id)initWithGUIDString:(NSString *)guidString;

///
/// Returns a general ID created by UUID string.
/// @param uuidString A UUID string.
/// @return A General ID from UUID string.
///
- (id)initWithUUIDString:(NSString *)uuidString;

///
/// Returns a general ID created by input data.
/// @param data Input data.
/// @return A general ID from data.
///
- (id)initWithData:(NSData *)data;


#pragma mark - Properties

/// An ID data.
@property (nonatomic, strong) NSData *ID;


#pragma mark - Methods

///
/// Returns a GUID string for the general ID.
/// @return A GUID string.
///
- (NSString *)GUIDString;

///
/// Returns a UUID string for the general ID.
/// @return A UUID string.
///
- (NSString *)UUIDString;


@end
