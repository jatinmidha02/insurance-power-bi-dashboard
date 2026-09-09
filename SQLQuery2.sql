Create database insurance;

use insurance;

CREATE TABLE Customers (
    Customer_ID VARCHAR(10) PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(20),
    Region VARCHAR(50)
);


CREATE TABLE Policies (
    Policy_ID VARCHAR(10) PRIMARY KEY,
    Customer_ID VARCHAR(10),
    Product VARCHAR(50),
    Policy_Start DATE,
    Premium DECIMAL(12,2),

    FOREIGN KEY (Customer_ID)
    REFERENCES Customers(Customer_ID)
);

CREATE TABLE Claims (
    Claim_ID VARCHAR(10) PRIMARY KEY,
    Policy_ID VARCHAR(10),
    Claim_Date DATE,
    Claim_Amount DECIMAL(12,2),
    Claim_Status VARCHAR(50),
    Processing_Days INT,

    FOREIGN KEY (Policy_ID)
    REFERENCES Policies(Policy_ID)
);
ALTER TABLE Customers
ADD CONSTRAINT PK_Customers
PRIMARY KEY (Customer_ID);

Alter table Policies 
Add constraint fk_policies_customer 
foreign key (customer_id)
references customers(customer_id)

Alter table claims
add constraint fk_claims_policy
foreign key (policy_id)
references Policies(Policy_id)

drop table claims

drop table policies

drop table customers