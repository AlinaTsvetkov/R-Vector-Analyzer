library(glue)

measurements <- c(
    20,
    506,
    2345,
    20,
    NA,
    1,
    57,
    NA,
    234,
    1045
)

valid_measurements <- measurements[!is.na(measurements)]
invalid_measurements <- measurements[is.na(measurements)]
suspicious_measurements <- valid_measurements[valid_measurements < 10 | valid_measurements > 1000]
queried_measurements <- valid_measurements[valid_measurements > 50 & valid_measurements < 1000]
measurements_out_of_query <- valid_measurements[valid_measurements <= 50 | valid_measurements >= 1000]

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
- QUERIED MEASUREMENTS'S POSITION:              {paste(which(measurements > 50 & measurements < 1000), collapse=', ')}
- MEASUREMENTS OUT OF QUERY ANALYSIS:           {paste(measurements_out_of_query, collapse=', ')}
- TOTAL OF MEASUREMENTS OUT OF QUERY ANALYSIS:  {length(measurements_out_of_query)}
- ARE ALL VALID MEASUREMENTS IN QUERY RANGE?:   {ifelse(all(valid_measurements > 50 & valid_measurements < 1000), 'Yes', 'No')}
"))

