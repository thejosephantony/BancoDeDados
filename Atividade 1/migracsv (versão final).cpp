#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <locale.h>
#include <vector>

using namespace std;

/*Criar uma estrutura para representar um discente. Pode ser através de
registros ou criação de uma classe.*/

class Discente{
    private:
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

    public:
        string get_matricula(){
            return this->matricula;
        }

        void set_matricula(const string& matricula){
            this->matricula = matricula;
        }

        string get_nome(){
            return this->nome_discente;
        }

        void set_nome(const string& nome_discente){
            this->nome_discente = nome_discente;
        }

        string get_ano_ingresso() const{
            return this->ano_ingresso;
        }

        void set_ano_ingresso(const string& ano_ingresso){
            this->ano_ingresso = ano_ingresso;
        }

        string get_periodo_ingresso() const{
            return this->periodo_ingresso;
        }


        void set_periodo_ingresso(const string & periodo_ingresso){
            this->periodo_ingresso = periodo_ingresso;
        }

        string get_tipo_discente() const{
            return this->tipo_discente;
        }

        void set_tipo_discente(const string& tipo_discente){
            this->tipo_discente = tipo_discente;
        }

        string get_status_discente() const{
            return this->status_discente;
        }

        void set_status_discente(const string& status_discente){
            this->status_discente = status_discente;
        }

        string get_nivel_ensino() const{
            return this->nivel_ensino;
        }

        void set_nivel_ensino(const string& nivel_ensino){
            this->nivel_ensino = nivel_ensino;
        }

        string get_nome_curso() const{
            return this->nome_curso;
        }

        void set_nome_curso(const string& nome_curso){
            this->nome_curso = nome_curso;
        }

        string get_modalidade_educacao() const{
            return this->modalidade_educacao;
        }

        void set_modalidade_educacao(const string& modalidade_educacao){
            this->modalidade_educacao = modalidade_educacao;
        }

        string get_nome_unidade() const{
            return this->nome_unidade;
        }

        void set_nome_unidade(const string& nome_unidade){
            this->nome_unidade = nome_unidade;
        }

        string get_nome_unidade_gestora() const{
            return this->nome_unidade_gestora;
        }

        void set_nome_unidade_gestora(const string& nome_unidade_gestora){
            this->nome_unidade_gestora = nome_unidade_gestora;
        }
};

/* Fazer uma função para percorrer as linhas do arquivo .csv e criar uma
lista/array de discentes. Cada posição da lista/array deve representar um
discente do arquivo .csv */

vector<Discente> discentes; // Vetor de discentes
int tamanhoCSV = 0;
char linha[300]; // Buffer para armazenar cada linha

void percorreCSV() {
    ifstream arquivo("C:/Users/Joseph/Downloads/BancoDeDados/Atividade 1/dis-csv-discentes-de-graduacao-de-2025_1.csv");

    // ifstream arquivo("discentes.csv");

    if (!arquivo.is_open()) {
        cout << "Erro ao abrir o arquivo.\n";
        return;
    }

    string linha;
    int i = 0;

    getline(arquivo, linha); // Pular cabeçalho

    while (getline(arquivo, linha) && !arquivo.eof()) {
        stringstream ss(linha);
        string campo;

        Discente aluno;

        string matricula,
	    nome_discente,
        ano_ingresso,
	    periodo_ingresso,
	    tipo_discente,
	    status_discente,
	    nivel_ensino,
	    nome_curso,
    	modalidade_educacao,
	    nome_unidade,
	    nome_unidade_gestora;

        getline(ss, matricula, ',');
        getline(ss, nome_discente, ',');
        getline(ss, ano_ingresso, ',');
        getline(ss, periodo_ingresso, ',');
        getline(ss, tipo_discente, ',');
        getline(ss, status_discente, ',');
        getline(ss, nivel_ensino, ',');
        getline(ss, nome_curso, ',');
        getline(ss, modalidade_educacao, ',');
        getline(ss, nome_unidade, ',');
        getline(ss, nome_unidade_gestora, ',');

        aluno.set_matricula(matricula);
        aluno.set_nome(nome_discente);
        aluno.set_ano_ingresso(ano_ingresso);
        aluno.set_periodo_ingresso(periodo_ingresso);
        aluno.set_tipo_discente(tipo_discente);
        aluno.set_status_discente(status_discente);
        aluno.set_nivel_ensino(nivel_ensino);
        aluno.set_nome_curso(nome_curso);
        aluno.set_modalidade_educacao(modalidade_educacao);
        aluno.set_nome_unidade(nome_unidade);
        aluno.set_nome_unidade_gestora(nome_unidade_gestora);

        discentes.emplace_back(aluno);
        i++;
    }

    tamanhoCSV = i;

    arquivo.close();
    cout << "Total de discentes carregados: " << i << endl;

}

/* Fazer uma função para a impressão de um discente. Fiquem livres para
decidir o formato, o importante é que todos os dados do discente sejam
apresentados. É necessário apresentar o nome de cada campo e valor
referente ao discente */

void mostrarAluno(int indice){

	cout << "\nDados do Estudante:\n\n";
    cout << "Matricula: " << discentes[indice].get_matricula() << endl;
    cout << "Nome: " << discentes[indice].get_nome() << endl;
    cout << "Ano Ingresso: " << discentes[indice].get_ano_ingresso() << endl;
    cout << "Periodo: " << discentes[indice].get_periodo_ingresso() << endl;
    cout << "Tipo: " << discentes[indice].get_tipo_discente() << endl;
    cout << "Status: " << discentes[indice].get_status_discente() << endl;
    cout << "Nível: " << discentes[indice].get_nivel_ensino() << endl;
    cout << "Curso: " << discentes[indice].get_nome_curso() << endl;
    cout << "Modalidade: " << discentes[indice].get_modalidade_educacao() << endl;
    cout << "Unidade: " << discentes[indice].get_nome_unidade() << endl;
    cout << "Unidade Gestora: " << discentes[indice].get_nome_unidade_gestora() << endl;
    cout << "----------------------------------------\n";

}

/* Fazer uma função para salvar em arquivo textos os dados dos discentes no
formato da função de impressão */

void salvarTXT(int total) { // salva em arquivo .txt
    ofstream arquivo("discentes.txt");

    if (!arquivo.is_open()) {
        cout << "Erro ao criar arquivo.\n";
        return;
    }

    for (int i = 0; i < total; i++) {
        arquivo << "Aluno " << i + 1 << ":\n";
        arquivo << "Matricula: " << discentes[i].get_matricula() << "\n";
        arquivo << "Nome: " << discentes[i].get_nome() << "\n";
        arquivo << "Ano Ingresso: " << discentes[i].get_ano_ingresso() << "\n";
        arquivo << "Periodo: " << discentes[i].get_periodo_ingresso() << "\n";
        arquivo << "Tipo: " << discentes[i].get_tipo_discente() << "\n";
        arquivo << "Status: " << discentes[i].get_status_discente() << "\n";
        arquivo << "Nivel: " << discentes[i].get_nivel_ensino() << "\n";
        arquivo << "Curso: " << discentes[i].get_nome_curso() << "\n";
        arquivo << "Modalidade: " << discentes[i].get_modalidade_educacao() << "\n";
        arquivo << "Unidade: " << discentes[i].get_nome_unidade() << "\n";
        arquivo << "Unidade Gestora: " << discentes[i].get_nome_unidade_gestora() << "\n";
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

void menu(){    // Função de impressão do menu

    printf("\n===== Implementação com arquivos =====\n");
    printf("1 - Imprimir Discente\n");
    printf("2 - Salvar Dados\n");
    printf("0 - Encerrar Programa\n");

}

int main() {    // Função principal para executar os métodos da aplicação

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
                salvarTXT(tamanhoCSV);
                break;
            case 0:
                break;

            default:
                printf("ERRO: Opção inválida. Escolha entre 1 e 2.\n");
        }

    }  while (op != 0);  // Continua até usuário escolher sair

    return 0;
}
