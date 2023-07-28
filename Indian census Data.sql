select count(*) from project.dbo.data1
select count (*) from project.dbo.data2

select * from project.dbo.data1 where state in ('Jharkhand','Bihar')

--sum of population

select sum(Population) from [dbo].[data2]

--avg growth

select state,avg(growth)*100 as AVG_GROWTH from  group by state ;

-- avg sex_ratio

select state,round(avg(sex_ratio),0) as avg_sex_ratio from project.dbo.data1
group by state having round(avg(Sex_Ratio),0)>800 order by avg_sex_ratio desc 

--top 3 state showing highest growth ratio

select top 3 state, (avg (growth)*100) as avg_growth from project.dbo.data1 group by state order by avg_growth desc

-- top and bottom 3 states in literacy rate

create table literacystates
( state nvarchar(255),
  literacystate float 
  )
  insert into literacystates
  select state,round(avg(literacy),0) as avg_literacy_ratio from project.dbo.data1
  group by state order by avg_literacy_ratio desc;

  select top 3  * from literacystates order by literacystate desc
  select top 3 * from literacystates order by literacystate asc
  select * from project.dbo.data1

  -- joining both tables
  select a.District,a.state,a.sex_ratio,b.population from project.dbo.data1 a inner join project.dbo.data2 b on a.District=b.District 

  -- calculating no. of males and females

    select c.district,c.state,round(c.population/(c.sex_ratio+1),0) as males ,round ((c.population*c.sex_ratio)/(c.sex_ratio+1),0) as females from
   (select a.District,a.state,a.sex_ratio,b.population from project.dbo.data1 a inner join project.dbo.data2 b on a.District=b.District ) c 

   -- analysing literacy ratio in population

   select d.district,d.state,d.literacy_ratio*d.population literate_people,(1*d.literacy_ratio)* d.population illiterate_people from
  ( select a.state,a.district ,a.literacy/100 literacy_ratio, b.population from project.dbo.data1 a inner join project.dbo.data2 b on a.district=b.district )d

  -- population in previous census
  select e.state,sum(e.previous_census_population) previous_census_population,sum(e.current_census_population) current_census_population from
  (select d.district,d.state,round(d.population/(1+d.growth),0) previous_census_population,d.population current_census_population from
(  select a.district,a.state,a.growth,b.population from project.dbo.data1 a inner join project.dbo.data2 b on a.district=b.district )d )e
group by e.state