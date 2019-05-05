%% gausseli: function description
function [x] = gausseli(A, b, n)
	x = zeros(n, 1);

	%elimination
	for k = 1:n-1 %para cada linha k
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