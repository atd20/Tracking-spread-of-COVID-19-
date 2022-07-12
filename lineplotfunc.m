%%%%%%%%%%%%%%%%%%%%%%%%function for line plot%%%%%%%%%%%%%%%%%%%%%%%%
%INPUTS
%h=INITIAL ANIMATED LINE PLOT FOR HEALTHY
%in=INITIAL ANIMATED LINE PLOT FOR INFECTED
%s=INITIAL ANIMATED LINE PLOT FOR SICK
%r=INITIAL ANIMATED LINE PLOT FOR RECOVERED
%XPOINTS = TIME IN HOURS
%DAY=NUMBER OF DAYS GONE BY 
%HOUR=NUMBER OF HOURS GONE BY
%OUTPUT= GRAPH WITH LINE PLOT HOURS AGAINST HEALTH STATUS
function []=lineplotfunc(h,in,s,re,day,hour,health,infect,sick,recov,t) 
    subplot(2,2,3);
    xpoints=floor(t/3600);
    addpoints(h,xpoints,health);
    addpoints(in,xpoints,infect);
    addpoints(s,xpoints,sick);
    addpoints(re,xpoints,recov);
    title(['Days',day,'   Hours',hour])
    drawnow  
end

 
