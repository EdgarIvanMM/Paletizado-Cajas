MODULE MainModule
    PERS wobjdata TarimaDer:=[FALSE,TRUE,"",[[1372.11,-163.36,-568.413],[0.99996,-0.00630356,0.00480355,-0.00406032]],[[0,0,0],[1,0,0,0]]];
    PERS wobjdata TarimaIzq:=[FALSE,TRUE,"",[[1372.11,-1313.36,-568.413],[0.99996,-0.00630356,0.00480355,-0.00406032]],[[0,0,0],[1,0,0,0]]];
    PERS wobjdata TarimaTEMP:=[FALSE,TRUE,"",[[1372.11,-1313.36,-568.413],[0.99996,-0.00630356,0.00480355,-0.00406032]],[[0,0,0],[1,0,0,0]]];

    PERS tooldata ToolBox:=[TRUE,[[0,0,205.71],[1,0,0,0]],[8.4,[0,0,310],[1,0,0,0],0,0,0.784]];
    CONST robtarget Home:=[[1408.88,37.23,925.30],[0,0.000635447,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Grab:=[[-848.31,2581.19,572.98],[0.00479979,-0.00346299,0.999963,0.00630643],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS loaddata noload:=[0.1,[0,0,-26160.6],[1,0,0,0],0,0,0];

    !_______________TARGETS TARIMA IZQUIERDA________________________________________________________________________________________________________
    CONST robtarget Pos1c1:=[[95.56,490.06,-110.10],[0.00101993,-0.700517,-0.713592,-0.00785931],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Pos4c1:=[[526.41,578.02,-108.43],[0.00482037,-0.00673115,0.999946,0.00629071],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Pos6c1:=[[864.23,583.43,-105.68],[0.00479627,-0.00290634,0.999964,0.0063091],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
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
    VAR num alturacajas:=2;
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
    VAR speeddata PalletizingSpeed:=[1000,250,250,5];
    VAR num SeleccionMosaico;
    VAR num SeleccionTarima;
    TASK PERS tooldata catoetc:=[TRUE,[[0,0,0],[1,0,0,0]],[180,[0,0,0],[1,0,0,0],0,0,0]];

    !tamano caja = 333x515
    !Total de niveles: 8
    !PALETIZADO CAJAS PLASTICO QUALTIA

    !_________________________________________________________________________________________________________________________________
    !____________________INICIO DE PROGRAMA___________________________________________________________________________________________

    PROC main()
        Palletizing02;
        <SMT>
        <SMT>
    ENDPROC


    !________________________PALLETIZED LAYOUT 1 NIGGERS________________________________________________________________________________________________

    PROC Palletizing01()
        TPWrite "Tiempo de total de ciclo: "\num:=ClkRead(clock1);
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
            off_y:=off_y+AnchoCaja+Tolerancia;
            Feeder;
            incr Posicion;
            !   2
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
            AccSet 20,100;
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
            AccSet 20,100;
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
            AccSet 20,100;
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
            AccSet 20,100;
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
        MoveJ Home,v2000,z100,tool0\WObj:=wobj0;
        NivelActual:=0;
        STOP;
    ENDPROC


    !________________________PALLETIZED LAYOUT 2________________________________________________________________________________________________

    PROC Palletizing02()
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
            AccSet 20,100;
            MoveJ offs(Pos1c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos1c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos1c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=off_y+LargoCaja+Tolerancia;
            Feeder;
            incr Posicion;
            !   2
            TPWrite "Estás en la posición:"\num:=Posicion;
            AccSet 20,100;
            MoveJ offs(Pos1c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos1c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos1c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=0;
            off_x:=0;
            Feeder;
            incr Posicion;
            !   3
            TPWrite "Estás en la posición:"\num:=Posicion;
            AccSet 20,100;
            MoveJ offs(Pos3c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos3c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos3c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=off_y+AnchoCaja+Tolerancia;
            Feeder;
            incr Posicion;
            !   4
            TPWrite "Estás en la posición:"\num:=Posicion;
            AccSet 20,100;
            MoveJ offs(Pos3c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos3c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos3c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=off_y+AnchoCaja+Tolerancia;
            Feeder;
            incr Posicion;
            !   5
            TPWrite "Estás en la posición:"\num:=Posicion;
            AccSet 20,100;
            MoveJ offs(Pos3c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos3c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos3c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=0;
            off_x:=0;
            off_x:=off_x+LargoCaja+AnchoCaja+Tolerancia+Xtra;
            Feeder;
            incr Posicion;
            !   6
            TPWrite "Estás en la posición:"\num:=Posicion;
            AccSet 20,100;
            MoveJ offs(Pos1c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos1c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos1c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=off_y+LargoCaja+Tolerancia;
            Feeder;
            incr Posicion;
            !   7
            TPWrite "Estás en la posición:"\num:=Posicion;
            AccSet 20,100;
            MoveJ offs(Pos1c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos1c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos1c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=0;
            off_x:=0;
            Posicion:=0;
            Incr NivelActual;
        ENDFOR
        <SMT>
        TPWrite "Tiempo de total de ciclo: "\num:=ClkRead(clock1);
        MoveJ Home,v2000,z100,tool0\WObj:=wobj0;
        NivelActual:=0;
        STOP;
    ENDPROC


    !________________________PALLETIZED LAYOUT 3________________________________________________________________________________________________

    PROC Palletizing03()
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
            AccSet 20,100;
            MoveJ offs(Pos1c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos1c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos1c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=off_y+LargoCaja+Tolerancia;
            Feeder;
            incr Posicion;
            !   2
            TPWrite "Estás en la posición:"\num:=Posicion;
            AccSet 20,100;
            MoveJ offs(Pos1c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos1c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos1c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=0;
            off_x:=0;
            Feeder;
            incr Posicion;
            !   3
            TPWrite "Estás en la posición:"\num:=Posicion;
            AccSet 20,100;
            MoveJ offs(Pos3c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos3c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos3c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=off_y+(2*AnchoCaja)+Tolerancia;
            Feeder;
            incr Posicion;
            !   4
            TPWrite "Estás en la posición:"\num:=Posicion;
            AccSet 20,100;
            MoveJ offs(Pos3c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos3c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos3c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=0;
            off_x:=0;
            off_x:=off_x+LargoCaja+AnchoCaja+Tolerancia+Xtra;
            Feeder;
            incr Posicion;
            !   5
            TPWrite "Estás en la posición:"\num:=Posicion;
            AccSet 20,100;
            MoveJ offs(Pos1c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos1c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos1c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=off_y+LargoCaja+Tolerancia;
            Feeder;
            incr Posicion;
            !   6
            TPWrite "Estás en la posición:"\num:=Posicion;
            AccSet 20,100;
            MoveJ offs(Pos1c2,off_x,off_y,off_z+500),PalletizingSpeed,fine,ToolBox\WObj:=TarimaTEMP;
            MoveL offs(Pos1c2,off_x,off_y,off_z),v2000,fine,ToolBox\WObj:=TarimaTEMP;
            TPWrite "ALTURA:"\Num:=off_target;
            WaitRob\InPos;
            WaitTime 1;
            Reset Local_IO_0_DO1;
            WaitTime 1;
            GripLoad noload;
            MoveL offs(Pos1c2,off_x,off_y,off_z+500),v5000,fine,ToolBox\WObj:=TarimaTEMP;
            off_y:=0;
            off_x:=0;
            Posicion:=0;
            Incr NivelActual;
        ENDFOR
        TPWrite "Tiempo de total de ciclo: "\num:=ClkRead(clock1);
        MoveJ Home,v2000,z100,tool0\WObj:=wobj0;
        NivelActual:=0;
        STOP;
    ENDPROC


    !________________________CONVEYOR FEEDER_______________________________________________________________________________________
    PROC Feeder()
        AccSet 80,100;
        MoveJ Grab,v6000,fine,ToolBox\WObj:=TarimaIzq;
        WaitDI PLC_SENSOR_CONVEYOR,1;
        AccSet 20,100;
        MoveL Offs(Grab,0,0,OffsGrab),v2000,fine,ToolBox\WObj:=TarimaIzq;
        WaitRob\InPos;
        WaitTime 1;
        Set Local_IO_0_DO1;
        WaitTime 1;
        !MoveL Offs(Grab,offsXPosFeeder,offsYPosFeeder,offsZPosFeeder),PalletizingSpeed,fine,ToolBox\WObj:=TarimaDer;
        IF Posicion<5 THEN
            MoveL Offs(Grab,offsXPosFeeder,offsYPosFeeder,offsZPosFeeder),PalletizingSpeed,fine,ToolBox\WObj:=TarimaIzq;
        ELSE
            MoveL Offs(Grab,offsXPosFeeder,offsYPosFeeder,offsZPosFeeder+400),PalletizingSpeed,fine,ToolBox\WObj:=TarimaIzq;
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
            off_y:=off_y+AnchoCaja+Tolerancia;
            Feeder;
            incr Posicion;
            !   2
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
            AccSet 20,100;
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
            AccSet 20,100;
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
            AccSet 20,100;
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
            AccSet 20,100;
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