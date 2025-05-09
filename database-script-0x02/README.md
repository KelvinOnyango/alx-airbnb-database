# README.md
## AirBnB Database Sample Data

### Overview
This script populates the AirBnB database with realistic sample data for testing and development purposes.

### Contents
- 5 users (1 admin, 2 hosts, 2 guests)
- 4 properties (2 per host)
- 4 bookings (2 confirmed, 1 pending)
- 3 completed payments
- 2 property reviews
- 3 example messages

### Usage
1. Ensure the database schema has been created first
2. Run the seed.sql script:
   ```bash
   psql -U username -d airbnb -f seed.sql
