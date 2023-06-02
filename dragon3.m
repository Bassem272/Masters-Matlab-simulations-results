clc, 
clearvars;
%error msg A;
warning off;
mODL_NAME = 'notch1';
load_system(mODL_NAME);
find_system(mODL_NAME);
%drago9 drago10
N=500;        % number of population made change 25/5 drago .mat copy of nocha22nota.m
  
  l1=5.87;
    l2=.95;
      l3=4.47;
  l4=1.47;
   c={'FaultA';'FaultA';'FaultA'};

    S={'FaultA';'FaultB';'FaultB'};
    
    V={'FaultA';'FaultB';'FaultC'};
  
    x1={.05*l1;.1*l1;.15*l1;.2*l1;.25*l1;.3*l1;.35*l1;.4*l1;.45*l1;.5*l1;.55*l1;.6*l1;.65*l1;.7*l1;.75*l1;.8*l1;.85*l1;.9*l1;.95*l1};
z1={.95*l1;.9*l1;.85*l1;.8*l1;.75*l1;.7*l1;.65*l1;.6*l1;.55*l1;.5*l1;.45*l1;.4*l1;.35*l1;.3*l1';.25*l1;.2*l1;.15*l1;.1*l1;.05*l1};
 
 x2={.05*l2;.1*l2;.15*l2;.2*l2;.25*l2;.3*l2;.35*l2;.4*l2;.45*l2;.5*l2;.55*l2;.6*l2;.65*l2;.7*l2;.75*l2;.8*l2;.85*l2;.9*l2;.95*l2};
z2={.95*l2;.9*l2;.85*l2;.8*l2;.75*l2;.7*l2;.65*l2;.6*l2;.55*l2;.5*l2;.45*l2;.4*l2;.35*l2;.3*l2';.25*l2;.2*l2;.15*l2;.1*l2;.05*l2};
 
  x3={.05*l3;.1*l3;.15*l3;.2*l3;.25*l3;.3*l3;.35*l3;.4*l3;.45*l3;.5*l3;.55*l3;.6*l3;.65*l3;.7*l3;.75*l3;.8*l3;.85*l3;.9*l3;.95*l3};
z3={.95*l3;.9*l3;.85*l3;.8*l3;.75*l3;.7*l3;.65*l3;.6*l3;.55*l3;.5*l3;.45*l3;.4*l3;.35*l3;.3*l3;.25*l3;.2*l3;.15*l3;.1*l3;.05*l3};
 
x4={.05*l3;.1*l3;.15*l3;.2*l3;.25*l3;.3*l3;.35*l3;.4*l3;.45*l3;.5*l3;.55*l3;.6*l3;.65*l3;.7*l3;.75*l3;.8*l3;.85*l3;.9*l3;.95*l3};
z4={.95*l3;.9*l3;.85*l3;.8*l3;.75*l3;.7*l3;.65*l3;.6*l3;.55*l3;.5*l3;.45*l3;.4*l3;.35*l3;.3*l3;.25*l3;.2*l3;.15*l3;.1*l3;.05*l3};

 ts={'[0 .06]';'[0.001 .06]';'[0.002 .06]';'[0.003 .06]';'[0.004 .06]';'[0.005 .06]';'[0.006 .06]';'[0.007 .06]';'[0.008 .06]';'[0.009 .06]';'[0.01 .06]';'[0.011 .06]';'[0.012 .06]';'[0.013 .06]';'[0.014 .06]';'[0.015 .06]';'[0.016 .06]';'[0.017 .06]';'[0.018 .06]';'[0.019 .06]';'[0.020 .06]'};
b1=round(N/2); 
fftime=repmat(ts,b1,1);


d=[1 0 0;1 1 0;1 1 1]


b=round(N/3)+1;
g=round(N/19)+1;
D=repmat(d,b,1);%output

l=rand(N,1);
  R=rand(N,1);
  
  F=repmat(c,b,1);
      f=repmat(S,b,1);
       ff=repmat(V,b,1);
      
     
       vv1=repmat(x1,g,1);
         zz1=repmat(z1,g,1);
          vv2=repmat(x2,g,1);
           zz2=repmat(z2,g,1);
             vv3=repmat(x3,g,1);
               zz3=repmat(z3,g,1);
             vv4=repmat(x3,g,1);
               zz4=repmat(z3,g,1);
   
    All_length= 1:N;
len=length(All_length);

 p=1e6+(2e6-1e6).*rand(1,N);
%   
 [ind, cap] = calc_reactiver(p);
% disp(ind);
% disp(cap);
 reac = calc_reactive_power(p);
% disp(reac);
% 
% time=.06+(.07-.06).*rand(1,N)


% 
% for line 1 faults
for N=1:len%%%@@@@@@@@@$$$$$$$--------------------------$$$$$$@@@@@@@@@%%

time(N)=fftime(N);
    react(N)=reac(N);
indc(N)=ind(N);
capc(N)=cap(N);
   
    lineone(N)=vv1(N);
    linel(N)=zz1(N);
    
 Fr1(N)=R(N)*100;
    fault(N)= F(N);
        fault2(N)=f(N);
            fault3(N)=ff(N);
        
 simin(N) = Simulink.SimulationInput(mODL_NAME);

   simin(N)=  simin(N).setBlockParameter('notch1/line1','length',string(lineone(N)));
     simin(N)=  simin(N).setBlockParameter('notch1/line1.1','length',string(linel(N)));
        simin(N)= simin(N).setBlockParameter('notch1/fault1','Faultresistance',num2str(Fr1(N))) ;
           simin(N)= simin(N).setBlockParameter('notch1/fault1',char(fault(N)), 'on');
              simin(N)= simin(N).setBlockParameter('notch1/fault1',char(fault2(N)), 'on');
                 simin(N)= simin(N).setBlockParameter('notch1/fault1',char(fault3(N)), 'on');
                     simin(N)= simin(N).setBlockParameter('notch1/fault1','GroundFault', 'on');
                     
simin(N)= simin(N).setBlockParameter('notch1/fault3','SwitchTimes',string(time(N)));
    simin(N) = simin(N).setPostSimFcn(@(x) postsim(x));


   
  
end  
 out = sim(simin);
     valc1=[out.x].';%current
    valc11=[out.x1].';
   valv1=[out.q].';
     valv11=[out.q1].';

 vali11=[out.g1].';
   vali12=[out.g2].';
      vali13=[out.g3].';
   
   
   %    vala1=[out.asd].'; valo1=[out.asd1].'; vale1=[out.asd2].';
   
   % i1 = out.i1;i2 = out.i2;i3 = out.i3;
simin = Simulink.SimulationInput(mODL_NAME);%             fi=@cfi; 
 simin= simin.setBlockParameter('notch1/fault1','FaultA', 'off');
  simin= simin.setBlockParameter('notch1/fault1','FaultB', 'off');
   simin= simin.setBlockParameter('notch1/fault1','FaultC', 'off');
   simin= simin.setBlockParameter('notch1/fault1','GroundFault', 'off');%             y = fi(i1,i2,i3);
%             table1(N,:)=y;

%for line 2
%faults%%%@@@@@@@@@$$$$$$$--------------------------$$$$$$@@@@@@@@@%%
for N=1:len
     time(N)=fftime(N);

 react(N)=reac(N);
indc(N)=ind(N);
capc(N)=cap(N);

    lineone(N)=vv2(N);
    linel(N)=zz2(N);
 
    Fr1(N)=R(N)*100;
    fault(N)= F(N);
      fault2(N)=f(N);
        fault3(N)=ff(N);
        
 simin(N) = Simulink.SimulationInput(mODL_NAME);
   
%      
 

   simin(N)=  simin(N).setBlockParameter('notch1/line2','length',string(lineone(N)));
      simin(N)=  simin(N).setBlockParameter('notch1/line2.1','length',string(linel(N)));
         simin(N)= simin(N).setBlockParameter('notch1/fault2','Faultresistance',num2str(Fr1(N)));
            simin(N)= simin(N).setBlockParameter('notch1/fault2',char(fault(N)), 'on');
               simin(N)= simin(N).setBlockParameter('notch1/fault2',char(fault2(N)), 'on');
                 simin(N)= simin(N).setBlockParameter('notch1/fault2',char(fault3(N)), 'on');
               
                simin(N)= simin(N).setBlockParameter('notch1/fault2','GroundFault', 'on');
              
simin(N)= simin(N).setBlockParameter('notch1/fault3','SwitchTimes',string(time(N)));
  
                
                simin(N) = simin(N).setPostSimFcn(@(x) postsim(x));


%   
%qwe is important for test date range
end  
out=sim(simin);%,'ShowSimulationManager','on')
  valc2=[out.x].';%current
    valc21=[out.x1].';
   valv2=[out.q].';
     valv21=[out.q1].';

 vali21=[out.g1].';
   vali22=[out.g2].';
      vali23=[out.g3].';
simin = Simulink.SimulationInput(mODL_NAME);%             fi=@cfi; 
 simin= simin.setBlockParameter('notch1/fault2','FaultA', 'off');
  simin= simin.setBlockParameter('notch1/fault2','FaultB', 'off');
   simin= simin.setBlockParameter('notch1/fault2','FaultC', 'off');
   simin= simin.setBlockParameter('notch1/fault2','GroundFault', 'off');
   %for line 3 faults
for N=1:len%%%%@@@@@@@@@$$$$$$$--------------------------$$$$$$@@@@@@@@@%%
time(N)=fftime(N);

     react(N)=reac(N);
indc(N)=ind(N);
capc(N)=cap(N);
   
    lineone(N)=vv3(N);
    linel(N)=zz3(N);
 
    Fr1(N)=R(N)*100;
       fault(N)= F(N);
          fault2(N)=f(N);
             fault3(N)=ff(N);
        
 simin(N) = Simulink.SimulationInput(mODL_NAME);
   
     



   simin(N)=  simin(N).setBlockParameter('notch1/line3','length',string(lineone(N)));
     simin(N)=  simin(N).setBlockParameter('notch1/line3.1','length',string(linel(N)));
         simin(N)= simin(N).setBlockParameter('notch1/fault3','Faultresistance',num2str(Fr1(N))) ; 
              simin(N)= simin(N).setBlockParameter('notch1/fault3',char(fault(N)), 'on');
                    simin(N)= simin(N).setBlockParameter('notch1/fault3',char(fault2(N)), 'on');
                          simin(N)= simin(N).setBlockParameter('notch1/fault3',char(fault3(N)), 'on');
                             simin(N)= simin(N).setBlockParameter('notch1/fault3','GroundFault', 'on');

simin(N)= simin(N).setBlockParameter('notch1/fault3','SwitchTimes',string(time(N)));
                             
                             simin(N) = simin(N).setPostSimFcn(@(x) postsim(x));


  

end  
out=sim(simin);%,'ShowSimulationManager','on')
  valc3=[out.x].';%current
    valc31=[out.x1].';
   valv3=[out.q].';
     valv31=[out.q1].';

 vali31=[out.g1].';
   vali32=[out.g2].';
      vali33=[out.g3].';
 
   
   
simin = Simulink.SimulationInput(mODL_NAME);%             fi=@cfi; 
 simin= simin.setBlockParameter('notch1/fault3','FaultA', 'off');
  simin= simin.setBlockParameter('notch1/fault3','FaultB', 'off');
   simin= simin.setBlockParameter('notch1/fault3','FaultC', 'off');
   simin= simin.setBlockParameter('notch1/fault3','GroundFault', 'off');
    
   %FOR FAULT AT the place of load adding after that fault4 block with only
   %changing the fault types and fault resistances 
   
   for N=1:len%%%@@@@@@@@@$$$$$$$--------------------------$$$$$$@@@@@@@@@%%
    time(N)=fftime(N);

    lineone(N)=vv3(N);
    linel(N)=zz3(N);
 
    Fr1(N)=R(N)*100;   % range of 100 ohm
       fault(N)= F(N);
          fault2(N)=f(N);
             fault3(N)=ff(N);
        
 simin(N) = Simulink.SimulationInput(mODL_NAME);
   
    

         simin(N)= simin(N).setBlockParameter('notch1/fault4','Faultresistance',num2str(Fr1(N)))  ;
              simin(N)= simin(N).setBlockParameter('notch1/fault4',char(fault(N)), 'on');
                    simin(N)= simin(N).setBlockParameter('notch1/fault4',char(fault2(N)), 'on');
                          simin(N)= simin(N).setBlockParameter('notch1/fault4',char(fault3(N)), 'on');
                             simin(N)= simin(N).setBlockParameter('notch1/fault4','GroundFault', 'on');

simin(N)= simin(N).setBlockParameter('notch1/fault4','SwitchTimes',string(time(N)));
  simin(N) = simin(N).setPostSimFcn(@(x) postsim(x));



end  
out=sim(simin)%,'ShowSimulationManager','on')
  valc4=[out.x].';%current
    valc41=[out.x1].';
   valv4=[out.q].';
     valv41=[out.q1].';

 vali41=[out.g1].';
   vali42=[out.g2].';
      vali43=[out.g3].';

% 

simin = Simulink.SimulationInput(mODL_NAME);%             fi=@cfi; 
 simin= simin.setBlockParameter('notch1/fault4','FaultA', 'off');
  simin= simin.setBlockParameter('notch1/fault4','FaultB', 'off');
   simin= simin.setBlockParameter('notch1/fault4','FaultC', 'off');
   simin= simin.setBlockParameter('notch1/fault4','GroundFault', 'off');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for load adding only at line 8
   for N=1:len%%%%@@@@@@@@@$$$$$$$--------------------------$$$$$$@@@@@@@@@%%
    time(N)=fftime(N);

    lineone(N)=vv3(N);
    linel(N)=zz3(N);
 
    Fr1(N)=R(N)*100;   % range of 100 ohm
       fault(N)= F(N);
          fault2(N)=f(N);
             fault3(N)=ff(N);
       
react(N)=reac(N);
indc(N)=ind(N);
capc(N)=cap(N);
 simin(N) = Simulink.SimulationInput(mODL_NAME);
   
    

         simin(N)= simin(N).setBlockParameter('notch1/test','ActivePower',num2str(react(N)))  ;
              simin(N)= simin(N).setBlockParameter('notch1/test','InductivePower',num2str(indc(N)));
                    simin(N)= simin(N).setBlockParameter('notch1/test','CapacitivePower',num2str(capc(N)));
%                          

simin(N)= simin(N).setBlockParameter('notch1/Three-Phase Breaker1','SwitchTimes',string(time(N)));
  simin(N) = simin(N).setPostSimFcn(@(x) postsim(x));

  

end  
out=sim(simin)%,'ShowSimulationManager','on')

  valc5=[out.x].';%current
    valc51=[out.x1].';
   valv5=[out.q].';
     valv51=[out.q1].';

 vali51=[out.g1].';
   vali52=[out.g2].';
      vali53=[out.g3].';
% 


% tablei=[valc;valc1;valc2];
%           tablev=[valv;valv1;valv2];;valc2;valc3;valc4;valc5;
%           tablea=[vala;vala1;vala2];valv2;valv3;valv4;valv5
%           tableo=[valo;valo1;valo2];
%           tablee=[valevalc;valv55;vale1;vale2];valc5;;valv5
       tablei=[valc1];
          tablev=[valv1;] ;  
          
save('drago11.mat');%normal drago2 5 ohm without switch timegood results
%drago3 100ohm timed also saved in matlabdrago3.mat=++=drago4 for fault and
%load add فيها  بس faults عند اللودdrago6.mat=load and line 8 finally all
%all the work done on voltage
%saved in dragon  and drago7 has line8 without time and 5 ohm
%drago8 timed 100 ohm using filters on voltage and current %%%% dragna
%saved dragon8-----drago9 -----addnoise to voltage drago10 success then we
%added the new x1 only in drago11


function reac = calc_reactive_power(p)
% Calculates the reactive power for an array of active power values.
% Assumes a power factor of 0.85 and a frequency of 50 Hz.

% Constants for the calculation
pf = 0.85;
f = 50; % Hz
V = 10000; % V (assuming a line-to-line voltage of 10 kV)
% Calculate the apparent power for each active power value
apparent_power = p ./ pf;

% Calculate the reactive power for each apparent power value
reac = sqrt(apparent_power.^2 - p.^2);

% Calculate the inductive and capacitive reactive power for each value
inductive_power = reac / 2;
capacitive_power = reac / 2;

% Calculate the inductance and capacitance for each value
inductance = inductive_power ./ (2*pi*f*V^2);
capacitance = 1 ./ (2*pi*f*V^2*inductance);

% Return the reactive power array
reac = inductive_power + capacitive_power;
end



function [ind, cap] = calc_reactiver(p);
% Calculates the inductive and capacitive reactive power for an array of active power values.
% Assumes a power factor of 0.85 and a frequency of 50 Hz.

% Constants for the calculation
pf = 0.85;
f = 50; % Hz
V = 10000; % V (assuming a line-to-line voltage of 10 kV)

% Calculate the apparent power for each active power value
apparent_power = p ./ pf;

% Calculate the reactive power for each apparent power value
reactive_power = sqrt(apparent_power.^2 - p.^2);

% Calculate the inductive and capacitive reactive power for each value
ind = reactive_power / 2;
cap = reactive_power / 2;

% Calculate the inductance and capacitance for each value
inductance = ind ./ (2*pi*f*V^2);
capacitance = 1 ./ (2*pi*f*V^2*inductance);

% Return the inductive and capacitive reactive power arrays
end



function newout = postsim(out);
%newout.x = out.i1;


currentA =out.i1;
currentB =out.i2;
currentC = out.i3;
%adding the noise%%%%%%%%%%%%%5/25%%%%%%%5/
    minNoisePowerA = var(currentA) / (10^(21.69/10));
    maxNoisePowerA = var(currentA) / (10^(50/10));
    minNoisePowerB = var(currentB) / (10^(21.69/10));
    maxNoisePowerB = var(currentB) / (10^(50/10));
    minNoisePowerC = var(currentC) / (10^(21.69/10));
    maxNoisePowerC = var(currentC) / (10^(50/10));
    
    % Generate random noise powers within the desired range
    noisePower1 = (maxNoisePowerA - minNoisePowerA) * rand() + minNoisePowerA;
    noisePower2 = (maxNoisePowerB - minNoisePowerB) * rand() + minNoisePowerB;
    noisePower3 = (maxNoisePowerC - minNoisePowerC) * rand() + minNoisePowerC;
    
    % Generate white noise
    noise1 = randn(size(currentA)) * sqrt(noisePower1);
    noise2 = randn(size(currentB)) * sqrt(noisePower2);
    noise3 = randn(size(currentC)) * sqrt(noisePower3);
    
    % Add the noise to the input signals
    noisySignal1 = currentA + noise1;
    noisySignal2 = currentB + noise2;
    noisySignal3 = currentC + noise3;
    currentA=noisySignal1;
    currentB=noisySignal2;
    currentC=noisySignal3;
%%wavelet decomposion for ther three signals of currnt%%%%%%%%%%%%%%%%%%%%%%%%%%%
wv = 'db4';
Fs = 3200;
fb = dwtfilterbank('Wavelet',wv,'Level',4,'SamplingFrequency',Fs);
[cA1, LA1] = wavedec(currentA, 1, 'db4');
[cB1, LB1] = wavedec(currentB, 1, 'db4');
[cC1, LC1] = wavedec(currentC, 1, 'db4');
[cA2, LA2] = wavedec(currentA, 2, 'db4');
[cB2, LB2] = wavedec(currentB, 2, 'db4');
[cC2, LC2] = wavedec(currentC, 2, 'db4');
[cA3, LA3] = wavedec(currentA, 3, 'db4');
[cB3, LB3] = wavedec(currentB, 3, 'db4');
[cC3, LC3] = wavedec(currentC, 3, 'db4');
[cA4, LA4] = wavedec(currentA, 4, 'db4');
[cB4, LB4] = wavedec(currentB, 4, 'db4');
[cC4, LC4] = wavedec(currentC, 4, 'db4');

dA1 = detcoef(cA1, LA1, 1);
dB1 = detcoef(cB1, LB1, 1);
dC1 = detcoef(cC1, LC1, 1);
dA2 = detcoef(cA2, LA2,2);
dB2 = detcoef(cB2, LB2, 2);
dC2 = detcoef(cC2, LC2, 2);
dA3 = detcoef(cA3, LA3, 3);
dB3 = detcoef(cB3, LB3, 3);
dC3 = detcoef(cC3, LC3, 3);
dA4 = detcoef(cA4, LA4, 4);
dB4 = detcoef(cB4, LB4, 4);
dC4 = detcoef(cC4, LC4, 4);
aA4 = appcoef(cA4, LA4,'db4', 4);
aB4 = appcoef(cB4, LB4,'db4', 4);
aC4 = appcoef(cC4, LC4,'db4' ,4);
aA1 = appcoef(cA1, LA1,'db4', 1);
aB1 = appcoef(cB1, LB1,'db4', 1);
aC1 = appcoef(cC1, LC1,'db4' ,1);

%%%==========================--------------%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w1 =out.v1;
w2 =out.v2;
w3 = out.v3;

%%%%%%%%%%%%%%%%---adding tht noise for the three voltage signals--%%%%%%%%%%%%%%%%%
    minNoisePowerAv = var(w1) / (10^(21/10));
    maxNoisePowerAv = var(w1) / (10^(50/10));
    minNoisePowerBv = var(w2 ) / (10^(21/10));
    maxNoisePowerBv = var(w2 ) / (10^(50/10));
    minNoisePowerCv = var(w3) / (10^(21/10));
    maxNoisePowerCv = var(w3) / (10^(50/10));
    
    % Generate random noise powers within the desired range
    noisePower1v = (maxNoisePowerAv - minNoisePowerAv) * rand() + minNoisePowerAv;
    noisePower2v = (maxNoisePowerBv - minNoisePowerBv) * rand() + minNoisePowerBv;
    noisePower3v = (maxNoisePowerCv - minNoisePowerCv) * rand() + minNoisePowerCv;
    
    % Generate white noise
    noise1v = randn(size(w1)) * sqrt(noisePower1v);
    noise2v = randn(size(w2 )) * sqrt(noisePower2v);
    noise3v = randn(size(w3)) * sqrt(noisePower3v);
    
    % Add the noise to the input signals
    noisySignal1v = w1 + noise1v;
    noisySignal2v= w2  + noise2v;
    noisySignal3v = w3 + noise3v;
newout.g1=noisySignal1v;
newout.g2=noisySignal2v;
newout.g3=noisySignal3v;
%   w1 = wdenoise(noisySignal1v, 4, ...
%     'Wavelet', 'coif5', ...
%     'DenoisingMethod', 'Bayes', ...
%     'ThresholdRule', 'Hard', ...
%     'NoiseEstimate', 'LevelDependent'); 
%   w2  = wdenoise(noisySignal2v, 4, ...
%     'Wavelet', 'coif5', ...
%     'DenoisingMethod', 'Bayes', ...
%     'ThresholdRule', 'Hard', ...
%     'NoiseEstimate', 'LevelDependent'); 
%     w3 = wdenoise(noisySignal3v, 4, ...
%     'Wavelet', 'coif5', ...
%     'DenoisingMethod', 'Bayes', ...
%     'ThresholdRule', 'Hard', ...
%     'NoiseEstimate', 'LevelDependent'); 
% median filter     
% w1= medfilt1(noisySignal1v,10,'omitnan');
% w2= medfilt1(noisySignal2v,10,'omitnan');
% %  w3= medfilt1(noisySignal3v,10,'omitnan');
% order = 9;
% framelen = 21;
% 
% %soglay filter
% w1 = sgolayfilt(noisySignal1v,order,framelen);
% w2 = sgolayfilt(noisySignal2v,order,framelen);
% w3 = sgolayfilt(noisySignal3v,order,framelen);


% wavelet decomptions for the three voltage signals
wv = 'db4';
Fs = 3200;
fb = dwtfilterbank('Wavelet',wv,'Level',4,'SamplingFrequency',Fs);

[ca1, La1] = wavedec(w1, 1, 'db4');
[cb1, Lb1] = wavedec(w2, 1, 'db4');
[cc1, Lc1] = wavedec(w3, 1, 'db4');
[ca2, La2] = wavedec(w1, 2, 'db4');
[cb2, Lb2] = wavedec(w2, 2, 'db4');
[cc2, Lc2] = wavedec(w3, 2, 'db4');
[ca3, La3] = wavedec(w1, 3, 'db4');
[cb3, Lb3] = wavedec(w2, 3, 'db4');
[cc3, Lc3] = wavedec(w3, 3, 'db4');
[ca4, La4] = wavedec(w1, 4, 'db4');
[cb4, Lb4] = wavedec(w2, 4, 'db4');
[cc4, Lc4] = wavedec(w3, 4, 'db4');
da1 = detcoef(ca1, La1, 1);
db1 = detcoef(cb1, Lb1, 1);
dc1 = detcoef(cc1, Lc1, 1);
da2 = detcoef(ca2, La2,2);
db2 = detcoef(cb2, Lb2, 2);
dc2 = detcoef(cc2, Lc2, 2);
da3 = detcoef(ca3, La3, 3);
db3 = detcoef(cb3, Lb3, 3);
dc3 = detcoef(cc3, Lc3, 3);
%level 4 detail
da4 = detcoef (ca4, La4, 4);
db4 = detcoef(cb4, Lb4, 4);
dc4 = detcoef(cc4, Lc4, 4);
%level 4 approximation
aa4 = appcoef(ca4, La4,'db4', 4);
ab4 = appcoef(cb4, Lb4,'db4', 4);
ac4 = appcoef(cc4, Lc4,'db4' ,4);
in1=[aA4 ;dA4 ; dA3 ;  dA2 ; dA1 ];
    in2=[aB4; dB4 ; dB3 ;  dB2 ; dB1];
    in3=[aC4; dC4 ; dC3 ; dC2 ; dC1];
    %the final array that will be but in the valv array to be used for 
    %training  اخر محاولة ناجحة كانت 7.96ز17 تيار  صنفت النقط newout.q
newout.q=[aa4;ac4;ab4;aa4;ac4;ab4;aA4;aB4; aC4 ;dA4; dB4 ; dC4 ;da4 ;da3 ; da2; db4 ;db3 ; db2; dc4 ;dc3 ; dc2; ];%valv
newout.q1=[ab4;aa4;ac4;aA4;aB4; aC4 ;dA4; dB4 ; dC4 ;da4 ;da3 ; da2; db4 ;db3 ; db2; dc4 ;dc3 ; dc2;da1;db1;dc1 ];%valv2 accuracy>q

 %the final array that will be but in the valc array to be used for
    %training 
newout.x=[aA4 ;dA4 ; dA3 ;  dA2 ; dA1 ; aB4; dB4 ; dB3 ;  dB2 ; dB1; aC4; dC4 ; dC3 ; dC2 ; dC1];%valc
newout.x1=[;dA4 ; dA3 ;  dA2 ; dA1 ;  dB4 ; dB3 ;  dB2 ; dB1;  dC4 ; dC3 ; dC2 ; dC1;dc4 ;dc3 ; dc2; db4 ;db3 ; db2;da4 ;da3 ; da2];%valc
% Inputs
% new_x = newout.x;  % Input array for 'valc'
% new_q = newout.q;  % Input array for 'valv'
% wv = 'db4';       % Wavelet name
% level = 4;        % Decomposition level
% 
% % Call the function to extract features
% [coeffs_x, approx_x, coeffs_q, approx_q] = extractFeaturesArray(new_x, new_q, wv, level);
% newout.wy=[coeffs_x;approx_x]
% 
% newout.zy=[coeffs_q; approx_q]
% % newout.qq=[aa4; ab4;ac4;aA4;aB4;aC4;];%valvv
% newout.xx= [dA4 ; dA3 ;  dA2 ; dA1 ;  dB4 ; dB3 ;  dB2 ; dB1; dC4 ; dC3 ; dC2 ; dC1;dc4 ;dc3 ; dc2; dc1;db4 ;db3 ; db2; db1;da4 ;da3 ; da2; da1;];%valcc

%  da4 ;da3 ; da2; da1;db4 ;db3 ; db2; db1;dc4 ;dc3 ; dc2; dc1





k1 =in1;
k2 =in2;
k3 = in3;
%Obtain the percentages of energy in the approximation and details coefficients.
wv = 'db4';
Fs = 2200;
fb = dwtfilterbank('Wavelet',wv,'Level',10,'SamplingFrequency',Fs);
[ga6, ha6] = wavedec(k1, 6, 'db4');
[gb6, hb6] = wavedec(k2, 6, 'db4');
[gc6, hc6] = wavedec(k3, 6, 'db4');
[aa,ad] = wenergy(ga6,ha6);
[ba,bd] = wenergy(gb6,hb6);
[ca,cd] = wenergy(gc6,hc6);
v=ad+bd+cd;
as1=sum(ad);
as2=sum(bd);
as3=sum(cd);
newout.asd=[as1 ,as2 ,as3];
%s.e = pentropy(Ed)
%Ed = 1×4
  %  2.1560    1.2286    1.4664    6.8630

%%Obtain the wavelet packet tree corresponding to the 3-level wavelet packet decomposition of the signal using the sym4 wavelet.
%t = wpdec(noisbump,3,wv);
%Obtain the percentages of energy in the terminal nodes.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[cA6, LA6] = wavedec(currentA, 6, 'db4');
[cB6, LB6] = wavedec(currentB, 6, 'db4');
[cC6, LC6] = wavedec(currentC, 6, 'db4');
[af,aj] = wenergy(cA6, LA6);
[bf,bj] = wenergy(cB6, LB6);
[cf,cj] = wenergy(cC6, LC6);
v=aj+bj+cj;
ae1=sum(aj);
ae2=sum(bj);
ae3=sum(cj);
newout.asd1=[ae1 ,ae2 ,ae3];%%%%$$$
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wv = 'fk22';
Fs = 12500;
fb = dwtfilterbank('Wavelet',wv,'Level',9,'SamplingFrequency',Fs);
[nA6, mA6] = wavedec(currentA, 10, 'db4');
[nB6, mB6] = wavedec(currentB, 10, 'db4');
[nC6, mC6] = wavedec(currentC,10, 'db4');
[aq,ak] = wenergy(nA6, mA6);
[bq,bk] = wenergy(nB6, mB6);
[cq,ck] = wenergy(nC6, mC6);
v=ak+bk+ck;
ab1=sum(ak);
ab2=sum(bk);
ab3=sum(ck);
newout.asd2=[ab1 ,ab2 ,ab3];%%%%$$$%e = wenergy(t)
%%%%%%%%%%%%%%%%---addition drago9 only this section---%%%%%%%%%%%%%%%%%


% % Define the wavelet and sampling frequency wavelet = 'sym4';
% sampling_frequency = 1000;
% 
% % Create the filter bank [Lo_D, Hi_D] = wfilters(wavelet, 'd');
% 
% % Apply wavelet decomposition and thresholding to each signal
% [denoised_coeffs1, ~, ~, ~] = wdenoise(w1, 'Wavelet', wavelet,
% 'DenoisingMethod', 'Soft', 'ThresholdRule', 'sqrt', 'ThresholdMode',
% 'LevelIndependent'); [denoised_coeffs2, ~, ~, ~] = wdenoise(w2,
% 'Wavelet', wavelet, 'DenoisingMethod', 'Soft', 'ThresholdRule', 'sqrt',
% 'ThresholdMode', 'LevelIndependent'); [denoised_coeffs3, ~, ~, ~] =
% wdenoise(w3, 'Wavelet', wavelet, 'DenoisingMethod', 'Soft',
% 'ThresholdRule', 'sqrt', 'ThresholdMode', 'LevelIndependent');
% 
% % Reconstruct the original signals reconstructed_signal1 =
% waverec(denoised_coeffs1, [], wavelet); reconstructed_signal2 =
% waverec(denoised_coeffs2, [], wavelet); reconstructed_signal3 =
% waverec(denoised_coeffs3, [], wavelet);
% 
% % You can now use the denoised and reconstructed signals as per your %
% requirements
% 
% % Reconstruct signals using denoised coefficients
% 
%  w1=reconstructed_signal1;
%     w2 =reconstructed_signal2;
%    w3=reconstructed_signal3;
end

