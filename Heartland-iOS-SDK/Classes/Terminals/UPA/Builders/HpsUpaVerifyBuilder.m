#import "HpsUpaVerifyBuilder.h"

@implementation HpsUpaVerifyBuilder

- (id)initWithDevice: (HpsUpaDevice*)upaDevice{
    self = [super init];
    if (self != nil)
    {
        device = upaDevice;
    }
    return self;
}

- (void) execute:(void(^)(HpsUpaResponse*, NSError*))responseBlock{
    [self validate];

    HpsUpaRequest* request = [[HpsUpaRequest alloc] init];
    request.message = @"MSG";
    request.data = [[HpsUpaCommandData alloc] init];
    request.data.command = UPA_MSG_ID_toString[ UPA_MSG_ID_CARD_VERIFY ];
    request.data.EcrId = self.ecrId;
    if (self.referenceNumber > 0) {
        request.data.requestId = [NSString stringWithFormat:@"%d", self.referenceNumber];
    } else {
        request.data.requestId = [NSString stringWithFormat:@"%d", [device generateNumber]];
    }
    request.data.data = [[HpsUpaData alloc] init];
    
    request.data.data.params = [[HpsUpaParams alloc] init];
    request.data.data.params.clerkId = self.clerkId;
    request.data.data.params.tokenRequest = self.requestMultiUseToken ? @"1" : @"0";
    request.data.data.params.tokenValue = self.token;
    request.data.data.params.cardBrandTransId = self.cardBrandTransactionId;
    if ((self.requestMultiUseToken || self.cardBrandTransactionId != nil) && self.storedCardInitiator != HpsStoredCardInitiator_None) {
        request.data.data.params.cardOnFileIndicator = HpsStoredCardInitiator_toString[self.storedCardInitiator];
    }
    
    request.data.data.transaction.cardIsHSAFSA = self.cardIsHSAFSA ? @"1" : @"0";
    
    [device processTransactionWithRequest:request withResponseBlock:^(id<IHPSDeviceResponse> response, NSString *json, NSError * error) {
        if (error != nil) {
            responseBlock(nil, error);
            return;
        }
        
        responseBlock((HpsUpaResponse*)response, nil);
    }];
}

- (void) validate
{
}

@end
