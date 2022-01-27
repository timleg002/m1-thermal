//
//  thermal-Bridging-Header.h
//  thermal
//
//  Created by timko on 22/08/2021.
//

#ifndef thermal_Bridging_Header_h
#define thermal_Bridging_Header_h

#import <IOKit/hidsystem/IOHIDEventSystemClient.h>
#import <Foundation/Foundation.h>

typedef struct __IOHIDEvent *IOHIDEventRef;
typedef struct __IOHIDServiceClient *IOHIDServiceClientRef;

IOHIDEventSystemClientRef IOHIDEventSystemClientCreate(CFAllocatorRef allocator);
int IOHIDEventSystemClientSetMatching(IOHIDEventSystemClientRef client, CFDictionaryRef match);
int IOHIDEventSystemClientSetMatchingMultiple(IOHIDEventSystemClientRef client, CFArrayRef match);
IOHIDEventRef IOHIDServiceClientCopyEvent(IOHIDServiceClientRef, int64_t , int32_t, int64_t);
CFTypeRef IOHIDServiceClientCopyProperty(IOHIDServiceClientRef service, CFStringRef key);
double IOHIDEventGetFloatValue(IOHIDEventRef event, int32_t field);
// CFStringRef CFStr(const char* cStr);
CFStringRef __CFStringMakeConstantString();

#endif /* thermal_Bridging_Header_h */
