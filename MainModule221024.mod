MODULE MainModule
    PERS wobjdata TarimaDer:=[FALSE,TRUE,"",[[1372.11,-163.36,-568.413],[0.99996,-0.00630356,0.00480355,-0.00406032]],[[0,0,0],[1,0,0,0]]];
    PERS wobjdata TarimaIzq:=[FALSE,TRUE,"",[[1272.11,-1313.36,-568.413],[0.99996,-0.00630356,0.00480355,-0.00406032]],[[0,0,0],[1,0,0,0]]];
    PERS wobjdata TarimaTEMP:=[FALSE,TRUE,"",[[1272.11,-1313.36,-568.413],[0.99996,-0.00630356,0.00480355,-0.00406032]],[[0,0,0],[1,0,0,0]]];
    PERS wobjdata Conveyor:=[FALSE,TRUE,"",[[1372.11,-1313.36,-568.413],[0.99996,-0.00630356,0.00480355,-0.00406032]],[[0,0,0],[1,0,0,0]]];
    
    PERS tooldata ToolBox:=[TRUE,[[0,0,205.71],[1,0,0,0]],[8.4,[0,0,310],[1,0,0,0],0,0,0.784]];
    CONST robtarget Home:=[[1408.88,37.23,925.30],[0,0.000635447,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Grab:=[[-847.65,2582.09,502.98],[0.00480007,-0.00350848,0.999962,0.00630621],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS loaddata noload:=[0.1,[0,0,-26160.6],[1,0,0,0],0,0,0];

    !_______________TARGETS TARIMA IZQUIERDA________________________________________________________________________________________________________
    CONST robtarget Pos1c1:=[[97.02,492.03,-220.98],[0.00102017,-0.700539,-0.713571,-0.00785928],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Pos4c1:=[[526.41,578.02,-226.98],[0.00482037,-0.00673115,0.999946,0.00629071],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Pos6c1:=[[864.23,583.43,-226.98],[0.00479627,-0.00290634,0.999964,0.0063091],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    !_______________TARGETS TARIMA DERECHA__________________________________________________________________________________________________________
    CONST robtarget Pos1c2:=[[10.40,553.40,-109.73],[0.00479995,-0.00348884,0.999963,0.00630631],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Pos3c2:=[[441.71,468.51,-106.77],[0.00785555,-0.711041,0.703106,0.00104849],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

    CONST robtarget p10:=[[1419.98,429.18,470.66],[0,-0.00353235,0.999994,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget p20:=[[1421.11,-325.25,475.46],[0,-0.00350174,0.999994,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget p30:=[[1421.10,-325.24,749.47],[0,-0.00350001,0.999994,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget p40:=[[1421.16,227.40,749.45],[0,-0.00349924,0.999994,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

    VAR num Altura:=0;
    VAR num off_x:=0;
    VAR num off_y:=0;
    VAR num off_z:=0;
    VAR num off_target:=0;
    VAR num alturacajas:=4; !Variable para definir el numero de camas que se quieren.
    VAR num Posicion:=0;
    VAR num htarima:=145;
    VAR num hcaja:=274;
    VAR num AnchoCaja:=333;
    VAR num LargoCaja:=515;
    VAR num NivelActual:=0;
    VAR num offsXPosFeeder:=500;
    VAR num offsYPosFeeder:=0;
    VAR num offsZPosFeeder:=350;
    VAR num START;
    VAR num OffsGrab:=-78.34;
    VAR num Tolerancia:=4;
    VAR num Xtra:=5;
    VAR speeddata SpeedNoLoad:=[5000,500,5000,1000];
    VAR speeddata PalletizingSpeed:=[7000,250,250,5];
    VAR num SeleccionMosaico;
    VAR num SeleccionTarima;
    TASK PERS tooldata catoetc:=[TRUE,[[0,0,0],[1,0,0,0]],[180,[0,0,0],[1,0,0,0],0,0,0]];

    !Tamaño caja = 333x515
    !Total de niveles: 8
    !PALETIZADO CAJAS PLASTICO QUALTIA
    
    !PALETIZADO CAJAS SIGMA
    !PRUEBAS 22/Octubre/2024
    !TIEMPO DE PALETIZADO EN VACIO: 3:25 minutos.

    !________________________________________________________________________________________________________________________________
    !____________________INICIO DE PROGRAMA___________________________________________________________________________________________

    PROC main()
        !Se llama a Palletizing01, actualmente encargado de paletizar simulador SIGMA
        Palletizing01;
        <SMT>
        <SMT>
    ENDPROC

    !________________________PALLETIZED LAYOUT 1________________________________________________________________________________________________

   !Paletizado simulacion SIGMA
    PROC Palletizing01() 
        MoveL Home,v7000,fine,ToolBox\WObj:=wobj0; !Inicia el paletizado en posicion segura - HOME.
        TPWrite "Tiempo de total de ciclo: "\num:=ClkRead(clock1); !Se muestra el tiempo de ciclo en el TP.
        
        !Ciclo para el paletizado
        !Ciclo hasta que variable Altura sea igual variable alturacajas.
        FOR Altura FROM 0 TO alturacajas DO      !Altura esta declarado en linea 25. Actualmente = 0. | alturacajas esta declarado en linea 30. Actualmente = 4 
            off_z:=Altura*hcaja;                 !Calcula altura para el offset que tomara en Z | hcaja esta declarada en linea 33. = 274 (Corresponde a altura de caja (27.4cm)).
            TPWrite "Estás en el nivel:"\Num:=Altura+1; 
            IF Altura = 0 THEN                   !Si Altura es 0 (si corresponde a la primer cama) calcula el off_target de diferente manera.
                off_target:=(Altura + 1)*(2 * hcaja)+htarima; 
            ELSE                                 !Si es mayor a 0(si corresponde a la segunda o cama) se calcula de la siguiente manera.
                off_target:=(Altura * hcaja)+(2*hcaja)+htarima;
            ENDIF
            
            !---------------------------------------------------PRIMERA POISICION-----------------------------------------------
            Feeder; !Se llama a PROC que se encarga de tomar las cajas en el conveyor.
            incr Posicion; !Se incrementa variable de posicion.
            TPWrite "Estás en la posición:"\num:=Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos1c1,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm arriba de la posicion 1 a dejar. 
            MoveL offs(Pos1c1,off_x,off_y,off_z),v7000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja.   
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\inpos; !Espera que el robot este en posicion.
            !WaitTime 1;  
            Reset Local_IO_0_DO1; !Suelta caja.
            WaitTime .8; !Espera 0.8 segundos.
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos1c1,off_x,off_y,off_z+500),v7000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm arriba de la posicion donde se dejo la caja. 
            off_y:=off_y+AnchoCaja+Tolerancia; !Calcula cuanto se movera en -y- en la proxima posicion. 
            
            !---------------------------------------------------SEGUNDA POSICION-----------------------------------------------
            Feeder; !Tomar siguiente caja.
            incr Posicion; !Incrementa variable posicion. 
            !2
            TPWrite "Estás en la posición: "\num:= Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos1c1,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm arriba de la siguiente posicion a dejar.
            MoveL offs(Pos1c1,off_x,off_y,off_z),v7000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja.
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\inpos; !Espera que robot este en posicion.
            !WaitTime 1;
            Reset Local_IO_0_DO1; !Suelta la caja.
            WaitTime .8; !Espera 0.8 seg.
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos1c1,off_x,off_y,off_z+500),v7000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm arriba de la posicion donde se dejo la caja.
            off_y:=off_y+AnchoCaja+Tolerancia; !Calculo de -y- para siguiente posicion .
            
            !---------------------------------------------------TERCERA POSICION-----------------------------------------------
            Feeder; !PROC para tomar caja.
            incr Posicion; !Incrementa valor de variable.
            TPWrite "Estás en la posición:"\num:=Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos1c1,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm arriba de la siguiente posicion a dejar.
            MoveL offs(Pos1c1,off_x,off_y,off_z),v7000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja.
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\inpos; !Espera que el robot este en posicion.
            !WaitTime 1;
            Reset Local_IO_0_DO1; !Suelta la caja.
            WaitTime .8; !Espera 0.8 seg.
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos1c1,off_x,off_y,off_z+500),v7000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm arriba de la posicion donde se dejo la caja.
            off_y:=0; !Se reinicia calculo del offset en -y-.
            off_x:=0; !Se reinicia calculo del offset en -x-.
            
            !---------------------------------------------------CUARTA POSICION-----------------------------------------------
            Feeder; !PROC para tomar caja.
            incr Posicion; !Incrementa valor de variable.
            !4
            TPWrite "Estás en la posición:"\num:=Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos4c1,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm arriba de la siguiente posicion a dejar.
            MoveL offs(Pos4c1,off_x,off_y,off_z),v7000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja.
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\inpos; !Espera que el robot este en posicion.
            !WaitTime 1;
            Reset Local_IO_0_DO1; !Suelta la caja.
            WaitTime .8; !Espera 0.8 seg.
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos4c1,off_x,off_y,off_z+500),v7000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm arriba de la posicion donde se dejo la caja.
            off_y:=off_y+LargoCaja+Tolerancia; !Calculo de -y- para siguiente posicion.
            
            !---------------------------------------------------QUINTA POSICION-----------------------------------------------
            Feeder; !PROC para tomar caja.
            incr Posicion; !Incrementa valor de variable.
            !5
            TPWrite "Estás en la posición:"\num:=Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos4c1,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm arriba de la siguiente posicion a dejar.
            MoveL offs(Pos4c1,off_x,off_y,off_z),v7000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja.
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\inpos; !Espera que el robot este en posicion.
            !WaitTime 1;
            Reset Local_IO_0_DO1; !Suelta la caja.
            WaitTime .8; !Espera 0.8 seg.
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos4c1,off_x,off_y,off_z+500),v7000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm arriba de la posicion donde se dejo la caja.
            off_y:=0; !Se reinicia calculo del offset en -y-
            off_x:=0; !Se reinicia calculo del offset en -x-
            
            !---------------------------------------------------SEXTA POSICION-----------------------------------------------
            Feeder; !PROC para tomar caja.
            incr Posicion; !Incrementa valor de variable.
            !6
            TPWrite "Estás en la posición:"\num:=Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos6c1,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm arriba de la siguiente posicion a dejar.
            MoveL offs(Pos6c1,off_x,off_y,off_z),v7000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja.
            TPWrite "ALTURA:"\Num:=off_target; 
            WaitRob\inpos; !Espera que el robot este en posicion.
            !WaitTime 1;
            Reset Local_IO_0_DO1; !Suelta la caja.
            WaitTime .8; !Espera 0.8 seg.
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos6c1,off_x,off_y,off_z+500),v7000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm arriba de la posicion donde se dejo la caja.
            off_y:=off_y+LargoCaja+Tolerancia+Xtra; !Calculo de -y- para siguiente posicion.
            
            !---------------------------------------------------SEPTIMA POSICION-----------------------------------------------
            Feeder; !PROC para tomar caja.
            incr Posicion; !Incrementa valor de variable.
            !7
            TPWrite "Estás en la posición:"\num:=Posicion; 
            !AccSet 20,100;
            MoveJ offs(Pos6c1,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm arriba de la siguiente posicion a dejar.
            MoveL offs(Pos6c1,off_x,off_y,off_z),v7000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja.
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\inpos; !Espera que el robot este en posicion.
            !WaitTime 1;
            Reset Local_IO_0_DO1; !Suelta la caja.
            WaitTime .8; !Espera 0.8 seg.
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos6c1,off_x,off_y,off_z+500),v7000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm arriba de la posicion donde se dejo la caja.

            off_y:=0; !Se reinicia calculo del offset en -y-.
            off_x:=0; !Se reinicia calculo del offset en -x-.
            Posicion:=0; !Se reinicia variable de Posicion. 
            Incr NivelActual; !Se incrementa el -NivelActual- para sigueinte cama.
        ENDFOR
        
        MoveJ Home,v7000,z100,tool0\WObj:=wobj0; !Mover a home al terminar paletizado.
        NivelActual:=0; !Se reinicia NivelActual a 0.
        STOP; !Detiene el programa.
    ENDPROC


    !________________________PALLETIZED LAYOUT 2________________________________________________________________________________________________

    PROC Palletizing02()
        !Ciclo para el paletizado
        !Ciclo hasta que variable Altura sea igual variable alturacajas.
        FOR Altura FROM 0 TO alturacajas DO !Altura esta declarado en linea 25. Actualmente = 0.
            off_z:=Altura*hcaja; !Calcula altura para el offset que tomara en Z | hcaja esta declarada en linea 33. = 274 (Corresponde a altura de caja (27.4cm)).
            TPWrite "Estás en el nivel:"\Num:=Altura+1;
            
            IF Altura=0 THEN                                    !Si Altura es 0 (si corresponde a la primer cama) calcula el off_target de diferente manera.
                off_target:=(Altura+1)*(2*hcaja)+htarima;
            ELSE                                                !Si es mayor a 0(si corresponde a la segunda o cama) se calcula de la siguiente manera.
                off_target:=(Altura*hcaja)+(2*hcaja)+htarima; 
            ENDIF
            
            !---------------------------------------------------PRIMERA POSICION-----------------------------------------------
            Feeder; !PROC que toma caja
            incr Posicion; !Se incrementa en 1 la variable posicion.
            !1
            TPWrite "Estás en la posición:"\num:=Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos1c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            MoveL offs(Pos1c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja. 
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\zerospeed; !Espera que el robot este totalmente detenido. 
            !WaitTime 1;
            Reset Local_IO_0_DO1; !Deja la caja
            !WaitTime 1;
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos1c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z donde se deja caja.
            off_y:=off_y+LargoCaja+Tolerancia; !Calculo de offset en y
            
            !---------------------------------------------------SEGUNDA POSICION-----------------------------------------------
            Feeder; !PROC que toma caja.
            incr Posicion; !Se incrementa 1 la variable posicion.
            !2
            TPWrite "Estás en la posición:"\num:=Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos1c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            MoveL offs(Pos1c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja. 
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos; !Espera que el robot este en posicion.
            !WaitTime 1;
            Reset Local_IO_0_DO1; !Deja la caja.
            !WaitTime 1;
            GripLoad noload;!Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos1c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            off_y:=0; !Se reinician los valores del offset en -y-.
            off_x:=0; !Se reinician los valores del offset en -x-.
            
            !---------------------------------------------------TERCERA POSICION-----------------------------------------------
            Feeder; !PROC que toma caja.
            incr Posicion; !Se incrementa 1 la variable posicion.
            !3
            TPWrite "Estás en la posición:"\num:=Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos3c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            MoveL offs(Pos3c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja.
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos; !Espera que el robot este en posicion.
            !WaitTime 1;
            Reset Local_IO_0_DO1; !Deja la caja.
            !WaitTime 1;
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos3c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            off_y:=off_y+AnchoCaja+Tolerancia;
            
            !---------------------------------------------------CUARTA POSICION-----------------------------------------------
            Feeder; !PROC que toma caja.
            incr Posicion; !Se incrementa 1 la variable posicion.
            !4
            TPWrite "Estás en la posición:"\num:=Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos3c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            MoveL offs(Pos3c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja.
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos; !Espera que el robot este en posicion.
            !WaitTime 1;
            Reset Local_IO_0_DO1; !Deja la caja.
            !WaitTime 1;
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos3c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            off_y:=off_y+AnchoCaja+Tolerancia; !Calculo de offset en y
            
            !---------------------------------------------------QUINTA POSICION-----------------------------------------------
            Feeder; !PROC que toma caja.
            incr Posicion; !Se incrementa 1 la variable posicion.
            !5
            TPWrite "Estás en la posición:"\num:=Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos3c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            MoveL offs(Pos3c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja.
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos; !Espera que el robot este en posicion.
            !WaitTime 1;
            Reset Local_IO_0_DO1; !Deja la caja.
            !WaitTime 1;
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos3c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba)
            off_y:=0; !Se reinician los valores del offset en -y-.
            off_x:=0; !Se reinician los valores del offset en -x-.
            off_x:=off_x+LargoCaja+AnchoCaja+Tolerancia+Xtra; !Calculo de x para el offset.
            
            !---------------------------------------------------SEXTA POSICION-----------------------------------------------
            Feeder; !PROC que toma caja.
            incr Posicion; !Se incrementa 1 la variable posicion.
            !6
            TPWrite "Estás en la posición:"\num:=Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos1c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            MoveL offs(Pos1c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja.
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos; !Espera que el robot este en posicion.
            !WaitTime 1;
            Reset Local_IO_0_DO1; !Deja la caja.
            !WaitTime 1; 
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos1c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            off_y:=off_y+LargoCaja+Tolerancia; !Calculo de offset en y
            
            !---------------------------------------------------SEPTIMA POSICION-----------------------------------------------
            Feeder; !PROC que toma caja.
            incr Posicion; !Se incrementa 1 la variable posicion.
            !7
            TPWrite "Estás en la posición:"\num:=Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos1c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            MoveL offs(Pos1c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja.
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos; !Espera que el robot este en posicion.
            !WaitTime 1; 
            Reset Local_IO_0_DO1; !Deja la caja.
            !WaitTime 1;
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos1c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            off_y:=0; !Se reinician los valores del offset en -y-.
            off_x:=0; !Se reinician los valores del offset en -x-.
            Posicion:=0; !Se reinician los valores de la variable -Posicion-.
            Incr NivelActual; !Se incrementa el nivel de la cama.
        ENDFOR
        
        <SMT>
        TPWrite "Tiempo de total de ciclo: "\num:=ClkRead(clock1);
        MoveJ Home,v2000,z100,tool0\WObj:=wobj0; !Movimiento a home despues de terminar paletizado.
        NivelActual:=0; !Se reinician valores del nivel de cama.
        STOP; !Se detiene el programa.
    ENDPROC


    !________________________PALLETIZED LAYOUT 3________________________________________________________________________________________________

    PROC Palletizing03()
        
        !Ciclo para el paletizado
        !Ciclo hasta que variable Altura sea igual variable alturacajas.
        FOR Altura FROM 0 TO alturacajas DO !Altura esta declarado en linea 25. Actualmente = 0. | alturacajas esta declarado en linea 30. Actualmente = 4 
            off_z:=Altura*hcaja; !Calcula altura para el offset que tomara en Z | hcaja esta declarada en linea 33. = 274 (Corresponde a altura de caja (27.4cm)).
            TPWrite "Estás en el nivel:"\Num:=Altura+1;
            IF Altura=0 THEN                                   !Si Altura es 0 (si corresponde a la primer cama) calcula el off_target de diferente manera.
                off_target:=(Altura+1)*(2*hcaja)+htarima;
            ELSE                                               !Si es mayor a 0(si corresponde a la segunda o cama) se calcula de la siguiente manera.
                off_target:=(Altura*hcaja)+(2*hcaja)+htarima; 
            ENDIF
            
            !---------------------------------------------------PRIMERA POSICION-----------------------------------------------
            Feeder; !PROC que toma caja
            incr Posicion; !Se incrementa 1 la variable posicion.
            !1
            TPWrite "Estás en la posición:"\num:=Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos1c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            MoveL offs(Pos1c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja.
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos; !Espera que el robot este en posicion.
            !WaitTime 1;
            Reset Local_IO_0_DO1; !Deja la caja.
            !WaitTime 1;
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos1c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            off_y:=off_y+LargoCaja+Tolerancia; !Calculo de offset en y.
            
            !---------------------------------------------------SEGUNDA POSICION-----------------------------------------------
            Feeder; !PROC que toma caja
            incr Posicion; !Se incrementa 1 la variable posicion.
            !2
            TPWrite "Estás en la posición:"\num:=Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos1c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            MoveL offs(Pos1c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja.
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos; !Espera que el robot este en posicion.
            !WaitTime 1;
            Reset Local_IO_0_DO1; !Deja la caja.
            !WaitTime 1;
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos1c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            off_y:=0; !Se reinician los valores del offset en -y-.
            off_x:=0; !Se reinician los valores del offset en -x-.
            
            !---------------------------------------------------TRECERA POSICION-----------------------------------------------
            Feeder; !PROC que toma caja
            incr Posicion; !Se incrementa 1 la variable posicion.
            !3
            TPWrite "Estás en la posición:"\num:=Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos3c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            MoveL offs(Pos3c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja.
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos; !Espera que el robot este en posicion.
            !WaitTime 1;
            Reset Local_IO_0_DO1; !Deja la caja.
            !WaitTime 1;
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos3c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            off_y:=off_y+(2*AnchoCaja)+Tolerancia; !Calculo de offset en y.
            
            !---------------------------------------------------CUARTA POSICION-----------------------------------------------
            Feeder; !PROC que toma caja
            incr Posicion; !Se incrementa 1 la variable posicion.
            !4
            TPWrite "Estás en la posición:"\num:=Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos3c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            MoveL offs(Pos3c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja.
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos; !Espera que el robot este en posicion.
            !WaitTime 1;
            Reset Local_IO_0_DO1; !Deja la caja.
            !WaitTime 1;
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos3c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            off_y:=0; !Se reinician los valores del offset en -y-.
            off_x:=0; !Se reinician los valores del offset en -x-.
            off_x:=off_x+LargoCaja+AnchoCaja+Tolerancia+Xtra; !Calculo de offset en x
            
            !---------------------------------------------------QUINTA POSICION-----------------------------------------------
            Feeder; !PROC que toma caja
            incr Posicion; !Se incrementa 1 la variable posicion.
            !5
            TPWrite "Estás en la posición:"\num:=Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos1c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            MoveL offs(Pos1c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja.
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos; !Espera que el robot este en posicion.
            !WaitTime 1;
            Reset Local_IO_0_DO1; !Deja la caja.
            !WaitTime 1;
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos1c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            off_y:=off_y+LargoCaja+Tolerancia; !Calculo de offset en y.
            
            !---------------------------------------------------SEXTA POSICION-----------------------------------------------
            Feeder; !PROC que toma caja
            incr Posicion; !Se incrementa 1 la variable posicion.
            !6
            TPWrite "Estás en la posición:"\num:=Posicion;
            !AccSet 20,100;
            MoveJ offs(Pos1c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            MoveL offs(Pos1c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona en donde dejara la caja.
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos; !Espera que el robot este en posicion.
            !WaitTime 1;
            Reset Local_IO_0_DO1; !Deja la caja.
            !WaitTime 1;
            GripLoad noload; !Se reinicia el peso de robot (ya no lleva peso).
            MoveL offs(Pos1c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP; !Se posiciona 500mm en Z (arriba) donde se deja caja.
            off_y:=0; !Se reinician los valores del offset en -y-.
            off_x:=0; !Se reinician los valores del offset en -x-.
            Posicion:=0; !Se reinician los valores de la variable -Posicion-.
            Incr NivelActual; !Se incrementa en nivel actual (cama)
        ENDFOR
        
        TPWrite "Tiempo de total de ciclo: "\num:=ClkRead(clock1);
        MoveJ Home,v2000,z100,tool0\WObj:=wobj0; !Movimiento a home despues de terminar el paletizado
        NivelActual:=0; !Se reinicia nivel (cama)
        STOP; !Se detiene el programa
        
    ENDPROC


    !________________________CONVEYOR FEEDER_______________________________________________________________________________________
   PROC Feeder()
        !AccSet 80,100;
        Reset Local_IO_0_DO1; !Abre herramienta evitando que entre por caja con la herramienta cerrada.
        MoveJ offs(Grab,0,0,150),PalletizingSpeed,fine,ToolBox\WObj:=Conveyor; !Se posiciona 500mm arriba de la caja a tomar.
        MoveL Grab,v6000,fine,ToolBox\WObj:=Conveyor; !Se posiciona en donde tomara la caja.
        !WaitDI PLC_SENSOR_CONVEYOR,1;
        !AccSet 20,100;
        !MoveL Offs(Grab,0,0,OffsGrab),v2000,fine,ToolBox\WObj:=TarimaIzq;
        WaitRob\zerospeed; !Espera que robot este totalmente detenido.
        !WaitTime .5;
        Set Local_IO_0_DO1; !Toma la caja.
        !WaitTime 1;
        !MoveL Offs(Grab,offsXPosFeeder,offsYPosFeeder,offsZPosFeeder),PalletizingSpeed,fine,ToolBox\WObj:=TarimaDer;
        
        IF Posicion<5 THEN  
            !Si la posicion es menor a 5 no sube extra en Z
            MoveL Offs(Grab,offsXPosFeeder,offsYPosFeeder,offsZPosFeeder),PalletizingSpeed,fine,ToolBox\WObj:=Conveyor; 
        ELSE
            !Si la posicion es mayor a 5 sube extra 400mm en Z.
            MoveL Offs(Grab,offsXPosFeeder,offsYPosFeeder,offsZPosFeeder+400),PalletizingSpeed,fine,ToolBox\WObj:=Conveyor;
        ENDIF
    ENDPROC


    PROC DATAPLC()
        SeleccionTarima:=PLC_SeleccionTarima;
        SeleccionMosaico:=PLC_SeleccionMosaico;
        TEST SeleccionTarima
        CASE 1:
            TarimaTEMP:=TarimaIzq;
        CASE 2:
            TarimaTEMP:=TarimaDer;
        ENDTEST
        TEST SeleccionMosaico
        CASE 1:
            Palletizing01;
        CASE 2:
            Palletizing02;
        CASE 3:
            Palletizing03;
        ENDTEST
    ENDPROC


    PROC Prueba_MestaRuta()
        MoveJ p10,v5000,z10,tool0,\WObj:=wobj0;
        MoveJ p20,v5000,z10,tool0,\WObj:=wobj0;
        MoveJ p30,v5000,z10,tool0,\WObj:=wobj0;
        MoveJ p40,v5000,z10,tool0,\WObj:=wobj0;
    ENDPROC
    
	PROC Routine1()
        FOR Altura FROM 0 TO alturacajas DO
            off_z:=Altura*hcaja;
            TPWrite "Estás en el nivel:"\Num:=Altura+1;
            IF Altura=0 THEN
                off_target:=(Altura+1)*(2*hcaja)+htarima;
            ELSE
                off_target:=(Altura*hcaja)+(2*hcaja)+htarima;
            ENDIF
            Feeder;
            incr Posicion;
            !   1
            TPWrite "Estás en la posición:"\num:=Posicion;
!            AccSet 20,100;
            MoveJ offs(Pos1c1,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos1c1,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos1c1,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=off_y+AnchoCaja+Tolerancia;
            Feeder;
            incr Posicion;
            !   2
            TPWrite "Estás en la posición:"\num:=Posicion;
!            AccSet 20,100;
            MoveJ offs(Pos1c1,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos1c1,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos1c1,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=off_y+AnchoCaja+Tolerancia;
            Feeder;
            incr Posicion;
            !   3
            TPWrite "Estás en la posición:"\num:=Posicion;
            AccSet 20,100;
            MoveJ offs(Pos1c1,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos1c1,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos1c1,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=0;
            off_x:=0;
            Feeder;
            incr Posicion;
            !   4
            TPWrite "Estás en la posición:"\num:=Posicion;
!            AccSet 20,100;
            MoveJ offs(Pos4c1,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos4c1,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos4c1,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=off_y+LargoCaja+Tolerancia;
            Feeder;
            incr Posicion;
            !   5
            TPWrite "Estás en la posición:"\num:=Posicion;
!            AccSet 20,100;
            MoveJ offs(Pos4c1,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos4c1,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos4c1,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=0;
            off_x:=0;
            Feeder;
            incr Posicion;
            !   6
            TPWrite "Estás en la posición:"\num:=Posicion;
!            AccSet 20,100;
            MoveJ offs(Pos6c1,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos6c1,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos6c1,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=off_y+LargoCaja+Tolerancia+Xtra;
            Feeder;
            incr Posicion;
            !   7
            TPWrite "Estás en la posición:"\num:=Posicion;
!            AccSet 20,100;
            MoveJ offs(Pos6c1,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos6c1,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos6c1,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;

            off_y:=0;
            off_x:=0;
            Posicion:=0;
            Incr NivelActual;
        ENDFOR
	ENDPROC
    
	PROC Routine2()
		<SMT>
	ENDPROC
    
	PROC Routine3()
		!<SMT>
	ENDPROC

ENDMODULE