### Database Structure
This schema defines the complete database structure for an AirBnB-like application with the following tables:

1. **users** - Stores user account information
2. **properties** - Contains property listings
3. **bookings** - Manages reservation records
4. **payments** - Tracks payment transactions
5. **reviews** - Stores property reviews
6. **messages** - Handles user messaging

### Key Features
- UUID primary keys for all tables
- Proper foreign key relationships with ON DELETE CASCADE
- Data validation through CHECK constraints
- Automatic timestamp generation
- Optimized indexes for performance

### Installation
1. Execute the `schema.sql` file in your PostgreSQL database
2. The script will:
   - Enable UUID extension if needed
   - Create all tables with constraints
   - Set up necessary indexes

### Constraints Implemented
- NOT NULL for required fields
- UNIQUE for email addresses
- ENUM-like constraints using CHECK
- Date validation (end_date > start_date)
- Rating range validation (1-5)
- Self-referential checks (sender ≠ recipient)

### Indexes Created
- All primary keys are automatically indexed
- Additional indexes on foreign keys and search columns
- Email index for faster user lookup
- Property and user indexes for bookings and reviews
