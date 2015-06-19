program prog1;

{Cabecalho}

{*** Definicao de tipos. Aqui, 'date' e um registro que armazena dia, mes
e ano; ***}
type date = record
	d: integer;
	m: integer;
	a: integer;
	end;
func = record {Registro 'funcionario'}
	cod: integer;
	nome: string[30];
	salario: real;
	dt_adm: date;
	end;

{*** Declaracao de rotulos ***}
label prox;

{*** Declaracao das variaveis. ***}
var
	func_t: func; {Funcionario "intermediario" usado para entrada e validacao}
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
    if func_t.cod = 9999 then begin Close(arq_func); halt; end;
    {Valida o c¢digo}
	while (func_t.cod <> 9999) do
	begin
		while not(func_t.cod > 0) do
		begin
			write('C¢digo invalido (menor ou igual a zero). Deseja redigitar o campo? s/n: '); read(r);
			while (r <> 's') and (r <> 'S') and (r <> 'n') and (r <> 'N') do
			begin
				write('Resposta invalida. Digite novamente: '); read(r);
			end;
			if (r = 'n') or (r = 'N') then goto prox;
			write('C¢digo do funcionario: '); readln(func_t.cod);
		end;

		write('Nome do funcionario: '); readln(func_t.nome);
		{Valida o nome}
		while not(func_t.nome[1] in ['A'..'Z']) do
		begin
			write('Nome invalido (primeira letra deve ser maiuscula). Deseja redigitar o campo? s/n: '); readln(r);
			while (r <> 's') and (r <> 'S') and (r <> 'n') and (r <> 'N') do
			begin
				write('Resposta invalida. Digite novamente: '); readln(r);
			end;
			if (r = 'n') or (r = 'N') then goto prox;
			write('Nome do funcionario: '); readln(func_t.nome);
		end;

		write('Salario: '); readln(func_t.salario);
		{Valida o salário}
		while not(func_t.salario > 0) do
		begin
			write('Salário invalido. Deseja redigitar o campo? s/n: '); readln(r);
			while (r <> 's') and (r <> 'S') and (r <> 'n') and (r <> 'N') do
			begin
				write('Resposta invalida. Digite novamente: '); read(r);
			end;
			if (r = 'n') or (r = 'N') then goto prox;
			write('Salario: '); readln(func_t.salario);
		end;

		write('Data de admissao (formato dd/mm/aaaa): '); readln(dataStr);
		{Valida a data}
		repeat
            valid := true;
			if not (dataStr[3] = '/') or not (dataStr[6] = '/') then valid := false
			else
			begin
				{Converte a string para registro data de admissão do funcionário}
				dia := 0; mes := 0; ano := 0;
				dia := dia + (Ord(dataStr[1])-48)*10 + (Ord(dataStr[2])-48); write(dia);
				mes := mes + (Ord(dataStr[4])-48)*10 + (Ord(dataStr[5])-48); write(mes);
				ano := ano + (Ord(dataStr[7])-48)*1000 + (Ord(dataStr[8])-48)*100 + (Ord(dataStr[9])-48)*10 + (Ord(dataStr[10])-48);
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
				write('A data informada nao e valida. Deseja digitar novamente? s/n: '); readln(r);
				while (r <> 's') and (r <> 'S') and (r <> 'n') and (r <> 'N') do
				begin
					write('Resposta invalida. Digite novamente: '); read(r);
				end;
				if (r = 'n') or (r = 'N') then goto prox;
				write('Data de admissao: '); readln(dataStr);
			end;
		until valid;
		func_t.dt_adm.d := dia;
		func_t.dt_adm.m := mes;
		func_t.dt_adm.a := ano;
		{Gravar os dados validados}
		Write(arq_func, func_t);
        writeln('Registro gravado com sucesso.');
		{Entrada do proximo funcionario}
        prox:
        write('Deseja inserir mais um registro? s/n: '); readln(r);
        while(r <> 's') and (r <> 'S') and (r <> 'n') and (r <> 'N') do
		begin
            write('Resposta invalida. Digite novamente: '); read(r);
        end;
        if (r = 'n') or (r = 'N') then begin Close(arq_func); halt; end;
		write('C¢digo do funcion rio: '); readln(func_t.cod);
		if func_t.cod = 9999 then begin Close(arq_func); halt; end;
	end;
end.