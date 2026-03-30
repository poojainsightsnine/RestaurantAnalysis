Restaurant Data Analysis <br>
📌 Project Overview <br>
This project analyzes restaurant data to uncover insights related to cuisines, cities, pricing, ratings, and customer preferences.
The analysis is performed using SQL (MySQL) for data processing and Power BI for interactive visualization.

🎯 Objectives <br>
Identify top cuisines and their popularity <br>
Analyze restaurant distribution across cities <br>
Study pricing trends<br>
Evaluate online delivery impact <br>
Discover cuisine combinations <br>
Perform geographic and chain analysis <br>
🛠️ Tools & Technologies <br>

Excel/CSV – Dataset & initial cleaning <br>

SQL (MySQL) – Data cleaning, transformation & analysis<br>

Power BI – Dashboard & visualization<br>

🧹 Data Cleaning & Preparation (Excel/SQL) <br>

Checked duplicate records using restaurant id <br>

Identified missing latitude & longitude values <br>

Fixed missing geo-coordinates using: <br>
    🔹Locality-level averages<br>
    🔹City-level fallback <br>
Replaced missing cuisines with "Not Specified" <br>

Split multiple cuisines using JSON_TABLE <br>

Created views for analysis:<br>

restaurant_map_view → for map visualization <br>

restaurant_cuisine_split → for cuisine-level insights <br>

🧠 SQL Analysis Performed <br>

🔹 Level 1 Analysis <br>

Top 3 cuisines & their percentage <br>

City with highest restaurants <br>

Average rating per city <br>

Price range distribution <br>

Online delivery percentage & rating comparison <br>

🔹 Level 2 Analysis <br>

Rating distribution <br>

Average votes per restaurant <br>

Cuisine combinations analysis <br>

High-rated cuisine combinations <br>

Restaurant chain identification & performance <br>

🔹 Level 3 Analysis <br>

Review-based analysis using rating text <br>

Relationship between votes and ratings <br>

Price range vs online delivery availability <br>

Geographic clustering (used in Power BI map) <br>

📊 Dashboard Preview <br>

<img width="869" height="480" alt="image" src="https://github.com/user-attachments/assets/5938443e-cae3-4afe-b071-959f25d7e0a6" /> <br>


📊 Dashboard Features <br>

KPI Cards (Total Restaurants, Cities, Ratings, Votes, Chains) <br>

Cuisine Distribution (Pie Chart) <br>

Top Cities Analysis (Bar Chart) <br>

Price Range Breakdown <br>

Restaurant Chain Analysis <br>

Online Delivery vs Rating <br>

Geographic Map Visualization <br>

Interactive Filters (City, Cuisine, Price Range, Rating) <br>

📈 Key Insights <br>

🍜 Cuisine Insights <br>

North Indian cuisine dominates (41.46%) <br>

Followed by Chinese and Fast Food <br>

🌆 City Insights <br>

New Delhi has the highest restaurant count (5473) <br>

Restaurants are concentrated in metro cities <br>

💰 Pricing Insights <br>

Majority of restaurants fall under Price Range 1 & 2 (~79%) <br>

Indicates a budget-focused market <br>

🚚 Online Delivery <br>

Only 25.66% restaurants offer delivery <br>

Restaurants with delivery have higher ratings (~3.2 vs 2.1) <br>

🏬 Chain Analysis <br>

741 restaurant chains identified <br>

Popular chains:<br>

Cafe Coffee Day <br>
Domino’s Pizza <br>
Subway <br>
McDonald’s <br>
📍 Geographic Insights <br>
High restaurant clustering in urban areas <br>
Map visualization highlights demand-driven locations <br>
💡 Business Recommendations <br>
Expand online delivery services <br>
Focus on high-demand cuisines <br>
Target metro cities for growth <br>
Maintain affordable pricing strategies <br>
Improve customer experience to increase ratings <br>
🚀 Conclusion <br>

This project demonstrates how raw restaurant data can be transformed into meaningful insights using SQL and Power BI. <br>

👉 Key factors influencing success: <br>

Cuisine preference <br>
Pricing strategy <br>
Location<br>
Online delivery availability <br>

Businesses can use these insights to make data-driven decisions and improve performance. <br>

📂 Project Structure <br>
├── Dataset (CSV) <br>
├── SQL Scripts <br>
├── Power BI Dashboard (.pbix) <br>
├── Dashboard Image <br>
└── README.md <br>
🙋‍♀️ Author <br>

Pooja Parashar <br>

📧 pooja.insightsnine@gmail.com <br>
🔗 https://www.linkedin.com/in/pooja-parashar-889b0837b <br>
💻 https://github.com/poojainsightsnine
