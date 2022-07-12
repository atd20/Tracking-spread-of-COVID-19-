%housekeeping
clear
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Initialise positions, directions and velocities of each person%%%
%COLOUR COORDINATION:HEALTHY=GREEN, INFECTED=ORANGE,SICK=RED,RECOVERED=BLUE
n=input('Please Enter A Population Size:');%USER INPUTS POLUATION SIZE RECOMMENDED BETWEEN 50 AND 100
Xpos=996*rand(1,n)+2;%RANDOMLY GENERATING THE X AND Y POSITIONS OF EACH PERSON IN THE POPULATION
Ypos=996*rand(1,n)+2;
dt=10; %TIME STEP FOR SIMULATION
V=0.1*rand(1,n) + 0.1;%RESULTANT VELOCITY BETWEEN 0.1 AND 0.2m/s
Theta=360*rand(1,n);%ANGLE BETWEEN RESULTANT VELOCITY AND ITS COMPONENTS
Xvel=V.*cosd(Theta);%X COMPONENT OF VELOCITY
Yvel=V.*sind(Theta);%Y COMPONENT OF VELOCITY
status=ones(1,n);%ARRAY CONTAINING THE STATUS OF EVERY MEMBER IN THE POPULATION %1=Healthy, 2=Infected, 3=Sick, 4=Recovered
status(1)=3;%STATUS OF ONE PERSON IS INITIALLY SET TO SICK(3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Plotting initial positions and saving them to a text file named'initialpos'%%%
myplot=figure(1)%CREATING A FIGURE FOR THE INITIAL POSITIONS PLOT
plot(Xpos(find(status==1)),Ypos(find(status==1)),'o','MarkerSize',7,'MarkerFaceColor',[0.4660 0.6740 0.1880])
hold on
plot(Xpos(find(status==3)),Ypos(find(status==3)),'o','MarkerSize',7,'MarkerFaceColor',[0.6350 0.0780 0.1840])
hold off
title('Initial Positions of Population');
saveas(myplot,'initalpos.jpg')
close(myplot)
%myplot=figure(1)
count(1,n)=0;%setting relative time counter matrix to zero
t=0;% initial time is set to zero
figure1=figure('Position',[0, 0, 1500, 1500]);
lineplotcounter=1;
fileID= fopen('Dailysummaries.txt','w+');%TO CLEAR PREVIOUS DATA STORED IN FILE TO SAVE DAILY SUMARRIES EACH TIME CODE IS RUN+CREATS NEW FILE
fclose(fileID);
 
%INITIATING LINE PLOT USING ANIMATED LINE PLOT
subplot(2,2,3)
h=animatedline(0,length(find(status==1)),'color',[0.4660 0.6740 0.1880],'LineWidth',2);%HEALTHY LINE PLOT
in=animatedline(0,length(find(status==2)),'color',[0.9290 0.6940 0.1250],'LineWidth',2);%INFECTED LINE PLOT
s=animatedline(0,length(find(status==3)),'color',[0.6350 0.0780 0.1840],'LineWidth',2);%SICK LINE PLOT
re=animatedline(0,length(find(status==4)),'color',[0 0.4470 0.7410],'LineWidth',2);%RECOVERED LINE PLOT
%GRAPH PLOTTING HOUSKEEPING
legend('Healthy','Infected','Sick','Recovered')
xlabel('Hours')
ylabel('Number of people')
axis square
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%STARTING CODE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for ts=1:(864000/dt)%FOR A TOTAL TIME OF 10 DAYS(TS = SECONDS;1TS=10 REAL SECONDS)
    %CHECKS IF POSITIONS ARE OUT OF BOUNDS ACCOURDING TO DATA SHEET(WITHIN 2 METRES OF THE BOUNDARY)
    for i =1:n
        if (Xpos(i)<=2)|(Xpos(i)>=998)
            Xvel(i)=Xvel(i).*-1;% IF OUT OF BOUNDS, VELOCITY IS REVERSED
        end
        if (Ypos(i)<=2)|(Ypos(i)>=998)
            Yvel(i)=Yvel(i).*-1;
        end
        for j=1:n
            chance=rand;%INITIATING THE CHANCE
            %CHECKING IF THE DISTANCE OF EACH PERSON IS SMALLER THAN 2m to each other
            if i~=j% ENSURING NOT PICKING THE SAME PERSON
                r=sqrt((Xpos(j)-Xpos(i))^2+(Ypos(j)-Ypos(i))^2);%RELATIVE DISTANCE OF PERSON i TO PERSON j
                 if (r <=2 && chance<=0.3 && status(i)==2 && status(j)==1)%IF DISTANCE IS SMALLER THAN 2m,AND PERSON IS INFECTED THEY INFECT ANOTHER PERSON WITH CHANCE 30%
                     status(j)=2;
                 
                 elseif (r <=2 && chance<=0.5 && status(i)==3 && status(j)==1 )%IF DISTANCE IS SMALLER THAN 2m, AND PERSON IS SICK THEY INFECT ANOTHER PERSON WITH CHANCE 50%
                      status(j)=2;
                 end
             end
        end
        %AFTER ALL DISTANCES ARE CHECKED POSITIONS OF X AND Y ARE UPDATED
        Xpos(i) = Xpos(i) + Xvel(i)*dt;
        Ypos(i) = Ypos(i) + Yvel(i)*dt;
        %COUNTER IS INITIATED TO FIND TIME DIFFERENCE SINCE CHANGE OF HEALTH STATUS OCCURS
       if (status(i)==2) | (status(i)==3)
         count(i)=count(i)+dt;%CONVERTS THE COUNT TO SECONDS
       end
       %CHANGING STATUS
       if (count(i)>= 172800 ) && (status(i)==2 )%172800= TIME FOR 2 DAYS  432000 =TIME FOR 5 DAYS
         status(i)=3;
       
       elseif ((count(i)>= 432000) && (status(i)==3))|((count(i)>= 259200) && (status(1)==3))
         status(i)=4;%DAY 5 SICK PERSON AUTOMATICALLY BECOMES RECOVERED
        
       end
    end
    %%% CALL FUNCTION TO PLOT THE POSITIONS%%
    if mod(ts*dt,900)==0%PLOTTING EVERY 15 MINUTES
    dotplot(Xpos,Ypos,status,ts,dt)
    end
   
    %STRUCTURE ARRAY WITH 4/5 FIELDS TO TRACK THE STATUS OF :
    Data(ts).Healthy=sum(status(:) == 1);%HEALTHY
    Data(ts).Infected=sum(status(:) == 2);%INFECTED
    Data(ts).Sick=sum(status(:) == 3);%SICK
    Data(ts).Recovered=sum(status(:) == 4);%RECOVERED PEOPLE
   
    %%%%%%INITIALISING DATEVEC%%%%%%
    t=ts*dt;% ACTUAL TIME IN SECONDS
    f=datevec(seconds(t));%FUNCTION TO UPDATE TIME AS A VECTOR
    Data(ts).Time=f; %ADDING TIME TO THE REST OF THE STRUCTURE ARRAY
   
    %%% CALL FUNCTION TO PLOT BAR GRAPH%%%
    if mod(t,900)==0%PLOTTING EVERY 15 MINUTES
    bargraphfunc(Data(ts).Healthy,Data(ts).Infected,Data(ts).Sick,Data(ts).Recovered,num2str(f(3)),num2str(f(4)),n)
    end
   
    %%% CALL FUNCTION TO PLOT LINE PLOT %%%
    if mod(t,900)==0%PLOTTING EVERY 15 MINUTES
    lineplotfunc(h,in,s,re,num2str(f(3)),num2str(f(4)),Data(ts).Healthy,Data(ts).Infected,Data(ts).Sick,Data(ts).Recovered,t) 
    end
   
   if t ==172800 %172800% SAVES ALL 3 PLOTS AT 2, 4 AND 6 DAYS IN A JPEG FILE
     saveas(figure1,'Day2plots.jpg')
   elseif t== 345600 %345600
     saveas(figure1,'Day4plots.jpg')
   elseif t==518400 %518400
     saveas(figure1,'Day6plots.jpg')
   end
    %DISPLAYS THE DAILY SUMMARY EVERY DAY
   if mod(t,86400)==0%10 DAYS
    fileID= fopen('Dailysummaries.txt','a+');%NEW FILE CREATED TO APPEND IN
    fprintf(fileID,'Day: %1.0f \nHealthy: %1.0f \nInfected: %1.0f \nSick: %1.0f \nRecovered: %1.0f \n \n',f(3),sum(status(:) == 1),sum(status(:) == 2),sum(status(:) == 3),sum(status(:) == 4));
    fprintf('Day: %1.0f \nHealthy: %1.0f \nInfected: %1.0f \nSick: %1.0f \nRecovered: %1.0f \n',f(3),sum(status(:) == 1),sum(status(:) == 2),sum(status(:) == 3),sum(status(:) == 4))
    disp('  ')%CREATS A SPACE IN THE TEXT FILE AFTER EACH DAY
    fclose(fileID);%HOUSEKEEPING
   end
 
end
