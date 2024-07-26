create database insurance;
use insurance

-- select all the columns for all the patients
select * from insurance_data;

-- display the average claim amount for patients in each region
select region, avg(claim) as avg_claim from insurance_data group by region;

-- select the maximum and minimum BMI values in the table
select max(bmi) as max_bmi,min(bmi) as min_bmi from insurance_data;

-- select the PatientID,age and BMI for patients with a BMI between 40 and 50
select PatientID,age,bmi from insurance_data where bmi between 40 and 50;

-- select the numbers of smokers in each region
select region,count(PatientID) from insurance_data where smoker="yes" group by region;

-- average claim amount for patients who are both diabetic and smokers
select avg(claim) as avg_claim from insurance_data where diabetic="yes" and smoker="yes";

-- Retrieve all the patients who have a BMI greater than the average BMI of patients who are smokers
select * from insurance_data where smoker ="yes" and bmi > (select avg(bmi) from insurance_data where smoker="yes");
select avg(bmi) from insurance_data where smoker="yes";

-- select the average claim amount for patients in each age group
select
   case when age < 18 then "under 18"
   when age between 18 and 30 then "18-30"
   when age between 31 and 50 then "31-50"
   else "over 50"
   end as age_group ,
   round(avg(claim),2) as avg_claim
   from insurance_data group by age_group ;
   
   -- retrieve the total claim amount for each patient,along with the average claim amount across all patient
   select PatientID,sum(claim) over(partition by PatientID) as totail_claim,
   avg(claim) over() as avg_claim from insurance_data;
      select* ,sum(claim) over(partition by PatientID) as totail_claim,
   avg(claim) over() as avg_claim from insurance_data;
   
   -- retrieve the top 3 patient with the highest claim amount,along with their respective claim amount and the total claim amount for all patients
   select PatientID,claim,sum(claim) over() as total_claim from insurance_data
   order by claim desc limit 3;
   
   -- select the details of patients who have a claim amount greater than the average claim amount for their region
   select * from (select *,avg(claim) over (partition by region)
   as avg_claim from insurance_data) as subquery where claim > avg_claim;
   
   -- retrieve the rank of each patient based on their claim amount
   select* ,rank() over(order by claim desc) from insurance_data;
   
   -- select the details of patients along with their claim amount and their rank based on claim amount within their region
   select * ,rank() over(partition by region order by claim desc) from insurance_data;
   
   