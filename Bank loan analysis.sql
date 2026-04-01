

Create database Bank_Loan
use Bank_Loan

select * from financial_loan

select top 10 * from financial_loan

--Find the total number of applications
select count(id) as total_applications from financial_loan

--Find total MTD loan applications
select count(id) as MTD_Applications from financial_loan where month(issue_date)=12 and year(issue_date)=2021

--Total Funded amount
select sum(loan_amount) as total_funded_amount from financial_loan

--Find total MTD funded amount
select sum(loan_amount) as total_MTD_funded_amount from financial_loan where month(issue_date)=12 and year(issue_date)=2021

--Find the total amount received
select sum(total_payment) as total_amount_received from financial_loan

--Find the MTD total amount received
select sum(total_payment) as total_amount_received from financial_loan where month(issue_date)=12 and year(issue_date)=2021

--Calculate the average interest rate across all the loans
select round(avg(int_rate)*100,2) as avg_int_rate from financial_loan

--Calculate the average MTD interest rate across all the loans
select round(avg(int_rate)*100,2) as avg_int_rate from financial_loan where month(issue_date)=12 and year(issue_date)=2021

--Calculate average DTI ratio
select round(avg(dti)*100,2) as avg_dti from financial_loan

--Calculate average MTD DTI ratio
select round(avg(dti)*100,2) as avg_dti from financial_loan where month(issue_date)=12 and year(issue_date)=2021

--Calculate good loan percentage
select 
	count(case when loan_status='Fully Paid' or loan_status='Current' then id end)*100.0/count(id) 
	as good_loan_percentage from financial_loan

--Calculate good loan applications
select count(id) as good_loan_applications from financial_loan where loan_status in ('Fully Paid','Current')

--calculate good loan funded amount
select sum(loan_amount) as good_loan_funded_amount from financial_loan where loan_status in ('Fully Paid','Current')

--calculate good loan received amount amount
select sum(total_payment) as good_loan_received_amount from financial_loan where loan_status in ('Fully Paid','Current')

--Calculate bad loan percentage
select 
	round(count(case when loan_status='Charged off' then id end)*100.0/count(id),2)
	as bad_loan_percentage from financial_loan

--Calculate bad loan applications
select count(id) as bad_loan_applications from financial_loan where loan_status = 'Charged off'


--calculate bad loan funded amount
select sum(loan_amount) as bad_loan_funded_amount from financial_loan where loan_status = 'Charged off'

--calculate bad loan received amount amount
select sum(total_payment) as good_loan_received_amount from financial_loan where loan_status = 'Charged off'

--Create a Loan status grid view
select loan_status,
count(id) as total_loan_applications,
sum(total_payment) as total_amount_received,
sum(loan_amount) as total_funded_amount,
avg(int_rate)*100 as avg_int_rate,
avg(dti)*100 as avg_dti 
from financial_loan
group by loan_status

--Create a MTD Loan status grid view
select loan_status,
sum(total_payment) as MTD_total_amount_received,
sum(loan_amount) as MTD_total_funded_amount 
from financial_loan 
where month(issue_date)=12 
group by loan_status

--Monthly trends by isssue date
select month(issue_date) as month_number,
DATENAME(MONTH,issue_date) as month_name,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received 
from financial_loan
group by month(issue_date),DATENAME(MONTH,issue_date)
order by month(issue_date)

--Regional analysis by state
select address_state,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received 
from financial_loan
group by address_state
order by address_state

--Loan term analysis
select term,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received 
from financial_loan
group by term
order by term

--Employee length analysis
select emp_length,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received 
from financial_loan
group by emp_length
order by emp_length

--Loan purpose breakdown
select purpose,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received 
from financial_loan
group by purpose
order by count(id) desc

--Home ownership analysis
select home_ownership,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received 
from financial_loan
group by home_ownership
order by count(id) desc
