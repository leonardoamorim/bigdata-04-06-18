lista_data = LOAD '/user/admin/u.data' AS (usuarioID: int, filmeID: int, classificacao: int, data: int);
lista_item = LOAD '/user/admin/u.item' using PigStorage('|') AS (filmeID: int, filmeTitulo: chararray, dataLancamento: chararray, videoLancamento: chararray, link: chararray);

classifcacao_por_filme = GROUP lista_data BY filmeID;

avgRatings = FOREACH classifcacao_por_filme GENERATE group AS filmeID,
    AVG(lista_data.classificacao) AS avgRating;
    
cincoestrelas = FILTER avgRatings BY avgRating > 4.0;

b = foreach cincoestrelas generate (int) $1 as IDFILME;

c = LIMIT b 5;

dump c;
