SELECT * FROM sales.sharktank; 

-- total epidoes & max episodes
select count(distinct ep_no) from sales.sharktank;
select min(ep_no) from sales.sharktank;

-- total pitches
select count(distinct brand) as total_brands from sales.sharktank;

-- brand with funding
select count(brands_with_funding)/count(*) from  (
select count(distinct brand) as brands_with_funding from sales.sharktank 
where deal <> "no deal") conversion_subquery;

-- total male
select sum(male) as total_males, sum(female) as total_females
 from sales.sharktank;
 
 --  gender ratio
 select sum(female)/sum(male) as gender_ratio from sales.sharktank;
 
 -- total amount invested
 select sum(deal) from sales.sharktank;
 
 -- avg equity taken
 select avg(Equity_Taken) from(
 select * from sales.sharktank where equity_taken>0) a;
 
 -- highest equity taken
 select max(equity_taken) from sales.sharktank;
 
 -- pitches with atleast 1 women 
 select count(*) as startup_with_atleast_1women from(
 select brand, female from sales.sharktank where female>=1) a;
 
 -- pitches converted having atleast 1 women
 select count(*) as converted_with_atleast_1women from(
 select brand, equity*100, female from sales.sharktank where equity*100>0 and female>0) a;
 
 -- average team member no.
 select round(avg(team_members),0) as avg_team_member from sales.sharktank;
 
-- adding amount_invested column & dropping column
alter table sales.sharktank
add amount_invested int;
select * from sales.sharktank;
alter table sales.sharktank
drop column amount_invested;
select * from sales.sharktank;
 
 -- age frequency
 select avg_age,count(avg_age) as cnt from sales.sharktank group by Avg_age order by cnt desc;
 
 -- most famous location
 select location, count(location) as total_locations from sales.sharktank group by Location;
 
 -- partner deals
 select	partners, count(partners) as cnt from sales.sharktank group by partners order by cnt asc;
 
 -- making the matrix
SELECT a.keyy, a.ashneer_deals, b.amount_ashneer_invested
FROM (
    SELECT 'ashneer' AS keyy, COUNT(ashneer_invested) AS ashneer_deals
    FROM sales.sharktank
    WHERE ashneer_invested > 0
) a
INNER JOIN (
    SELECT 'ashneer' AS keyy, SUM(ashneer_invested) AS amount_ashneer_invested, AVG(ashneer_invested) AS avg_amount
    FROM sales.sharktank
) b
ON a.keyy = b.keyy;

 -- which is the startup in which the highest amount invested in each domain
 select c.*
 from (
 select brand, deal, sector, rank() over (partition by sector order by deal desc) rnk
 from sales.sharktank where deal <> 'No Deal'
 ) c
 where c.rnk=1;
 
