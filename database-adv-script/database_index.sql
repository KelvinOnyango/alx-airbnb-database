EXPLAIN ANALYZE 
SELECT * FROM bookings WHERE user_id = 123;

EXPLAIN ANALYZE
SELECT * FROM properties WHERE location = 'New York' AND price < 100;

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_created_at ON users(created_at);

CREATE INDEX IF NOT EXISTS idx_booking_user_id ON bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON bookings(property_id);
CREATE INDEX IF NOT EXISTS idx_booking_start_date ON bookings(start_date);
CREATE INDEX IF NOT EXISTS idx_booking_end_date ON bookings(end_date);

CREATE INDEX IF NOT EXISTS idx_property_host_id ON properties(host_id);
CREATE INDEX IF NOT EXISTS idx_property_location ON properties(location);
CREATE INDEX IF NOT EXISTS idx_property_price ON properties(price);

EXPLAIN ANALYZE 
SELECT * FROM bookings WHERE user_id = 123;

EXPLAIN ANALYZE
SELECT * FROM properties WHERE location = 'New York' AND price < 100;
