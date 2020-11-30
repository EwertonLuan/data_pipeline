----------- Number of different assets in the portfolio

select count(distinct(asset_id)) from assets;

---------------------------------------------

----------- Average view duration per viewer by city

select 
	vr.city,
	vs.viewer_id,
	avg(vs.view_duration) as avg_view_duration
from viewer vr
	inner join views as vs on vs.viewer_id = vr.viewer_id
group by 1, 2;

---------------------------------------------

----------- Total view duration for asset name “Pegasus” on 29th of April
select 
	sum(vs.view_duration)
from assets a 
	inner join views as vs on vs.asset_id = a.asset_id
where a.asset_name = 'Pegasus'
	and vs.view_date = '2020-04-29'
---------------------------------------------

	
----------- List of viewer names for the asset type “Video” *Obs the column viwer don't have the property name

select 
	distinct(vr.viewer_id) 
from assets a
	inner join views as vs on vs.asset_id = a.asset_id
	inner join viewer as vr on vr.viewer_id= vs.viewer_id
where a.asset_type= 'Video';
---------------------------------------------

----------- Total costs per view

select 
	a.asset_id,
	a.production_cost,
	count(vs.view_id) as total_views,
	a.production_cost / count(vs.view_id) as costs_per_view
from assets a 
	inner join views as vs on vs.asset_id = a.asset_id
group by 1,2;
---------------------------------------------


----------- Top 3 viewers based on total views
select 
	viewer_id,
    count(*) as total_views
from views
group by 1 order by total_views desc limit 3;

---------------------------------------------

----------- Viewers who have created an account in the last 90 days but haven’t viewed a video yet

select 
	vr.* 
from viewer vr 
	left join views as vs on vs.viewer_id = vr.viewer_id 
where vr.date_of_account_creation >= current_date - interval '90' day
	and vs.view_id isnull;

---------------------------------------------