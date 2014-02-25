function val = extract_segmentation(testIms, imagePath, savePath, seg_params, fix_sz)


% output value
val = 0;

totalTime = 0;
for i=1:length(testIms)
    fprintf('Elaborating %d / %d %s\n', i, length(testIms), testIms{i});
    
    % VOCopts.img
    im = imread([imagePath testIms{i}]);
    im = resize_image_max_size(im, fix_sz);
    idx = 1; idx2 = 1;
    for j=1:length(seg_params.ks)
        k = seg_params.ks(j); % Segmentation threshold k
        minSize = k; % We set minSize = k
        for n = 1:length(seg_params.colorTypes)
            colorType = seg_params.colorTypes{n};
            tic;
            [boxesT{idx} blobIndIm{idx} blobBoxes hierarchy priorityT{idx}]...
                    = Image2HierarchicalGrouping(im, seg_params.sigma, k, minSize, ...
                       colorType, seg_params.simFunctionHandles);
            totalTime = totalTime + toc;
            
            % Get blobs of initial segmentation
            segmentation = SegmentIndices2Blobs(blobIndIm{idx}, blobBoxes);
               
            if length(hierarchy)==1
                tree{idx} = ...
                    RecreateBlobHierarchyLevelsTree(segmentation, ...
                                                    hierarchy{1});
                hBlobs{idx} = RecreateBlobHierarchyIndIm(blobIndIm{idx}, ...
                                                blobBoxes, hierarchy{1});
                
            else
                for h = 1:length(hierarchy)
                    % recreate the tree to be saved
                    tree{idx2} = ...
                        RecreateBlobHierarchyLevelsTree(segmentation, ...
                                                        hierarchy{h});                
                                                    
                    hBlobs{idx2} = RecreateBlobHierarchyIndIm(blobIndIm{idx}, ...
                                            blobBoxes, hierarchy{h});
                                        
                    idx2 = idx2 + 1;
%                 % visualization
%                 subplot(5,5,1)
%                 imagesc(im), axis image
%                 [real_hier, hBlobs] = RecreateBlobHierarchyIndImLevels(blobIndIm{idx}, blobBoxes, hierarchy{h});
%                 % visualize if needed
%                 for l = 1:min(length(real_hier),24)
%                     subplot(5,5,l+1), imagesc(real_hier{l}, [0,max(real_hier{end}(:))]),
%                     axis image
%                 end
%                 pause;
%                 clf;
                end
            end
            
            idx = idx + 1;
        end
    end
   
    [a,remain] = strtok(testIms{i},'/');
    if isempty(remain)
        remain = a;
    else
        remain = remain(2:end);
    end
    save([savePath strtok(remain,'.') '.mat'],'blobIndIm','tree','hBlobs')
end

% output value
val = 1;

end
