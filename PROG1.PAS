program prog1;


{Cabe‡alho}

{*** Defini‡ao de tipos. Aqui, 'date' ‚ um registro que armazena dia, mˆs
e ano; ***}
type date = record
	d: integer;
	m: integer;
	a: integer;
	end;
func = record {Registro 'funcion rio'}
	cod: integer;
	nome: string[30];
	salario: real;
	dt_adm: date;
	end;

{*** Declara‡ao de fun‡oes e procedimentos ***}


{*** Declara‡ao das vari veis. ***}
var
	func_t: func;
	arq_func: file of func;
	r: char;
	dataStr: string[10];
   
	valid: boolean;
	dia, mes, ano: integer;
	biss: boolean;
	diaMesCap: integer;

{Algoritmo}

begin
    assign(arq_func, 'arq_func.dat');
    rewrite(arq_func);

{*** Entrada de dados ***}
    write('C¢digo do funcion rio: '); readln(func_t.cod);
    if func_t.cod = 9999 then halt;
    {Valida o c¢digo}
	while (func_t.cod <> 9999) do
	begin
		while not(func_t.cod > 0) do
		begin
			write('C¢digo inv lido (menor ou igual a zero). Deseja redigitar o campo? s/n: '); read(r);
			while (r <> 's') and (r <> 'S') and (r <> 'n') and (r <> 'N') do
			begin
				write('Resposta inv lida. Digite novamente: '); read(r);
			end;
			if (r = 'n') or (r = 'N') then halt;
			write('C¢digo do funcion rio: '); readln(func_t.cod);
		end;

		write('Nome do funcion rio: '); readln(func_t.nome);
		{Valida o nome}
		while not(func_t.nome[1] in ['A'..'Z']) do
		begin
			write('Nome inválido (primeira letra deve ser maiúscula). Deseja redigitar o campo? s/n: '); readln(r);
			while (r <> 's') and (r <> 'S') and (r <> 'n') and (r <> 'N') do
			begin
				write('Resposta inv lida. Digite novamente: '); readln(r);
			end;
			if (r = 'n') or (r = 'N') then halt;
			write('Nome do funcion rio: '); readln(func_t.nome);
		end;

		write('Sal rio: '); readln(func_t.salario);
		{Valida o salário}
		while not(func_t.salario > 0) do
		begin
			write('Salário inválido. Deseja redigitar o campo? s/n: '); readln(r);
			while (r <> 's') and (r <> 'S') and (r <> 'n') and (r <> 'N') do
			begin
				write('Resposta inv lida. Digite novamente: '); read(r);
			end;
			if (r = 'n') or (r = 'N') then halt;
			write('Sal rio: '); readln(func_t.salario);
		end;

		write('Data de admissao (dd/mm/aaaa): '); readln(dataStr);
		{Valida a data}
		repeat
			if not (dataStr[3] = '/') or not (dataStr[6] = '/') then valid := false
			else
			begin
				{Converte a string para registro data de admissão do funcionário}
				dia := 0; mes := 0; ano := 0;
				dia := dia + Integer(dataStr[1])*10 + Integer(dataStr[2]); write(dia);
				mes := mes + Integer(dataStr[4])*10 + Integer(dataStr[5]); write(mes);
				ano := ano + Integer(dataStr[7])*1000 + Integer(dataStr[8])*100 + Integer(dataStr[9])*10 + Integer(dataStr[10]);
                                write(ano);
				if not (ano > 0) then valid := false
				else
				begin
					if not (mes > 0) or not (mes < 13) then valid := false
					else
					begin
						if mes = 2 then
						begin
							if ano mod 4 = 0 then biss := true;
							if ano mod 100 = 0 then biss := false;
							if ano mod 400 = 0 then biss := true;
							if biss then diaMesCap := 29 else diaMesCap := 28;
						end;
						if (mes = 1) or (mes = 3) or (mes = 5) or (mes = 7) or (mes = 8) or (mes = 10) or (mes = 12) then diaMesCap := 31;
						if (mes = 4) or (mes = 6) or (mes = 9) or (mes = 11) then diaMesCap := 30;
						if not (dia > 0) or not (dia <= diaMesCap) then valid := false;
					end;
				end;
			end;
			if not valid then
			begin
				write('A data informada não é válida. Deseja digitar novamente? s/n: '); readln(r);
				while (r <> 's') and (r <> 'S') and (r <> 'n') and (r <> 'N') do
				begin
					write('Resposta inv lida. Digite novamente: '); read(r);
				end;
				if (r = 'n') or (r = 'N') then halt;
				write('Data de admissão: '); readln(dataStr);
			end; 
		until valid;
		{Gravar os dados validados}
		
		write('C¢digo do funcion rio: '); readln(func_t.cod);
		end;

end.