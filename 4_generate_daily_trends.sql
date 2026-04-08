CREATE OR REPLACE VIEW `data-analysis-assessment-1.marketing_analysis_views.vw_daily_trends` AS

SELECT
  date,
  channel,

  SUM(impressions)                                         AS daily_impressions,
  SUM(clicks)                                             AS daily_clicks,
  SUM(cost)                                               AS daily_spend,
  SUM(conversions)                                        AS daily_conversions,

  SAFE_DIVIDE(SUM(clicks), SUM(impressions))              AS daily_ctr,
  SAFE_DIVIDE(SUM(cost), SUM(clicks))                     AS daily_cpc,
  SAFE_DIVIDE(SUM(cost), SUM(impressions)) * 1000         AS daily_cpm,
  SAFE_DIVIDE(SUM(cost), SUM(conversions))                AS daily_cpa,
  SAFE_DIVIDE(SUM(conversion_value), SUM(cost))           AS daily_roas,

  -- rolling 7-day CPA
  AVG(SAFE_DIVIDE(SUM(cost), SUM(conversions)))
    OVER (
      PARTITION BY channel
      ORDER BY date
      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    )                                                      AS rolling_7d_cpa,

  -- rolling 7-day CTR
  AVG(SAFE_DIVIDE(SUM(clicks), SUM(impressions)))
    OVER (
      PARTITION BY channel
      ORDER BY date
      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    )                                                      AS rolling_7d_ctr,

  -- facebook ad fatigue tracking
  AVG(frequency)                                          AS avg_daily_frequency

FROM `data-analysis-assessment-1.marketing_analysis_views.vw_cross_channel_metrics`
GROUP BY date, channel;