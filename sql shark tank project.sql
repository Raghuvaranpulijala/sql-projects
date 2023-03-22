select * from [sql portfolio project]..sharktank

--Total no of episodes
select max( [Ep# No#]) as  Totalepisodes from [sql portfolio project]..sharktank
select count(Distinct [Ep# No#]) from [sql portfolio project]..sharktank

-- pitches
select count(Distinct [Brand]) as totalpitches from [sql portfolio project]..sharktank

--- total male

select sum(male) from [sql portfolio project]..sharktank

--total female
select sum(female) from [sql portfolio project]..sharktank

--- gender ratio
select sum(female)/sum(male) from  [sql portfolio project]..sharktank

--- total invested amount

select sum([Amount Invested lakhs])from [sql portfolio project]..sharktank


-- avg equity taken

select avg(a.[Equity Taken %]) from
(select * from [sql portfolio project]..sharktank where [Equity Taken %]>0) a



--- highest deal taken


select max([amount invested lakhs]) from [sql portfolio project]..sharktank


--higheest equity taken

select max([Equity Taken %]) from [sql portfolio project]..sharktank


-- startups having at least women

select sum(a.female_count)  from 
(select female,case when female>0 then 1 else 0 end as female_count from [sql portfolio project]..sharktank) a

-- pitches converted having atleast One women
select * from [sql portfolio project]..sharktank

select sum(b.female_count) from(

select case when a.female>0 then 1 else 0 end as female_count ,a.*from (
(select * from [sql portfolio project]..sharktank where deal!='No Deal')) a)b


select avg([Team members]) from [sql portfolio project]..sharktank


--- amount invested per deal

select avg(a.[amount invested lakhs]) amount_invested_per_Deal from
(select * from [sql portfolio project]..sharktank where deal!='No Deal')a



-- location group of contestants

select location,count(location) cnt from [sql portfolio project]..sharktank group by location order by cnt desc



-- sector group of contestants

select sector,count(sector) cnt from [sql portfolio project]..sharktank group by sector order by cnt desc


--partner deals

select partners,count(partners) cnt from [sql portfolio project]..sharktank  where partners!='-' group by partners order by cnt desc




-- which is the startup in which the highest amount has been invested in each domain/sector




select c.* from 
(select brand,sector,[amount invested lakhs],rank() over(partition by sector order by [amount invested lakhs] desc) rnk 

from [sql portfolio project]..sharktank) c

where c.rnk=1