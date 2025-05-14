SELECT user_id, COUNT(*) as total_bookings
FROM bookings
GROUP BY user_id;

SELECT 
    p.property_id,
    p.property_name,
    COUNT(b.booking_id) as total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) as booking_rank
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
GROUP BY p.property_id, p.property_name;
