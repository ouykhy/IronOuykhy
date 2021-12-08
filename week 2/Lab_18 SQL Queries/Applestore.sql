create database applestore;
select * from applestore.applestore limit 10;
select prime_genre FROM applestore.applestore group by prime_genre order by prime_genre;
select prime_genre, count(track_name), rating_count_tot 
FROM applestore.applestore group by prime_genre order by rating_count_tot desc;
select prime_genre, count(track_name)
FROM applestore.applestore 
group by prime_genre
order by count(track_name) desc
limit 1;
select prime_genre, count(track_name)
FROM applestore.applestore 
group by prime_genre
order by count(track_name) asc
limit 1;
select track_name, rating_count_tot
FROM applestore.applestore 
order by rating_count_tot desc
limit 10;
select track_name, user_rating
FROM applestore.applestore 
order by user_rating desc
limit 10;
select track_name, user_rating, rating_count_tot
FROM applestore.applestore 
where user_rating=5
order by rating_count_tot desc
limit 3;
select track_name, price, prime_genre,rating_count_tot
FROM applestore.applestore 
where price = 0
order by rating_count_tot desc