import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Transacao implements Runnable {


	public Connection conexao = null;
	int id;
	long inicio;
	public static int abortada;
	


	public Transacao(int id, long inicio) {
		try{
			//Carregar driver JDBC do postgress
			Class.forName("org.postgresql.Driver");
			this.id = id;
			this.inicio = inicio;
			
		} catch (ClassNotFoundException ex){ex.printStackTrace();}
	}

	public static Connection setConnection() throws SQLException{

		String host = "10.27.3.48:5432";
		String database = "bd_aula";
		String url = "jdbc:postgresql://" +  host + "/" + database;
		String user = "aluno";
		String password = "aluno";
		return DriverManager.getConnection(url, user, password);
	}
	
	public static void  dadosIniciais(Connection conexao, int numThreads) throws SQLException{
		   String sql = "Select * from universidade.departamento WHERE cod_depto = 'DCOMP'";
		   Statement comando = conexao.createStatement();
		   ResultSet resultado = comando.executeQuery(sql);
		   int orcamento = 0;
		   while(resultado.next()){
		      orcamento = resultado.getInt("orcamento");
		   }	
		   
		   System.out.println("========================================");
		   System.out.println("Dados iniciais");
		   System.out.println("# de threads: " + numThreads);
		   System.out.println("# de threads de leitura: " + numThreads/2.0);
		   System.out.println("# de threads de escrita: " + numThreads/2.0);
		   
		   System.out.println("Cada thread de escrita adiciona +1 no orcamento");
		   System.out.println("Valor inicial do orcamento: " + orcamento);
		   int novo = orcamento + (numThreads/2);
		   System.out.println("Valor final se execução for sequencial: " + novo);
		   System.out.println("========================================");
		   
		   comando.close();
		}
	
	public static void dadosFinais(Connection conexao, int numThreads) throws SQLException{
		   String sql = "Select * from universidade.departamento WHERE cod_depto = 'DCOMP'";
		   Statement comando = conexao.createStatement();
		   ResultSet resultado = comando.executeQuery(sql);
		   String orcamento = "";
		   while(resultado.next()){
		      orcamento = resultado.getString("orcamento");
		   }	
		   
		   System.out.println("========================================");
		   System.out.println("Dados finais");
		   System.out.println("Valor final do orcamento: " + orcamento);
		   System.out.println("Transações abortadas: " + abortada);
		   System.out.println("========================================");
		   
		   comando.close();
		}


	public void duasLeituras()throws Exception{
		conexao.setAutoCommit(false);
		//System.out.println(id + ": Início da transação ");
		Statement comando = conexao.createStatement();
		String sql1 = "SELECT orcamento FROM universidade.departamento WHERE cod_depto = 'DCOMP' ";
		ResultSet resultado = comando.executeQuery(sql1);

		double orcamento = 0;

		while(resultado.next()){
			orcamento = resultado.getDouble(1);
		}

		System.out.println("T" + id + ": Primeira leitura: " + orcamento );
		long ms = (long)Math.floor(Math.random()*1000);
		//System.out.println(id + ": Dormindo: " + ms + " ms");
		Thread.sleep(ms);
		resultado = comando.executeQuery(sql1);

		double novo_orcamento = 0;

		while(resultado.next()){
			novo_orcamento = resultado.getDouble(1);
		} 
		System.out.println("T"+id + ": Segunda leitura: " + novo_orcamento + "(valor que deveria ter sido lido:"+ orcamento + ")");
		conexao.commit();	
	}

	public void alteracao() throws Exception{
		conexao.setAutoCommit(false);
		//System.out.println(id + ": Início da transação ");
		Statement comando = conexao.createStatement();
		String sql1 = "SELECT orcamento FROM universidade.departamento WHERE cod_depto = 'DCOMP' ";
		ResultSet resultado = comando.executeQuery(sql1);

		double orcamento = 0;

		while(resultado.next()){
			orcamento = resultado.getDouble(1);
		}
		
		System.out.println("T" + id + ": Primeira leitura: " + orcamento );
		orcamento+=1;
		System.out.println("T" + id + ": Valor local após alteração (+1): " + orcamento );
		long ms = (long)Math.floor(Math.random()*1000);
		//System.out.println(id + ": Dormindo: " + ms + " ms");
		Thread.sleep(ms);
		
		//System.out.println(id + ": Salario + 100 = " +  salario);
		System.out.println("T"+id + ": Alterou banco...");
		String sql2 = "UPDATE universidade.departamento SET orcamento = " + orcamento + " WHERE cod_depto = 'DCOMP'";
		comando.executeUpdate(sql2);
		
		resultado = comando.executeQuery(sql1);

		double novo_orcamento = 0;

		while(resultado.next()){
			novo_orcamento = resultado.getDouble(1);
		}
		
		System.out.println("T"+id + ": Segunda leitura: " + novo_orcamento + "(valor que deveria ter sido lido:"+ orcamento + ")");
		
		if(Math.random() >= 0.9) {
			Thread.sleep(ms);
			conexao.rollback();
			System.out.println("T" + id + ": FOI ABORTADA.");

			resultado = comando.executeQuery(sql1);

			double orcamento3 = 0;

			while(resultado.next()){
				orcamento3 = resultado.getDouble(1);
			}
			System.out.println("T"+id + ": Leu após alteração. Valor no banco após alteração: " + orcamento3 + "(valor que foi atualizado no banco:"+ novo_orcamento + ")");
			abortada++;
		}
		conexao.commit();

	}
	@Override
	public void run() {
		try{
			if(id%2 == 0)
				duasLeituras();
			else
				alteracao();
			System.out.println("T" + id +": Finalizou em " + (System.currentTimeMillis() - inicio) + "(ms)");
	
		}catch(Exception ex){ ex.printStackTrace();++Transacao.abortada;}

	}

	public static void main(String[] args) {

		try{
			int numThreads = 10;
			Thread threads[] = new Thread[numThreads];
			dadosIniciais(setConnection(), numThreads);
			long inicio = System.currentTimeMillis();
			Transacao.abortada = 0;
			
			for (int i = 0; i < threads.length; i++) {
				Transacao t = new Transacao(i, inicio);
				t.conexao = setConnection();
				t.conexao.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);
				Thread thread = threads[i];
				thread = new Thread(t);
				System.out.println("T" + i +": Iniciou em " + (System.currentTimeMillis() - inicio)+ "(ms)");
				thread.start();
				Thread.sleep(200);
			}
			Thread.sleep(2000);
			dadosFinais(setConnection(), numThreads);
		} catch(Exception ex){ex.printStackTrace();}
	}

}
