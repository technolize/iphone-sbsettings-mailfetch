//
//  MailFetchToggle.m
//  MailFetchToggle
//
//  Created by Eiji Kato a.k.a. technolize
//

#import <Foundation/Foundation.h>

#define PREF_FILE @"/var/mobile/Library/Preferences/com.apple.persistentconnection.plist"
#define TMP_FILE @"/var/mobile/Library/SBSettings/Toggles/MailFetch/interval.plist"

BOOL isCapable() {
  return YES;
}

BOOL isEnabled() {
  NSDictionary *pref = [NSDictionary dictionaryWithContentsOfFile:PREF_FILE];
  return [[pref objectForKey:@"PCDefaultPollInterval"] boolValue];
}

BOOL getStateFast() {
  return isEnabled();
}

void setState(BOOL enable) {
  NSMutableDictionary *pref = [NSMutableDictionary dictionaryWithContentsOfFile:PREF_FILE];
  NSMutableDictionary *tmp;
  
  if (enable == YES) {
    NSNumber *interval;
    tmp = [NSMutableDictionary dictionaryWithContentsOfFile:TMP_FILE];
    
    if (tmp == nil) {
      interval = [NSNumber numberWithInt:900];
    }
    else {
      interval = [tmp objectForKey:@"interval"];
    }
    
    [pref setValue:interval forKey:@"PCDefaultPollInterval"];
  }
  else {
    tmp = [NSMutableDictionary dictionaryWithObject:[pref objectForKey:@"PCDefaultPollInterval"] forKey:@"interval"];
    [tmp writeToFile:TMP_FILE atomically:YES];
    [pref setValue:[NSNumber numberWithInt:0] forKey:@"PCDefaultPollInterval"];
  }
  
  [pref writeToFile:PREF_FILE atomically:YES];
}

float getDelayTime() {
  return 0.5f;
}