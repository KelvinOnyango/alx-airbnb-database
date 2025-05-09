# AirBnB Database ER Diagram

## Entities and Relationships

### Entities with Attributes

1. **User**
   - `user_id` (PK, UUID)
   - `first_name` (VARCHAR, NOT NULL)
   - `last_name` (VARCHAR, NOT NULL)
   - `email` (VARCHAR, UNIQUE, NOT NULL)
   - `password_hash` (VARCHAR, NOT NULL)
   - `phone_number` (VARCHAR)
   - `role` (ENUM: guest/host/admin, NOT NULL)
   - `created_at` (TIMESTAMP)

2. **Property**
   - `property_id` (PK, UUID)
   - `host_id` (FK → User)
   - `name` (VARCHAR, NOT NULL)
   - `description` (TEXT, NOT NULL)
   - `location` (VARCHAR, NOT NULL)
   - `pricepernight` (DECIMAL, NOT NULL)
   - `created_at` (TIMESTAMP)
   - `updated_at` (TIMESTAMP)

3. **Booking**
   - `booking_id` (PK, UUID)
   - `property_id` (FK → Property)
   - `user_id` (FK → User)
   - `start_date` (DATE, NOT NULL)
   - `end_date` (DATE, NOT NULL)
   - `total_price` (DECIMAL, NOT NULL)
   - `status` (ENUM: pending/confirmed/canceled, NOT NULL)
   - `created_at` (TIMESTAMP)

4. **Payment**
   - `payment_id` (PK, UUID)
   - `booking_id` (FK → Booking)
   - `amount` (DECIMAL, NOT NULL)
   - `payment_date` (TIMESTAMP)
   - `payment_method` (ENUM: credit_card/paypal/stripe, NOT NULL)

5. **Review**
   - `review_id` (PK, UUID)
   - `property_id` (FK → Property)
   - `user_id` (FK → User)
   - `rating` (INT, 1-5, NOT NULL)
   - `comment` (TEXT, NOT NULL)
   - `created_at` (TIMESTAMP)

6. **Message**
   - `message_id` (PK, UUID)
   - `sender_id` (FK → User)
   - `recipient_id` (FK → User)
   - `message_body` (TEXT, NOT NULL)
   - `sent_at` (TIMESTAMP)

## Relationships

1. **User → Property** (1-to-many):
   - A host (User) can list many Properties
   - Implemented via `host_id` FK in Property

2. **User → Booking** (1-to-many):
   - A guest (User) can make many Bookings
   - Implemented via `user_id` FK in Booking

3. **Property → Booking** (1-to-many):
   - A Property can have many Bookings
   - Implemented via `property_id` FK in Booking

4. **Booking → Payment** (1-to-1):
   - Each Booking has exactly one Payment
   - Implemented via `booking_id` FK in Payment

5. **Property → Review** (1-to-many):
   - A Property can have many Reviews
   - Implemented via `property_id` FK in Review

6. **User → Review** (1-to-many):
   - A User can write many Reviews
   - Implemented via `user_id` FK in Review

7. **User → Message** (many-to-many):
   - Users can send/receive many Messages
   - Implemented via `sender_id` and `recipient_id` FKs in Message

## Mermaid ER Diagram Code

```mermaid
erDiagram
    USER ||--o{ PROPERTY : "hosts"
    USER {
        string user_id PK
        string first_name
        string last_name
        string email
        string password_hash
        string phone_number
        string role
        timestamp created_at
    }
    
    USER ||--o{ BOOKING : "makes"
    PROPERTY ||--o{ BOOKING : "has"
    BOOKING {
        string booking_id PK
        string property_id FK
        string user_id FK
        date start_date
        date end_date
        decimal total_price
        string status
        timestamp created_at
    }
    
    BOOKING ||--|| PAYMENT : "has"
    PAYMENT {
        string payment_id PK
        string booking_id FK
        decimal amount
        timestamp payment_date
        string payment_method
    }
    
    PROPERTY ||--o{ REVIEW : "receives"
    USER ||--o{ REVIEW : "writes"
    REVIEW {
        string review_id PK
        string property_id FK
        string user_id FK
        int rating
        text comment
        timestamp created_at
    }
    
    USER ||--o{ MESSAGE : "sends"
    USER ||--o{ MESSAGE : "receives"
    MESSAGE {
        string message_id PK
        string sender_id FK
        string recipient_id FK
        text message_body
        timestamp sent_at
    }
