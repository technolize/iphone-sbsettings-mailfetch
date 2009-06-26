//
//  MailFetchToggle.m
//  MailFetchToggle
//
//  Created by Eiji Kato a.k.a. technolize
//

#import <Foundation/Foundation.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_2_2
  #define PREF_FILE @"/var/mobile/Library/Preferences/com.apple.persistentconnection-mcc.plist"
#else
  #define PREF_FILE @"/var/mobile/Library/Preferences/com.apple.persistentconnection.plist"
#endif
#define TMP_FILE @"/var/mobile/Library/SBSettings/Toggles/MailFetch/interval.plist"

BOOL isCapable() {
  return YES;
}

BOOL isEnabled() {
  NSDictionary *pref = [[NSDictionary alloc] initWithContentsOfFile:PREF_FILE];
  BOOL flag = [[pref objectForKey:@"PCDefaultPollInterval"] boolValue];
  [pref release];
  return flag;
}

BOOL getStateFast() {
  return isEnabled();
}

void setState(BOOL enable) {
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  NSMutableDictionary *pref = [NSMutableDictionary dictionaryWithContentsOfFile:PREF_FILE];
  NSMutableDictionary *tmp;
  NSNumber *interval;
  
  if (enable) {
    tmp = [NSMutableDictionary dictionaryWithContentsOfFile:TMP_FILE];
    interval = [tmp objectForKey:@"interval"];
    if (interval == nil || [interval intValue] < 900)
      interval = [NSNumber numberWithInt:900];
  }
  else {
    interval = [NSNumber numberWithInt:0];
    tmp = [NSMutableDictionary dictionaryWithObject:[pref objectForKey:@"PCDefaultPollInterval"]
                                             forKey:@"interval"];
    [tmp writeToFile:TMP_FILE atomically:YES];
  }
  
  [pref setValue:interval forKey:@"PCDefaultPollInterval"];
  [pref writeToFile:PREF_FILE atomically:YES];
  [pool release];
}

float getDelayTime() {
  return 0.5f;
}