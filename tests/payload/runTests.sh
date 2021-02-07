#!/bin/bash

# # # # # # #    Payload Testing    # # # # # # # 
# 
## AWS CLI
# These example tests whether the event pattern matches a specific event. Most services in AWS treat ":" (doublecolon) or "/"" (forward slash) as 
# the same character in Amazon Resource Names (ARNs). However, EventBridge uses an exact match in event patterns and rules. 
# Be sure to use the correct ARN characters when creating event patterns so that they match the ARN syntax in the event that you want to match.
# In these examples, the output would be "true" because the event patters match the respective events

aws events test-event-pattern \
--event-pattern "{\"source\": [\"aws.signin\"],\"detail-type\":[\"AWS Console Sign In via CloudTrail\"]}" \
--event '{"version":"0","id":"1xxx872-1y65-z987-x123-212dff51fe1f","detail-type":"AWS Console Sign In via CloudTrail","source":"aws.signin","account":"C","time":"2021-02-02T09:17:54Z","region":"us-east-1","resources":[],"detail":{"eventVersion":"1.08","userIdentity":{"type":"IAMUser","principalId":"XXXXXXXXXXXXXXXXXXXXXX","accountId":"111111111111","accessKeyId":"","userName":"zzz-yyy-xxx"},"eventTime":"2021-02-02T09:17:54Z","eventSource":"signin.amazonaws.com","eventName":"CheckMfa","awsRegion":"us-east-1","sourceIPAddress":"00.00.00.00","userAgent":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.96 Safari/537.36","requestParameters":null,"responseElements":{"CheckMfa":"Success"},"additionalEventData":{"MfaType":"Virtual MFA"},"eventID":"1xxx872-1y65-z987-x123-212dff51fe1f","readOnly":true,"eventType":"AwsConsoleSignIn","managementEvent":true,"eventCategory":"Management"}}'

aws events test-event-pattern \
--event-pattern "{\"source\": [\"Order Fulfillment Process\"],\"detail-type\":[\"New Order\"]}" \
--event '{"id": "e00c66cb-fe7a-4fcc-81ad-58eb60f5d96b", "detail-type": "New Order", "source": "Order Fulfillment Process", "account": "111111111111", "time": "2021-02-02T09:17:54Z", "region": "us-east-1", "detail": "{\"orderNumber\": \"000001\",\"productId\": \"paxz_001\",\"price\": 10,\"customer\": {\"name\": \"XY\",\"customerId\": \"0123456789\",\"address\": \"2121 7th Ave, Seattle, WA 98121\"}}\",\"EventBusName\": \"default\"}"}'

aws events test-event-pattern \
--event-pattern "{\"source\":[\"com.myorg.dep.app\"]}" \
--event "{\"id\":\"1\",\"source\":\"com.myorg.dep.app\",\"detail-type\":\"myDetailType\",\"account\":\"111111111111\",\"region\":\"us-east-1\",\"time\":\"2021-02-02T09:17:54Z\"}"


## EVB CLI
# Besides other useful functionalities, evb-cli provides the possibility to run tests an event payload against all existing rules on a bus. 
# This is something to be performed against existing infrastructure. It will identity all the rules in the event bus the match a particular pattern.
# You can add parameter -a to see all rules, even those unmatched.
evb test-event  -e ../../events/event1.json -b default
evb test-event  -e ../../events/event2.json -b default
evb test-event  -e ../../events/event3.json -b default