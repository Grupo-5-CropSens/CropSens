# Projeto CropSens

1. Contexto (Cenário do Projeto) 

 
	Problema: A falta de precisão e erros na lavoura que causam prejuízos enormes para os produtores, que não têm dificuldade para identificar a melhor hora de agir para melhorar a performance do plantio.  
 
	O Sensor ultrassônico (HC-SR04) é usado para registrar o momento em que o milho atinge determinada altura, representando o melhor momento para colheita. A partir desse dado, conseguimos gerar gráficos e cálculos de lucro/perda financeira acarretada pela colheita tardia ou pelo crescimento potencializado dessas plantas. A instalação desse sensor, a integração ao banco de dados e os gráficos apresentados por meio de um Dashboard, conseguem nos mostrar o tempo necessário para o milho atingir a altura de colheita, comparar o tempo que levou para atingir a altura para colheita e comparar com as colheitas anteriores, trazendo insights valiosos para o agricultor conseguir tomar as melhores decisões com clareza e respaldo estatístico.

2. Justificativa 

Em 2025, o milho consolidou-se como o 5º produto mais exportado pelo Brasil, ele é um recurso extremamente crucial para a alimentação animal e é utilizado em processos para a produção de etanol. 

O planejamento da colheita do milho visando melhorar o rendimento de forma a facilitar a movimentação da colhedora e o escoamento da colheita pelas carretas ou caminhões é essencial para o Brasil, que tem alcançado números recordes de embarques e faturamento. Apesar da volatilidade dos preços internacionais causada pela ampla oferta global, em um único mês (agosto de 2025) o Brasil arrecadou U$1.377 bilhão com valor de U$201,20 por tonelada de milho. Sendo assim, podemos concluir que a produção de milho para o agronegócio é fundamental para o superávit brasileiro, que foi de US$ 57 bilhões em 2025 e a ausência/ pouca produção dele comprometeria seriamente esse saldo positivo. 

Se o Brasil se retirasse do mercado, perderia espaço imediatamente para competidores agressivos como os Estados Unidos (que tiveram a maior safra da história recentemente) e a Argentina. Recuperar esses mercados e a confiança dos compradores internacionais após uma interrupção seria extremamente difícil e caro.

3. Escopo do Projeto (Inclusões e Exclusões) 

Dentro do Escopo (O que será entregue) 

	Sensor que registra dados do crescimento da planta sendo eles:  

    Altura de colheita  

    Tempo médio até atingir determinadas alturas; colheita  

     Intervalo de tempo destinado a colheita após altura ideal atingida 

 

Site institucional;  

        Versão desktop e mobile;  

        Cadastro/Login;  

        Interface do usuário; 

        Dashboard com gráficos da variação dos registros coletados pelo sensor;  

        Integração com banco de dados;  

        Calculadora de lucro/prejuízo;  

        Métricas estatísticas (analíticas);  

        Alertas baseados nos dados; 

 

Banco de dados;  

        Gravar dados no BD local / nuvem;  

        Ler dados do BD e plotar (gráficos) no Dashboard; 

 

Fora do Escopo (O que NÃO será feito) 

		Sensor que registra dados do crescimento da planta sendo eles:  

        Sensores diferentes;  

        Coleta de dados relacionados aos nutrientes do solo;  

        Coleta de dados relacionados   

        aos nutrientes da planta;  

        Arduíno integrado na rede; 

 

Site institucional;  

    Aplicativo; 

        Cadastro via google ou outros métodos;  

        Instruções de negócio baseadas nas informações;  

        Atendimento exclusivo ao cliente;  

        Calculadora de investimento previsto; 

 

Banco de dados;  

 		Banco de Dados em linguagem que não seja o MySQL; 

		Itens não listados dentro do escopo não serão contemplados nas entregáveis do projeto.

6. Premissas e Restrições 
Abaixo, diferencie o que é assumido como verdade do que é uma limitação imposta. 

   		Premissas 
    	O cliente possuir uma plantação de milho; 

	    O plantio possuir acesso à internet; 
	
	    O cliente possuir um dispositivo desktop ou mobile; 
	
	    O cliente registrar a data do plantio e de colheita de cada lote; 
	
	    Disponibilidade de tempo para análise e correção de produção; 
	

    Restrições
   
   			Manter a plantação ao alcance do sensor HC-SR04; 
		
		    Monitoramento de apenas um ponto amostral; 
		
		    O cliente plantar algo que não seja milho; 
		
		    Posicionamento do sensor; 

   			Condições extremas (ex: calor intenso, muito sujo ou exposto a chuva); 
