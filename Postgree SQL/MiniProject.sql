-- Data Preparation & Table Relationhip ----------------------------------------------------------

-- check duplicate
select order_id, count(*)
from olist_orders_dataset
group by order_id
having count(*) > 1;
-- tidak memiliki duplicate

-- check missing
select *
from olist_orders_dataset
where order_id is null;
-- tidak memiliki missing value

-- Set PK Orders Dataset
alter table olist_orders_dataset
add primary key (order_id);
-- sudah berhasil jadi PK

-- Check duplicate order id di order payments
select order_id, count(*) as jumlah
from olist_order_payments_dataset
group by order_id
having count(*) > 1
order by jumlah desc;
-- Terdapat duplicate order_id, ada kemungkinan 1 order banyak payment

-- cek order id + payment_sequential untuk dijadikan composite PK
select
order_id,
payment_sequential,
count(*) as jumlah
from olist_order_payments_dataset
group by order_id, payment_sequential
having count(*) > 1;
-- tidak ada duplicate

-- check missing order id + payment squential
select *
from olist_order_payments_dataset
where order_id is null or payment_sequential is null;
-- tidak ada missing

-- membuat composite primary key
alter table olist_order_payments_dataset
add primary key (order_id, payment_sequential);

-- FK Order Payment ke orders data set
alter table olist_order_payments_dataset
add constraint fk_payment_order
foreign key (order_id)
references olist_orders_dataset(order_id);

-- check duplicate order_id + order_item_id
select
order_id,
order_item_id,
count(*) as jumlah
from olist_order_items_dataset
group by order_id, order_item_id
having count(*) > 1;
-- tidak ada duplicate

-- Check Missing
select *
from olist_order_items_dataset
where order_id is null or order_item_id is null;
-- tidak ada missing

-- set composite PK dari order_id & order_item
alter table olist_order_items_dataset
add primary key (order_id, order_item_id);

-- set FK order items ke orders dataset
alter table olist_order_items_dataset
add constraint fk_order_items_order
foreign key (order_id)
references olist_orders_dataset(order_id);

-- check duplicate product_id
select
product_id,
count(*) as jumlah
from olist_products_dataset
group by product_id
having count(*) > 1;
-- tidak ada duplicate

-- check missing product_id
select *
from olist_products_dataset
where product_id is null;
-- tidak ada missing

-- set product_id jadi PK
alter table olist_products_dataset 
add primary key (product_id);

-- set FK products ke order items dengan product_id
alter table olist_order_items_dataset
add constraint fk_order_items_product
foreign key (product_id)
references olist_products_dataset(product_id);

-- check duplicate seller_id di sellers dataset
select
seller_id,
count(*) as jumlah
from olist_sellers_dataset
group by seller_id
having count(*) > 1;
-- tidak ada duplicate

-- check missing
select *
from olist_sellers_dataset
where seller_id is null;
-- tidak ada missing

-- set PK seller_id
alter table olist_sellers_dataset
add primary key (seller_id);

-- Set FK sellers ke order items menggunakan seller_id
alter table olist_order_items_dataset
add constraint fk_order_items_seller
foreign key (seller_id)
references olist_sellers_dataset(seller_id);

-- check duplicate customer id
select
customer_id,
count(*)
from olist_customers_dataset
group by customer_id
having count(*) > 1;

-- Set PK customer_id
alter table olist_customers_dataset
add primary key (customer_id);

-- Menghubungkan orders dengan customers
alter table olist_orders_dataset
add constraint fk_orders_customers
foreign key (customer_id)
references olist_customers_dataset(customer_id);

-- Menghapus tabel Olist yang tidak digunakan dalam analisis
drop table olist_geolocation_dataset;

-- Data Exploration -----------------------------------------------------------------------

-- Mengecek jumlah data pada tabel orders
select count(*) as total_orders
from olist_orders_dataset;
-- orders = 99,441

-- Mengecek jumlah data pada tabel customers
select count(*) as total_customers
from olist_customers_dataset;
-- Customers : 99,441


-- Mengecek jumlah data pada tabel order items
select count(*) as total_order_items
from olist_order_items_dataset;
-- Order Items  : 112,650


-- Mengecek jumlah data pada tabel payments
select count(*) as total_payments
from olist_order_payments_dataset;
-- Payments : 103,886

-- Mengecek jumlah data pada tabel sellers
select count(*) as total_sellers
from olist_sellers_dataset;
-- Sellers : 3,095

-- Mengecek jumlah data pada tabel products
select count(*) as total_products
from olist_products_dataset;
-- Products : 32,951

-- Mengecek periode transaksi pada dataset
select
min(order_purchase_timestamp) as tanggal_awal,
max(order_purchase_timestamp) as tanggal_akhir
from olist_orders_dataset;
-- Periode data : 2016-09-04 sampai 2018-10-17

-- Mengecek jumlah order berdasarkan status
select
order_status,
count(*) as total_orders
from olist_orders_dataset
group by order_status
order by total_orders desc;
-- Insight:
-- Mayoritas order memiliki status "delivered" sebanyak 96,478 order.
-- Status lainnya memiliki jumlah yang jauh lebih sedikit,
-- seperti shipped (1,107), canceled (625), dan unavailable (609).
-- Oleh karena itu, analisis penjualan selanjutnya akan difokuskan
-- pada order dengan status "delivered" yang merupakan order yang "berhasil"

-- Mengecek jumlah transaksi berdasarkan metode pembayaran
select
payment_type,
count(*) as total_payments
from olist_order_payments_dataset
group by payment_type
order by total_payments desc;
-- Insight:
-- Credit card merupakan metode pembayaran yang paling banyak digunakan
-- dengan 76,795 payment records, diikuti oleh boleto sebanyak 19,784.
-- Voucher dan debit card digunakan dalam jumlah yang lebih sedikit.
-- Terdapat 3 record dengan payment type "not_defined".

-- Mengecek statistik dasar harga produk
select
min(price) as minimum_price,
round(avg(price)::numeric, 2) as average_price,
max(price) as maximum_price
from olist_order_items_dataset;
-- Insight:
-- Harga produk memiliki rentang yang cukup lebar,
-- dari 0.85 hingga 6,735.00.
-- Rata-rata harga produk adalah 120.65.

-- Mengecek statistik dasar biaya pengiriman
select
min(freight_value) as minimum_freight,
round(avg(freight_value)::numeric, 2) as average_freight,
max(freight_value) as maximum_freight
from olist_order_items_dataset;
-- Insight:
-- Biaya pengiriman memiliki rata-rata sebesar 19.99.
-- Biaya pengiriman terendah adalah 0.00
-- dan biaya pengiriman tertinggi adalah 409.68.

-- Mengecek jumlah seller berdasarkan state
select
    seller_state,
    count(*) as total_sellers
from olist_sellers_dataset
group by seller_state
order by total_sellers desc;
-- Insight:
-- Seller paling banyak berasal dari state SP,
-- dengan jumlah 1,849 seller.
-- Jumlah tersebut jauh lebih tinggi dibandingkan state lainnya,
-- seperti PR, MG, SC, dan RJ.

-- Data Analysis -----------------------------------------------------------------------------------

-- 1. Monthly Sales Performance
-- Melihat jumlah order dan total penjualan produk setiap bulan

select
date_trunc('month', o.order_purchase_timestamp::timestamp) as month,
count(distinct o.order_id) as total_orders,
round(sum(oi.price)::numeric, 2) as total_sales
from olist_orders_dataset o
inner join olist_order_items_dataset oi
on o.order_id = oi.order_id
where o.order_status = 'delivered'
group by month
order by month;
-- Insight:
-- Penjualan menunjukkan pertumbuhan sepanjang tahun 2017.
-- Jumlah order tertinggi terjadi pada November 2017 dengan 7,289 orders.
-- Pada tahun 2018, jumlah order relatif stabil di kisaran
-- 6,000 - 7,000 orders per bulan.

-- 2. Payment Method Performance
-- Melihat penggunaan dan total nilai dari setiap metode pembayaran

select
payment_type,
count(*) as total_payments,
round(sum(payment_value)::numeric, 2) as total_payment_value,
round(avg(payment_value)::numeric, 2) as average_payment_value
from olist_order_payments_dataset
group by payment_type
order by total_payment_value desc;

-- Insight:
-- Credit card merupakan metode pembayaran yang paling dominan,
-- dengan 76,795 payment records dan total payment value 12,542,100.
-- Credit card juga memiliki rata-rata payment value tertinggi
-- sebesar 163.32 dibandingkan metode pembayaran utama lainnya.


-- 3. Seller Performance by State
-- Melihat jumlah seller dan total penjualan produk
-- dari delivered orders berdasarkan state

select
s.seller_state,
count(distinct s.seller_id) as total_sellers,
count(distinct oi.order_id) as total_orders,
round(sum(oi.price)::numeric, 2) as total_sales
from olist_order_items_dataset oi
inner join olist_sellers_dataset s
on oi.seller_id = s.seller_id
inner join olist_orders_dataset o
on oi.order_id = o.order_id
where o.order_status = 'delivered'
group by s.seller_state
order by total_sales desc;
-- Insight:
-- SP memiliki jumlah seller, jumlah order, dan total sales terbesar.
-- Seller dari SP menghasilkan 68,641 delivered orders
-- dengan total sales sebesar 8,511,620.
-- PR dan MG menjadi state berikutnya dengan total sales terbesar.

-- 4. Product Category Performance
-- Melihat kategori produk dengan total penjualan terbesar

select
p.product_category_name,
count(distinct oi.order_id) as total_orders,
count(*) as total_items,
round(sum(oi.price)::numeric, 2) as total_sales
from olist_order_items_dataset oi
inner join olist_products_dataset p
on oi.product_id = p.product_id
inner join olist_orders_dataset o
on oi.order_id = o.order_id
where o.order_status = 'delivered'
group by p.product_category_name
order by total_sales desc;
-- Insight:
-- Kategori beleza_saude menghasilkan total sales terbesar
-- sebesar 1,233,110 dari 9,465 items.
-- Kategori relogios_presentes berada di posisi kedua
-- dengan total sales sebesar 1,166,160.
-- Sementara itu, cama_mesa_banho memiliki jumlah item terjual
-- paling banyak di antara kategori teratas, yaitu 10,953 items.

-- 5. Customer Distribution by State
-- Melihat jumlah delivered order berdasarkan lokasi customer

select
    c.customer_state,
    count(distinct o.order_id) as total_orders
from olist_orders_dataset o
inner join olist_customers_dataset c
    on o.customer_id = c.customer_id
where o.order_status = 'delivered'
group by c.customer_state
order by total_orders desc;
-- Insight:
-- SP memiliki jumlah delivered order terbesar yaitu 40,501 orders,
-- diikuti oleh RJ sebanyak 12,350 orders dan MG sebanyak 11,354 orders.
-- Hal ini menunjukkan bahwa sebagian besar order dalam dataset
-- berasal dari customer yang berlokasi di SP.

-- 6. Product Price Category
-- Mengelompokkan item berdasarkan kategori harga

select
case
	when price < 50 then 'Low Price'
    when price <= 150 then 'Medium Price'
    else 'High Price'
end as price_category,
count(*) as total_items,
round(avg(price)::numeric, 2) as average_price
from olist_order_items_dataset
group by price_category
order by average_price;
-- Insight:
-- Sebagian besar item berada pada kategori Medium Price
-- dengan jumlah 51,171 items dan rata-rata harga 92.87.
-- Low Price memiliki 39,024 items, sedangkan
-- High Price memiliki jumlah paling sedikit yaitu 22,455 items.


