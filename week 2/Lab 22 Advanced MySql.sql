USE publication;
# Challenge 1 - top 3 most Profiting Authors >> subqueries
# table sales, 1 title appear several times. The royalties to be calculated for each sale
# the advance must be calculated only once for each title
# sum up for each individual author: All advances and royalties 
# STEP 1
select titles.title_id, au_id, 
(titles.advance * titleauthor.royaltyper/ 100) as advance, 
(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty 
from titleauthor
right join titles on titleauthor.title_id = titles.title_id
left join sales on sales.title_id = titles.title_id;
# STEP 2
select titles.title_id, au_id, 
SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as Aggregated_royalties 
from titleauthor
right join titles on titleauthor.title_id = titles.title_id
left join sales on sales.title_id = titles.title_id
group by au_id, title_id;
# STEP 3
select au_id, titles.title_id, 
SUM((titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) +
 (titles.advance * titleauthor.royaltyper/ 100)) as Profits
from titleauthor
right join titles on titleauthor.title_id = titles.title_id
left join sales on sales.title_id = titles.title_id
group by au_id, title_id
order by Profits desc
limit 3;
# Challenge 2 - Alternative Solution: temporary tables 
CREATE TEMPORARY TABLE Advance_Royalty
select titles.title_id, au_id, 
(titles.advance * titleauthor.royaltyper/ 100) as advance, 
(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty 
from titleauthor
right join titles on titleauthor.title_id = titles.title_id
left join sales on sales.title_id = titles.title_id;
CREATE TEMPORARY TABLE Profits
select title_id, au_id, sum(advance) as Sum_adv, sum(sales_royalty) as Sum_roy
from Advance_Royalty
group by title_id,au_id;
select title_id, au_id, sum(Sum_adv+Sum_roy) as Profit
from Profits
group by title_id,au_id
order by Profit desc
limit 3;
# Challenge 3 - permanent table: most_profiting_authors
create table Most_profiting_authors
select au_id, titles.title_id, 
SUM((titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) +
 (titles.advance * titleauthor.royaltyper/ 100)) as Profits
from titleauthor
right join titles on titleauthor.title_id = titles.title_id
left join sales on sales.title_id = titles.title_id
group by au_id, title_id
order by Profits desc
limit 3;
	
	
