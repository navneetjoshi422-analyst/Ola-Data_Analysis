
create table ola_data(
Date DATE,
Time TIME,
Booking_id varchar(100),
Booking_Status varchar(100),	
Customer_ID varchar(100),
Vehicle_Type varchar(100),
Pickup_Location varchar(100),
Drop_Location varchar(100),
V_TAT int, 
C_TAT int,
Canceled_Rides_by_Customer varchar(100),
Canceled_Rides_by_Driver varchar(100),
Incomplete_Rides varchar(200),
Incomplete_Rides_Reason varchar(200),
Booking_Value bigint,
Payment_Method varchar(200),	
Ride_Distance int,
Driver_Ratings DECIMAL(4,2),
Customer_Rating DECIMAL(4,2)
);
select * from ola_data limit 500;
-- SQL Questions:

-- 1. Retrieve all successful bookings:

create view Successful_Bookings as 
select * from ola_data 
where booking_status = 'Success';
select * from Successful_Bookings;

-- 2. Find the average ride distance for each vehicle type:

create view Avg_ride_distance_for_each_vehicle as
select vehicle_type , avg(ride_distance) as Avg_Distance
from ola_data
group by vehicle_type;
select * from Avg_ride_distance_for_each_vehicle;

-- 3. Get the total number of cancelled rides by customers:

create view cancelled_rides_by_customers as 
select vehicle_type , count(Canceled_Rides_by_Customer) as cancel_by_customer
from ola_data
group by vehicle_type;
select * from cancelled_rides_by_customers;

-- 4. List the top 5 customers who booked the highest number of rides:

create view highest_number_of_rides as 
select customer_id , count(booking_id) as best_customers
from ola_data
group by customer_id
order by best_customers desc limit 5;
select * from highest_number_of_rides;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:

create view cancelled_by_drivers as 
select vehicle_type , count(Canceled_Rides_by_Driver) as cancel_by_driver
from ola_data
group by vehicle_type;
select * from cancelled_by_drivers;

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:

create view min_max_rating as
select max(driver_ratings),min(driver_ratings)
from ola_data
where vehicle_type = 'Prime Sedan';
select * from min_max_rating;

-- 7. Retrieve all rides where payment was made using UPI:

create view payment_was_made_using_UPI as
select * from ola_data
where payment_method = 'UPI';
select * from payment_was_made_using_UPI;

-- 8. Find the average customer rating per vehicle type:

create view customer_rating as
select vehicle_type , round(avg(customer_rating),2) as rating_avg
from ola_data
group by vehicle_type;
select * from customer_rating;
-- 9. Calculate the total booking value of rides completed successfully:

create view rides_completed_successfully as 
select vehicle_type , sum(booking_value) as revenue
from ola_data
group by vehicle_type,booking_status
having booking_status = 'Success';
select * from rides_completed_successfully;


-- 10. List all incomplete rides along with the reason:

create view incomplete_rides_reason as 
select incomplete_rides_reason,count(incomplete_rides_reason) as irr
from ola_data
group by incomplete_rides_reason,incomplete_rides
having incomplete_rides = 'Yes';
select * from incomplete_rides_reason;
