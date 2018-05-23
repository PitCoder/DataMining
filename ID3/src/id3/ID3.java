package id3;

import deepcopy.DeepCopy;
import narytree.N_AryTree;
import com.opencsv.CSVReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;
import java.util.Set;
import javax.swing.JFileChooser;

public class ID3 {
    public static Clase clase;
    
    public static void main(String[] args) throws CloneNotSupportedException {
        /***LECTURA CREACION Y CLASIFICACION DE LOS DATOS ***/
        int noAtributos;
        int noValores;
        String nombreAtrib;
        String nombreClase;
        String nombreValor;
        HashMap<String, Atributo> atributos = new HashMap();
        ArrayList<Dato> tabla= new ArrayList<>();
        
        Scanner sc = new Scanner(System.in);
        System.out.println("*** Generador de ID3 ***");
        System.out.print("Especifique el nombre de la clase: ");
        nombreClase = sc.nextLine().trim();
        clase = new Clase(nombreClase);
        System.out.print("Especifique el numero de valores: ");
        noValores = Integer.parseInt(sc.nextLine().trim());
        for(int i=0; i<noValores; i++){
            nombreValor = sc.nextLine().trim();
            clase.agregaValor(nombreValor);
        }
        
        System.out.print("Especifique el numero de atributos: ");
        noAtributos = Integer.parseInt(sc.nextLine().trim());
        for(int i=0; i<noAtributos; i++){
            System.out.print("Especifique el nombre del atributo: ");
            nombreAtrib = sc.nextLine().trim();
            System.out.print("Especifique numero de valores: ");
            noValores = Integer.parseInt(sc.nextLine().trim());
            System.out.println("Especifique los valores: ");
            HashMap<String, Valor> valores = new HashMap<>();
            
            for(int j=0; j<noValores; j++){
                nombreValor = sc.nextLine().trim();
                Clase copiaClase = (Clase) DeepCopy.copy(clase);
                //Clase copiaClase = new Clase(clase.obtenerNombre(), clase.obtenerTablaValores());
                Valor valor = new Valor(copiaClase, nombreValor);
                valores.put(nombreValor, valor);
            }
                        
            Atributo atributo = new Atributo(nombreAtrib, valores);
            atributos.put(nombreAtrib, atributo);
            System.out.println("***Atributo Agregado***\n");
        }
        
        
        final JFileChooser fc = new JFileChooser();
        int returnVal = fc.showOpenDialog(null);
        if(returnVal == JFileChooser.APPROVE_OPTION){
            File file = fc.getSelectedFile();
            
            if(file.isFile()){
                String fileName = file.getName();
                if(fileName.substring(fileName.indexOf('.') + 1).equals("csv")){
                    CSVReader reader = null;
                    try{
                        reader = new CSVReader(new FileReader(file));
                        String[] header;
                        if((header = reader.readNext()) != null){
                            String[] line;
                            while((line = reader.readNext()) != null){
                                Dato dato = new Dato();
                                System.out.print("Dato: [ ");
                                for(int iterator = 0; iterator < header.length-1; iterator++){
                                    if(atributos.get(header[iterator]).obtenerValor(line[iterator]).obtenerClase() != null)
                                        System.out.print("Clase: " + atributos.get(header[iterator]).obtenerValor(line[iterator]).obtenerClase() + " ");
                                    atributos.get(header[iterator]).obtenerValor(line[iterator]).incrementaFrecuencia(line[header.length-1]);
                                    dato.agregarColumna(header[iterator], line[iterator]);
                                    System.out.print(header[iterator] + "=" + line[iterator] + " " + atributos.get(header[iterator]).obtenerValor(line[iterator]).obtenerFrecuencia(line[header.length-1]) + " ");
                                }
                                if(header.length > 0){
                                    dato.agregarColumna(header[header.length-1], line[header.length-1]);
                                    System.out.print(header[header.length-1] + "=" + line[header.length-1] + " ");   
                                    clase.incrementaFrecuencia(line[header.length-1]);
                                }
                                tabla.add(dato);
                                System.out.println("]");
                            }
                        }
                        else{
                            System.out.println("Empty File");
                        }
                    }
                    catch(IOException e){
                        e.printStackTrace();
                    }
                }
                else{
                    System.out.println("Error, Archivo no valido: Debe ser un archivo .csv");
                    System.exit(1);
                }
            }
            else{
                System.out.println("Error, la opcion elegida no es un archivo");
                System.exit(1);
            }
        }
      
        String temp;
        System.out.println("\n***Prueba de frecuencias por atributo-valor***");
        Iterator iterador = atributos.keySet().iterator();
        while(iterador.hasNext()){
            Atributo testAtributo = atributos.get((String)iterador.next());
            HashMap<String, Valor> testValores = testAtributo.obtenerValores();
            Iterator iterador2 = testValores.keySet().iterator();
            while(iterador2.hasNext()){
                Valor testValor = testValores.get((String)iterador2.next());
                Clase testClase = testValor.obtenerClase();
                Iterator iterador3 = testClase.obtenerValores().iterator();
                while(iterador3.hasNext()){
                   temp = (String)iterador3.next();
                   System.out.println("Atributo: " + testAtributo.obtenerNombre() +  "  Valor de Atributo: " + testValor.obtenerNombre() + " Valor de Clase: " + temp + "  Frecuencia: " + testClase.obtenerFrecuencia(temp));
                }
            }
        }
        
        /*** PARTE RUDA, IMPLEMENTACION DE ALGORITMO COMO TAL ***/
        /*** CALCULANDO LA ENTROPIA BINARIA PARA CADA ATRIBUTO ***/
        iterador = atributos.keySet().iterator();
        Object[] vals = clase.obtenerValores().toArray();
        System.out.println(vals[0]);
        System.out.println(vals[1]);
        
        double p = (double) clase.obtenerFrecuencia((String)vals[0]);
        double n = (double) clase.obtenerFrecuencia((String)vals[1]);
        
        System.out.println(p);
        System.out.println(n);
        double valueLogp = (p/(p+n)); 
        double valueLogn = (n/(p+n));
        double informacion = -valueLogp * (Math.log(valueLogp)/Math.log(2)) -valueLogn *(Math.log(valueLogn)/Math.log(2));
        double maxganancia = 0;
        String max = "";
        
        while(iterador.hasNext()){
            System.out.println("Im here");
            Atributo testAtributo = atributos.get((String)iterador.next());
            testAtributo.calcularEntropia((String)vals[0], (String)vals[1]);
           // System.out.println(testAtributo.obtenerEntropia());
            testAtributo.calcularGanancia(informacion);
            //System.out.println(testAtributo.obtenerEntropia());
            if(testAtributo.obtenerGanancia() > maxganancia){
                maxganancia = testAtributo.obtenerGanancia();
                max = testAtributo.obtenerNombre();
            }
        }
        
        System.out.println("El atributo con maxima ganacia es: " + max + " Ganancia: " + maxganancia);
        
        /*** CONSTRUCCION DEL ARBOL DE DECISIONES ***/
        N_AryTree<String> arbolDecision = new N_AryTree<>();
        /*Agregamos el nodo padre */
        arbolDecision.setData(max);
        /*Agregamos los nodos hijos, que son los valores del atributo con ganancia maxima*/
        Atributo seleccionado = atributos.get(max);
        iterador = seleccionado.obtenerValores().keySet().iterator();
        while(iterador.hasNext()){
            String nombreSel = seleccionado.obtenerValor((String)iterador.next()).obtenerNombre();
            /*** CONSTRUCCION DE NUEVAS TABLAS DADO UN CRITERIO DE SELECCION + VALOR ***/
            ArrayList<Dato> nuevaTabla = creaNuevaTabla(tabla, max, nombreSel);
            printTabla(creaNuevaTabla(tabla, max, nombreSel));
            if(seleccionado.obtenerValor(nombreSel).consultarEntropia() == 0){
                System.out.println("Es una Hoja");
                List<N_AryTree<String>> leaf = new ArrayList<>();
                leaf.add(new N_AryTree<String>(seleccionado.obtenerValor(nombreSel).obtenerClase().obtenerDominante()));
                arbolDecision.addChild(new N_AryTree(nombreSel, leaf));
            }
            else{
                /***APLICAMOS EL PROCESO ANTERIOR DE FORMA RECURSIVA ***/
                System.out.println("Requiere de mas divisiones");
                HashMap<String, Atributo> nuevoMapa = creaNuevoMapa(nuevaTabla, max, atributos);
                arbolDecision.addChild(new N_AryTree(nombreSel, particion(nuevaTabla, nuevoMapa)));
            }
        }
        /* Imprimimos el arbol de decision*/
        System.out.println("\n\n***** ARBOL DE DECISION (ID3) ****\n\n");
        arbolDecision.print("", true, arbolDecision);
    }
   
    public static List<N_AryTree<String>> particion(ArrayList<Dato> tabla, HashMap<String, Atributo> mapa){
        List<N_AryTree<String>> tree  = new ArrayList<>();
        
        if(!tabla.isEmpty()){
            /*** CALCULANDO LA ENTROPIA BINARIA PARA CADA ATRIBUTO ***/
            Iterator iterador = mapa.keySet().iterator();
            Object[] vals = clase.obtenerValores().toArray();
            System.out.println(vals[0]);
            System.out.println(vals[1]);
        
            double p = (double) clase.obtenerFrecuencia((String)vals[0]);
            double n = (double) clase.obtenerFrecuencia((String)vals[1]);
        
            System.out.println(p);
            System.out.println(n);
            double valueLogp = (p/(p+n)); 
            double valueLogn = (n/(p+n));
            double informacion = -valueLogp * (Math.log(valueLogp)/Math.log(2)) -valueLogn *(Math.log(valueLogn)/Math.log(2));
            double maxganancia = 0;
            String max = "";
        
            while(iterador.hasNext()){
                System.out.println("Im here");
                Atributo testAtributo = mapa.get((String)iterador.next());
                testAtributo.calcularEntropia((String)vals[0], (String)vals[1]);
               // System.out.println(testAtributo.obtenerEntropia());
                testAtributo.calcularGanancia(informacion);
                //System.out.println(testAtributo.obtenerEntropia());
                if(testAtributo.obtenerGanancia() > maxganancia){
                    maxganancia = testAtributo.obtenerGanancia();
                    max = testAtributo.obtenerNombre();
                }
            }
            System.out.println("El atributo con maxima ganacia es: " + max + " Ganancia: " + maxganancia);
            
            /*** CONSTRUCCION DEL ARBOL DE DECISIONES ***/
            N_AryTree<String> arbolDecision = new N_AryTree<>();
            /*Agregamos el nodo padre */
            arbolDecision.setData(max);
            /*Agregamos los nodos hijos, que son los valores del atributo con ganancia maxima*/
            Atributo seleccionado = mapa.get(max);
            iterador = seleccionado.obtenerValores().keySet().iterator();
            while(iterador.hasNext()){
                String nombreSel = seleccionado.obtenerValor((String)iterador.next()).obtenerNombre();
                /*** CONSTRUCCION DE NUEVAS TABLAS DADO UN CRITERIO DE SELECCION + VALOR ***/
                ArrayList<Dato> nuevaTabla = creaNuevaTabla(tabla, max, nombreSel);
                printTabla(creaNuevaTabla(tabla, max, nombreSel));
                if(seleccionado.obtenerValor(nombreSel).consultarEntropia() == 0){
                    System.out.println("Es una Hoja");
                    List<N_AryTree<String>> leaf = new ArrayList<>();
                    leaf.add(new N_AryTree<String>(seleccionado.obtenerValor(nombreSel).obtenerClase().obtenerDominante()));
                    arbolDecision.addChild(new N_AryTree(nombreSel, leaf));
                }
                else{
                    /***APLICAMOS EL PROCESO ANTERIOR DE FORMA RECURSIVA ***/
                    System.out.println("Requiere de mas divisiones");
                    HashMap<String, Atributo> nuevoMapa = creaNuevoMapa(nuevaTabla, max, mapa);
                    arbolDecision.addChild(new N_AryTree(nombreSel, particion(nuevaTabla, nuevoMapa)));
                }
            }
            tree.add(arbolDecision);
        }
        
        return tree;
    }
    
    public static HashMap<String, Atributo> creaNuevoMapa(ArrayList<Dato> tabla, String seleccionado, HashMap<String, Atributo> viejoMapa){
        HashMap<String, Atributo> mapa = (HashMap<String, Atributo>) DeepCopy.copy(viejoMapa);
        /* Quitamos del mapa el atributo seleccionado */
        mapa.remove(seleccionado);
        
        /*Reseteamos el total de las frecuencias almacenadas a cero */
        clase.reseteaFrecuencias();
        
        /* Reseteamos todas las frecuencias almacenadas a cero */
        for(String nomAtributo : mapa.keySet()){
            Atributo atributo = mapa.get(nomAtributo);
            atributo.reseteaFrecuencias();
        }
        
        /* Llenamos el nuevo mapa con las nuevas frecuencias */
        for(Dato dato: tabla){
            for(String columna : dato.obtenerColumnas()){
                if(!columna.equals(clase.obtenerNombre())){
                        mapa.get(columna).obtenerValor(dato.obtenerValor(columna)).incrementaFrecuencia(dato.obtenerValor(clase.obtenerNombre()));
                }
                else{
                    clase.incrementaFrecuencia(dato.obtenerValor(columna));
                }
            }
        }
        
        /* Quitamos todos los valores cuya frecuencia es igual a cero */
        /* Verificamos que el nuevo mapa se haya llenado exitosamente */
        System.out.println("\n***Prueba de frecuencias por atributo-valor***");
        Iterator iterador = mapa.keySet().iterator();
        ArrayList<String> removerA = new ArrayList<>();
        ArrayList<String> removerV = new ArrayList<>();
        int frecuenciaAcum;
        int frecuencia;
        
        for(String tempA : mapa.keySet()){
            Atributo testAtributo = mapa.get(tempA);
            HashMap<String, Valor> testValores = testAtributo.obtenerValores();
            removerV = new ArrayList<>();
            for(String tempV : testValores.keySet()){         
                frecuenciaAcum = 0;
                Valor testValor = testValores.get(tempV);
                Clase testClase = testValor.obtenerClase();
                for(String tempC : testClase.obtenerValores()){
                   frecuencia = testClase.obtenerFrecuencia(tempC);
                   frecuenciaAcum += frecuencia;
                   if(frecuencia != 0)
                    System.out.println("Atributo: " + testAtributo.obtenerNombre() +  "  Valor de Atributo: " + testValor.obtenerNombre() + " Valor de Clase: " + tempC + "  Frecuencia: " + frecuencia);
                }
                if(frecuenciaAcum == 0)
                    removerV.add(tempV);
            }
            for(int i=0; i<removerV.size(); i++)
                testValores.remove(removerV.get(i));
            
            if(testAtributo.obtenerValores().isEmpty())
                removerA.add(tempA);
        }
        
        for(int i=0; i<removerA.size(); i++)
                mapa.remove(removerV.get(i));
        
        System.out.println("\n***Fin de prueba de frecuencias por atributo-valor***");
       
        return mapa;
    }
    
    public static void printTabla(ArrayList<Dato> tabla){
       Set<String> columnas;
       Iterator iterador;
       System.out.println("\n ********************************");
       for(Dato dato: tabla){
           columnas = dato.obtenerColumnas();
           iterador = columnas.iterator();
           while(iterador.hasNext()){
               String atributo = (String) iterador.next();
               String valor = dato.obtenerValor(atributo);
               System.out.print(" Atributo: " + atributo + " Dato: " + valor);
           }
           System.out.println("");
       }
       System.out.println(" ********************************");
   }
   
   public static ArrayList<Dato> creaNuevaTabla(ArrayList<Dato> viejaTabla, String seleccionado, String valorAtributo){
        /***Hacemos una copia del objeto, para poder modificar los atributos de los elementos del HashMap***/
        ArrayList<Dato> nuevaTabla = new ArrayList<>();
        /*** PASO1: Quitar y seleccionar las tuplas que cumplen con el valorAtributo***/
        for(int i=0;i <viejaTabla.size(); i++){
            Dato dato = (Dato) DeepCopy.copy(viejaTabla.get(i));
            if(dato.obtenerValor(seleccionado).equals(valorAtributo)){
                dato.quitarColumna(seleccionado);
                nuevaTabla.add(dato);
            }
        }
        return nuevaTabla;
    }
}