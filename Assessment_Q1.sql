SELECT 
    u.id AS owner_id,
    u.name,
    s.savings_count,
    p.investment_count,
    IFNULL(s.total_savings, 0) + IFNULL(p.total_investments, 0) AS total_deposits
FROM users_customuser u
JOIN ( 
    SELECT 
        owner_id, 
        COUNT(*) AS savings_count,
        SUM(new_balance) AS total_savings
    FROM savings_savingsaccount
    WHERE new_balance > 0
    GROUP BY owner_id
) s ON u.id = s.owner_id
JOIN (
    SELECT 
        owner_id, 
        COUNT(*) AS investment_count,
        SUM(amount) AS total_investments
    FROM plans_plan
    WHERE amount > 0
    AND is_deleted = 0
    AND is_archived = 0
    GROUP BY owner_id
) p ON u.id = p.owner_id
ORDER BY total_deposits DESC;

