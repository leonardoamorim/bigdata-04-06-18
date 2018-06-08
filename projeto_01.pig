lista_data = LOAD '/user/admin/u.data' AS (usuarioID: int, filmeID: int, classificacao: int, data: int);
lista_item = LOAD '/user/admin/u.item' using PigStorage('|') AS (filmeID: int, filmeTitulo: chararray, dataLancamento: chararray, videoLancamento: chararray, link: chararray);
inner_join = JOIN lista_data BY filmeID, lista_item BY filmeID;

classif_filter = FILTER inner_join by lista_data.classificacao >4.0;

PROJETO_PIG_01 = FOREACH classif_filter GENERATE filmeID, classificacao, filmeTitulo;

dump PROJETO_PIG_01;

---DUMP classif_filter;

---STORE inner_join INTO 'outputItem' USING PigStorage(';');

====================================

Correção

lista_data = LOAD '/user/admin/u.data' AS (usuarioID: int, filmeID: int, classificacao: int, data: int);
lista_item = LOAD '/user/admin/u.item' using PigStorage('|') AS (filmeID: int, filmeTitulo: chararray, dataLancamento: chararray, videoLancamento: chararray, link: chararray);

classifcacao_por_filme = GROUP lista_data BY filmeID;

avgRatings = FOREACH classifcacao_por_filme GENERATE group AS filmeID,
    AVG(lista_data.classificacao) AS avgRating;
    
cincoestrelas = FILTER avgRatings BY avgRating > 4.0;

dump cincoestrelas;

=====================================

lista_data = LOAD '/user/admin/u.data' AS (usuarioID: int, filmeID: int, classificacao: int, data: int);
lista_item = LOAD '/user/admin/u.item' using PigStorage('|') AS (filmeID: int, filmeTitulo: chararray, dataLancamento: chararray, videoLancamento: chararray, link: chararray);

classifcacao_por_filme = GROUP lista_data BY filmeID;

avgRatings = FOREACH classifcacao_por_filme GENERATE group AS filmeID,
    AVG(lista_data.classificacao) AS avgRating;
    
cincoestrelas = FILTER avgRatings BY avgRating > 4.0;

b = foreach cincoestrelas generate (int) $1 as IDFILME;

dump b;
