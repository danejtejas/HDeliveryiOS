# HapiHyper Delivery API Documentation

## Base Configuration
- **Base URL**: `https://hapihyper.com/admin/`
- **API Base Path**: `https://hapihyper.com/admin/api/`
- **Request Timeout**: 30 seconds
- **Platform Type**: Android (type = 1)

## Response Format
All API responses follow this standard format:
```json
{
  "status": "SUCCESS" | "ERROR",
  "data": "1" | "0",
  "message": "Response message",
  "count": "number of items"
}
```

---

## 1. Authentication APIs

### 1.1 Prepare Login
**Endpoint**: `/api/prepareLogin`  
**Method**: POST  
**Description**: Check if email exists in the system

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| email | String | Yes | User email address |

**Example Request**:
```json
{
  "email": "user@example.com"
}
```

---

### 1.2 Authorize Token
**Endpoint**: `/api/authorize`  
**Method**: POST  
**Description**: Validate user token

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |

**Example Request**:
```json
{
  "token": "user_auth_token_here"
}
```

---

### 1.3 Normal Login
**Endpoint**: `/api/loginNormal`  
**Method**: GET  
**Description**: Login with email and password

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| email | String | Yes | User email |
| password | String | Yes | User password |
| gcm_id | String | Yes | Firebase/GCM token |
| ime | String | Yes | Device IMEI |
| lat | String | Yes | User latitude |
| long | String | Yes | User longitude |
| type | String | Yes | Account type (0=normal, 1=social) |

**Example Request**:
```
GET /api/loginNormal?email=user@example.com&password=123456&gcm_id=firebase_token&ime=device_imei&lat=40.7128&long=-74.0060&type=0
```

---

### 1.4 Social Login
**Endpoint**: `/api/login`  
**Method**: POST  
**Description**: Login with social media accounts (Facebook/Google)

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| gcm_id | String | Yes | Firebase/GCM token |
| email | String | Yes | Social media email |
| ime | String | Yes | Device IMEI |
| type | String | Yes | Platform type (1=Android, 2=iOS) |
| lat | String | Yes | User latitude |
| long | String | Yes | User longitude |
| name | String | Yes | User full name |
| gender | String | Yes | User gender |
| image | String | Yes | Profile image URL |

**Example Request**:
```json
{
  "gcm_id": "firebase_token",
  "email": "user@example.com",
  "ime": "device_imei",
  "type": "1",
  "lat": "40.7128",
  "long": "-74.0060",
  "name": "John Doe",
  "gender": "male",
  "image": "profile_image_url"
}
```

---

### 1.5 Logout
**Endpoint**: `/api/logout`  
**Method**: POST  
**Description**: Logout user from the system

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |

**Example Request**:
```json
{
  "token": "user_auth_token_here"
}
```

---

## 2. User Management APIs

### 2.1 Register Account
**Endpoint**: `/api/signupAndroid`  
**Method**: POST  
**Description**: Register new user account

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| full_name | String | Yes | User full name |
| phone | String | Yes | Phone number |
| email | String | Yes | Email address |
| password | String | Yes | Password |
| address | String | Yes | User address |
| city | String | Yes | City |
| country | String | Yes | Country |
| post_code | String | Yes | Postal code |
| account | String | Yes | Bank account |
| image | String | Yes | Base64 encoded profile image |

**Example Request**:
```json
{
  "full_name": "John Doe",
  "phone": "+1234567890",
  "email": "john@example.com",
  "password": "password123",
  "address": "123 Main St",
  "city": "New York",
  "country": "USA",
  "post_code": "10001",
  "account": "bank_account_info",
  "image": "base64_encoded_image"
}
```

---

### 2.2 Show User Info
**Endpoint**: `/api/showUserInfo`  
**Method**: POST  
**Description**: Get user profile information

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |

**Example Request**:
```json
{
  "token": "user_auth_token_here"
}
```

---

### 2.3 Update Profile
**Endpoint**: `/api/updateProfile`  
**Method**: POST  
**Description**: Update user profile information

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| description | String | No | User description |
| full_name | String | No | Full name |
| address | String | No | Address |
| phone | String | No | Phone number |
| cityId | String | No | City ID |
| stateId | String | No | State ID |
| account | String | No | Bank account |
| type_device | String | No | Device type |
| image | String | No | Base64 encoded image |

**Example Request**:
```json
{
  "token": "user_auth_token_here",
  "description": "Updated description",
  "full_name": "John Doe Updated",
  "address": "456 New St",
  "phone": "+1234567890",
  "cityId": "1",
  "stateId": "1",
  "account": "new_bank_account",
  "type_device": "android",
  "image": "base64_encoded_image"
}
```

---

### 2.4 Change Password
**Endpoint**: `/api/changePassword`  
**Method**: GET  
**Description**: Change user password

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| oldPassword | String | Yes | Current password |
| newPassword | String | Yes | New password |

**Example Request**:
```
GET /api/changePassword?token=user_token&oldPassword=old123&newPassword=new123
```

---

### 2.5 Forgot Password
**Endpoint**: `/api/forgotPassword`  
**Method**: GET  
**Description**: Request password reset

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| email | String | Yes | User email address |

**Example Request**:
```
GET /api/forgotPassword?email=user@example.com
```

---

## 3. Driver Management APIs

### 3.1 Driver Registration
**Endpoint**: `/api/driverRegisterAndroid`  
**Method**: POST  
**Description**: Register as a driver

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| carPlate | String | Yes | Vehicle license plate |
| identity | String | Yes | Driver identity number |
| brand | String | Yes | Vehicle brand |
| model | String | Yes | Vehicle model |
| year | String | Yes | Vehicle year |
| status | String | Yes | Driver status |
| account | String | Yes | Bank account |
| referred_by | String | No | Referral code |
| link_type | String | Yes | Vehicle type |
| image | String | Yes | Base64 encoded vehicle image 1 |
| image2 | String | Yes | Base64 encoded vehicle image 2 |
| document | String | Yes | Base64 encoded vehicle document |
| document_name | String | Yes | Document filename |
| document_id | String | Yes | Base64 encoded ID document |
| document_id_name | String | Yes | ID document filename |

**Example Request**:
```json
{
  "token": "user_auth_token_here",
  "carPlate": "ABC-123",
  "identity": "ID123456789",
  "brand": "Toyota",
  "model": "Camry",
  "year": "2020",
  "status": "active",
  "account": "bank_account_info",
  "referred_by": "REF123",
  "link_type": "1",
  "image": "base64_encoded_car_image_1",
  "image2": "base64_encoded_car_image_2",
  "document": "base64_encoded_document",
  "document_name": "vehicle_doc.pdf",
  "document_id": "base64_encoded_id",
  "document_id_name": "driver_id.pdf"
}
```

---

### 3.2 Update Driver Profile
**Endpoint**: `/api/updateDriverDataAndroid`  
**Method**: POST  
**Description**: Update driver profile information

**Parameters**: Similar to driver registration with optional fields

---

### 3.3 Driver Online Status
**Endpoint**: `/api/online`  
**Method**: POST  
**Description**: Set driver online/offline status

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | Driver authentication token |
| status | String | Yes | Status (1=online, 0=offline) |

**Example Request**:
```json
{
  "token": "driver_auth_token_here",
  "status": "1"
}
```

---

### 3.4 Update Driver Coordinate
**Endpoint**: `/api/updateCoordinate`  
**Method**: POST  
**Description**: Update driver's current location

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | Driver authentication token |
| lat | String | Yes | Driver latitude |
| long | String | Yes | Driver longitude |

**Example Request**:
```json
{
  "token": "driver_auth_token_here",
  "lat": "40.7128",
  "long": "-74.0060"
}
```

---

### 3.5 Get Driver Location
**Endpoint**: `/api/getDriverLocation`  
**Method**: GET  
**Description**: Get specific driver's location

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| driverId | String | Yes | Driver ID |

**Example Request**:
```
GET /api/getDriverLocation?driverId=123
```

---

### 3.6 Search Drivers
**Endpoint**: `/api/searchDriver`  
**Method**: GET  
**Description**: Search for available drivers in area

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| startLat | String | Yes | Search center latitude |
| startLong | String | Yes | Search center longitude |
| carType | String | Yes | Vehicle type filter |
| distance | String | Yes | Search radius in km |

**Example Request**:
```
GET /api/searchDriver?startLat=40.7128&startLong=-74.0060&carType=1&distance=5
```

---

## 4. Trip Management APIs

### 4.1 Create Request
**Endpoint**: `/api/createRequest`  
**Method**: POST  
**Description**: Create a new delivery request

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| link | String | Yes | Trip link/reference |
| startLat | String | Yes | Pickup latitude |
| startLong | String | Yes | Pickup longitude |
| startLocation | String | Yes | Pickup address |
| endLat | String | Yes | Destination latitude |
| endLong | String | Yes | Destination longitude |
| endLocation | String | Yes | Destination address |
| estimateDistance | String | Yes | Estimated distance |
| item_id | String | Yes | JSON string of items |

**Example Request**:
```json
{
  "token": "user_auth_token_here",
  "link": "trip_reference_123",
  "startLat": "40.7128",
  "startLong": "-74.0060",
  "startLocation": "123 Main St, New York",
  "endLat": "40.7589",
  "endLong": "-73.9851",
  "endLocation": "456 Broadway, New York",
  "estimateDistance": "5.2",
  "item_id": "[{\"id\":1,\"name\":\"Package\",\"price\":10}]"
}
```

---

### 4.2 Driver Confirm Request
**Endpoint**: `/api/driverConfirm`  
**Method**: POST  
**Description**: Driver confirms a delivery request

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | Driver authentication token |
| requestId | String | Yes | Request ID to confirm |
| startLat | String | Yes | Driver's current latitude |
| startLong | String | Yes | Driver's current longitude |
| startLocation | String | Yes | Driver's current location |

**Example Request**:
```json
{
  "token": "driver_auth_token_here",
  "requestId": "REQ123",
  "startLat": "40.7128",
  "startLong": "-74.0060",
  "startLocation": "Current driver location"
}
```

---

### 4.3 Start Trip
**Endpoint**: `/api/startTrip`  
**Method**: POST  
**Description**: Driver starts the trip

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | Driver authentication token |
| tripId | String | Yes | Trip ID |

**Example Request**:
```json
{
  "token": "driver_auth_token_here",
  "tripId": "TRIP123"
}
```

---

### 4.4 End Trip
**Endpoint**: `/api/endTrip`  
**Method**: POST  
**Description**: Driver ends the trip

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | Driver authentication token |
| tripId | String | Yes | Trip ID |
| distance | String | Yes | Actual trip distance |

**Example Request**:
```json
{
  "token": "driver_auth_token_here",
  "tripId": "TRIP123",
  "distance": "5.8"
}
```

---

### 4.5 Cancel Trip
**Endpoint**: `/api/cancelTrip`  
**Method**: POST  
**Description**: Cancel an active trip

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| tripId | String | Yes | Trip ID to cancel |

**Example Request**:
```json
{
  "token": "user_auth_token_here",
  "tripId": "TRIP123"
}
```

---

### 4.6 Cancel Request
**Endpoint**: `/api/cancelRequest`  
**Method**: POST  
**Description**: Cancel a pending request

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| driver | String | Yes | Driver flag (0 for passenger) |

**Example Request**:
```json
{
  "token": "user_auth_token_here",
  "driver": "0"
}
```

---

### 4.7 Show My Request
**Endpoint**: `/api/showMyRequest`  
**Method**: POST  
**Description**: Get user's current requests

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| driver | String | No | Driver flag (0 for passenger requests) |

**Example Request**:
```json
{
  "token": "user_auth_token_here",
  "driver": "0"
}
```

---

### 4.8 Driver Arrived
**Endpoint**: `/api/driverArrived`  
**Method**: GET  
**Description**: Notify that driver has arrived

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | Driver authentication token |
| tripId | String | Yes | Trip ID |

**Example Request**:
```
GET /api/driverArrived?token=driver_token&tripId=TRIP123
```

---

### 4.9 Change Status
**Endpoint**: `/api/changeStatus`  
**Method**: POST  
**Description**: Change trip status

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| tripId | String | Yes | Trip ID |
| status | String | Yes | New status |

**Example Request**:
```json
{
  "token": "user_auth_token_here",
  "tripId": "TRIP123",
  "status": "6"
}
```

---

### 4.10 Show Trip Detail
**Endpoint**: `/api/showTripDetail`  
**Method**: POST  
**Description**: Get detailed trip information

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| tripId | String | Yes | Trip ID |

**Example Request**:
```json
{
  "token": "user_auth_token_here",
  "tripId": "TRIP123"
}
```

---

### 4.11 Show Distance
**Endpoint**: `/api/showDistance`  
**Method**: POST  
**Description**: Get trip distance information

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| tripId | String | Yes | Trip ID |

**Example Request**:
```json
{
  "token": "user_auth_token_here",
  "tripId": "TRIP123"
}
```

---

## 5. Payment APIs

### 5.1 Trip Payment
**Endpoint**: `/api/tripPayment`  
**Method**: POST  
**Description**: Process trip payment

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| tripId | String | Yes | Trip ID |
| paymentMethod | String | Yes | Payment method (1=balance, 2=cash, 3=stripe) |

**Example Request**:
```json
{
  "token": "user_auth_token_here",
  "tripId": "TRIP123",
  "paymentMethod": "1"
}
```

---

### 5.2 Driver Confirm Payment
**Endpoint**: `/api/driverConfirmPaymentTrip`  
**Method**: POST  
**Description**: Driver confirms cash payment received

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| tripId | String | Yes | Trip ID |
| paymentMethod | String | Yes | Payment method (2=cash) |
| action | String | Yes | Action (1=confirm, 0=cancel) |

**Example Request**:
```json
{
  "tripId": "TRIP123",
  "paymentMethod": "2",
  "action": "1"
}
```

---

### 5.3 Point Exchange (Deposit)
**Endpoint**: `/api/pointExchange`  
**Method**: POST  
**Description**: Add money to user balance

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| amount | String | Yes | Amount to add |
| transactionId | String | Yes | Payment transaction ID |
| paymentMethod | String | Yes | Payment method (1=paypal, 2=card, 3=stripe) |

**Example Request**:
```json
{
  "token": "user_auth_token_here",
  "amount": "100.00",
  "transactionId": "TXN123456",
  "paymentMethod": "3"
}
```

---

### 5.4 Point Redeem (Payout)
**Endpoint**: `/api/pointRedeem`  
**Method**: POST  
**Description**: Withdraw money from user balance

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| amount | String | Yes | Amount to withdraw |

**Example Request**:
```json
{
  "token": "user_auth_token_here",
  "amount": "50.00"
}
```

---

### 5.5 Point Transfer
**Endpoint**: `/api/pointTransfer`  
**Method**: POST  
**Description**: Transfer money to another user

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | Sender authentication token |
| amount | String | Yes | Amount to transfer |
| receiverEmail | String | Yes | Recipient email |
| note | String | Yes | Transfer note |

**Example Request**:
```json
{
  "token": "sender_auth_token_here",
  "amount": "25.00",
  "receiverEmail": "recipient@example.com",
  "note": "Payment for service"
}
```

---

### 5.6 Search User
**Endpoint**: `/api/searchUser`  
**Method**: POST  
**Description**: Search for user by email for transfers

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| email | String | Yes | Email to search |

**Example Request**:
```json
{
  "token": "user_auth_token_here",
  "email": "search@example.com"
}
```

---

### 5.7 Stripe Payment Request
**Endpoint**: `/stripe/web/index.php`  
**Method**: GET  
**Description**: Process Stripe payment

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| amount | String | Yes | Payment amount |
| email | String | Yes | User email |

**Example Request**:
```
GET /stripe/web/index.php?token=user_token&amount=100.00&email=user@example.com
```

---

## 6. History APIs

### 6.1 Trip History
**Endpoint**: `/api/showMyTrip`  
**Method**: POST  
**Description**: Get user's trip history

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| page | String | Yes | Page number for pagination |

**Example Request**:
```json
{
  "token": "user_auth_token_here",
  "page": "1"
}
```

---

### 6.2 Transaction History
**Endpoint**: `/api/transactionHistory`  
**Method**: POST  
**Description**: Get user's transaction history

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| page | String | Yes | Page number for pagination |

**Example Request**:
```json
{
  "token": "user_auth_token_here",
  "page": "1"
}
```

---

## 7. Rating APIs

### 7.1 Rate Driver
**Endpoint**: `/api/rateDriver`  
**Method**: POST  
**Description**: Rate the driver after trip completion

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| tripId | String | Yes | Trip ID |
| rate | String | Yes | Rating (1-5) |

**Example Request**:
```json
{
  "token": "user_auth_token_here",
  "tripId": "TRIP123",
  "rate": "5"
}
```

---

### 7.2 Rate Passenger
**Endpoint**: `/api/ratePassenger`  
**Method**: POST  
**Description**: Driver rates the passenger

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | Driver authentication token |
| tripId | String | Yes | Trip ID |
| rate | String | Yes | Rating (1-5) |

**Example Request**:
```json
{
  "token": "driver_auth_token_here",
  "tripId": "TRIP123",
  "rate": "4"
}
```

---

## 8. Utility APIs

### 8.1 Show Car Types
**Endpoint**: `/api/showCarType`  
**Method**: POST  
**Description**: Get available vehicle types

**Parameters**: None required

**Example Request**:
```json
{}
```

---

### 8.2 Show State City
**Endpoint**: `/api/showStateCity`  
**Method**: GET  
**Description**: Get list of states and cities

**Parameters**: None required

**Example Request**:
```
GET /api/showStateCity
```

---

### 8.3 Get Items
**Endpoint**: `/api/items`  
**Method**: GET  
**Description**: Get available delivery items

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| job_type | String | Yes | Job type filter |

**Example Request**:
```
GET /api/items?job_type=delivery
```

---

### 8.4 General Settings
**Endpoint**: `/api/generalSettings`  
**Method**: POST  
**Description**: Get app general settings

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |

**Example Request**:
```json
{
  "token": "user_auth_token_here"
}
```

---

### 8.5 Share App
**Endpoint**: `/api/shareApp`  
**Method**: POST  
**Description**: Track app sharing activity

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| type | String | Yes | Share type |
| social | String | Yes | Social platform |

**Example Request**:
```json
{
  "token": "user_auth_token_here",
  "type": "referral",
  "social": "facebook"
}
```

---

### 8.6 Need Help
**Endpoint**: `/api/needHelpTrip`  
**Method**: POST  
**Description**: Request help for a trip

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | User authentication token |
| tripId | String | Yes | Trip ID |

**Example Request**:
```json
{
  "token": "user_auth_token_here",
  "tripId": "TRIP123"
}
```

---

## 9. Promotion APIs

### 9.1 Show My Code
**Endpoint**: `/api/showMyCode`  
**Method**: GET  
**Description**: Get user's referral code

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| user_id | String | Yes | User ID |

**Example Request**:
```
GET /api/showMyCode?user_id=123
```

---

### 9.2 Apply Promo Code
**Endpoint**: `/api/ApplyPromo`  
**Method**: GET  
**Description**: Apply promotional code

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| user_id | String | Yes | User ID |
| promocode | String | Yes | Promotional code |

**Example Request**:
```
GET /api/ApplyPromo?user_id=123&promocode=PROMO123
```

---

### 9.3 Get Introduction
**Endpoint**: `/api/instruction`  
**Method**: GET  
**Description**: Get app introduction/instructions

**Parameters**: None required

**Example Request**:
```
GET /api/instruction
```

---

## 10. Signature API

### 10.1 Receiver Signature
**Endpoint**: `/api/receiverdate`  
**Method**: POST  
**Description**: Submit delivery signature and receiver information

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | Driver authentication token |
| tripId | String | Yes | Trip ID |
| username | String | Yes | Receiver name |
| transection_id | String | Yes | Transaction ID |
| user_id | String | Yes | User ID |
| image | String | Yes | Base64 encoded receiver photo |
| receiver_signature | String | Yes | Base64 encoded signature |

**Example Request**:
```json
{
  "token": "driver_auth_token_here",
  "tripId": "TRIP123",
  "username": "John Receiver",
  "transection_id": "TXN123",
  "user_id": "USER123",
  "image": "base64_encoded_receiver_photo",
  "receiver_signature": "base64_encoded_signature"
}
```

---

## 11. Driver Request Management

### 11.1 Delete Request
**Endpoint**: `/api/taskerDeleteRequest`  
**Method**: POST  
**Description**: Driver deletes their current request

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | Driver authentication token |

**Example Request**:
```json
{
  "token": "driver_auth_token_here"
}
```

---

### 11.2 Dismiss Request
**Endpoint**: `/api/dismissRequest`  
**Method**: POST  
**Description**: Driver dismisses a specific request

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| token | String | Yes | Driver authentication token |
| requestId | String | Yes | Request ID to dismiss |

**Example Request**:
```json
{
  "token": "driver_auth_token_here",
  "requestId": "REQ123"
}
```

---

## Status Codes

### Trip Status
- `1` - Approaching (Driver confirmed and approaching)
- `2` - In Progress (Trip started)
- `3` - Pending Payment (Trip ended, waiting for payment)
- `4` - Finished (Trip completed)
- `6` - Arrived A (Driver arrived at pickup)
- `7` - Arrived B (Driver arrived at destination)
- `8` - Start Task (Task started)

### Driver Status
- `1` - Online/Available
- `0` - Offline/Busy

### Payment Methods
- `1` - Balance/PayPal
- `2` - Cash
- `3` - Stripe

### Account Types
- `0` - Normal account
- `1` - Social account

---

## Error Handling

All API endpoints return standard HTTP status codes:
- `200` - Success
- `400` - Bad Request (Invalid parameters)
- `401` - Unauthorized (Invalid token)
- `404` - Not Found
- `500` - Internal Server Error

Error responses include a message field with details about the error.

---

## Firebase Integration

The app uses Firebase for:
- Push notifications (FCM tokens required for registration)
- Real-time database: `https://taxinear-c804e.firebaseio.com/`

---

## Google Maps Integration

The app integrates with Google Maps APIs for:
- Geocoding: `http://maps.google.com/maps/api/geocode/json`
- Directions: `http://maps.googleapis.com/maps/api/directions/json`
- Parameters: `&sensor=false&units=metric&mode=driving`

---

## Notes

1. All image uploads should be Base64 encoded
2. Location coordinates should be provided as strings
3. Tokens are required for most authenticated endpoints
4. The app supports both normal and social login methods
5. Driver registration requires additional documentation and vehicle information
6. Real-time location updates are crucial for driver tracking
7. Payment processing supports multiple methods including cash, balance, and Stripe
8. The system includes comprehensive trip status tracking and management
