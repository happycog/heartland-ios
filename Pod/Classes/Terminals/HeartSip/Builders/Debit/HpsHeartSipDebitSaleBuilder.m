	//  Copyright (c) 2017 Heartland Payment Systems. All rights reserved.

#import "HpsHeartSipDebitSaleBuilder.h"
#import "HpsHeartSipRequest.h"
@interface HpsHeartSipDebitSaleBuilder()

@property (readwrite, strong) NSString  *cardGroup;
@property (readwrite, strong) NSNumber *version;
@property (readwrite, strong) NSString *ecrId;
@property (readwrite, strong) NSNumber *confirmAmount;
@property (readwrite, strong) NSNumber *invoiceNbr;
@property (readwrite, strong) NSNumber *baseAmount;
@property (readwrite, strong) NSNumber *taxAmount;
@property (readwrite, strong) NSNumber *totalAmount;
@property (readwrite, strong) NSString *serverLabel;

@end

@implementation HpsHeartSipDebitSaleBuilder

- (id)initWithDevice: (HpsHeartSipDevice*)HeartSipDevice{
	self = [super init];
	if (self != nil)
		{
		device = HeartSipDevice;
		self.version = [NSNumber numberWithDouble:1.0];
		self.ecrId = @"1004";
		self.confirmAmount = [NSNumber numberWithDouble:0];
		self.cardGroup = @"Debit";
		}
	return self;
}

- (void) execute:(void(^)(id<IHPSDeviceResponse>, NSError*))responseBlock{

	self.invoiceNbr = [NSNumber numberWithInteger:self.referenceNumber];
	self.totalAmount = [NSNumber numberWithFloat:(self.amount.doubleValue * 100)] ;
	[self validate];
	HpsHeartSipRequest *request_sale = [[HpsHeartSipRequest alloc]
										initWithDebitSaleRequestwithVersion:(self.version.stringValue ? self.version.stringValue :@"1.0")
										withEcrId:( self.ecrId ? self.ecrId :@"1004")
										withRequest:HSIP_MSG_ID_toString[CREDIT_SALE]
										withCardGroup:self.cardGroup
										withConfirmAmount:(self.confirmAmount.stringValue ?self.confirmAmount.stringValue :@"0")
										withInvoiceNbr:(self.invoiceNbr.stringValue ? self.invoiceNbr.stringValue :nil)
										withBaseAmount:(self.baseAmount.stringValue ?self.baseAmount.stringValue :nil)
										withTaxAmount:(self.taxAmount.stringValue ?self.taxAmount.stringValue :nil)
										withTotalAmount:(self.totalAmount.stringValue ? self.totalAmount.stringValue :nil)
										withServerLabel:(self.serverLabel ? self.serverLabel :nil)];

	request_sale.RequestId = self.referenceNumber;

	[device processTransactionWithRequest:request_sale withResponseBlock:^(id<IHPSDeviceResponse> respose, NSError *error)
	 {
	 dispatch_async(dispatch_get_main_queue(), ^{
		 responseBlock(respose, error);
	 });
	 }];
}

-(void) validate{
	if (self.totalAmount == nil || self.totalAmount.doubleValue <= 0)
		{
		@throw [NSException exceptionWithName:@"HpsHeartSipException" reason:@"Amount is required." userInfo:nil];
		}
}

@end
