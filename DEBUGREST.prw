#include 'PROTHEUS.CH'
user function DEBUGREST()
	//O nome do job REST e ambiente de execu��o dele, podem ser obtidos no arquivo
	//de configura��o do _appServer_.
	//Detalhes da fun��o em https://tdn.totvs.com/display/tec/StartJob
	startjob("HTTP_START", GetEnvServer(), .T.) //lwait, sempre dever ser false
	// sleep(15000) //aguarda o servi�o ser inicializado. Ajuste o tempo se necess�rio.
	alert(">> Servi�o REST inicializado. <<")
return
