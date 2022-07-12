%%%%%%%%%%%%fuction for bar graph%%%%%%%%%%%%
%INPUTS
%health=healthy people count
%infect=infected peole count
%sicks=sick peoplec count
%recov=recovered people count
%OUTPUT= BAR GRAPH WITH HEALTH STATUS ACCORDING THE COLOURS STATED INITIALLY
function []=bargraphfunc(health,infect,sicks,recov,datavecday,datavechour,n)
    subplot(2,2,[2 4])
    x = categorical({'Healthy','Infected','Sick','Recovered'});
    x = reordercats(x,{'Healthy','Infected','Sick','Recovered'});
    y = [ health, infect, sicks, recov ];
    h=bar(x,y);%plots bar graph
    h.FaceColor = 'flat';
    ylim([0,n]);
    %colour accouring to health status
    h.CData(1,:) = [0.4660 0.6740 0.1880];
    h.CData(2,:) = [0.9290 0.6940 0.1250];
    h.CData(3,:) = [0.6350 0.0780 0.1840];
    h.CData(4,:) = [0 0.4470 0.7410];
    ylabel('Number of People')
    title(['Days',datavecday,'   Hours',datavechour])
    %axis square 
end

