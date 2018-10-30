function [LL,ALF,NODE_CONNECT,ARZ1,ARZ4,AREAZ1,AREAZ4,CMK1,CMK4,h,RESIST,COMPLIANCE]=LaNrCrC(NVESSEL,Pout,nonconstant)
%**************
% MIT License
% 
% Copyright (c) 2018 <Yashar Seyed Vahedein, Alexander Liberson>
% 
% Permission is hereby granted, free of charge, to any person obtaining a
% copy of this software and associated documentation files (the
% "Software"), to deal in the Software without restriction, including
% without limitation the rights to use, copy, modify, merge, publish,
% distribute, sublicense, and/or sell copies of the Software, and to permit
% persons to whom the Software is furnished to do so, subject to the
% following conditions:
% 
% The above copyright notice and this permission notice shall be included
% in all copies or substantial portions of the Software.
%
% The user is recommended to reference the first released publication based on this code:
% 
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
% NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
% DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
% OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
% USE OR OTHER DEALINGS IN THE SOFTWARE.
%**************
if NVESSEL==26
    %% 26
    %Vessel lengths
    LL(1:NVESSEL)=[19.4 20.6 20.0 5.8 5.7 8.5 4.8 15.2 20.6 19.4 20.0 19.7 ...
                   20.3 20.0 20.0 11.0 29.0 24.1 15.9 15.6 20.0 22.0 20.0 ...
                   12.3 20.0 13.1]*1.e-3;  %m
    
    %Vessel angles of orientations with respect to coordinate system
    ALF(1:NVESSEL)=[180 165 135 115 100 90 80 60 30 0 0 -5 -5 ...
        -10 -10 -10 -12 -12 -10 -10 -135 -150 ...
        180 180 180 -155]*pi/180; %radian
    
    %NODE_CONNECT(inode=1:NNODE,ivup,ivdn1,ivdn2)
    NODE_CONNECT=[1 0 1 0;      2 1 2 0;      3 2 3 0; ...
        4 3 4 0;      5 4 5 21;     6 5 6 23; ...
        7 6 7 0;      8 7 8 25;     9 8 9 0; ...
        10 9 10 0;     11 10 11 0;   12 11 12 0; ...
        13 12 13 0;   14 13 14 0;   15 14 15 0; ...
        16 15 16 0;   17 16 17 0;   18 17 18 0; ...
        19 18 19 0;   20 19 20 0;   21 20 0 0; ... %%--%%fix
        22 21 22 0;   23 22 0 0;    24 23 24 0; ...
        25 24 0 0;    26 25 26 0;   27 26 0 0];
    'size(NODE_CONNECT) from INPUT','size(NODE_CONNECT)'
    
    % Radii, Area, CMK, Thickness
    %=========================================================
    %Internal radii
    ARZ1=[12.4 13.2 13.2 12.8 12.3 11.8 11.1 10.9 10.7 10.6 ...
        10.0 9.3  9.1  8.8  8.6  8.5  8.3  7.8  7.5  7.5  ...
        7.0  4.5  5.1  3.1  5.3  3.5].*1.e-3;  %m
    ARZ4=[13.2 13.2 12.8 12.3 11.8 11.1 10.9 10.7 10.6 10.0...
        9.3  9.1  8.8  8.6  8.5  8.3  7.8  7.5  7.5  7.5 ...
        4.5  4.3  3.1  2.9  3.5  3.4].*1e-3;  %m was 13
    
    %Cross sectional area at each segment
    AREAZ1=pi*ARZ1.^2;%m^2
    AREAZ4=pi*ARZ4.^2;%m^2
    
    %Speed of Propagation based on MOENS-KORTEWEG,
    %in terms of Alastruey,Figueroa CMK=sqrt(3/4)*C
    
    if nonconstant==1
        CMK1=[4.56 4.42 4.42 4.49 4.56 4.66 4.81 4.86 4.91 4.93 ...
            5.08 5.27 5.31 5.41 5.46 5.50 5.57 5.76 5.87 5.85 ...
            6.06 7.54 7.10 9.18 6.97 8.64];  %m/s
        
        CMK4=[4.42 4.42 4.49 4.56 4.66 4.81 4.86 4.91 4.93 5.08...
            5.27 5.31 5.41 5.46 5.50 5.57 5.76 5.87 5.85 5.84...
            7.54 7.77 9.18 9.43 8.64 8.67];  %m/s
    else
        CMK1=repmat(4.56,1,26)/1.045;  %m/s
        CMK4=repmat(4.56,1,26)/1.045;  %m/s
    end
    %Thickness of the Vessel Wall
    h=[0.51].*1e-3;
    
    
    %================================================================
    % Terminal Resistance and Compliance Arrays at Exit Vessels
    %================================================================
    RESIST=[0.02644628/(69.1/100) 0.02644628/(19.3/100) 0.02644628/(5.2/100) 0.02644628/(6.4/100)].*1e9;   % Pa s/m^3
    
    % COMPLIANCE=[1.32]/(133.3*(1.e8)); %m^3/Pa see last lines of code
    if Pout~=4400
        COMPLIANCE=12.1*(1e-9);   % ALASTRUEY 2016 - if Pout=9.3 kPa
    elseif Pout==4400
        COMPLIANCE=10.3*(1e-9); % ALASTRUEY 2016 - if Pout=4.4 kPa
    end
    %In case of ALASTRUEY 2016 CP and CC calculated below
    
    
    
    
    
elseif NVESSEL==55
    %% 55
    %VEssels' lengths, angles of orientations with respect to X
    LL(1:NVESSEL)=[58	23	39	39	108 171 485 270 77  91	...
        197	205	187	45	160	205	187	60	39	170 ...
        485	270	77	91	197	92	120	61	23	23  ...
        76	82	72	68	23	37	23	37	122	58  ...
        23	68	68	166	58	509	145	369	398	166 ...
        58	509	145	369	398]*1.e-3;  %m
    
    ALF(1:NVESSEL)=[180 135 -135 -130 180 ...
        180 -20 -20 0 -15 ...
        -10 -175 -170 60 170 ...
        -175 170 -5 150 175 ...
        30 30 10 20 15 ...
        60 0 0 -85 -90 ...
        -35 -100 -80 90 -5 ...
        45 -5 -90 0 80 ...
        0 25 -35 15 0 ...
        -1.5 +5 -5 2.5 -20 ...
        0 1.5 -5 5 0]*pi/180; %radian
    
    %NODE_CONNECT(inode=1:NNODE,ivup,ivdn1,ivdn2)
    NODE_CONNECT=[1 0 1 0;      2 1 2 3;      3 2 14 15; ...
        4 3 5 4;      5 4 6 7;      6 7 8 9; ...
        7 8 0 0;      8 14 18 19;   9 19 21 20; ...
        10 21 23 22;  11 22 0 0;    12 18 27 26; ...
        13 27 29 28;  14 28 35 34;  15 34 0 0; ...
        16 35 38 37;  17 37 39 36;  18 39 41 40; ...
        19 41 43 42;  20 42 45 44;  21 43 50 51; ... %%--%%fix
        22 50 53 52;  23 52 55 54;  24 54 0 0; ...
        25 44 46 47;  26 46 48 49;  27 48 0 0; ...
        28 45 0 0;    29 47 0 0;    30 49 0 0; ...
        31 51 0 0;    32 53 0 0;    33 55 0 0; ...
        34 26 0 0;    35 29 30 31;  36 30 32 33; ...
        37 32 0 0;    38 33 0 0;    39 31 0 0; ...
        40 38 0 0;    41 36 0 0;    42 40 0 0; ...
        43 20 0 0;    44 23 25 24;  45 24 0 0; ...
        46 25 0 0;    47 5 12 13;   48 12 0 0; ...
        49 13 0 0;    50 6 0 0;     51 9 10 11; ... %fix
        52 10 0 0;    53 11 0 0;    54 15 17 16; ...
        55 16 0 0;    56 17 0 0];
    'size(NODE_CONNECT) from INPUT',size(NODE_CONNECT)
    
    % Radii, Area, CMK, Thickness
    %=========================================================
    %Internal radii, Moens-Korteweg, Rho
    ARZ1=[15.4	13.2	10.6	6.0     5.7 	1.9 	4.2     1.9     1.9     1.1  ...
        1.6   2.9     1.3     11.2    5.1     2.2     1.0     10.4    5.7     1.9  ...
        4.2   1.8     2.2     0.9     2.1     6.6     8.6     6.3	    4.1     2.7  ...
        2.8   1.6     2.2     4.1     6.0     2.7     6.1     2.7     6.0     2.4  ...
        5.6   4.1     4.1     3.3     2.1     2.7     2.1     1.6     1.3     3.3  ...
        2.1   2.7     2.1     1.6     1.3]*1.e-3;  %m
    
    ARZ4=[15.4  12.6    9.4     4.7     2.9     1.4     2.4     1.6     1.7     0.9  ...
        1.4   2.2     0.8     10.9    2.5     1.7     0.6     9.9     4.4     1.4  ...
        2.4   1.4     2.2     0.9     1.9     4.9     6.7     6.3     3.6     2.5  ...
        2.3   1.5     2.0     3.7     5.9     2.7     6.1     2.7     5.7     1.6  ...
        5.4   3.6     3.6     3.1     2.1     1.9     1.9     1.4     1.1     3.1  ...
        2.1   1.9     1.9     1.4     1.1]*1.e-3;  %m
    
    %     ARZ2=ARZ1;
    %     ARZ4=ARZ3;
    
    AREAZ1=pi*ARZ1.^2;%m^2
    %     AREAZ2=pi*ARZ2.^2;%m^2
    %     AREAZ3=pi*ARZ3.^2;%m^2
    AREAZ4=pi*ARZ4.^2;%m^2
    
    
    
    CMK1=[4.0   4.2     4.5     5.3     5.3     8.1     6.4     8.0     8.0 ...
        9.5   8.4     7.1     9.1     4.4     5.5     7.7     9.8     4.5 ...
        5.3   8.1     6.4     8.2     7.7     10.0    7.8     5.1     4.7	...
        5.2   5.9     6.7     7.2     8.4     7.7     5.9     5.3     6.7 ...
        5.2   6.7     5.3     7.5     5.4     5.9     5.9     6.3     7.9 ...
        7.3   7.9     8.4     8.9     6.3     7.9     7.3     7.9     8.4 ...
        8.9];
    
    CMK4=[4.0   4.2     4.6     5.7     6.5     8.7     7.5     8.4     8.2 ...
        10.0  8.7     7.7     10.4    4.4     6.8     8.2     11.1    4.6 ...
        5.8   8.7     7.5     8.7     7.7     10.0    8.0     5.6     5.1 ...
        5.2   6.1     6.8     7.6     8.5     7.9     6.1     5.3     6.7 ...
        5.2   6.7     5.3     8.4     5.4     6.1     6.1     6.3     7.9 ...
        7.9   8.0     8.6     9.1     6.3     7.9     7.9     8.0     8.6 ...
        9.1];
    
    %     CMK2=CMK1;
    %     CMK4=CMK3;
    
    %================================================================
    % Terminal Resistance and Compliance Arrays at Exit Vessels
    %================================================================
    RESIST=    [29.7  29.7  5.2   26.8  26.8  44.7  26.8  31.4  44.7  26.8  31.4...
        45    30.4  13.1  20.4  6.4   6.4   38.7  33.8  474.2 29.7  14.1...
        78.2  33.8  474.2 29.7  14.1  78.2]*(133.3*1.e6);   % Pa s/m^3    %resistance of exist vessels, Rt=-W2/W1,
    COMPLIANCE=[1.32  1.13  6.41  0.99  0.99  1.82  1.69  0.68  1.82  1.69  0.68...
        13.9  1.09  1.87  2.73  3.08  3.08  1.78  1.2   0.37  1.73  3.45...
        2.57  1.2   0.43  1.03  2.52  2.31]/(133.3*(1.e8)); %m^3/Pa
    
    h=[0.51].*1e-3;
    
    
    
elseif NVESSEL==37
    %% 37
    %VEssels' lengths, angles of orientations with respect to X
    LL(1:NVESSEL)=[36	28	145	218	165	235	177	21	178	29	...
                   227	175	245	191	56	195	72	38	13	191	...
                   198	186	62	120	7	118	104	205	216	206	...
                   201  195	207	163	151	149	126]*1.e-3;  %m
    
    ALF(1:NVESSEL)=[0 -90 -110 -70 -70 ...
        -80 -70 0 70 0 ...
        45 45 55 45 0 ...
        45 0 -90 -90 -115 ...
        -75 -50 0 70 -2 ...
        -65 0 -5 -5 -7.5 ...
        2.5 5 5 -15 -2.5 ...
        2.5 20]*pi/180; %radian
    
    %NODE_CONNECT(inode=1:NNODE,ivup,ivdn1,ivdn2)
    NODE_CONNECT=[1 0 1 0;  2 1 2 8;  3 2 3 4; ...
        4 8 10 9;  5 10 15 11;  6 11 12 0; ...
        7 12 14 13;  8 4 5 0;  9 5 6 7; ...
        10 15 17 16;  11 17 18 23;  12 18 19 22; ...
        13 19 20 21;  14 23 26 25;  15 25 27 24; ...
        16 27 28 31;  17 31 32 0;  18 28 29 30; ...
        19 32 33 0;  20 29 30 0;  21 33 36 37; ... %%--%%fix
        22 30 34 35;  23 37 0 0;  24 36 0 0; ...
        25 35 0 0;  26 34 0 0;  27 24 0 0; ...
        28 26 0 0;  29 22 0 0;  30 21 0 0; ...
        31 20 0 0;  32 16 0 0;  33 13 0 0; ...
        34 14 0 0;  35 9 0 0;  36 3 0 0; ...
        37 7 0 0;  38 6 0 0];
    'size(NODE_CONNECT) from INPUT',size(NODE_CONNECT)
    % Radii, Area, CMK, Thickness
    %=========================================================
    %Internal radii, Moens-Korteweg, Rho
    ARZ1=[14.4	11    5.37  4.36  3.34  2.07  2.1  13    5.58  12.5 ...
          4.42	3.39  2.07	2.07  11.8	4.12  11   3.97  4.31  1.83  ...
          1.92	3.31  9.26  2.59  7.9   2.55  7.8  3.9	3.38  2.31  ...
          4.02	3.34  2.26	1.55  1.53  1.58  1.55]*1.e-3;  %m
      
    ARZ4=[13    7.29  3.86  3.34  2.78  2.07  2.1  12.5  3.73  11.8  ...
          3.39  2.84  2.07  2.07  11    3.22  9.26  3.97 4.31  1.83  ...
          1.92  2.89  8.01  2.59  7.9   2.55  5.88  3.38  2.31  2.1 ...
          3.34  2.26  2.12  1.55  1.53  1.58  1.55]*1e-3;  %m
    % ARZ2=ARZ1;
    % ARZ4=ARZ3;
    
    AREAZ1=pi*ARZ1.^2;%m^2
    % AREAZ2=pi*ARZ2.^2;%m^2
    % AREAZ3=pi*ARZ3.^2;%m^2
    AREAZ4=pi*ARZ4.^2;%m^2
    
    
    
    CMK1=[5.21	4.89	6.35	6.87	6.00	7.43	8.81	5.41	6.55	4.98  ...
          6.21  6.26    8.84    7.77    5.29    7.07    4.84    6.2     14.9    7.24  ...
          6.73  6.95    5.19    7.39    5.83    6.95    5.41    6.47    5.89    8.04  ...
          6.19  6.11    6.67    8.47    7.73    7.23    7.01];  %m/s
    
    CMK4=[5.49  6.01    7.49    7.84    6.58    7.43    8.81    5.52    8.00    5.12  ...
          7.10  6.84    8.84    7.77    5.48    7.99    5.26    6.20    14.9    7.24  ...
          6.73  7.44    5.59    7.39    5.83    6.95    6.24    6.94    7.13    8.44  ...
          6.79  7.44    6.89    8.47    7.73    7.23    7.01];  %m/s
    % CMK2=CMK1;
    % CMK4=CMK3;
    
    h=[0.51 0.35 0.28 0.27 0.16 0.15 0.21 0.5 0.31 0.41 0.22 0.17 0.21 0.16 0.43 ...
       0.27 0.34 0.2 1.25 0.13 0.11 0.21 0.33 0.19 0.35 0.16 0.3 0.21 0.15 0.2 ...
       0.2 0.16 0.13 0.15 0.12 0.11 0.1].*1e-3;
    
    %================================================================
    % Terminal Resistance and Compliance Arrays at Exit Vessels
    %================================================================
    %COLUMNS are from last to first%
    RESIST=    [3.16  4.59  5.65  5.16  3.45  3.46  3.75  4.24  3.54  2.59  3.74  3.77  3.11  2.67  3.24  3.92]*(1.e9);   % Pa s/m^3    %resistance of exist vessels, Rt=-W2/W1,
%     COMPLIANCE=[1.32  1.13  6.41  0.99  0.99  1.82  1.69  0.68  1.82  1.69  0.68  13.9  1.09  1.87  2.73  3.08]/(133.3*(1.e8)); %m^3/Pa
    COMPLIANCE=repmat(10e-11,1,16);

end
end
