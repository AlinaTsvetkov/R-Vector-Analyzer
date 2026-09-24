library(glue)

measurements <- c(
    75,
    120,
    NA,
    980,
    45,
    0,
    650,
    NA,
    1500,
    300
)

valid_measurements <- measurements[!is.na(measurements)]
invalid_measurements <- measurements[is.na(measurements)]
suspicious_measurements <- valid_measurements[valid_measurements < 10 | valid_measurements > 1000]
queried_measurements <- valid_measurements[valid_measurements >= 50 & valid_measurements <= 1000]
measurements_out_of_query <- valid_measurements[valid_measurements < 50 | valid_measurements > 1000]

print(glue("
VECTOR ANALYZER SUMMARY:

- VALID MEASUREMENTS:                           {paste(valid_measurements, collapse=', ')} 
- TOTAL OF VALID MEASUREMENTS:                  {length(valid_measurements)}
- TYPEOF VECTOR:                                {typeof(measurements)}
- VECTOR'S CLASS:                               {class(measurements)}
- VECTOR'S LENGTH (INCLUDING NA REGISTRIES):    {length(measurements)}

DATA VALIDATION:

- TOTAL OF MEASUREMENTS:                        {length(measurements)}
- TOTAL OF VALID MEASUREMENTS:                  {length(valid_measurements)}
- TOTAL OF NA REGISTRIES:                       {length(invalid_measurements)}
- NA REGISTRIES'S POSITION:                     {paste(which(is.na(measurements)), collapse=', ')}
- PERCENTAGE OF NA REGISTRIES IN MEASUREMENTS:  {(length(invalid_measurements) / length(measurements) * 100)}%

MEASUREMENT SCREENING:

- SUSPICIOUS MEASUREMENTS:                      {paste(suspicious_measurements, collapse=', ')}
- TOTAL OF SUSPICIOUS MEASUREMENTS:             {length(suspicious_measurements)}
- SUSPICIOUS MEASUREMENTS'S POSITION:           {paste(which(measurements < 10 | measurements > 1000), collapse=', ')}
- AT LEAST ONE SUSPICIOUS MEASUREMENT EXISTS?:   {ifelse(any(valid_measurements < 10 | valid_measurements > 1000), 'Yes', 'No')}

STATISTICAL ANALYSIS:

- SUM OF VALID MEASUREMENTS:                    {sum(valid_measurements)}
- ARITHMETIC MEAN OF VALID MEASUREMENTS:        {mean(valid_measurements)}
- BIGGEST MEASUREMENT IN VECTOR:                {max(valid_measurements)}
- SMALLEST MEASUREMENT IN VECTOR:               {min(valid_measurements)}
- BIGGEST MEASUREMENT'S POSITION:               {which.max(measurements)}
- SMALLEST MEASUREMENT'S POSITION:              {which.min(measurements)}

QUERY ANALYSIS (MEASUREMENTS BETWEEN 50 AND 1000):

- QUERIED MEASUREMENTS:                         {paste(queried_measurements, collapse=', ')}
- TOTAL OF QUERIED MEASUREMENTS:                {length(queried_measurements)}
- QUERIED MEASUREMENTS'S POSITION:              {paste(which(measurements >= 50 & measurements <= 1000), collapse=', ')}
- MEASUREMENTS OUT OF QUERY ANALYSIS:           {paste(measurements_out_of_query, collapse=', ')}
- TOTAL OF MEASUREMENTS OUT OF QUERY ANALYSIS:  {length(measurements_out_of_query)}
- ARE ALL VALID MEASUREMENTS IN QUERY RANGE?:   {ifelse(all(valid_measurements >= 50 & valid_measurements <= 1000), 'Yes', 'No')}

POSITION ANALYSIS:

- VALID MEASUREMENTS'S POSITION:                {paste(which(!is.na(measurements)), collapse=', ')}
- SUSPICIOUS MEASUREMENTS'S POSITION:           {paste(which(!is.na(measurements) & (measurements < 10 | measurements > 1000)), collapse=', ')}
- BIGGEST MEASUREMENT'S POSITION:               {which.max(measurements)}
- SMALLEST MEASUREMENT'S POSITION:              {which.min(measurements)}
- MEASUREMENTS IN QUERY'S POSITION:             {paste(which(measurements >= 50 & measurements <= 1000), collapse=', ')}
- NA REGISTRIES'S POSITION:                     {paste(which(is.na(measurements)), collapse=', ')}

LOGICAL DATA CHECKS:

- DO NA REGISTRIES EXIST?:                      {any(is.na(measurements))}
- DO SUSPICIOUS MEASUREMENTS EXIST?:            {any(valid_measurements < 10 | valid_measurements > 1000)}
- ARE ALL MEASUREMENTS IN ACCEPTABLE RANGE?:    {all(valid_measurements >= 50 & valid_measurements <= 1000)}
- ARE ALL MEASUREMENTS POSITIVE VALUES?:        {all(valid_measurements > 0)}
- AT LEAST ONE VALID MEASUREMENT EXIST?:        {any(valid_measurements >= 50 & valid_measurements <= 1000)}

VECTOR OPERATIONS:

- VALID MEASUREMENTS + 10:                      {paste(valid_measurements + 10, collapse=', ')}
- VALID MEASUREMENTS * 2:                       {paste(valid_measurements * 2,  collapse=', ')}
- VALID MEASUREMENTS ^ 2:                       {paste(valid_measurements ^ 2,  collapse=', ')}
- DIFFERENCE FROM 500:                          {paste(valid_measurements - 500, collapse=', ')}

ANALYSIS REPORT:

- MISSING DATA STATUS:                          {ifelse(length(invalid_measurements) > 0, glue('There are {length(invalid_measurements)} missing measurements you must check in'), 'Nothing to fix in')}
- SUSPICIOUS DATA STATUS:                       {ifelse(length(suspicious_measurements) > 0, glue('There are {length(suspicious_measurements)} suspicious measurements you must check in'), 'Nothing to fix in')}
- QUERY RANGE DATA STATUS:                      {glue('There are {length(queried_measurements)} queried measurements')}
- POSITIVE DATA STATUS:                         {glue('There are {length(valid_measurements[valid_measurements > 0])} positive measurements')}
"))
