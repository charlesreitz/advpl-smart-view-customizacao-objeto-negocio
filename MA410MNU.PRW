/*/{Protheus.doc} MA410MNU
	
	Este ponto de entrada pode ser utilizado para inserir novas opções no array aRotina.

	@author TSCB87 - Leandro Inocencio
	@since 29/10/2020
	@see https://tdn.totvs.com/display/public/PROT/MA410MNU
/*/

User Function MA410MNU()


	aadd(aRotina,{'Imprimir Smartview Com Interface','U_PrintSM' , 0 , 2,0,NIL})
	aadd(aRotina,{'Imprimir Smartview Sem Interface','U_PrintSI' , 0 , 2,0,NIL})

Return

User Function PrintSM()
	local lSuccess As logical
	local oSmartView as object

	oSmartView := totvs.framework.smartview.callSmartView():new("custom.meucliente.faturamento.trp")
	oSmartView:setParam("MV_PAR01", "000001")
	oSmartView:setParam("MV_PAR02", "000400")

	lSuccess := oSmartView:executeSmartView()

	If !lSuccess
		alert(oSmartView:getError())
	EndIf

	oSmartView:destroy()
Return


User Function PrintSI()
	
	FWMsgRun( /* Obj_tela */ , {|oSay| PrintSI() } , "Gerando Relatório" , "Aguarde")

Return

Static Function PrintSI()
	Local cSpool 			:= SuperGetMV('MV_RELT',,"\SPOOL\")
	Local cFile 			:= FWUUIDV4()
	Local cExtensao 		:= 'pdf'
	Local cFullFilePath 	:= cSpool+cFile+"."+cExtensao
	Local cDrive, cDir, cNome, cExt

	If File(cFullFilePath)
		FErase(cFullFilePath)
	EndIf
	//Para geração sem interface sempre deverá ser setado um recurso único -  - 
	oSmartView := totvs.framework.smartview.callSmartView():new("custom.meucliente.faturamento.trp", "report")
	oSmartView:setNoInterface(.T.)
	oSmartView:setParam("MV_PAR01",  "000001")
	oSmartView:setParam("MV_PAR02", "000001")
	oSmartView:setPrintType(1)

	jPrint := jsonObject():new()
	jPrint["extension"] := cExtensao
	jPrint["name"] 		:= cFile
	jPrint["path"] 		:= cSpool

	oSmartView:setPrintInfo(jPrint)

	lSuccess := oSmartView:executeSmartView()

	If !lSuccess
		alert(oSmartView:getError())
	EndIf
	oSmartView:destroy()

	If FIle(cFullFilePath) .AND. !IsBlind()
		If CpyS2T(cFullFilePath, GetTempPath(.T.), .T. )
			cDrive	:=	""
			cDir	:=	""
			cNome	:=	""
			cExt	:= ""
			SplitPath(cFullFilePath, @cDrive, @cDir, @cNome, @cExt )
			If ShellExecute("Open",cNome+cExt,"", GetTempPath(.T.),3) == 0
				FWalerterror("Não foi possível abrir o arquivo de LOG, verifique no caminho ->"+GetTempPath(.T.)+'\'+::cFileLog,"Atenção - "+Procname()+" - "+cvaltochar(procLine()))
			EndIf
		Else
			FWalerterror("Não foi possível copiar o arquivo para máquina local","Atenção - "+Procname()+" - "+cvaltochar(procLine()))
		EndIf
	EndIf
Return

