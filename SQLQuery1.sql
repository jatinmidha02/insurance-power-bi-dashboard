--SQL Queries
Select top 10* from Customers

--How many customers are there
Select count(*) as customer_count from customers;

--How many policies are there
Select count(*) as policy_count from policies

--How many claims are there
Select count(*) as claim_count from claims

--total claim amount
Select round(sum(Claim_Amount),2) as claim_amount from claims

-- claim status questions

--approved claims
Select count(*) as approved_claims from claims where Claim_Status ='Approved'
-- rejected claims
Select count(*) as rejected_claims from claims where Claim_Status ='Rejected'
--pending claims
Select count(*) as pending_claims from claims where Claim_Status ='Pending'
--claim percentage of each status
SELECT Claim_Status,
       CAST(COUNT(*) AS DECIMAL(10,2))
       / (SELECT COUNT(*) FROM Claims) * 100 AS Claim_Percentage
FROM Claims
GROUP BY Claim_Status;

--for product
--which product has the most claims
Select top 1 product, COUNT(*) as claim_count from claims c join policies p on c.Policy_ID=p.Policy_ID group by p.Product order by claim_count desc

-- top claim by product

Select top 1 product, round(sum(Claim_Amount),2) as claim_amount from claims c join policies p on c.Policy_ID=p.Policy_ID  group by p.Product order by claim_amount desc