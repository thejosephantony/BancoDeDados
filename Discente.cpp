#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>


using std::cout;
using std::cin;
using std::endl;
using std::string;
using std::vector;


class Discente{
    private:
        string nome;
        string matricula;
        int ano_ingresso;
        int periodo_ingresso;
        string tipo_ingresso;
        string status_discente;
        string nivel_ensino;
        string nome_curso;
        string modalidade_educacao;
        string nome_unidade;
        string nome_unidade_gestora;

    public:
        void set_nome(const string& nome){
            this->nome = nome;
        }
        string get_nome() const{
            return this->nome;
        }

        void set_matricula(const string& matricula){
            this->matricula = matricula;
        }
        string get_matricula() const{
            return this->matricula;
        }

        void set_ano_ingresso(const int ano_ingresso){
            this->ano_ingresso = ano_ingresso;
        }
        int get_ano_ingresso() const{
            return this->ano_ingresso;
        }

        void set_periodo_ingresso(const int periodo_ingresso){
            this->periodo_ingresso = periodo_ingresso;
        }
        int get_periodo_ingresso() const{
            return this->periodo_ingresso;
        }

        void set_tipo_ingresso(const string& tipo_ingresso){
            this->tipo_ingresso = tipo_ingresso;
        }
        string get_tipo_ingresso() const{
            return this->tipo_ingresso;
        }

        void set_status_discente(const string& status_discente){
            this->status_discente = status_discente;
        }
        string get_status_discente() const{
            return this->status_discente;
        }

        void set_nivel_ensino(const string& nivel_ensino){
            this->nivel_ensino = nivel_ensino;
        }
        string get_nivel_ensino() const{
            return this->nivel_ensino;
        }

        void set_nome_curso(const string& nome_curso){
            this->nome_curso = nome_curso;
        }

        string get_nome_curso() const{
            return this->nome_curso;
        }

        void set_modalidade_educacao(const string& modalidade_educacao){
            this->modalidade_educacao = modalidade_educacao;
        }

        string get_modalidade_educacao() const{
            return this->modalidade_educacao;
        }

        void set_nome_unidade(const string& nome_unidade){
            this->nome_unidade = nome_unidade;
        }

        string get_nome_unidade() const{
            return this->nome_unidade;
        }

        void set_nome_unidade_gestora(const string& nome_unidade_gestora){
            this->nome_unidade_gestora = nome_unidade_gestora;
        }

        string get_nome_unidade_gestora() const{
            return this->nome_unidade_gestora;
        }

};


vector<string> parseCSV(const string& linha) {
    vector<string> campos;
    string campo;
    bool dentroAspas = false;

    for (char c : linha) {
        if (c == '"') {
            dentroAspas = !dentroAspas;
        }
        else if (c == ',' && !dentroAspas) {
            campos.push_back(campo);
            campo.clear();
        }
        else {
            campo += c;
        }
    }

    campos.push_back(campo);
    return campos;
}


int to_int(const string& s) {
    try {
        return std::stoi(s);
    } catch (...) {
        return 0;
    }
}
int main() {
    std::ifstream arquivo("C:/Users/Joseph/Downloads/BancoDeDados/dis-csv-discentes-de-graduacao-de-2025_1.csv");
    vector<Discente> discentes;

    if (!arquivo.is_open()) {
        cout << "Erro ao abrir arquivo\n";
        return 1;
    }

    string linha;


    getline(arquivo, linha);

    while (getline(arquivo, linha)) {
        auto campos = parseCSV(linha);

        if (campos.size() < 11) continue;

        Discente d;

        d.set_matricula(campos[0]);
        d.set_nome(campos[1]);
        d.set_ano_ingresso(to_int(campos[2]));
        d.set_periodo_ingresso(to_int(campos[3]));
        d.set_tipo_ingresso(campos[4]);
        d.set_status_discente(campos[5]);
        d.set_nivel_ensino(campos[6]);
        d.set_nome_curso(campos[7]);
        d.set_modalidade_educacao(campos[8]);
        d.set_nome_unidade(campos[9]);
        d.set_nome_unidade_gestora(campos[10]);

        discentes.emplace_back(d);
    }

    arquivo.close();


    cout << "Total de discentes: " << discentes.size() << endl;

    cout << "\nPrimeiros 10:\n";
    for (int i = 0; i < 10 && i < discentes.size(); i++) {
        cout << discentes[i].get_nome()
             << " - "
             << discentes[i].get_matricula()
             << endl;
    }

    return 0;
}
