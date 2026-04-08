CREATE OR REPLACE TABLE `data-analysis-assessment-1.marketing_analysis_refined.cross_channels` AS

-- FACEBOOK
SELECT
  date,
  'facebook'        AS channel,
  campaign_id,
  campaign_name,
  ad_set_id         AS ad_group_id,
  ad_set_name       AS ad_group_name,
  impressions,
  clicks,
  spend             AS cost,
  conversions,
  video_views,
  reach,
  frequency,
  engagement_rate,

  -- google nulls
  NULL              AS conversion_value,
  NULL              AS quality_score,
  NULL              AS search_impression_share,
  NULL              AS avg_cpc,

  -- tiktok video nulls
  NULL              AS video_watch_25,
  NULL              AS video_watch_50,
  NULL              AS video_watch_75,
  NULL              AS video_watch_100,

  -- tiktok social nulls
  NULL              AS likes,
  NULL              AS shares,
  NULL              AS comments

FROM `data-analysis-assessment-1.marketing_analysis_raw.facebook_ads`

UNION ALL

-- Google
SELECT
  date,
  'google'          AS channel,
  campaign_id,
  campaign_name,
  ad_group_id,
  ad_group_name,
  impressions,
  clicks,
  cost,
  conversions,

  -- facebook nulls
  NULL              AS video_views,
  NULL              AS reach,
  NULL              AS frequency,
  NULL              AS engagement_rate,

  conversion_value,
  quality_score,
  search_impression_share,
  avg_cpc,

  -- tiktok video nulls
  NULL              AS video_watch_25,
  NULL              AS video_watch_50,
  NULL              AS video_watch_75,
  NULL              AS video_watch_100,

  -- tiktok social nulls
  NULL              AS likes,
  NULL              AS shares,
  NULL              AS comments

FROM `data-analysis-assessment-1.marketing_analysis_raw.google_ads`

UNION ALL

-- TIKTOK
SELECT
  date,
  'tiktok'          AS channel,
  campaign_id,
  campaign_name,
  adgroup_id        AS ad_group_id,
  adgroup_name      AS ad_group_name,
  impressions,
  clicks,
  cost,
  conversions,
  video_views,

  -- facebook nulls
  NULL              AS reach,
  NULL              AS frequency,
  NULL              AS engagement_rate,

  -- google nulls  
  NULL              AS conversion_value,
  NULL              AS quality_score,
  NULL              AS search_impression_share,
  NULL              AS avg_cpc,

  video_watch_25,
  video_watch_50,
  video_watch_75,
  video_watch_100,
  likes,
  shares,
  comments

FROM `data-analysis-assessment-1.marketing_analysis_raw.tiktok_ads`;