lista_data = LOAD '/user/admin/4linux/u.data' 
			 AS (usuarioID: int, filmeID: int, 
				 classificacao: int, data: int);

lista_item = LOAD '/user/admin/4linux/u.item' USING PigStorage ('|') AS 
			(filmeID: int, filmeTutulo: chararray, dataLancamento: chararray, 
             videoLancamento: chararray, link:chararray);
             
     
tbl_full = join lista_data by filmeID, lista_item by filmeID;
/*DESCRIBE inner_join;*/

tbl_foreach = foreach tbl_full generate (chararray)lista_data::filmeID,
										(chararray)lista_item::filmeTutulo,
                                        (int)lista_data::classificacao;
/*describe tbl_foreach;*/

tbl_rating = Filter tbl_foreach by lista_data::classificacao > 4;

resultado = distinct tbl_rating;

dump resultado;

/*count = foreach resultado generate count (1);

dump count;*/

