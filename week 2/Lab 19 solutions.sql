select * from olist.order_items limit 10;
# 1. From the order_items table, find the price of the highest priced order: 6735
select max(price) from olist.order_items;
# 1. lowest price order: 0.85
select min(price) from olist.order_items;
# 2. From the order_items table, what is range of the shipping_limit_date of the orders?
select min(shipping_limit_date), max(shipping_limit_date) from olist.order_items;
SELECT shipping_limit_date FROM olist.order_items
WHERE shipping_limit_date BETWEEN '2016-09-19' AND '2020-04-10'order by shipping_limit_date ;
# 3. From the customers table, find the states with the greatest number of customers.
select customer_state, count(customer_unique_id) from olist.customers
group by customer_state
order by count(customer_unique_id) desc
limit 5;
# 4. within the state with the greatest number of customers, 
# find the cities with the greatest number of customers.
select customer_city, count(customer_unique_id) from olist.customers
where customer_state = 'SP'
group by customer_city
order by count(customer_unique_id) desc
limit 5;
# 5. From the closed_deals table, 
# how many distinct business segments are there (not including null)?
select distinct count(business_segment) from olist.closed_deals; 
# 6. From the closed_deals table, 
# sum the declared_monthly_revenue for duplicate row values in business_segment 
# and find the 3 business segments with the highest declared monthly revenue 
# (of those that declared revenue).
select distinct business_segment, sum(declared_monthly_revenue)
from olist.closed_deals group by business_segment 
order by sum(declared_monthly_revenue) desc limit 3;
# 7. From the order_reviews table, find the total number of distinct review score values.
select distinct sum(review_score)
from olist.order_reviews; 
# 8. In the order_reviews table, create a new column with a description that 
# corresponds to each number category for each review score from 1 - 5, 
# then find the review score and category occurring most frequently in the table.
select * from olist.order_reviews limit 10; 
SELECT review_id, order_id, review_score, review_comment_title, case WHEN review_score =1 THEN 'very low'
     WHEN review_score =2 THEN 'low'
     when review_score =3 then "mid"
     when review_score =4 then "good"
     when review_score =5 then "excellent"
END description
FROM olist.order_reviews;
select review_score, count(review_score)
from olist.order_reviews
group by review_score
order by count(review_score) desc;
# 9. From the order_reviews table, find the review value occurring most frequently 
# and how many times it occurs.
SELECT review_score, count(review_score)
FROM olist.order_reviews group by review_score order by count(review_score) desc;