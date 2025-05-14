-- Initial complex query (before optimization)
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    u.user_id,
    u.username,
    u.email,
    p.property_id,
    p.property_name,
    p.location,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id;

-- Optimized query (after analysis)
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    u.user_id,
    u.username,
    u.email,
    p.property_id,
    p.property_name,
    p.location,
    p.price_per_night,
    pay.amount,
    pay.payment_method,
    pay.payment_status
FROM bookings b
JOIN (
    SELECT user_id, username, email 
    FROM users
) u ON b.user_id = u.user_id
JOIN (
    SELECT property_id, property_name, location, price_per_night
    FROM properties
) p ON b.property_id = p.property_id
LEFT JOIN (
    SELECT booking_id, amount, payment_method, payment_status
    FROM payments
) pay ON b.booking_id = pay.booking_id
WHERE b.start_date > CURRENT_DATE - INTERVAL '1 year';
