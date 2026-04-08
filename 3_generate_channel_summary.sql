CREATE OR REPLACE VIEW `data-analysis-assessment-1.marketing_analysis_views.vw_channel_summary` AS

SELECT
  channel,

  -- volume
  SUM(impressions)                                          AS total_impressions,
  SUM(clicks)                                              AS total_clicks,
  SUM(cost)                                                AS total_spend,
  SUM(conversions)                                         AS total_conversions,
  SUM(conversion_value)                                    AS total_conversion_value,

  -- efficiency (aggregated)
  SAFE_DIVIDE(SUM(clicks), SUM(impressions))               AS blended_ctr,
  SAFE_DIVIDE(SUM(cost), SUM(clicks))                      AS blended_cpc,
  SAFE_DIVIDE(SUM(cost), SUM(impressions)) * 1000          AS blended_cpm,
  SAFE_DIVIDE(SUM(conversions), SUM(clicks))               AS blended_conversion_rate,
  SAFE_DIVIDE(SUM(cost), SUM(conversions))                 AS blended_cpa,
  SAFE_DIVIDE(SUM(conversion_value), SUM(cost))            AS blended_roas,

  -- spend share and conversion share (for over/under delivery analysis)
  SAFE_DIVIDE(SUM(cost),
    SUM(SUM(cost)) OVER())                                 AS spend_share,
  SAFE_DIVIDE(SUM(conversions),
    SUM(SUM(conversions)) OVER())                          AS conversion_share,

  -- facebook specific
  SUM(reach)                                               AS total_reach,
  AVG(frequency)                                           AS avg_frequency,
  SAFE_DIVIDE(SUM(cost), SUM(reach))                       AS cost_per_reach,

  -- google specific
  AVG(quality_score)                                       AS avg_quality_score,
  AVG(search_impression_share)                             AS avg_search_impression_share,

  -- video metrics (facebook & tiktok combined)
  SUM(video_views)                                         AS total_video_views,
  SAFE_DIVIDE(SUM(video_views), SUM(impressions))          AS blended_video_view_rate,
  SAFE_DIVIDE(SUM(cost), SUM(video_views))                 AS blended_cpv,

  -- tiktok completion funnel
  SAFE_DIVIDE(SUM(video_watch_100), SUM(video_views))      AS full_watch_rate,

  -- tiktok social
  SUM(likes)                                               AS total_likes,
  SUM(shares)                                              AS total_shares,
  SUM(comments)                                            AS total_comments,
  SAFE_DIVIDE(SUM(shares), SUM(impressions))               AS virality_rate

FROM `data-analysis-assessment-1.marketing_analysis_views.vw_cross_channel_metrics`
GROUP BY channel;