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
