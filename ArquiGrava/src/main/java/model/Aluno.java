package model;

import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Aluno {
	private int id;
	
	private int ra;
	private String nome;
	private int codigoCurso;
	
	private String nomeSocial;
	private LocalDate nascimento;
	private String telefone1;
	private String telefone2;
	private String email;
	private LocalDate dataSegundoGrau;
	private String nomeInstituicao;
	
	private int pontuacao;
	private int posicao;
	private int anoIngresso;
	private int semestreIngresso;
	private int anoLimite;
	private int semestreLimite;
	
	private String cpf;
}
