//
//  ContactsData.m
//  FunBookMobile.iOS
//
//  Created by Admin on 11/10/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "ContactsData.h"
#import <AddressBook/ABAddressBook.h>
#import <AddressBook/ABSource.h>
#import <AddressBook/ABPerson.h>
#import <AddressBook/ABGroup.h>
#import <AddressBook/ABRecord.h>
#import <AddressBook/ABMultiValue.h>

@implementation ContactsData
-(NSDictionary*) contactsForEmailsDict {
    CFErrorRef *error = nil;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    
    __block BOOL accessGranted = NO;
    
    if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else { // we're on iOS 5 or older
        accessGranted = YES;
    }
    
    if (accessGranted) {
        NSLog(@"Fetching contact info ----> ");
        
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        ABRecordRef source = ABAddressBookCopyDefaultSource(addressBook);
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(addressBook, source, kABPersonSortByFirstName);
        
        CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
        NSMutableDictionary* emailsToContacts = [NSMutableDictionary dictionary];
        
        for (int i = 0; i < nPeople; i++)
        {
            ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
            
            //get Phone Numbers
            NSMutableArray *phoneNumbers = [[NSMutableArray alloc] init];
            ABMultiValueRef multiPhones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
            for(CFIndex i=0;i<ABMultiValueGetCount(multiPhones);i++) {
                CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(multiPhones, i);
                NSString *phoneNumber = (__bridge NSString *) phoneNumberRef;
                [phoneNumbers addObject:phoneNumber];
            }
            
            //get Contact email and for each one add all gathered phones
            ABMultiValueRef multiEmails = ABRecordCopyValue(person, kABPersonEmailProperty);
            
            for (CFIndex i=0; i<ABMultiValueGetCount(multiEmails); i++) {
                CFStringRef contactEmailRef = ABMultiValueCopyValueAtIndex(multiEmails, i);
                NSString *contactEmail = (__bridge NSString *)contactEmailRef;
                
                for (NSInteger i = 0; i < phoneNumbers.count; i++) {
                    [emailsToContacts setObject:phoneNumbers[i] forKey:contactEmail];
                }
            }
        }
        return emailsToContacts;
    } else {
        NSLog(@"Cannot fetch Contacts :( ");
        return nil;
    }
}

@end
