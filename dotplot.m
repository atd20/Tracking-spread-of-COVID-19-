%%%%%%%%%%%% function to plot positions of people %%%%%%%%%%%%
%INPUTS
%xpos= X POSITION ARRAY
%ypos= Y POSITION ARRAY
%stat = STATUS ARRAY
%timestep=TS
%deltatime=dT
%OUTPUT= GRAPHS WITH DOTS MOVING ACCORDING TO THEIR INDIVIDUELL HEALTH STATUS
function []= dotplot(xpos,ypos,stat,timestep,deltatime)
    subplot(2,2,1)
    inittime=datevec(seconds(timestep*deltatime));
    if isempty(find(stat==1))==0%finds all healthy people in the status array(1) and plots them with green marker
    plot(xpos(find(stat==1)),ypos(find(stat==1)),'o','MarkerSize',7,'MarkerFaceColor',[0.4660 0.6740 0.1880],'MarkerEdgeColor',[0.4660 0.6740 0.1880])
    hold on
    end
    
    if isempty(find(stat==2))==0%finds all infected people in the status array(2) and plots them with orange marker
    plot(xpos(find(stat==2)),ypos(find(stat==2)),'o','MarkerSize',7,'MarkerFaceColor',[0.9290 0.6940 0.1250],'MarkerEdgeColor',[0.9290 0.6940 0.1250])
    hold on
    end
   
    if isempty(find(stat==3))==0%finds all sick people in the status array(2) and plots them with red marker
    plot(xpos(find(stat==3)),ypos(find(stat==3)),'o','MarkerSize',7,'MarkerFaceColor',[0.6350 0.0780 0.1840],'MarkerEdgeColor',[0.6350 0.0780 0.1840])
    hold on
    end
    if isempty(find(stat==4))==0%finds all recovered people in the status array(2) and plots them with blue marker
    plot(xpos(find(stat==4)),ypos(find(stat==4)),'o','MarkerSize',7,'MarkerFaceColor',[0 0.4470 0.7410],'MarkerEdgeColor',[0 0.4470 0.7410])
    end
    hold off
    axis square
    axis([0 1000 0 1000])
    title(['Days',num2str(inittime(3)),'   Hours',num2str(inittime(4))])
    pause(0.00000001)
end
