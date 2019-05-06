%% gausselipiv: eliminação gaussiana com pivotamento parcial
function [] = gausselipiv(A, b, n)
	x = zeros(n, 1); %forma de inicializar array

	%elimination
	for k = 1:n-1 %para cada linha k
		% note bem a implementação elegante pra caralho dessa função de sorting
		pivoted = k;
		pivoted = pivot(A, n, k); %acha o pivo da coluna k
		if pivoted ~= k %se o índice for diferente do que já era (k)
			%trocas na matriz A
			tmp = A(k,:);
			A(k,:) = A(pivoted,:);
			A(pivoted,:) = tmp;

			%trocas no vetor B
			tmp = b(k); %estore b(k)
			b(k) = b(pivoted) %troque b(k) por b(pivotado)
			b(pivoted) = tmp; %faça b(pivotado) ser b(k)
		end
		for i = k+1:n %usando i e j para iterar sobre todos os elementos da matriz que estejam abaixo da primeira linha
			mult = A(i,k) / A(k, k); %
			%A(i, k) = mult;
			for j = 1:n
				A(i,j) = A(i,j) - mult*A(k,j);
			end
			b(i) = b(i) - mult*b(k); %como não possuem colunas para se iterar em B, vai pra fora de j.
		end
	end

	%retrosubstitution
	x(n) = b(n) / A(n,n); %última linha
	for i = n-1:-1:1 %como já se resolveu a última linha ^
		for j = i+1:n %iterando sobre os elementos das linhas
			x(i) = b(i) - A(i, j)*x(j);
		end
		x(i) = x(i) / A(i,i);
	end
	A
	x
end


%% pivoting: busca o maior coeficiente na matriz A de tamanho n na coluna k
function pivotIndice = pivot(A, n, k)
	%busca o maior coeficiente na coluna k
	pivotIndice = k;
	pivot = abs(A(k,k));
	for i = k+1:n
		p = abs(A(i, k));
		if p > pivot
			pivot = p; 
			pivotIndice = i;
		end
	end
end
