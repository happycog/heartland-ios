	//  Copyright (c) 2017 Heartland Payment Systems. All rights reserved.

#import "HpsHeartSipCreditVerifyBuilder.h"

@interface HpsHeartSipCreditVerifyBuilder()
@property (readwrite, strong) NSNumber *version;
@property (readwrite, strong) NSString *ecrId;
@property (readwrite, strong) NSString *cardGroup;
@property (nonatomic, strong) NSNumber *totalAmount;
@property (nonatomic, readwrite) NSNumber *invoiceNumber;

@end

@implementation HpsHeartSipCreditVerifyBuilder
- (id)initWithDevice: (HpsHeartSipDevice*)HeartSipDevice{
	self = [super init];
	if (self != nil)
		{
		device = HeartSipDevice;
		self.version = [NSNumber numberWithDouble:1.0];
		self.ecrId = @"1004";
		self.cardGroup = @"Credit";
		}
	return self;
}

- (void) execute:(void(^)(id <IHPSDeviceResponse>, NSError*))responseBlock{
	self.totalAmount = [NSNumber numberWithFloat:(self.amount.doubleValue * 100)] ;
	self.invoiceNumber = [NSNumber numberWithInteger:self.referenceNumber];
	[self validate];
	self.cardGroup = @"Credit";

	HpsHeartSipRequest *request_verify = [[HpsHeartSipRequest alloc]
										  initWithCreditSaleRequestwithVersion:(self.version.stringValue ? self.version.stringValue :@"1.0")
										  withEcrId:( self.ecrId ? self.ecrId :@"1004")
										  withRequest:@"CardVerify"
										  withCardGroup:self.cardGroup
										  withConfirmAmount:nil
										  withInvoiceNbr:nil
										  withBaseAmount:nil
										  withTaxAmount:nil
										  withTotalAmount:nil
										  withServerLabel:nil];
	request_verify.RequestId = self.referenceNumber;

	[device processTransactionWithRequest:request_verify withResponseBlock:^(id<IHPSDeviceResponse> respose, NSError *error){
	 dispatch_async(dispatch_get_main_queue(), ^{
		 responseBlock(respose, error);
	 });

	}];
}

- (void) validate{}

@end
