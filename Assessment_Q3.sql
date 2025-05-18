-- Inactive Savings Accounts
SELECT 
    s.id AS plan_id,
    s.owner_id,
    'Savings' AS type,
    MAX(s.transaction_date) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days
FROM savings_savingsaccount s
WHERE s.new_balance > 0
GROUP BY s.owner_id, s.id
HAVING MAX(s.transaction_date) < CURDATE() - INTERVAL 365 DAY

UNION

-- Inactive Investment Plans
SELECT 
    p.id AS plan_id,
    p.owner_id,
    'Investment' AS type,
    p.last_charge_date AS last_transaction_date,
    DATEDIFF(CURDATE(), p.last_charge_date) AS inactivity_days
FROM plans_plan p
WHERE 
    p.amount > 0
    AND p.is_deleted = 0
    AND p.is_archived = 0
    AND p.last_charge_date < CURDATE() - INTERVAL 365 DAY;
