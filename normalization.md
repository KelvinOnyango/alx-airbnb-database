# Database Normalization to 3NF

## Initial Schema Assessment

### Original Tables:
1. `User`
2. `Property`
3. `Booking`
4. `Payment`
5. `Review`
6. `Message`

## Normalization Process

### 1. First Normal Form (1NF)

**Requirements Met:**
- All tables have primary keys
- No repeating groups
- All attributes contain atomic values

**Example Compliance:**
- `Booking` table's `status` uses ENUM (atomic values)
- No arrays or composite values in any field

### 2. Second Normal Form (2NF)

**Checking Partial Dependencies:**

1. **Property Table:**
   - All non-key attributes depend on full PK (`property_id`)
   - `host_id` is a foreign key, not part of PK
   - Compliant with 2NF

2. **Booking Table:**
   - `total_price` could be calculated from `Property.pricepernight` and dates
   - However, it's stored as historical record (acceptable denormalization)
   - Compliant with 2NF

3. **Payment Table:**
   - All attributes depend on full PK (`payment_id`)
   - Compliant with 2NF

### 3. Third Normal Form (3NF)

**Checking Transitive Dependencies:**

1. **User Table:**
   - No transitive dependencies found
   - All attributes describe the user only

2. **Property Table Improvement:**
   - `location` could contain city/country/zip in one field
   - **Normalization Action:**
     ```sql
     CREATE TABLE Location (
         location_id SERIAL PRIMARY KEY,
         property_id UUID REFERENCES Property(property_id),
         street VARCHAR NOT NULL,
         city VARCHAR NOT NULL,
         state VARCHAR NOT NULL,
         postal_code VARCHAR NOT NULL,
         country VARCHAR NOT NULL
     );
     ```
   - Removes potential transitive dependency if location → city → country

3. **Review Table:**
   - All attributes directly depend on PK
   - No transitive dependencies

## Final 3NF Schema

### Optimized Tables:

1. **User** (Unchanged)
   ```sql
   CREATE TABLE User (
       user_id UUID PRIMARY KEY,
       first_name VARCHAR NOT NULL,
       last_name VARCHAR NOT NULL,
       email VARCHAR UNIQUE NOT NULL,
       password_hash VARCHAR NOT NULL,
       phone_number VARCHAR,
       role ENUM('guest','host','admin') NOT NULL,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );
   CREATE TABLE Property (
    property_id UUID PRIMARY KEY,
    host_id UUID NOT NULL REFERENCES User(user_id),
    name VARCHAR NOT NULL,
    description TEXT NOT NULL,
    pricepernight DECIMAL NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

   CREATE TABLE Location (
       location_id SERIAL PRIMARY KEY,
       property_id UUID NOT NULL REFERENCES Property(property_id),
       street VARCHAR NOT NULL,
       city VARCHAR NOT NULL,
       state VARCHAR NOT NULL,
       postal_code VARCHAR NOT NULL,
       country VARCHAR NOT NULL,
       UNIQUE(property_id)
   );
   CREATE TABLE Booking (
       booking_id UUID PRIMARY KEY,
       property_id UUID NOT NULL REFERENCES Property(property_id),
       user_id UUID NOT NULL REFERENCES User(user_id),
       start_date DATE NOT NULL,
       end_date DATE NOT NULL,
       total_price DECIMAL NOT NULL,
       status ENUM('pending','confirmed','canceled') NOT NULL,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       CHECK (end_date > start_date)
   );
   CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY,
    booking_id UUID NOT NULL REFERENCES Booking(booking_id),
    amount DECIMAL NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card','paypal','stripe') NOT NULL

   CREATE TABLE Review (
       review_id UUID PRIMARY KEY,
       property_id UUID NOT NULL REFERENCES Property(property_id),
       user_id UUID NOT NULL REFERENCES User(user_id),
       rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
       comment TEXT NOT NULL,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );
   CREATE TABLE Message (
    message_id UUID PRIMARY KEY,
    sender_id UUID NOT NULL REFERENCES User(user_id),
    recipient_id UUID NOT NULL REFERENCES User(user_id),
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (sender_id != recipient_id)

