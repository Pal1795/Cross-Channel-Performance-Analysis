**Overview:**  

This project analyzes 30 days of paid media performance data (January 2024) across three advertising platforms — Facebook Ads, Google Ads, and TikTok Ads — covering a combined spend of $130,244 and 13,363 total conversions across 12 campaigns (4 per platform). Raw CSV exports from each platform were ingested into Google BigQuery, unified into a single cross-channel schema, and modeled into a set of analytical views that power a one-page Tableau Public dashboard.

Each platform serves a distinct role in the marketing funnel: Facebook is used for audience reach and brand awareness (tracked via reach, frequency, and engagement rate); Google captures active demand through search (tracked via quality score, search impression share, and conversion value); and TikTok drives content-led engagement (tracked via a video completion funnel at 25%, 50%, 75%, and 100% watch thresholds, alongside social actions like likes, shares, and comments). Because each platform exposes different data, a unified CPA (cost per acquisition) is used as the primary cross-channel efficiency metric. ROAS (return on ad spend) is calculated for Google only, as Facebook and TikTok do not return monetary conversion value in their exports.

The data is modeled across five BigQuery objects — a unified base table and four analytical views — producing over 30 calculated metrics covering funnel performance, audience efficiency, video engagement, search health, and campaign-level ROI. The final dashboard is structured to answer four business questions: where is the budget going, what is working, where are users dropping off, and which campaigns should be scaled or paused.

**Project Structure:**

<img width="578" height="278" alt="Screenshot 2026-04-08 at 12 19 40 PM" src="https://github.com/user-attachments/assets/887e3081-0e6e-4db6-ae65-8552de515e62" />


**Architecture:**

<img width="466" height="306" alt="Screenshot 2026-04-08 at 12 20 05 PM" src="https://github.com/user-attachments/assets/fab350cc-a726-477e-9183-00ec590488c9" />


**Key Findings:**

<img width="672" height="157" alt="Screenshot 2026-04-08 at 12 20 17 PM" src="https://github.com/user-attachments/assets/8bda5727-bc94-45b5-a687-c3605139ef95" />

Note: ROAS is Google-only. Facebook and TikTok do not return conversion value data. CPA is used as the primary cross-channel efficiency metric.

**Tableau Dashboard:**

**Link:** https://public.tableau.com/app/profile/pallavi.gowdar/viz/Cross-ChannelPerformanceAnalysis_17756255013120/MainDashboard  

**Screenshot:**
<img width="1556" height="948" alt="Screenshot 2026-04-08 at 12 24 34 PM" src="https://github.com/user-attachments/assets/25363086-21e0-4999-b76a-5f32243b9e2c" />

**Insights:**

1. **Facebook** is the most cost-efficient channel despite the lowest spend allocation.
At a $7.64 CPA, Facebook outperforms both Google ($8.93) and TikTok ($11.00), yet receives only 14% of total budget — suggesting room for increased investment.  
2. **TikTok** dominates in volume but at the highest cost per conversion.
TikTok consumes 57% of total spend ($74,266) and drives 50% of all conversions (6,750), but at the highest CPA of $11.00 — indicating scale at the expense of efficiency.
3. **Google** is the only channel with measurable revenue impact.
As the sole platform returning conversion value data, Google is the only channel where true ROAS can be calculated — making it the most accountable channel for direct revenue attribution despite ranking second in both spend and conversion volume.
