package com.compiladores;

import java_cup.runtime.Symbol;

import java.io.*;
import java.util.ArrayList;


public class App
{
    public static void main( String[] args ) throws Exception
    {
        String archivoFuente = "src/main/java/com/compiladores/fuente.txt";

        testLexer(archivoFuente); // PRUEBA LEXER
        testParser(archivoFuente); // PRUEBA PARSER

    }


    public static void testLexer(String archivoFuente) throws Exception {

        Reader reader = new BufferedReader(new FileReader(archivoFuente));
        Lexer lexer = new Lexer(reader);

        String archivoDeTokens = "src/main/java/com/compiladores/tokens.txt";
        FileWriter fw = new FileWriter(archivoDeTokens);

        Symbol s;

        do {
            s = lexer.next_token();
            fw.write("Token: " + s.sym + " Value: "+ s.value + "\n"); // Escribe en el archivo de tokens
        } while (s.sym != 0);

        fw.flush();
        fw.close();
    }

    public static void testParser(String archivoFuente) throws Exception {

        Reader reader = new BufferedReader(new FileReader(archivoFuente));
        Lexer lexer = new Lexer(reader);

        parser p = new parser(lexer);
        p.parse();
        //Intermedio i = new Intermedio(lexer);
        //i.parse();
        //Escribir en archivo de codigo intermedio
       //intermediateCode(i.getIntermediateCode());
    }

    public static void intermediateCode(StringBuffer intermediateCode) {
        try {
            BufferedWriter escritor = new BufferedWriter(new FileWriter("src/main/java/com/compiladores/Intermedio.txt"));

            escritor.write(intermediateCode.toString());

            escritor.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }




}