
% General properties
width = 3.45;                   % Width in inches
height = 2.6;                   % Height in inches
font_size = 8;                  % Fontsize
font_size_leg = 6;              % Font size (legend)
font_name = 'TimesNewRoman';    % Font name
line_width = 1.5;               % LineWidth

% Plot instructions
figure();
figshift;
hold on
plot(NSR(:,1,1),(mean(NSR(:,2,:),3)),'k','LineWidth',line_width);
hold on
errorbar(NSR(:,1,1)+1,(mean(NSR(:,3,:),3)),devstNSR(:,3),'b','LineWidth',line_width);
errorbar(NSR(:,1,1),(mean(NSR(:,4,:),3)),devstNSR(:,4),'r','LineWidth',line_width);

% Set various properties
xlim([0 vett_nodi(end)+2]);

box on;
grid on;

xlabel('Nodes of network', 'FontSize', font_size, 'FontName', font_name);
ylabel('NSR [dB]', 'FontSize', font_size, 'FontName', font_name);

set(gca, 'FontSize', font_size);
set(gca, 'FontName', font_name);

h_legend=legend('Centralized-RVFL','Consensus-RVFL','Local-RVFL','Location', 'NorthWest');
set(h_legend,'FontSize', font_size_leg);
set(h_legend,'FontName', font_name);

% Set the default Size for display
set(gcf, 'PaperUnits', 'inches');
defpos = get(gcf, 'Position');
set(gcf,'Position', [defpos(1) defpos(2) width*100, height*100]);

% Set the defaults for saving/printing to a file
defsize = get(gcf, 'PaperSize');
left = (defsize(1)- width)/2;
bottom = (defsize(2)- height)/2;
defsize = [left, bottom, width, height];
set(gcf, 'PaperPosition', defsize);