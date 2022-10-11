%identificamos nulos
Matriz_Null= ismissing(texas);
Column_Null= sum(Matriz_Null);
DataFrame_Null= sum(Column_Null);

%sustituimos:
DataFrame_Fill_1 = fillmissing(texas,'previous');
DataFrame_Fill_2 = fillmissing(DataFrame_Fill_1,'next');

%idetificamos nulos
Matriz_Null1= ismissing(DataFrame_Fill_2);
Column_Null1= sum(Matriz_Null1);
DataFrame_Null1= sum(Column_Null1);

%ya no tenemos datos nulos de texas. 


%%%%%%%%%%%%%%% ya no tenemos datos nulos
%---------Identificación de Outliers---------

%Identificamos Matriz de outliers mediante método de quartiles de solamente
%las variables cuantitativas que vamos a utilizar. 
Outliers1 = isoutlier(DataFrame_Fill_2,'quartiles','DataVariables',{'price','minimum_nights','number_of_reviews','reviews_per_month','calculated_host_listings_count','availability_365','number_of_reviews_ltm' });
Column_outliers1= sum(Outliers1);
DataFrame_outliers_quartiles= sum(Column_outliers1); 
%contamos con 1069 datos atípicos. 

%---------Sustitución de Outliers---------
%Rellenamos Outliers por DataFrame usando un método
DataFrame_Filloutliers_1 = filloutliers(DataFrame_Fill_2,'linear','DataVariables',{'price','minimum_nights','number_of_reviews','reviews_per_month','calculated_host_listings_count','availability_365','number_of_reviews_ltm','host_response_rate', 'host_acceptance_rate', 'host_total_listings_count','accommodates', 'bedrooms','beds','maximum_nights','review_scores_rating','review_scores_accuracy','review_scores_cleanliness','review_scores_checkin','review_scores_communication','review_scores_location','review_scores_value','calculated_host_listings_count_entire_homes','calculated_host_listings_count_private_rooms','calculated_host_listings_count_shared_rooms' });
%Identificamos Matriz de outliers mediante método de quartiles
Outliers2 = isoutlier(DataFrame_Filloutliers_1,'quartiles','DataVariables',{'price','minimum_nights','number_of_reviews','reviews_per_month','calculated_host_listings_count','availability_365','number_of_reviews_ltm','host_response_rate', 'host_acceptance_rate', 'host_total_listings_count','accommodates', 'bedrooms','beds','maximum_nights','review_scores_rating','review_scores_accuracy','review_scores_cleanliness','review_scores_checkin','review_scores_communication','review_scores_location','review_scores_value','calculated_host_listings_count_entire_homes','calculated_host_listings_count_private_rooms','calculated_host_listings_count_shared_rooms' });
%Identificamos la cantidad de outliers por Columna
Column_outliers2= sum(Outliers2);
%Identificamos la cantidad de datos atipicos por DataFrame
DataFrame_outliers_quartiles2= sum(Column_outliers2); 

room_type=DataFrame_Filloutliers_1(:,34);
property_type=DataFrame_Filloutliers_1(:,33);
neighbourhood_cleansed=DataFrame_Filloutliers_1(:,28);

data = addvars(DataFrame_Filloutliers_1, room_type, property_type, neighbourhood_cleansed);

datacuanti = DataFrame_Fill_2(:,[ 41,42, 57,75, 71, 55,58, 17, 18, 35, 38, 39, 43, 62, 63, 64, 65, 66, 67, 68, 72, 73, 74]);

Matriz=table2array(datacuanti); 
Mat_Corr=corrcoef(Matriz);
h = heatmap(Mat_Corr)

