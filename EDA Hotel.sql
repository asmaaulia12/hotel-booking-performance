create database Hotel_Booking;
use Hotel_Booking;
select*from hotel_transaction;
select distinct(ï»¿Hotel_Name) from hotel_transaction;
describe hotel_transaction;

-- Create Table Duplikat
create table hotel_transaction_staging
like hotel_transaction;

insert  hotel_transaction_staging
select*
from hotel_transaction;

select*from hotel_transaction_staging
limit 10;

# Menghapus kolom yang tidak akan digunakan 

alter table hotel_transaction_staging
drop column reg,
drop column state,
drop column phone_no,
drop column emel, 
drop column rep_guest, 
drop column prev_cancel, 
drop column card_no, 
drop column resv_status, 
drop column assgn_room,
drop column adult,
drop column `(Child)`, 
drop column package_, 
drop column disc_amt,
drop column dep, 
drop column D_S,
drop column pos,
drop column `Sales Person`,
drop column comm_pay;

describe hotel_transaction_staging;

# Mengubah/Memperbaiki nama kolom

alter table  hotel_transaction_staging
change ï»¿Hotel_Name Hotel_Name varchar(100),
change Types Hotel_Types varchar(50),
change Cus_Name Customer_Name varchar(100),
change `Room-Type` Room_Type varchar(50),
change Cus_Seg Customer_Segment varchar(50),
change Dis_Channel Booking_Channel varchar(50);

# Ternyta data-data yng bertype varchar/text semuany mengndung spasi di datanya, maka harus dihapus terlebih dahulu

set sql_safe_updates = 0;

update hotel_transaction_staging
set Hotel_Types = trim(Hotel_Types);

update hotel_transaction_staging
set Room_Type = trim(Room_Type);

update hotel_transaction_staging
set Price = trim(Price);

update hotel_transaction_staging
set gross = trim(gross);

update hotel_transaction_staging
set sales = trim(sales);

# Menghapus tanda koma pada data

update hotel_transaction_staging
set Price = replace(Price, ',', '');

update hotel_transaction_staging
set Gross = replace(Gross, ',', '');
 
update hotel_transaction_staging
set Sales = replace(Sales, ',', '');

# Melakukan standarisasi nama hotel

update hotel_transaction_staging
set Hotel_Name = case
	when Hotel_Name = 'Lexis Suites, Penang' then 'Lexis Suites'
    when Hotel_Name = 'Le MÃ©ridien, Sabah' then 'Le Meridien'
    when Hotel_Name = 'The Hilton, Kuala Lumpur' then 'The Hilton'
    else Hotel_Name
end;

# Melakukan standarisasi pada kolom meal

update hotel_transaction_staging
set Meal = case
    when Meal = 'BB' then 'Bed & Breakfast'
    when Meal = 'FB' then 'Full Board'
    when Meal = 'HB' then 'Half Board'
    when Meal = 'SC' then 'Self Catering'
    else Meal
end;

# Melakukan standarisasi pada kolom

update hotel_transaction_staging
set Membership = 'None'
where Membership = 'N/A';

# Mengubah type data

alter table hotel_transaction_staging
add column Discount decimal(5,2);

update hotel_transaction_staging
set Discount = cast(replace(Disc, '%', '') as decimal(5,2)) / 100;

alter table hotel_transaction_staging
drop column Disc;

alter table hotel_transaction_staging
modify column Price int;

alter table hotel_transaction_staging
modify column Gross int;

alter table hotel_transaction_staging
modify column Sales int;

alter table hotel_transaction_staging add column Arrival_Date_Clean date;
update hotel_transaction_staging
set Arrival_Date_Clean = str_to_date(Arrival_Date, '%m/%d/%Y');

alter table hotel_transaction_staging add column Departure_Date_Clean date;
update hotel_transaction_staging
set Departure_Date_Clean = str_to_date(Depature_Date, '%m/%d/%Y');

alter table hotel_transaction_staging 
drop column Depature_Date, 
drop column Arrival_Date;

alter table  hotel_transaction_staging
change Arrival_Date_Clean Arrival_Date date,
change Departure_Date_Clean Departure_Date date;

# Menambahkan kolom bulan

alter table hotel_transaction_staging 
add column Month_Arrival varchar(20);
update hotel_transaction_staging
set 
  Month_Arrival = monthname(Arrival_Date);

# Exploratory Data Analysis

# Business Problem (Sales Analysis)
# 1.	Bagaimana tren bulanan total revenue per hotel, dan bagaimana perbedaan performa revenue antar-hotel sepanjang tahun?
select
	Hotel_Name,
    Month_Arrival,
    sum(Sales) as Total_Revenue
From hotel_transaction_staging
group by Month_Arrival, Hotel_Name
Order by Month_Arrival, Hotel_Name;

#2.	Bagaimana  tren bulanan Average Daily Rate (ADR) masing-masing hotel?
select
	Hotel_Name,
    Month_Arrival,
    avg(ADR)
from hotel_transaction_staging
group by Hotel_Name, Month_Arrival
Order by Hotel_Name, Month_Arrival;

# 3. Room type mana yang memberikan kontribusi terbesar terhadap total revenue untuk masing-masing hotel?

select
    Hotel_Name,
    Room_Type,
    sum(Sales) as Total_Revenue
from hotel_transaction_staging
group by Hotel_Name, Room_Type
order by Hotel_Name, Total_Revenue desc;

# 4. Bagaimana distribusi channel booking?

select
    Booking_Channel,
    count(Customer_Name) as Total_Booking
from hotel_transaction_staging
group by Booking_Channel
order by Booking_Channel desc;

# 5. Bagaimana distribusi total revenue berdasarkan metode pembayaran, 
#    serta metode pembayaran mana yang memberikan kontribusi paling besar terhadap total revenue?

select 
	Payment_Method,
    sum(Sales) as Total_Revenue,
    round(sum(Sales)/(select sum(Sales) from hotel_transaction_staging)*100,2) as Percentaage
from hotel_transaction_staging
group by Payment_Method
order by Total_Revenue desc;

# Business Problem (Customer Analysis)

# 1. Bagaimana tren bulanan total customer per hotel sepanjang tahun?
select
  Hotel_Name,
  Month_Arrival,
  count(customer_name) as Total_Customer
from hotel_transaction_staging
group by Hotel_Name, Month_Arrival
order by Hotel_Name;

# 2. Bagaimana perbedaan total booking dan total revenue pada tiap customer segment (Corporate, Family, Individual)?

select 
  customer_segment,
  count(*) as Total_Orders,
  round(sum(sales), 2) as Total_Revenue
from hotel_transaction_staging
group by customer_segment;

# 3. Apakah terdapat preferensi jenis kamar tertentu pada masing-masing segmen customer?

select 
	Customer_Segment,
    Room_Type,
    count(*) as Total_Transaction
from hotel_transaction_staging
group by Customer_Segment, Room_Type
order by Customer_Segment, Room_Type;

# 4. Bagaimana distribusi rating yang diberikan oleh customer terhadap pelananan hotel?

select
  Hotel_Name,
  customer_rating,
  count(*) as total_customers
from hotel_transaction_staging
group by Hotel_Name,customer_rating
order by customer_rating desc;

# 5. Bagaimana distribusi total booking berdasarkan membership (Platinum, Gold, None)?

select 
  Membership,
  count(*) as Total_Customers
from hotel_transaction_staging
group by Membership;

# 6. Bagaimana distribusi total booking berdasarkan meal plan pada tiap hotel?

select 
  Hotel_Name,
  Meal,
  count(*) as total_customers
from hotel_transaction_staging
group by Hotel_Name, Meal
order by Hotel_Name;

# 7. Bagaimana distribusi review yang diberikan oleh customer terhadap hotel?
select
	Hotel_Name,
    Customer_Review,
    count(*) Total_Booking
from hotel_transaction_staging
group by Hotel_Name, Customer_Review
order by Hotel_Name;
