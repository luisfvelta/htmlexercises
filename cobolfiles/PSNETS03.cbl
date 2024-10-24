000100 IDENTIFICATION DIVISION.                                         00010026
000200 PROGRAM-ID. PSNNES03.                                            00020026
000300 AUTHOR. LUIS F VELASQUEZ T.                                      00030026
000400 DATE-WRITTEN. 06/09/2024.                                        00040026
000500 DATE-COMPILED.                                                   00050026
000600************************************************************      00060026
000700* PROGRAMA DE CONSULTA DE NOTAS POR ESTUDIANTE  20 09 2024 *      00070026
000800* MODIFICACIONES 21/09 POR LUIS VELASQUEZ                  *      00080026
000900* CON CICS ENLAZA A TRES PROGRAMAS:                        *      00090026
001000* PSNETS73:VALIDA LA EXISTENCIA DEL ESTUDIANTE Y CONSULTA -*      00100026
001100*          SU NOMBRE Y APELLIDOS                           *      00110026
001200* PSNETS53:CONSULTA SI EL ESTUDIANTE TIENE NOTAS REGISTRA- *      00120026
001300*          DAS, RECUPERA EL N�MERO DE NOTAS Y EL DETALLE DE*      00130026
001400*          LAS MISMAS PARA DESPLEGARLAS EN LA PANTALLA     *      00140026
001500* PSNETS53:CONSULTA EL NOMBRE DE UN CURSO DADO SU CODIGO   *      00150026
001600*                                                          *      00160026
001700* EL PROGRAMA PSNETS03 ES LLAMADO DESDE PANTALLA CON LA TRA*      00170026
001800*    TRANSACCI�N CICS SN03 DESDE EL MAPA MSNNE03 Y DESDE   *      00180026
001900*    DOS PROGRAMAS QUE LO INVOCAN DESDE SU MENU Y LE PASAN *      00190026
002000*    PARAMETROS DE LLAMADO EN LA DFHCOMMAREA               *      00200026
002100************************************************************      00210026
002200 ENVIRONMENT DIVISION.                                            00220026
002300 CONFIGURATION SECTION.                                           00230026
002400 SPECIAL-NAMES.                                                   00240026
002500 INPUT-OUTPUT SECTION.                                            00250026
002600 DATA DIVISION.                                                   00260026
002700 WORKING-STORAGE SECTION.                                         00270026
002800* COPY AREAS PARA FECHAS                                          00280026
002900* COPY UFECHAS.                                                   00290026
003000 01  WS-NOMBRES-MESES.                                            00300026
003100     03 WS-NOM-MESES                                              00310026
003200          PIC X(36) VALUE                                         00320026
003300       "ENEFEBMARABRMAYJUNJULAGOSEPOCTNOVDIC".                    00330026
003400     03 WS-NOM-MES REDEFINES WS-NOM-MESES                         00340026
003500          PIC XXX OCCURS 12 TIMES INDEXED BY IX-MES.              00350026
003600 01  WS-CURRENT-DATE-FIELDS.                                      00360026
003700     05 WS-CURRENT-DATE.                                          00370026
003800       10 WS-CURRENT-YEAR     PIC 9999.                           00380026
003900       10 WS-CURRENT-MONTH    PIC 99.                             00390026
004000       10 WS-CURRENT-DAY      PIC 99.                             00400026
004100     05 WS-CURRENT-TIME.                                          00410026
004200       10 WS-CURRENT-HH       PIC 99.                             00420026
004300       10 WS-CURRENT-MM       PIC 99.                             00430026
004400       10 WS-CURRENT-SS       PIC 99.                             00440026
004500       10 WS-CURRENT-CC       PIC 99.                             00450026
004600 01  WS-FECHA-AAAA-MM-DD.                                         00460026
004700       10 WS-AAAA             PIC 9999.                           00470026
004800       10 FILLER              PIC X VALUE "-".                    00480026
004900       10 WS-MM               PIC 99.                             00490026
005000       10 FILLER              PIC X VALUE "-".                    00500026
005100       10 WS-DD               PIC 99.                             00510026
005200 01  WS-HORA-MINUTOS-SEGUNDOS.                                    00520026
005300       10 WS-HH-F1            PIC 99.                             00530026
005400       10 FILLER              PIC X VALUE ".".                    00540026
005500       10 WS-MM-F1            PIC 99.                             00550026
005600       10 FILLER              PIC X VALUE ":".                    00560026
005700       10 WS-SS-F1            PIC 99.                             00570026
005800       10 FILLER              PIC X VALUE ":".                    00580026
005900       10 WS-CC-F1            PIC 99.                             00590026
006000 01  WS-FECHA-DD-MMM-AA.                                          00600026
006100       10 WS-DD-F2            PIC 99.                             00610026
006200       10 FILLER              PIC X VALUE "-".                    00620026
006300       10 WS-MM-F2            PIC XXX.                            00630026
006400       10 FILLER              PIC X VALUE "-".                    00640026
006500       10 WS-AAAA-F2          PIC 9999.                           00650026
006600                                                                  00660026
006700* COPY MSNNE03 MAPA DEL PROGRAMA DE CONSULTA DE NOTAS             00670026
006800  COPY MSNNE03.                                                   00680026
006900*  COPY MSNNE03R.                                                 00690026
007000*  MSNNE03R REDEFINE MSNNE03 ADECUA LINEAS DE SCROLL A OCCURS     00700026
007100 01  MSNNE03OR REDEFINES MSNNE03O.                                00710026
007200     05  FILLER PIC X(397).                                       00720026
007300     05  MLINEA OCCURS 5 TIMES INDEXED BY IX-LINEA.               00730026
007400         07 MCODCUR.                                              00740026
007500            10 MCODESP    PICTURE X(3).                           00750026
007600            10 MCODCOL    PICTURE X.                              00760026
007700            10 MCODPRO    PICTURE X.                              00770026
007800            10 MCODHIG    PICTURE X.                              00780026
007900            10 MVODVVV    PICTURE X.                              00790026
008000            10 MCODUND    PICTURE X.                              00800026
008100            10 MCODIGO    PIC X(9).                               00810026
008200         07 MDESCRI.                                              00820026
008300            10 MDESESP    PICTURE X(3).                           00830026
008400            10 MDESCOL    PICTURE X.                              00840026
008500            10 MDESPRO    PICTURE X.                              00850026
008600            10 MDESHIG    PICTURE X.                              00860026
008700            10 MDESVVV    PICTURE X.                              00870026
008800            10 MDESUND    PICTURE X.                              00880026
008900            10 MDESCUR    PICTURE X(25).                          00890026
009000         07 MAAACRS.                                              00900026
009100            10 MAAAESP    PICTURE X(3).                           00910026
009200            10 MAAACOL    PICTURE X.                              00920026
009300            10 MAAAPRO    PICTURE X.                              00930026
009400            10 MAAAHIG    PICTURE X.                              00940026
009500            10 MAAAVVV    PICTURE X.                              00950026
009600            10 MAAAUND    PICTURE X.                              00960026
009700            10 MAAACUR    PICTURE X(4).                           00970026
009800                                                                  00980026
009900         07 MNOTCRS.                                              00990026
010000            10 MNOTESP    PICTURE X(3).                           01000026
010100            10 MNOTCOL    PICTURE X.                              01010026
010200            10 MNOTPRO    PICTURE X.                              01020026
010300            10 MNOTHIG    PICTURE X.                              01030026
010400            10 MNOTVVV    PICTURE X.                              01040026
010500            10 MNOTUND    PICTURE X.                              01050026
010600            10 MNOTCUR    PICTURE X(4).                           01060026
010700                                                                  01070026
010800 01 DATOS-PRUEBA.                                                 01080026
010900       05 W-VARIOS-PRUEBA.                                        01090026
011000          10 W-DNI-BUSCADO PIC X(9).                              01100026
011100          10 W-DNI-HALLADO PIC X VALUE "N".                       01110026
011200          10 W-IND-FROM   PIC 9999.                               01120026
011300          10 W-IND-TO     PIC 9999.                               01130026
011400          10 W-IND-LISTA  PIC 9999.                               01140026
011500          10 W-IND-VISOR  PIC 9999.                               01150026
011600          10 W-M          PIC 9(4) VALUE 5.                       01160026
011700          10 W-EDI-NOTA   PIC 99V99.                              01170028
011800          10 W-EDI-NOTA-N PIC ZZ.9.                               01190026
011900          10 W-EDI-NOTA-R REDEFINES W-EDI-NOTA-N PIC XXXX.        01191028
012000       05 DNI-DNI OCCURS 6 TIMES INDEXED BY IX-DNI.               01200026
012100          07 DNI-ESTUD  PIC X(9).                                 01210026
012200          07 DNI-NOMEST PIC X(25).                                01220026
012300          07 DNI-APEEST PIC X(25).                                01230026
012400          07 DNI-FROM   PIC 9(4).                                 01240026
012500          07 DNI-TO     PIC 9(4).                                 01250026
012600       05 PRUEBA-NOTAS.                                           01260026
012700          07 FILLER PIC X(15) VALUE "OS390NO01202325".            01270026
012800          07 FILLER PIC X(15) VALUE "GITHBNO02202432".            01280026
012900          07 FILLER PIC X(15) VALUE "OSZSENO03202341".            01290026
013000          07 FILLER PIC X(15) VALUE "CODB2NO04202446".            01300026
013100          07 FILLER PIC X(15) VALUE "CODB2NO05202432".            01310026
013200          07 FILLER PIC X(15) VALUE "OSZSENO06202441".            01320026
013300          07 FILLER PIC X(15) VALUE "CCICSNO07202447".            01330026
013400          07 FILLER PIC X(15) VALUE "OS390NO08202441".            01340026
013500          07 FILLER PIC X(15) VALUE "GITHBNO09202335".            01350026
013600          07 FILLER PIC X(15) VALUE "OSZSENO10202346".            01360026
013700          07 FILLER PIC X(15) VALUE "OS390NO11202331".            01370026
013800          07 FILLER PIC X(15) VALUE "GITHBNO12202435".            01380026
013900          07 FILLER PIC X(15) VALUE "CODB2NO13202432".            01390026
014000          07 FILLER PIC X(15) VALUE "OSZSENO14202426".            01400026
014100          07 FILLER PIC X(15) VALUE "CCICSNO15202447".            01410026
014200          07 FILLER PIC X(15) VALUE "OS390NO16202335".            01420026
014300          07 FILLER PIC X(15) VALUE "CODB2NO17202326".            01430026
014400          07 FILLER PIC X(15) VALUE "CODB2NO18202431".            01440026
014500          07 FILLER PIC X(15) VALUE "CODB2NO19202340".            01450026
014600          07 FILLER PIC X(15) VALUE "CODB2NO20202350".            01460026
014700       05 NOTAS-ESTUD.                                            01470026
014800          07 WS-NUNOTAS PIC 99 VALUE 0.                           01480026
014900          07 NOTAEST                                              01490026
015000             OCCURS 20 TIMES                                      01500026
015100                       DEPENDING ON WS-NUNOTAS                    01510026
015200                       INDEXED BY IX-NOTA.                        01520026
015300             09 CURSO PIC XXXXX.                                  01530026
015400             09 NNOTA PIC XXXX.                                   01540026
015500             09 AAAA  PIC XXXX.                                   01550026
015600             09 NOTA  PIC 9V9.                                    01560026
015700* COPY WSDEBDIS.                                                  01570026
015800 01  WS-SW-DEBUG.                                                 01580026
015900     05 W-SW-DEBUG    PIC X VALUE "S".                            01590026
016000 01  WS-DEBDIS-MSG.                                               01600026
016100     05 W-TIME-DIS    PIC X(11).                                  01610026
016200     05 FILLER        PIC X VALUE SPACES.                         01620026
016300     05 W-PARRAFO     PIC X(10) VALUE SPACES.                     01630026
016400     05 FILLER        PIC X VALUE SPACES.                         01640026
016500     05 W-CAMPO       PIC X(10) VALUE SPACES.                     01650026
016600     05 FILLER        PIC X VALUE "=".                            01660026
016700     05 W-VALOR       PIC X(20).                                  01670026
016800     05 FILLER        PIC X VALUE SPACES.                         01680026
016900     05 W-CAMPO1      PIC X(10) VALUE SPACES.                     01690026
017000     05 FILLER        PIC X VALUE "=".                            01700026
017100     05 W-VALOR1      PIC X(20).                                  01710026
017200     05 FILLER        PIC X VALUE SPACES.                         01720026
017300     05 W-FECHA-DIS   PIC X(10).                                  01730026
017400                                                                  01740026
017500* AYUDAS DE BMS                                                   01750026
017600 COPY DFHAID.                                                     01760026
017700 COPY DFHBMSCA.                                                   01770026
017800 01 MI-COMMAREA PIC X(100).                                       01780026
017900 01 MI-COMMAREA-RED REDEFINES MI-COMMAREA.                        01790026
018000     03 CA-TRANS  PIC XXXX.                                       01800026
018100     03 CA-TERM   PIC XXXX.                                       01810026
018200     03 CA-DNI    PIC X(9).                                       01820026
018300     03 CA-RESTO  PIC X(83).                                      01830026
018400 01 MI-COMMAREA-OTHERS.                                           01840026
018500     03 CA-LEN    PIC 9(4).                                       01850026
018600********************************************************          01860026
018700*  AREA LINK PARA ENCAPSULADOR DE NOTAS *                         01870026
018800********************************************************          01880026
018900 01  AREA-LINK.                                                   01890026
019000                                                                  01900026
019100     05 LK-NT-TIPO-OPE      PIC 9(01).                            01910026
019200     05 LK-NT-SUBTIPO       PIC 9(02).                            01920026
019300     05 LK-NT-CURSO         PIC X(05).                            01930026
019400     05 LK-NT-DNIESTUD      PIC X(09).                            01940026
019500     05 LK-NT-AAAA          PIC X(04).                            01950026
019600     05 LK-NT-NOTA          PIC 99V99.                            01960026
019700     05 LK-NT-CONTADOR      PIC 9(2).                             01970026
019800     05 LK-NT-INDICE        PIC 9(2).                             01980026
019900     05 LK-NT-SQLCODE       PIC S9(9).                            01990026
020000     05 LK-NT-COD-RET       PIC 9(02).                            02000026
020100*********************************************************         02010026
020200*    AREA LINK PARA EL ENCAPSULADOR DE CURSOS           *         02020026
020300*********************************************************         02030026
020400 01 AREA-LINK-CUR REDEFINES AREA-LINK.                            02040026
020500     05 LK-CU-TIPO-OPE      PIC 9(01).                            02050026
020600     05 LK-CU-SUBTIPO-OPE   PIC 9(02).                            02060026
020700     05 LK-CU-CURSO         PIC X(05).                            02070026
020800     05 LK-CU-DESCRIPCION   PIC X(25).                            02080026
020900     05 LK-CU-DNIPROFESOR   PIC X(9).                             02090026
021000     05 LK-CU-ESTADO        PIC X.                                02100026
021100     05 LK-CU-COD-RET       PIC 9(02).                            02110026
021200     05 LK-CU-SQLCODE       PIC S9(9).                            02120026
021300     05 FILLER              PIC X(86).                            02130026
021400**********************************************                    02140026
021500*    AREA LINK PARA ENCAPSULADOR DE USUARIOS *                    02150026
021600**********************************************                    02160026
021700 01  AREA-LINK-USUARIO  REDEFINES AREA-LINK.                      02170026
021800     05 LK-TIPO-OPE     PIC 9(01).                                02180026
021900     05 LK-SUBTIPO-OPE  PIC 9(02).                                02190026
022000     05 LK-US-DNI       PIC X(09).                                02200026
022100     05 LK-US-TIPOUSUA  PIC X(05).                                02210026
022200     05 LK-US-CLAVE     PIC X(08).                                02220026
022300     05 LK-US-NOMBRE    PIC X(20).                                02230026
022400     05 LK-US-APELLIDOS PIC X(20).                                02240026
022500     05 LK-US-DIRECCION PIC X(35).                                02250026
022600     05 LK-US-CARGO     PIC X(20).                                02260026
022700     05 LK-US-ESTADO    PIC X(01).                                02270026
022800     05 LK-US-COD-RET   PIC 99.                                   02280026
022900     05 LK-US-SQLCODE   PIC S9(9).                                02290026
023000*********************** FINAL AREAS DE ENCAPSULADORES             02300026
023100 01 MENSAJES.                                                     02310026
023200    03 MSG-FIN-SESION PIC X(18) VALUE "AU REVOIR MON AMI!".       02320026
023300     03 MSG    PIC X(50) VALUE SPACES.                            02330026
023400 LINKAGE SECTION.                                                 02340026
023500 01 DFHCOMMAREA PIC X(100).                                       02350026
023600                                                                  02360026
023700 PROCEDURE DIVISION.                                              02370026
023800 0000-MAIN.                                                       02380026
023900     PERFORM 1000-INICIO-DE-PROGRAMA                              02390026
024000     PERFORM 2000-MANEJO-DE-CICLOS-DE-CICS                        02400026
024100     PERFORM 9999-FIN-DE-PROGRAMA                                 02410026
024200     .                                                            02420026
024300 1000-INICIO-DE-PROGRAMA.                                         02430026
024400     PERFORM 3500-GENERA-NOTAS-DE-PRUEBA                          02440026
024500     .                                                            02450026
024600 2000-MANEJO-DE-CICLOS-DE-CICS.                                   02460026
024700     IF EIBCALEN = 0 THEN                                         02470026
024800        PERFORM 3100-CARGA-DATOS-PARA-MAPA                        02480026
024900        PERFORM 7000-ENVIO-MAPA                                   02490026
025000        PERFORM 7800-RETORNO-TRANSACCION                          02500026
025100     ELSE                                                         02510026
025200        MOVE DFHCOMMAREA TO MI-COMMAREA                           02520026
025300        PERFORM 7100-RECIBO-DE-MAPA                               02530026
025400     END-IF                                                       02540026
025500     .                                                            02550026
025600 3000-6999-TODOS-PARRAFOS-PROGR.                                  02560026
025700     CONTINUE                                                     02570026
025800     .                                                            02580026
025900 3100-CARGA-DATOS-PARA-MAPA.                                      02590026
026000*    PERFORM 3100-GET-DATES                                       02600026
026100     MOVE WS-FECHA-AAAA-MM-DD    TO MFECHAO                       02610026
026200*    MOVE "-> 3100-CARGA-DATOS-MAPA--" TO W-PARRAFO               02620026
026300*    MOVE "EIBCALEN" TO W-CAMPO                                   02630026
026400*    MOVE EIBCALEN TO W-VALOR                                     02640026
026500*    PERFORM 9100-DEB-DIS                                         02650026
026600     .                                                            02660026
026700* COPY RUTINA FORMATO DE FECHAS                                   02670026
026800* COPY UGETDATE.                                                  02680026
026900 3100-GET-DATES.                                                  02690026
027000     MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DATE-FIELDS         02700026
027100     MOVE WS-CURRENT-YEAR       TO WS-AAAA                        02710026
027200     MOVE WS-CURRENT-MONTH      TO WS-MM                          02720026
027300     MOVE WS-CURRENT-DAY        TO WS-DD                          02730026
027400     MOVE WS-CURRENT-YEAR       TO WS-AAAA-F2                     02740026
027500     MOVE WS-CURRENT-DAY        TO WS-DD-F2                       02750026
027600     SET IX-MES TO WS-CURRENT-MONTH                               02760026
027700     MOVE WS-NOM-MES (IX-MES) TO WS-MM-F2                         02770026
027800     MOVE WS-CURRENT-HH         TO WS-HH-F1                       02780026
027900     MOVE WS-CURRENT-MM         TO WS-MM-F1                       02790026
028000     MOVE WS-CURRENT-SS         TO WS-SS-F1                       02800026
028100     MOVE WS-CURRENT-CC         TO WS-CC-F1                       02810026
028200     .                                                            02820026
028300                                                                  02830026
028400 3200-CONSULTA-NOTAS.                                             02840026
028500                                                                  02850026
028600     PERFORM 3100-GET-DATES                                       02860026
028700     MOVE WS-FECHA-AAAA-MM-DD    TO MFECHAO                       02870026
028800**************************************************************    02880026
028900*    CONSULTA EL ESTUDIANTE Y RECUPERA EL NOMBRE Y APELLIDOS *    02890026
029000**************************************************************    02900026
029100     MOVE "**NO REGISTRADO **" TO MNOMESO MAPEESO                 02910026
029200     MOVE MDNIESI TO LK-US-DNI                                    02920026
029300     MOVE 1 TO LK-US-COD-RET MOVE 100 TO LK-US-SQLCODE            02930026
029400     MOVE "ESTUD" TO LK-US-TIPOUSUA                               02940026
029500     PERFORM 4200-BUSCAR-USUARIO                                  02950026
029600     IF LK-US-COD-RET = 0 THEN                                    02960026
029700          MOVE LK-US-NOMBRE TO MNOMESO                            02970026
029800          MOVE LK-US-APELLIDOS TO MAPEESO                         02980026
029900          MOVE "S" TO W-DNI-HALLADO                               02990026
030000     ELSE                                                         03000026
030100          MOVE "N" TO W-DNI-HALLADO                               03010026
030200     END-IF                                                       03020026
030300************************************************************      03030026
030400*    FIN DE BUSQUEDA DE ESTUDIANTE                         *      03040026
030500************************************************************      03050026
030600                                                                  03060026
030700************************************************************      03070026
030800*    INICIO BUSQUEDA DE NOTAS POR ESTUDIANTE               *      03080026
030900*    PRIMERO CONSULTA EL NUMERO DE NOTAS QUE EL ESTUDIANTE *      03090026
031000*    TIENE REGISTRADAS. SI TIENE NOTAS, LUEGO PIDE LOS DE  *      03100026
031100*    DETALLES DE CADA CURSO, CODIGO, NOMBRE, A�O Y NOTA OB-*      03110026
031200*    TENIDA PARA SU DESPLIEGUE EN EL MAPA EN LA SECCION    *      03120026
031300*    LLAMADA VISOR                                         *      03130026
031400*    ENV�A TIPO DE OPERACI�N 1 Y SUBTIPO 4                        03140026
031500*       SI NO CONSIGUE NOTAS                                      03150026
031600*             RET 100 EN SQLCODE Y 0 EN CONTADOR                  03160026
031700*       DE LO CONTRARIO. SI CONSIGUES ALGO, EL CAMPO SQLCODE      03170026
031800*             RETORNA 0 EN SQLCODE                                03180026
031900*             RETORNA NUMERO DE NOTAS DEL DNI EN CONTADOR         03190026
032000*    FIN                                                          03200026
032100*    ENVIA TIPO DE OPERACI�N 1, SUBTIPO 1, DNI, CONTADOR          03210026
032200*    EN ESTE CASO CONTADOR ES EL ORDINAL DE LA NOTA REQUERIDA     03220026
032300*    CON UN VALOR DE CONTADOR ENTRE 1 Y EL VALOR DE CONTADOR      03230026
032400*    RETORNADO EN CONSULTA CON OPERACION1 Y SUBTIPO 4             03240026
032500*                                                                 03250026
032600*    RECIBIRA EL DNI, EL CURSO, EL A�O, LA NOTA Y SQLCODE EN 0    03260026
032700*                                                                 03270026
032800************************************************************      03280026
032900     MOVE 1 TO LK-NT-TIPO-OPE                                     03290026
033000     MOVE 4 TO LK-NT-SUBTIPO                                      03300026
033100     MOVE MDNIESI TO LK-NT-DNIESTUD                               03310026
033200     MOVE "N" TO W-DNI-HALLADO                                    03320026
033300     MOVE 100 TO LK-NT-SQLCODE                                    03330026
033400     MOVE 0 TO LK-NT-CONTADOR                                     03340026
033500     PERFORM 4000-BUSCAR-NRO-NOTAS-DNI                            03350026
033600     IF   LK-NT-SQLCODE = 0 THEN                                  03360026
033700          MOVE "S" TO W-DNI-HALLADO                               03370026
033800     ELSE                                                         03380026
033900          MOVE "N" TO W-DNI-HALLADO                               03390026
034000     END-IF                                                       03400026
034100***********************************************************       03410026
034200*    SI RETORNA UN NUMERO DE NOTAS > 0                    *       03420026
034300*    LAS SOLICITA 1 A 1 PARA CARGAR LA LISTA DE NOTAS DEL *       03430026
034400*    Y COMENZAR SU VISUALIZACION DE W-M EN W-M GRUPOS     *       03440026
034500*    SEGUN EL TAMA�O DEL VISOR                            *       03450026
034600***********************************************************       03460026
034700                                                                  03470026
034800     MOVE 1 TO W-IND-VISOR                                        03480026
034900     PERFORM 3650-BORRAR-VISOR                                    03490026
035000             UNTIL W-IND-VISOR > W-M                              03500026
035100     IF LK-NT-CONTADOR = 0 THEN                                   03510026
035200        MOVE "ESTUDIANTE SIN NOTAS REGISTRADAS" TO MTXMSGO        03520026
035300        PERFORM 7000-ENVIO-MAPA                                   03530026
035400        PERFORM 7800-RETORNO-TRANSACCION                          03540026
035500     END-IF                                                       03550026
035600     MOVE LK-NT-CONTADOR TO WS-NUNOTAS                            03560026
035700     PERFORM 3700-PEDIR-NOTAS TEST AFTER                          03570026
035800        VARYING IX-NOTA FROM 1 BY 1                               03580026
035900        UNTIL IX-NOTA > WS-NUNOTAS                                03590026
036000*    END-PERFORM                                                  03600026
036100     MOVE 1 TO W-IND-FROM                                         03610026
036200     MOVE WS-NUNOTAS TO W-IND-TO                                  03620026
036300     IF W-IND-TO NOT > W-IND-FROM + W-M                           03630026
036400        AND W-DNI-HALLADO = "S" THEN                              03640026
036500            MOVE 1 TO W-IND-VISOR                                 03650026
036600            MOVE W-IND-FROM TO W-IND-LISTA                        03660026
036700            PERFORM 3600-MUEVE-LISTA-A-VISOR                      03670026
036800                 UNTIL W-IND-LISTA > W-IND-TO                     03680026
036900     END-IF                                                       03690026
037000     PERFORM 7000-ENVIO-MAPA                                      03700026
037100     PERFORM 7800-RETORNO-TRANSACCION                             03710026
037200     .                                                            03720026
037300 3300-HACIA-ADELANTE.                                             03730026
037400                                                                  03740026
037500     MOVE "--3300-HACIA-ADELANTE--" TO W-PARRAFO                  03750026
037600     MOVE "EIBCALEN" TO W-CAMPO                                   03760026
037700     MOVE EIBCALEN TO W-VALOR                                     03770026
037800     PERFORM 9100-DEB-DIS                                         03780026
037900     .                                                            03790026
038000 3400-HACIA-ATRAS.                                                03800026
038100                                                                  03810026
038200     MOVE "--3400-HACIA-ATRAS--" TO W-PARRAFO                     03820026
038300     MOVE "EIBCALEN" TO W-CAMPO                                   03830026
038400     MOVE EIBCALEN TO W-VALOR                                     03840026
038500     PERFORM 9100-DEB-DIS                                         03850026
038600     .                                                            03860026
038700 3500-GENERA-NOTAS-DE-PRUEBA.                                     03870026
038800     MOVE "-> 3500-GENERA-DATOS--" TO W-PARRAFO                   03880026
038900     MOVE "EIBCALEN" TO W-CAMPO                                   03890026
039000     MOVE EIBCALEN TO W-VALOR                                     03900026
039100     PERFORM 9100-DEB-DIS                                         03910026
039200     SET IX-DNI TO 1    MOVE "9533075  " TO DNI-ESTUD (IX-DNI)    03920026
039300     MOVE "FLAVIO NESTOR" TO DNI-NOMEST (IX-DNI)                  03930026
039400     MOVE "PATINO CORREA" TO DNI-APEEST (IX-DNI)                  03940026
039500     MOVE 1 TO DNI-FROM (IX-DNI) MOVE 4 TO DNI-TO (IX-DNI)        03950026
039600     SET IX-DNI UP BY 1 MOVE "52438489 " TO DNI-ESTUD (IX-DNI)    03960026
039700     MOVE "DORY CONSTANZA" TO DNI-NOMEST (IX-DNI)                 03970026
039800     MOVE "SANCHEZ ARAGON" TO DNI-APEEST (IX-DNI)                 03980026
039900     MOVE 5 TO DNI-FROM (IX-DNI) MOVE 9 TO DNI-TO (IX-DNI)        03990026
040000     SET IX-DNI UP BY 1 MOVE "52056163 " TO DNI-ESTUD (IX-DNI)    04000026
040100     MOVE "LUZ MERY" TO DNI-NOMEST (IX-DNI)                       04010026
040200     MOVE "ALARCON MEJIA" TO DNI-APEEST (IX-DNI)                  04020026
040300     MOVE 10 TO DNI-FROM (IX-DNI) MOVE 12 TO DNI-TO (IX-DNI)      04030026
040400     SET IX-DNI UP BY 1 MOVE "52057782 " TO DNI-ESTUD (IX-DNI)    04040026
040500     MOVE "MONICA LILIANA" TO DNI-NOMEST (IX-DNI)                 04050026
040600     MOVE "RODRIGUEZ RODRIGUEZ" TO DNI-APEEST (IX-DNI)            04060026
040700     MOVE 13 TO DNI-FROM (IX-DNI) MOVE 13 TO DNI-TO (IX-DNI)      04070026
040800     SET IX-DNI UP BY 1 MOVE "52263924 " TO DNI-ESTUD (IX-DNI)    04080026
040900     MOVE "ROSA CANDIDA" TO DNI-NOMEST (IX-DNI)                   04090026
041000     MOVE "OJEDA" TO DNI-APEEST (IX-DNI)                          04100026
041100     MOVE 14 TO DNI-FROM (IX-DNI) MOVE 17 TO DNI-TO (IX-DNI)      04110026
041200     SET IX-DNI UP BY 1 MOVE "52825799 " TO DNI-ESTUD (IX-DNI)    04120026
041300     MOVE "MAGDA MILENA" TO DNI-NOMEST (IX-DNI)                   04130026
041400     MOVE "RODRIGUEZ" TO DNI-APEEST (IX-DNI)                      04140026
041500     MOVE 18 TO DNI-FROM (IX-DNI) MOVE 18 TO DNI-TO (IX-DNI)      04150026
041600     .                                                            04160026
041700 3600-MUEVE-LISTA-A-VISOR.                                        04170026
041800     MOVE CURSO (W-IND-LISTA) TO MCODIGO (W-IND-VISOR)            04180026
041900     MOVE CURSO (W-IND-LISTA) TO LK-CU-CURSO                      04190026
042000     PERFORM 4100-BUSCAR-CURSO                                    04200026
042100     IF LK-CU-SQLCODE = 0 THEN                                    04210026
042200        MOVE LK-CU-DESCRIPCION TO MDESCUR(W-IND-VISOR)            04220026
042300     ELSE                                                         04230026
042400        MOVE "**SIN DESCRIPCION**" TO MDESCUR (W-IND-VISOR)       04240026
042500     END-IF                                                       04250026
042600     MOVE AAAA  (W-IND-LISTA) TO MAAACUR (W-IND-VISOR)            04260026
042700     MOVE NOTA  (W-IND-LISTA) TO W-EDI-NOTA                       04270028
042800     MOVE W-EDI-NOTA-R TO MNOTCUR (W-IND-VISOR)                   04280028
042900     ADD 1 TO W-IND-VISOR  W-IND-LISTA                            04290026
043000     .                                                            04300026
043100 3650-BORRAR-VISOR.                                               04310026
043200     MOVE SPACES TO MCODIGO (W-IND-VISOR)                         04320026
043300     MOVE SPACES TO MDESCUR (W-IND-VISOR)                         04330026
043400     MOVE SPACES TO MAAACUR (W-IND-VISOR)                         04340026
043500     MOVE SPACES TO MNOTCUR (W-IND-VISOR)                         04350026
043600     ADD 1 TO W-IND-VISOR                                         04360026
043700     .                                                            04370026
043800 3700-PEDIR-NOTAS.                                                04380026
043900     MOVE MDNIESI TO LK-NT-DNIESTUD                               04390027
044000     MOVE 1 TO LK-NT-TIPO-OPE                                     04400026
044100     MOVE 4 TO LK-NT-SUBTIPO                                      04410026
044200     PERFORM 4000-BUSCAR-NRO-NOTAS-DNI                            04420026
044300     IF LK-NT-SQLCODE = 0 THEN                                    04430026
044400        SET IX-NOTA UP BY 1                                       04440026
044500        MOVE LK-NT-CURSO TO CURSO(IX-NOTA)                        04450026
044600        MOVE LK-NT-AAAA    TO AAAA(IX-NOTA)                       04460027
044700        MOVE LK-NT-NOTA    TO W-EDI-NOTA                          04470027
044800        MOVE W-EDI-NOTA-N  TO NOTA(IX-NOTA)                       04480026
044900     END-IF                                                       04490026
045000     .                                                            04500026
045100 4000-BUSCAR-NRO-NOTAS-DNI.                                       04510026
045200                                                                  04520026
045300      EXEC CICS LINK PROGRAM('PSNETS53')                          04530026
045400           COMMAREA(AREA-LINK)                                    04540026
045500           LENGTH(LENGTH OF AREA-LINK)                            04550026
045600      END-EXEC                                                    04560026
045700      .                                                           04570026
045800 4100-BUSCAR-CURSO.                                               04580026
045900                                                                  04590026
046000      EXEC CICS LINK PROGRAM('PSNETS63')                          04600026
046100           COMMAREA(AREA-LINK-CUR)                                04610026
046200           LENGTH(LENGTH OF AREA-LINK-CUR)                        04620026
046300      END-EXEC                                                    04630026
046400      .                                                           04640026
046500 4200-BUSCAR-USUARIO.                                             04650026
046600                                                                  04660026
046700      EXEC CICS LINK PROGRAM('PSNETS73')                          04670026
046800           COMMAREA(AREA-LINK-USUARIO)                            04680026
046900           LENGTH(LENGTH OF AREA-LINK-USUARIO)                    04690026
047000      END-EXEC                                                    04700026
047100      .                                                           04710026
047200 7000-ENVIO-MAPA.                                                 04720026
047300     MOVE EIBTRMID TO CA-TERM                                     04730026
047400     MOVE EIBTRNID TO CA-TRANS                                    04740026
047500     EXEC CICS SEND                                               04750026
047600             MAP('MSNNE03')                                       04760026
047700          MAPSET('MSNNE03')                                       04770026
047800           FROM(MSNNE03O)                                         04780026
047900          NOHANDLE                                                04790026
048000     END-EXEC                                                     04800026
048100*    MOVE "-> 7000-ENVIO-MAPA--" TO W-PARRAFO                     04810026
048200*    MOVE "EIBTRNID" TO W-CAMPO                                   04820026
048300*    MOVE EIBTRNID TO W-VALOR                                     04830026
048400*    PERFORM 9100-DEB-DIS                                         04840026
048500     .                                                            04850026
048600 7100-RECIBO-DE-MAPA.                                             04860026
048700     EXEC CICS RECEIVE                                            04870026
048800          MAP('MSNNE03')                                          04880026
048900          MAPSET('MSNNE03')                                       04890026
049000          INTO (MSNNE03I)                                         04900026
049100          NOHANDLE                                                04910026
049200     END-EXEC                                                     04920026
049300     EXEC CICS                                                    04930026
049400          IGNORE CONDITION MAPFAIL                                04940026
049500     END-EXEC                                                     04950026
049600                                                                  04960026
049700*    MOVE "-> 7100-RECIBO-DE-MAPA--" TO W-PARRAFO                 04970026
049800*    MOVE "EIBCALEN" TO W-CAMPO                                   04980026
049900*    MOVE EIBCALEN TO W-VALOR                                     04990026
050000*    MOVE "MDNIESI" TO W-CAMPO1                                   05000026
050100*    MOVE MDNIESI TO W-VALOR1                                     05010026
050200*    PERFORM 9100-DEB-DIS                                         05020026
050300                                                                  05030026
050400*    MOVE "EIBAID" TO W-CAMPO                                     05040026
050500*    MOVE EIBAID TO W-VALOR                                       05050026
050600*    PERFORM 9100-DEB-DIS                                         05060026
050700                                                                  05070026
050800     EVALUATE EIBAID                                              05080026
050900          WHEN DFHENTER                                           05090026
051000               PERFORM 3200-CONSULTA-NOTAS                        05100026
051100          WHEN DFHPF3                                             05110026
051200               PERFORM 9999-FIN-DE-PROGRAMA                       05120026
051300          WHEN DFHPF7                                             05130026
051400               PERFORM 3400-HACIA-ATRAS                           05140026
051500          WHEN DFHPF8                                             05150026
051600               PERFORM 3300-HACIA-ADELANTE                        05160026
051700          WHEN OTHER                                              05170026
051800               MOVE "-TECLA NO HABILITADA-" TO MSG                05180026
051900               PERFORM 7200-MENSAJES-A-LA-PANTALLA                05190026
052000     END-EVALUATE                                                 05200026
052100     .                                                            05210026
052200 7200-MENSAJES-A-LA-PANTALLA.                                     05220026
052300     DISPLAY MSG                                                  05230026
052400     .                                                            05240026
052500 7800-RETORNO-TRANSACCION.                                        05250026
052600     MOVE "-> 7800-RETORNO-TRANS--" TO W-PARRAFO                  05260026
052700     MOVE "EIBTRNID" TO W-CAMPO                                   05270026
052800     MOVE EIBTRNID TO W-VALOR                                     05280026
052900     MOVE "EIBCALEN" TO W-CAMPO1                                  05290026
053000     MOVE EIBCALEN TO W-VALOR1                                    05300026
053100     PERFORM 9100-DEB-DIS                                         05310026
053200     MOVE EIBTRMID TO CA-TERM                                     05320026
053300     MOVE EIBTRNID TO CA-TRANS                                    05330026
053400                                                                  05340026
053500     EXEC CICS                                                    05350026
053600          RETURN                                                  05360026
053700          TRANSID(EIBTRNID)                                       05370026
053800          COMMAREA(MI-COMMAREA)                                   05380026
053900          LENGTH(LENGTH OF MI-COMMAREA)                           05390026
054000     END-EXEC                                                     05400026
054100     .                                                            05410026
054200                                                                  05450026
054600* COPY PDEBDIS.                                                   05460026
054700 9100-DEB-DIS.                                                    05470026
054800      PERFORM 3100-GET-DATES                                      05480026
054900      MOVE WS-FECHA-AAAA-MM-DD TO W-FECHA-DIS                     05490026
055000      MOVE WS-HORA-MINUTOS-SEGUNDOS TO W-TIME-DIS                 05500026
055100      IF W-SW-DEBUG = "S" THEN                                    05510026
055200         DISPLAY WS-DEBDIS-MSG                                    05520026
055300      END-IF                                                      05530026
055400                                                                  05540026
055500      .                                                           05550026
055600                                                                  05560026
055700 9999-FIN-DE-PROGRAMA.                                            05570026
055800     EXEC CICS                                                    05580026
055900          SEND TEXT FROM (MSG-FIN-SESION)                         05590026
056000               ERASE FREEKB                                       05600026
056100     END-EXEC                                                     05610026
056200     EXEC CICS RETURN                                             05620026
056300     END-EXEC                                                     05630026
056400     GOBACK                                                       05640026
056500     .                                                            05650026
