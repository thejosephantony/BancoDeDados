#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <locale.h>  // Configuração de localização
using namespace std;

/*Criar uma estrutura para representar um discente. Pode ser através de
registros ou criação de uma classe.*/

struct Aluno {
	string matricula;
	string nome_discente;
	string ano_ingresso;
	string periodo_ingresso;
	string tipo_discente;
	string status_discente;
	string nivel_ensino;
	string nome_curso;
	string modalidade_educacao;
	string nome_unidade;
	string nome_unidade_gestora;
};

Aluno discentes [6625];

char linha[300]; // Buffer para armazenar cada linha

/* Fazer uma função para percorrer as linhas do arquivo .csv e criar uma
lista/array de discentes. Cada posição da lista/array deve representar um
discente do arquivo .csv */

void percorreCSV() {
    //ifstream arquivo("dis-csv-discentes-de-graduacao-de-2025_1.csv");

    ifstream arquivo("discentes.csv");

    if (!arquivo.is_open()) {
        cout << "Erro ao abrir o arquivo.\n";
        return;
    }

    string linha;
    int i = 1; // Foi escolhido o número 1 para apresentação ser semelhante ao que foi feito no formato csv

    getline(arquivo, linha); // Pular cabeçalho

    while (getline(arquivo, linha) && i < 6625) {
        stringstream ss(linha);
        string campo;

        Aluno aluno;

        getline(ss, aluno.matricula, ',');
        getline(ss, aluno.nome_discente, ',');
        getline(ss, aluno.ano_ingresso, ',');
        getline(ss, aluno.periodo_ingresso, ',');
        getline(ss, aluno.tipo_discente, ',');
        getline(ss, aluno.status_discente, ',');
        getline(ss, aluno.nivel_ensino, ',');
        getline(ss, aluno.nome_curso, ',');
        getline(ss, aluno.modalidade_educacao, ',');
        getline(ss, aluno.nome_unidade, ',');
        getline(ss, aluno.nome_unidade_gestora, ',');

        discentes[i] = aluno;
        i++;
    }

    arquivo.close();
    cout << "Total de discentes carregados: " << i << endl;
    
}

/* Fazer uma função para a impressão de um discente. Fiquem livres para
decidir o formato, o importante é que todos os dados do discente sejam
apresentados. É necessário apresentar o nome de cada campo e valor
referente ao discente */

void mostrarAluno(int indice){
	
	cout << "\nDados do Estudante:\n\n";
    cout << "Matricula: " << discentes[indice].matricula << endl;
    cout << "Nome: " << discentes[indice].nome_discente << endl;
    cout << "Ano Ingresso: " << discentes[indice].ano_ingresso << endl;
    cout << "Periodo: " << discentes[indice].periodo_ingresso << endl;
    cout << "Tipo: " << discentes[indice].tipo_discente << endl;
    cout << "Status: " << discentes[indice].status_discente << endl;
    cout << "Nível: " << discentes[indice].nivel_ensino << endl;
    cout << "Curso: " << discentes[indice].nome_curso << endl;
    cout << "Modalidade: " << discentes[indice].modalidade_educacao << endl;
    cout << "Unidade: " << discentes[indice].nome_unidade << endl;
    cout << "Unidade Gestora: " << discentes[indice].nome_unidade_gestora << endl;
    cout << "----------------------------------------\n";

}

/* Fazer uma função para salvar em arquivo textos os dados dos discentes no
formato da função de impressão */

void salvarTXT(int total) {
    ofstream arquivo("discentes.txt");

    if (!arquivo.is_open()) {
        cout << "Erro ao criar arquivo.\n";
        return;
    }

    for (int i = 0; i < total; i++) {
        arquivo << "Aluno " << i + 1 << ":\n";
        arquivo << "Matricula: " << discentes[i].matricula << "\n";
        arquivo << "Nome: " << discentes[i].nome_discente << "\n";
        arquivo << "Ano Ingresso: " << discentes[i].ano_ingresso << "\n";
        arquivo << "Periodo: " << discentes[i].periodo_ingresso << "\n";
        arquivo << "Tipo: " << discentes[i].tipo_discente << "\n";
        arquivo << "Status: " << discentes[i].status_discente << "\n";
        arquivo << "Nivel: " << discentes[i].nivel_ensino << "\n";
        arquivo << "Curso: " << discentes[i].nome_curso << "\n";
        arquivo << "Modalidade: " << discentes[i].modalidade_educacao << "\n";
        arquivo << "Unidade: " << discentes[i].nome_unidade << "\n";
        arquivo << "Unidade Gestora: " << discentes[i].nome_unidade_gestora << "\n";
        arquivo << "----------------------------------------\n";
        
    }

    arquivo.close();
    cout << "\nArquivo .txt salvo com sucesso!\n";
}

/* Funções auxiliares */

void limparTela(){
	#ifdef _WIN32
		system("cls");       // Comando Windows
	#elif __linux__
		system("clear");     // Comando Linux/macOS
	#endif
}



/* Fazer uma função principal para executar os métodos de leitura do .csv e de
escrita do arquivo texto */

void menu(){

    printf("\n===== Implementação com arquivos =====\n");
    printf("1 - Imprimir Discente\n");
    printf("2 - Salvar Dados\n");
    printf("0 - Encerrar Programa\n");
	
}

int main() {
	
	setlocale(LC_ALL, "pt_BR.UTF-8");
    int op,value;
    percorreCSV();
	
    do {
        menu();  // Exibe as opções disponíveis

        scanf("%d", &op);

        // Processa a opção escolhida
        switch (op) {
            // Imprimir Discente 
            case 1:
                limparTela();
                printf("Digite o índice que corresponde ao discente: "); 
                scanf("%d",&value);
                mostrarAluno(value-1); // Ajustar o indice do array 
                break;
            //  Salvar dados
            case 2:
                limparTela();
                salvarTXT(6623);
                break;
            case 0:
                break;

            default:
                printf("ERRO: Opção inválida. Escolha entre 1 e 2.\n");
        }

    }  while (op != 0);  // Continua até usuário escolher sair


    return 0;
}

