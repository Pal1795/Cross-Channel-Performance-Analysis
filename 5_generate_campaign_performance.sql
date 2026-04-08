CREATE OR REPLACE VIEW `data-analysis-assessment-1.marketing_analysis_views.vw_campaign_performance` AS

SELECT
  channel,
  campaign_id,
  campaign_name,

  SUM(impressions)                                        AS total_impressions,
  SUM(clicks)                                            AS total_clicks,
  SUM(cost)                                              AS total_spend,
  SUM(conversions)                                       AS total_conversions,
  SUM(conversion_value)                                  AS total_conversion_value,

  SAFE_DIVIDE(SUM(clicks), SUM(impressions))             AS ctr,
  SAFE_DIVIDE(SUM(cost), SUM(clicks))                    AS cpc,
  SAFE_DIVIDE(SUM(cost), SUM(impressions)) * 1000        AS cpm,
  SAFE_DIVIDE(SUM(conversions), SUM(clicks))             AS conversion_rate,
  SAFE_DIVIDE(SUM(cost), SUM(conversions))               AS cpa,
  SAFE_DIVIDE(SUM(conversion_value), SUM(cost))          AS roas,

  -- performance tier for easy filtering
  CASE
    WHEN SAFE_DIVIDE(SUM(conversion_value), SUM(cost)) >= 3 THEN 'Scale'
    WHEN SAFE_DIVIDE(SUM(conversion_value), SUM(cost)) BETWEEN 1 AND 3 THEN 'Optimize'
    WHEN SAFE_DIVIDE(SUM(conversion_value), SUM(cost)) < 1 THEN 'Pause'
    ELSE 'Review'
  END                                                    AS campaign_action_flag,

  -- spend share within channel
  SAFE_DIVIDE(
    SUM(cost),
    SUM(SUM(cost)) OVER (PARTITION BY channel)
  )                                                      AS spend_share_within_channel

FROM `data-analysis-assessment-1.marketing_analysis_views.vw_cross_channel_metrics`
GROUP BY channel, campaign_id, campaign_name;