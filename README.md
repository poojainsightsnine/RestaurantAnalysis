Restaurant Data Analysis
📌 Project Overview

This project analyzes restaurant data to uncover insights related to cuisines, cities, pricing, ratings, and customer preferences.
The analysis is performed using SQL (MySQL) for data processing and Power BI for interactive visualization.

🎯 Objectives
Identify top cuisines and their popularity<br>
Analyze restaurant distribution across cities
Study pricing trends
Evaluate online delivery impact
Discover cuisine combinations
Perform geographic and chain analysis
🛠️ Tools & Technologies
Excel/CSV – Dataset & initial cleaning
SQL (MySQL) – Data cleaning, transformation & analysis
Power BI – Dashboard & visualization
🧹 Data Cleaning & Preparation (SQL)
Checked duplicate records using restaurant id
Identified missing latitude & longitude values
Fixed missing geo-coordinates using:
Locality-level averages
City-level fallback
Replaced missing cuisines with "Not Specified"
Split multiple cuisines using JSON_TABLE
Created views for analysis:
restaurant_map_view → for map visualization
restaurant_cuisine_split → for cuisine-level insights
🧠 SQL Analysis Performed
🔹 Level 1 Analysis
Top 3 cuisines & their percentage
City with highest restaurants
Average rating per city
Price range distribution
Online delivery percentage & rating comparison
🔹 Level 2 Analysis
Rating distribution
Average votes per restaurant
Cuisine combinations analysis
High-rated cuisine combinations
Restaurant chain identification & performance
🔹 Level 3 Analysis
Review-based analysis using rating text
Relationship between votes and ratings
Price range vs online delivery availability
Geographic clustering (used in Power BI map)
📊 Dashboard Preview
<img width="869" height="480" alt="image" src="https://github.com/user-attachments/assets/5938443e-cae3-4afe-b071-959f25d7e0a6" />

📊 Dashboard Features
KPI Cards (Total Restaurants, Cities, Ratings, Votes, Chains)
Cuisine Distribution (Pie Chart)
Top Cities Analysis (Bar Chart)
Price Range Breakdown
Restaurant Chain Analysis
Online Delivery vs Rating
Geographic Map Visualization
Interactive Filters (City, Cuisine, Price Range, Rating)
📈 Key Insights
🍜 Cuisine Insights
North Indian cuisine dominates (41.46%)
Followed by Chinese and Fast Food
🌆 City Insights
New Delhi has the highest restaurant count (5473)
Restaurants are concentrated in metro cities
💰 Pricing Insights
Majority of restaurants fall under Price Range 1 & 2 (~79%)
Indicates a budget-focused market
🚚 Online Delivery
Only 25.66% restaurants offer delivery
Restaurants with delivery have higher ratings (~3.2 vs 2.1)
🏬 Chain Analysis
741 restaurant chains identified
Popular chains:
Cafe Coffee Day
Domino’s Pizza
Subway
McDonald’s
📍 Geographic Insights
High restaurant clustering in urban areas
Map visualization highlights demand-driven locations
💡 Business Recommendations
Expand online delivery services
Focus on high-demand cuisines
Target metro cities for growth
Maintain affordable pricing strategies
Improve customer experience to increase ratings
🚀 Conclusion

This project demonstrates how raw restaurant data can be transformed into meaningful insights using SQL and Power BI.

👉 Key factors influencing success:

Cuisine preference
Pricing strategy
Location
Online delivery availability

Businesses can use these insights to make data-driven decisions and improve performance.

📂 Project Structure
├── Dataset (CSV)
├── SQL Scripts
├── Power BI Dashboard (.pbix)
├── Dashboard Image
└── README.md
🙋‍♀️ Author

Pooja Parashar

📧 pooja.insightsnine@gmail.com
🔗 https://www.linkedin.com/in/pooja-parashar-889b0837b
💻 https://github.com/poojainsightsnine
