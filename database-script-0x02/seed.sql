-- Clear existing data 
TRUNCATE TABLE messages, reviews, payments, bookings, properties, users RESTART IDENTITY CASCADE;

-- Insert Users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
-- Admins
('11111111-1111-1111-1111-111111111111', 'Admin', 'System', 'admin@airbnb.com', '$2a$10$examplehash', '+1234567890', 'admin', '2023-01-01 00:00:00'),
-- Hosts
('22222222-2222-2222-2222-222222222222', 'Sarah', 'Johnson', 'sarah@example.com', '$2a$10$hosthash1', '+1555123456', 'host', '2023-02-15 10:30:00'),
('33333333-3333-3333-3333-333333333333', 'Michael', 'Brown', 'michael@example.com', '$2a$10$hosthash2', '+1555234567', 'host', '2023-03-10 14:15:00'),
-- Guests
('44444444-4444-4444-4444-444444444444', 'Emily', 'Davis', 'emily@example.com', '$2a$10$guesthash1', '+1555345678', 'guest', '2023-04-05 09:00:00'),
('55555555-5555-5555-5555-555555555555', 'David', 'Wilson', 'david@example.com', '$2a$10$guesthash2', '+1555456789', 'guest', '2023-05-20 16:45:00');

-- Insert Properties
INSERT INTO properties (property_id, host_id, name, description, location, price_per_night, created_at, updated_at) VALUES
-- Sarah's properties
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '22222222-2222-2222-2222-222222222222', 'Beachfront Villa', 'Luxury villa with private beach access', 'Malibu, California', 350.00, '2023-02-20 11:00:00', '2023-06-01 09:30:00'),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '22222222-2222-2222-2222-222222222222', 'Downtown Loft', 'Modern loft in city center', 'New York, NY', 200.00, '2023-02-25 14:00:00', '2023-05-15 10:15:00'),
-- Michael's properties
('cccccccc-cccc-cccc-cccc-cccccccccccc', '33333333-3333-3333-3333-333333333333', 'Mountain Cabin', 'Cozy cabin with mountain views', 'Aspen, Colorado', 180.00, '2023-03-15 09:30:00', '2023-06-10 08:00:00'),
('dddddddd-dddd-dddd-dddd-dddddddddddd', '33333333-3333-3333-3333-333333333333', 'Lake House', 'Spacious house by the lake', 'Lake Tahoe, California', 275.00, '2023-03-20 16:45:00', '2023-05-25 11:20:00');

-- Insert Bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
-- Emily's bookings
('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '44444444-4444-4444-4444-444444444444', '2023-06-15', '2023-06-20', 1750.00, 'confirmed', '2023-05-01 10:00:00'),
('ffffffff-ffff-ffff-ffff-ffffffffffff', 'cccccccc-cccc-cccc-cccc-cccccccccccc', '44444444-4444-4444-4444-444444444444', '2023-07-10', '2023-07-15', 900.00, 'confirmed', '2023-05-10 14:30:00'),
-- David's bookings
('gggggggg-gggg-gggg-gggg-gggggggggggg', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '55555555-5555-5555-5555-555555555555', '2023-06-01', '2023-06-05', 800.00, 'confirmed', '2023-04-15 09:15:00'),
('hhhhhhhh-hhhh-hhhh-hhhh-hhhhhhhhhhhh', 'dddddddd-dddd-dddd-dddd-dddddddddddd', '55555555-5555-5555-5555-555555555555', '2023-08-20', '2023-08-27', 1925.00, 'pending', '2023-06-01 16:45:00');

-- Insert Payments
INSERT INTO payments (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('iiiiiiii-iiii-iiii-iiii-iiiiiiiiiiii', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 1750.00, '2023-05-01 10:05:00', 'credit_card'),
('jjjjjjjj-jjjj-jjjj-jjjj-jjjjjjjjjjjj', 'ffffffff-ffff-ffff-ffff-ffffffffffff', 900.00, '2023-05-10 14:35:00', 'paypal'),
('kkkkkkkk-kkkk-kkkk-kkkk-kkkkkkkkkkkk', 'gggggggg-gggg-gggg-gggg-gggggggggggg', 800.00, '2023-04-15 09:20:00', 'stripe');

-- Insert Reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment, created_at) VALUES
('llllllll-llll-llll-llll-llllllllllll', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '44444444-4444-4444-4444-444444444444', 5, 'Absolutely stunning views and perfect location!', '2023-06-21 10:00:00'),
('mmmmmmmm-mmmm-mmmm-mmmm-mmmmmmmmmmmm', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '55555555-5555-5555-5555-555555555555', 4, 'Great place, would stay again!', '2023-06-06 14:30:00');

-- Insert Messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
-- Guest to Host
('nnnnnnnn-nnnn-nnnn-nnnn-nnnnnnnnnnnn', '44444444-4444-4444-4444-444444444444', '22222222-2222-2222-2222-222222222222', 'Hi Sarah, is the beach villa pet friendly?', '2023-05-01 09:30:00'),
('oooooooo-oooo-oooo-oooo-oooooooooooo', '22222222-2222-2222-2222-222222222222', '44444444-4444-4444-4444-444444444444', 'Yes Emily, we allow small dogs under 25lbs!', '2023-05-01 10:15:00'),
-- Host to Guest
('pppppppp-pppp-pppp-pppp-pppppppppppp', '33333333-3333-3333-3333-333333333333', '55555555-5555-5555-5555-555555555555', 'Hi David, just confirming your August dates', '2023-06-02 08:00:00');
