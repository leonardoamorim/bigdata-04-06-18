lista_item = load '/user/admin/4linux/u.item'
using PigStorage('|') 
as (filmeID: int, 
    filmeTitulo:chararray, 
    dataLancamento:chararray,
    videoLancamento:chararray,
    link:chararray);
    
ratings = load '/user/admin/4linux/u.data' as (userId:int, movieID:int, rating:int, ratingTime:int);

ratingsByMovie = group ratings by movieID;
--avgRatings = foreach ratingsByMovie generate group as movieID, AVG(ratings.rating) as avgRating;
--sortedByRating = order avgRatings by avgRating desc;

sortedByRating = order (foreach ratingsByMovie generate group as movieID, AVG(ratings.rating) as avgRating) by avgRating desc;
cutsort = filter sortedByRating by avgRating >= 4.5;
final = order (join cutsort by movieID, lista_item by filmeID) by avgRating desc;
dump final;