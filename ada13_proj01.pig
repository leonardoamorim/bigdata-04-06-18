lista_filmes = LOAD '/user/admin/4linux/u.item' USING PigStorage('|') AS 
	(filmeID: int, filmeTitulo: chararray, dataLancamento: chararray, videoLancamento: chararray, link: chararray);
lista_ratings = LOAD '/user/admin/4linux/u.data' AS
    (usuarioID: int, filmeID: int, classificacao: int, data: int);
ratings_movie = GROUP lista_ratings BY filmeID;
media_ratings = FOREACH ratings_movie GENERATE group as filmeID, AVG(lista_ratings.classificacao) AS Media;
JuntaPontos = JOIN lista_filmes BY filmeID RIGHT, media_ratings BY filmeID;
MaiorQueQuatro = FILTER JuntaPontos BY Media > 4;
Display = FOREACH MaiorQueQuatro GENERATE (chararray) $1 AS Nome, (double) $6 AS Nota;
DisplayOrder = ORDER Display BY Nota DESC;
TOP10 = LIMIT DisplayOrder 20;
DUMP TOP10;
