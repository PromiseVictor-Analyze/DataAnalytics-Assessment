# DataAnalytics-Assessment
A submission of the assessment from Cowrywise

Assessment 1
High-Value Customers with Multiple Products
 Goal: Identify customers with both a funded savings and investment plan.
Approach:
•	I filtered savings_savingsaccount where new_balance > 0 to get funded savings.
•	I filtered plans_plan where amount > 0 and is_deleted = 0, is_archived = 0 for active investment plans.
•	I grouped by owner_id and counted occurrences.
•	Then, I joined both datasets on owner_id, calculated total_deposits, and ordered by total_deposits. 
 Key fields I used :
savings_savingsaccount.owner_id, plans_plan.owner_id, new_balance, amount and name
 Reasoning:
Using new_balance > 0 ensures the account is funded. We filter out deleted/archived plans to avoid outdated records.
________________________________________

Assessment 2 
Transaction Frequency Analysis
 Goal: Categorize customers based on how frequently they transact monthly.
 Approach:
•	I counted total transactions per user using the COUNT function.
•	I divided by 3 (assuming we use the transactions from the last 3 months to judge).
•	Then, I used CASE statements to bucket into frequency groups (High, Medium, and Low Frequency).
 Key fields I used:
savings_savingsaccount.owner_id, transaction_date
 Reasoning:
Grouping over 3 months gives a realistic recent pattern. Frequency buckets help in marketing segmentation.
________________________________________

Assessment 3
Account Inactivity Alert
 Goal: Flag savings or investment accounts with no inflow in the last 1 year.
Approach:
•	I used MAX(transaction_date) for savings and last_charge_date for plans.
•	I filtered where the date is older than 365 days.
•	Then, I calculated inactivity_days with DATEDIFF().
 Key fields I used:
savings_savingsaccount.transaction_date, plans_plan.last_charge_date, owner_id
Reasoning:
We’re checking the last transaction time to determine if an account has gone cold. Filtering only active accounts ensures accuracy.
________________________________________

Assessment 4
Customer Lifetime Value (CLV) Estimation
 Goal: Estimate CLV using account tenure and transaction volume.
 Approach:
•	I calculated tenure: TIMESTAMPDIFF(MONTH, date_joined, CURDATE())
•	Got total transactions and average transaction value per user.
•	Then I applied the CLV formula that was given.
 Key Fields:
users_customuser.date_joined, savings_savingsaccount.new_balance, transaction_date
 Reasoning:
We apply a basic LTV model suitable for SaaS or fintech using historical volume and profit rate (0.1%). Division by tenure ensures normalization across customers.
Difficulties:
•	I had to learn about  LTV(Lifetime Value) and its significance in businesses.
________________________________________
