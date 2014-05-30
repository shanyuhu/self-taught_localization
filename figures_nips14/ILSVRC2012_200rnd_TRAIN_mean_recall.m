function ILSVRC2012_200rnd_TRAIN_mean_recall()

config;

figure('name','ILSVRC2012_200rnd_TRAIN_mean_recall','Position', conf.figure_position);
hold on;
grid on;
set(gcf, 'DefaultLineLineWidth', conf.lw);
set(gcf, 'DefaultLineMarkerSize', conf.ms);
set(gca, 'fontsize', conf.fs);
xlabel('Number of bboxes per image');
ylabel('Mean Recall');
set(gca, 'XScale', 'log');
%title('This is the title');
%set(gca, 'XTick', xvalues);
%axis([1, 50, 0, 1]);


% ****** exp14_07stats / mean_recall *** SelectiveSearch, fast   **********
num_bboxes = [ 1.000000, 2.000000, 3.000000, 4.000000, 5.000000, 6.000000, 7.000000, 8.000000, 9.000000, 10.000000, 11.000000, 12.000000, 13.000000, 14.000000, 15.000000, 20.000000, 30.000000, 50.000000, 100.000000, 200.000000, 500.000000, 1000.000000, 2000.000000, 3000.000000 ];
mean_recall = [ 0.221412, 0.339171, 0.420465, 0.476851, 0.518515, 0.550086, 0.574054, 0.596519, 0.614508, 0.631143, 0.644563, 0.658633, 0.672613, 0.684028, 0.694240, 0.740343, 0.793165, 0.844750, 0.905764, 0.944328, 0.971459, 0.981308, 0.984845, 0.984888 ];
plot(num_bboxes, mean_recall, '-o', 'DisplayName', SS.legend, 'Color', SS.color);
h=legend('-DynamicLegend'); set(h,'Interpreter','none');


% ****** exp23_11stats_NMS_05 / mean_recall *** ObfuscationSearch, GT   **********
num_bboxes = [ 1.000000, 2.000000, 3.000000, 4.000000, 5.000000, 6.000000, 7.000000, 8.000000, 9.000000, 10.000000, 11.000000, 12.000000, 13.000000, 14.000000, 15.000000, 20.000000, 30.000000, 50.000000, 100.000000, 200.000000, 500.000000, 1000.000000 ];
mean_recall = [ 0.471012, 0.577074, 0.634031, 0.668324, 0.692151, 0.713033, 0.729343, 0.743241, 0.754464, 0.763680, 0.771009, 0.778467, 0.785564, 0.791828, 0.797684, 0.818302, 0.840731, 0.864191, 0.886411, 0.903001, 0.923257, 0.923762 ];
plot(num_bboxes, mean_recall, '-o', 'DisplayName', OBFSgt.legend, 'Color', OBFSgt.color);
h=legend('-DynamicLegend'); set(h,'Interpreter','none');


% ****** exp23_09stats_NMS_05 / mean_recall *** ObfuscationSearch, topC=5   **********
num_bboxes = [ 1.000000, 2.000000, 3.000000, 4.000000, 5.000000, 6.000000, 7.000000, 8.000000, 9.000000, 10.000000, 11.000000, 12.000000, 13.000000, 14.000000, 15.000000, 20.000000, 30.000000, 50.000000, 100.000000, 200.000000, 500.000000, 1000.000000 ];
mean_recall = [ 0.482297, 0.581159, 0.629804, 0.662464, 0.686653, 0.705994, 0.721132, 0.735902, 0.747617, 0.758061, 0.765104, 0.772347, 0.779051, 0.784795, 0.790938, 0.810537, 0.833687, 0.858368, 0.879430, 0.895763, 0.912901, 0.913431 ];
plot(num_bboxes, mean_recall, '-o', 'DisplayName', OBFStopC.legend, 'Color', OBFStopC.color);
h=legend('-DynamicLegend'); set(h,'Interpreter','none');

% ****** exp28_02stats_NMS_05 / mean_recall *** Sliding Window, topC=5   **********
num_bboxes = [ 1.000000, 2.000000, 3.000000, 4.000000, 5.000000, 6.000000, 7.000000, 8.000000, 9.000000, 10.000000, 11.000000, 12.000000, 13.000000, 14.000000, 15.000000, 20.000000, 30.000000, 50.000000, 100.000000, 200.000000, 500.000000, 1000.000000, 2000.000000 ];
mean_recall = [ 0.041242, 0.062598, 0.079726, 0.091620, 0.101085, 0.109747, 0.117146, 0.125017, 0.131422, 0.137338, 0.141808, 0.145760, 0.150112, 0.154562, 0.159513, 0.174394, 0.192852, 0.214895, 0.240795, 0.261455, 0.284662, 0.295013, 0.295292 ];
plot(num_bboxes, mean_recall, '-o', 'DisplayName', SW.legend, 'Color', SW.color);
h=legend('-DynamicLegend'); set(h,'Interpreter','none');

legend(h, 'Location', 'Best');

end
