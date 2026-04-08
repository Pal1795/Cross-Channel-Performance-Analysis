Overview
End-to-end analytics project ingesting paid media data from Facebook Ads, Google Ads, and TikTok Ads into Google BigQuery. Raw data is modeled into a unified cross-channel schema with calculated KPIs, then visualized in a one-page Tableau Public dashboard.

Project Structure
├── data/
│   ├── 01_facebook_ads.csv
│   ├── 02_google_ads.csv
│   └── 03_tiktok_ads.csv
│
├── sql/
│   ├── 01_all_channels.sql         ← unified UNION ALL table
│   ├── 02_vw_channel_metrics.sql   ← row-level KPIs
│   ├── 03_vw_channel_summary.sql   ← aggregated by channel
│   ├── 04_vw_daily_trends.sql      ← time-series with 7d rolling avg
│   └── 05_vw_campaign_performance.sql ← campaign-level rankings
│
├── dashboard/
│   └── [Tableau Public link]
│
└── README.md
