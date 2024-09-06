#include 'PROTHEUS.CH'
user function DEBUGREST()
	//O nome do job REST e ambiente de execução dele, podem ser obtidos no arquivo
	//de configuração do _appServer_.
	//Detalhes da função em https://tdn.totvs.com/display/tec/StartJob
	startjob("HTTP_START", GetEnvServer(), .T.) //lwait, sempre dever ser false
	// sleep(15000) //aguarda o serviço ser inicializado. Ajuste o tempo se necessário.
	alert(">> Serviço REST inicializado. <<")
return
