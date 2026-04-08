CREATE OR REPLACE VIEW `data-analysis-assessment-1.marketing_analysis_views.vw_cross_channel_metrics` AS

SELECT
  -- DIMENSIONS
  date,
  channel,
  campaign_id,
  campaign_name,
  ad_group_id,
  ad_group_name,

  -- RAW BASE METRICS
  impressions,
  clicks,
  cost,
  conversions,
  conversion_value,
  video_views,
  reach,
  frequency,
  engagement_rate,
  quality_score,
  search_impression_share,
  avg_cpc,
  video_watch_25,
  video_watch_50,
  video_watch_75,
  video_watch_100,
  likes,
  shares,
  comments,
  --
  -- 1) CORE CROSS-CHANNEL METRICS
  --
  -- click efficiency
  SAFE_DIVIDE(clicks, impressions)                          AS ctr,
  SAFE_DIVIDE(cost, clicks)                                 AS cpc,

  -- impress cost
  SAFE_DIVIDE(cost, impressions) * 1000                     AS cpm,

  -- conversion metrics
  SAFE_DIVIDE(conversions, clicks)                          AS conversion_rate,
  SAFE_DIVIDE(cost, conversions)                            AS cpa,

  -- revenue metrics (Google only, null for others)
  SAFE_DIVIDE(conversion_value, cost)                       AS roas,

  -- end-to-end funnel efficiency
  SAFE_DIVIDE(conversions, impressions)                     AS overall_funnel_efficiency,
  
  --
  -- 2) FACEBOOK-SPECIFIC METRICS
  --

  -- cost per unique person reached
  SAFE_DIVIDE(cost, reach)                                  AS cost_per_reach,

  -- ad fatigue signal: rising frequency = potential burnout
  frequency                                                 AS ad_frequency,

  --
  -- 3) GOOGLE-SPECIFIC METRICS
  --

  -- missed opportunity in search
  SAFE_DIVIDE(
    (1 - search_impression_share) * impressions,
    search_impression_share
  )                                                         AS estimated_lost_impressions,

  -- quality score health flag
  CASE
    WHEN quality_score >= 7 THEN 'Healthy'
    WHEN quality_score BETWEEN 5 AND 6 THEN 'Average'
    WHEN quality_score < 5 THEN 'Poor - Penalty Risk'
    ELSE NULL
  END                                                       AS quality_score_band,

  --
  -- 4) TIKTOK VIDEO METRICS
  --

  -- did the video stop the scroll?
  SAFE_DIVIDE(video_views, impressions)                     AS video_view_rate,

  -- cost per video view
  SAFE_DIVIDE(cost, video_views)                            AS cpv,

  -- completion funnel rates (drop-off at each stage)
  SAFE_DIVIDE(video_watch_25, video_views)                  AS watch_rate_25,
  SAFE_DIVIDE(video_watch_50, video_views)                  AS watch_rate_50,
  SAFE_DIVIDE(video_watch_75, video_views)                  AS watch_rate_75,
  SAFE_DIVIDE(video_watch_100, video_views)                 AS watch_rate_100,

  -- full watch rate: content quality signal
  SAFE_DIVIDE(video_watch_100, video_views)                 AS full_watch_rate,

  -- drop-off between hook (25%) and completion (100%)
  SAFE_DIVIDE(video_watch_25 - video_watch_100, video_watch_25) AS video_dropoff_rate,

  --
  -- 5) TIKTOK SOCIAL METRICS
  --

  -- organic amplification potential
  SAFE_DIVIDE(shares, impressions)                          AS virality_rate,

  -- overall social resonance
  SAFE_DIVIDE(
    COALESCE(likes, 0) + COALESCE(shares, 0) + COALESCE(comments, 0),
    impressions
  )                                                         AS social_engagement_rate,

  -- conversation signal (high = compelling or polarizing)
  SAFE_DIVIDE(comments, impressions)                        AS comment_rate,

  -- like rate
  SAFE_DIVIDE(likes, impressions)                           AS like_rate,

  -- share rate
  SAFE_DIVIDE(shares, impressions)                          AS share_rate

FROM `data-analysis-assessment-1.marketing_analysis_refined.cross_channels`;