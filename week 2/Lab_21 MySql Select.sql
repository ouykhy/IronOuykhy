USE publication;
# Challenge 1 - Who Have Published What At Where?
CREATE TEMPORARY TABLE publication.author_title_summary
SELECT authors.au_id, authors.au_lname, 
authors.au_fname, titleauthor.title_id
FROM publication.authors
RIGHT JOIN publication.titleauthor
ON authors.au_id = titleauthor.au_id;
CREATE TEMPORARY TABLE publication.publisher_title_summary
SELECT titles.title, publishers.pub_name,titles.title_id
FROM publication.titles
lEFT JOIN publication.publishers
ON titles.pub_id = publishers.pub_id;
Select author_title_summary.au_id, au_lname,au_fname,
publisher_title_summary.title, pub_name, publisher_title_summary.title_id
FROM author_title_summary
LEFT JOIN publisher_title_summary
ON  author_title_summary.title_id = publisher_title_summary.title_id;
# Challenge 2 - Who Have Published How Many At Where? how many titles each author has published at each publisher
Select author_title_summary.au_id, au_lname,au_fname,pub_name,
COUNT(publisher_title_summary.title) as Titles
FROM author_title_summary
LEFT JOIN publisher_title_summary
ON  author_title_summary.title_id = publisher_title_summary.title_id
group by au_id ,pub_name
order by au_id;
# Challenge 3 - Best Selling Authors, top 3 authors have sold the highest number of titles?
SELECT author_title_summary.au_id, au_lname,au_fname, sum(titles.ytd_sales) as Total 
FROM publication.author_title_summary
LEFT JOIN publication.titles
ON author_title_summary.title_id = titles.title_id
group by au_id
order by Total desc
limit 3;
# Challenge 4 - Best Selling Authors Ranking
SELECT author_title_summary.au_id, au_lname,au_fname, sum(titles.ytd_sales) as Total 
FROM publication.author_title_summary
LEFT JOIN publication.titles
ON author_title_summary.title_id = titles.title_id
# where Total >= 0
group by au_id
order by Total desc;