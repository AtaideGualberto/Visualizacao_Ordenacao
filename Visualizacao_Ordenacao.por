programa
{
	inclua biblioteca Graficos --> g
	inclua biblioteca Util --> u

	const inteiro ALG = 9 // Número de algoritmos de ordenação
	const inteiro CASOS = 3 // Número de casos (pior, médio e melhor)
	
	inteiro largura_janela = 1280 // Pixels
	inteiro altura_janela =  512  // Pixels
	
	const inteiro N = 256 // Quantidade de números a serem ordenados

	inteiro cor_fundo = g.criar_cor(0, 0, 0) // Cor: preto
	inteiro cor_retangulo = g.criar_cor(50, 255, 120) // Cor: algum tipo de verde

	inteiro largura_retangulo = largura_janela/N // Largura dos retângulos que vão aparecer na tela

	funcao inicio()
	{
		inteiro algoritmo_escolhido, caso_escolhido, v[N]
		inteiro denovo = 1
		cadeia algoritmos[ALG] = {"Bubble", "Selection", "Insertion", "Shell", "Heap", "Merge", "Quick", "Counting", "Radix"}
		cadeia casos[CASOS] = {"Pior Caso", "Caso Médio", "Melhor Caso"}

		enquanto(denovo == 1)
		{
			para(inteiro i = 0; i < ALG; i++)
			{
				escreva("[", i+1, "] ", algoritmos[i], "\n")
			}
			escreva("\nEscolha qual algoritmo de ordenação deseja visualizar: ")
			leia(algoritmo_escolhido)

			escreva("\n")
			para(inteiro i = 0; i < CASOS; i++)
			{
				escreva("[", i+1, "] ", casos[i], "\n")
			}
			escreva("\nEscolha qual caso deseja visualizar: ")
			leia(caso_escolhido)

			inicializar_modo_grafico() // Cria uma janela gráfica
			testa_algoritmo(algoritmo_escolhido - 1, caso_escolhido - 1, v)
			u.aguarde(1000) // Espera 1s
			finalizar_modo_grafico() // Fecha a janela gráfica

			escreva("\nDeseja ver outro algoritmo? [1] Sim, [0] Não: ")
			leia(denovo)
		}
	}

	funcao testa_algoritmo(inteiro algoritmo, inteiro Caso, inteiro &v[])
	{
		escolha(Caso)
		{
			caso 0: // Pior caso
				pior_caso(v)
			pare

			caso 1: // Caso médio
				caso_medio(v, verdadeiro)
			pare

			caso 2: // Melhor caso
				melhor_caso(v)
			pare

			caso contrario:
				escreva("\nCaso inválido!\n")
				retorne
		}

		desenha_vetor(v, 1) // Desenha o vetor na tela
		u.aguarde(1000) // Espera 1s
		
		escolha(algoritmo)
		{
			caso 0: // Bubble sort
				bubble_sort(v)
			pare
			
			caso 1: // Selection sort
				selection_sort(v)
			pare

			caso 2: // Insertion sort
				insertion_sort(v)
			pare

			caso 3: // Shell sort
				shell_sort(v)
			pare

			caso 4: // Heap sort
				heap_sort(v)
			pare

			caso 5: // Merge sort
				merge_sort(v, 0, N-1)
			pare

			caso 6: // Quick sort
				quick_sort(v, 0, N)
			pare

			caso 7: // Counting sort
				counting_sort(v, N-1)
			pare

			caso 8: // Radix sort
				radix_sort(v)
			pare

			caso contrario:
				escreva("\nAlgoritmo inválido!\n")
				retorne
		}
	}
	
	funcao inicializar_modo_grafico() // Cria janela gráfica
	{
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_dimensoes_janela(largura_janela, altura_janela)
		g.definir_titulo_janela("Algoritmos de Ordenação")
	}

	funcao melhor_caso(inteiro &v[]) // Cria vetor ordenado em ordem crescente
	{
		para(inteiro i = 0; i < N; i++)
		{
			v[i] = i
		}
	}
	
	funcao caso_medio(inteiro &v[], logico criarVetor) // Cria vetor com números embaralhados
	{
		se(criarVetor)
		{
			melhor_caso(v)
		}

		embaralha_vetor(v)
	}

	funcao pior_caso(inteiro &v[]) // Ordenado em ordem decrescente
	{
		para(inteiro i = 0; i < N; i++)
		{
			v[i] = N - i - 1
		}
	}

	funcao embaralha_vetor(inteiro &v[]) // Embaralha o vetor usando o algoritmo de Fisher–Yates
	{
		inteiro j, aux
		
		para(inteiro i = N - 1; i > 0; i--)
		{
			j = u.sorteia(0, i)

			aux = v[i]
			v[i] = v[j]
			v[j] = aux
		}
	}

	funcao copia_vetor(inteiro copiado[], inteiro &copia[])
	{
		inteiro n = u.numero_elementos(copiado)

		para(inteiro i = 0; i < n; i++)
		{
			copia[i] = copiado[i]
		}
	}

	funcao zeros(inteiro &v[], inteiro tam)
	{
		para(inteiro i = 0; i < tam; i++)
		{
			v[i] = 0
		}
	}

	funcao insertion_sort(inteiro &v[])
	{
		inteiro valorAtual, j

		para(inteiro i = 1; i < N; i++)
		{
			valorAtual = v[i]

			j = i - 1

			enquanto(j >= 0 e v[j] > valorAtual)
			{
				v[j + 1] = v[j]
				j = j - 1
				desenha_vetor(v, 0)
			}

			v[j + 1] = valorAtual
			desenha_vetor(v, 0)
		}
	}

	funcao selection_sort(inteiro &v[])
	{
		inteiro min
		inteiro aux
		
		para(inteiro i = 0; i < N - 1; i++)
		{
			min = i

			para(inteiro j = i + 1; j < N; j++)
			{
				se(v[j] < v[min])
				{
					min = j
				}
			}

			se(min != i)
			{
				aux = v[min]
				v[min] = v[i]
				v[i] = aux
			}
			desenha_vetor(v, 20)
		}
	}

	funcao bubble_sort(inteiro &v[])
	{
		inteiro aux
		logico estaordenado = verdadeiro
		
		para(inteiro i = 0; i < N - 1; i++)
		{
			para(inteiro j = 0; j < N - i - 1; j++)
			{
				se(v[j] > v[j + 1])
				{
					aux = v[j]
					v[j] = v[j + 1]
					v[j + 1] = aux
					estaordenado = falso
				}
				desenha_vetor(v, 0)
			}
			
			se(estaordenado)
			{
				pare
			}
		}
	}

	funcao shell_sort(inteiro &v[])
	{
		inteiro i, j, h, aux

		h = 1
		enquanto(h < N)
		{
			h = 3*h + 1
		}

		enquanto(h > 0)
		{
        		para(i = h; i < N; i++)
        		{
            		aux = v[i]
            		j = i
            		enquanto(j > h-1 e aux <= v[j - h])
            		{
                		v[j] = v[j - h]
                		j = j - h
                		desenha_vetor(v, 3)
            		}
            		v[j] = aux
            		desenha_vetor(v, 3)
        		}
        		h = (h-1)/3
    		}
	}

	funcao heap_sort(inteiro &v[])
	{
		inteiro n = N
		inteiro i = n/2
		inteiro pai, filho, t

		enquanto(verdadeiro)
		{
			se(i > 0)
			{
				i--
				t = v[i]
			}
			senao
			{
				n--
				se(n <= 0)
				{
					retorne
				}
				t = v[n]
				v[n] = v[0]
				desenha_vetor(v, 3)
			}
			pai = i
			filho = 2*i + 1
			enquanto(filho < n)
			{
				se((filho + 1 < n)  e  (v[filho + 1] > v[filho]))
				{
					filho++
				}
              			
          		se(v[filho] > t)
          		{
             			v[pai] = v[filho]
             			pai = filho
             			filho = 2*pai + 1
             			desenha_vetor(v, 3)
          		} 
          		senao 
          		{
             			pare
          		}
			}
			v[pai] = t
			desenha_vetor(v, 3)
		}
	}

	funcao merge_sort(inteiro &v[], inteiro comeco, inteiro fim)
	{
		inteiro meio
		se(comeco < fim)
		{
			meio = (comeco + fim)/2

			merge_sort(v, comeco, meio)
			merge_sort(v, meio + 1, fim)
			merge(v, comeco, meio, fim)
		}
	}

	funcao merge(inteiro &v[], inteiro comeco, inteiro meio, inteiro fim)
	{
		inteiro i, j, k, aux[N]
		
		para(i = comeco; i <= meio; i++)
		{
			aux[i] = v[i]
		}

		para(j = meio + 1; j <= fim; j++)
		{
			aux[fim + meio + 1 - j] = v[j]
		}

		i = comeco
		j = fim

		para(k = comeco; k <= fim; k++)
		{
			se(aux[i] <= aux[j])
			{
				v[k] = aux[i]
				i = i + 1
				desenha_vetor(v, 4)
			}
			senao
			{
				v[k] = aux[j]
				j = j - 1
				desenha_vetor(v, 4)
			}
		}
	}

	funcao quick_sort(inteiro &v[], inteiro comeco, inteiro fim)
	{
		inteiro i, j, pivo, aux
		i = comeco
		j = fim - 1
		pivo = v[(comeco + fim)/2]

		enquanto(i <= j)
		{
			enquanto(v[i] < pivo e i < fim)
			{
				i++
			}

			enquanto(v[j] > pivo e j > comeco)
			{
				j--
			}

			se(i <= j)
			{
				aux = v[i]
				v[i] = v[j]
				v[j] = aux
				i++
				j--
				desenha_vetor(v, 10)
			}
		}

		se(j > comeco)
		{
			quick_sort(v, comeco, j + 1)
		}

		se(i < fim)
		{
			quick_sort(v, i, fim)
		}
	}

	funcao counting_sort(inteiro &v[], inteiro k)
	{
		inteiro i, f[N], aux[N]

		zeros(f, N)
		copia_vetor(v, aux)

		// Frequência
		para(i = 0; i < N; i++)
		{
			f[aux[i]]++ 
		}

		// Acumulador
		para(i = 1; i <= k; i++)
		{
			f[i] = f[i] + f[i - 1]
		}

		
		para(i = N - 1; i >= 0; i--)
		{
			v[f[aux[i]] - 1] = aux[i]
			f[aux[i]] -= 1
			desenha_vetor(v, 7)
		}
	}

	funcao inteiro maior(inteiro v[])
	{
		inteiro m = v[0]
		para(inteiro i = 1; i < N; i++)
		{
			se(v[i] > m)
			{
				m = v[i]
			}
		}
		retorne m
	}

	funcao contagem(inteiro &v[], inteiro pot)
	{
		inteiro i, f[N], aux[N]

		zeros(f, N)
		copia_vetor(v, aux)

		// Frequência
		para(i = 0; i < N; i++)
		{
			f[((aux[i]/pot) % 10)]++ 
		}

		// Acumulador
		para(i = 1; i < 10; i++)
		{
			f[i] = f[i] + f[i - 1]
		}

		
		para(i = N - 1; i >= 0; i--)
		{
			v[f[((aux[i]/pot) % 10)] - 1] = aux[i]
			f[((aux[i]/pot) % 10)] -= 1
			desenha_vetor(v, 5)
		}
	} 
	
	funcao radix_sort(inteiro &v[])
	{
		inteiro m = maior(v)

		para(inteiro potencia = 1; (m/potencia) > 0; potencia *= 10)
		{
			contagem(v, potencia)
		}
	}

	funcao desenha_vetor(inteiro v[], inteiro tempo) // Desenha o vetor na janela gráfica
	{
		inteiro posicao_retangulo, altura_retangulo
		
		g.definir_cor(cor_fundo)
		g.limpar()
		g.definir_cor(cor_retangulo)
		
		para(inteiro i = 0; i < largura_janela; i += largura_retangulo)
		{
			posicao_retangulo = altura_janela - (altura_janela/N)*v[i/largura_retangulo]
			altura_retangulo = (altura_janela/N)*v[i/largura_retangulo]
			
			g.desenhar_retangulo(i, posicao_retangulo, largura_retangulo - 1, altura_retangulo, falso, verdadeiro)
		}
		g.renderizar()
		u.aguarde(tempo) // milissegundos
	}
	
	funcao finalizar_modo_grafico() // Fecha a janela gráfica
	{
		g.encerrar_modo_grafico()
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 2944; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
