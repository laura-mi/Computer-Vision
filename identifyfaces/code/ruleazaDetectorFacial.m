function [detectii, scoruriDetectii, imageIdx] = ruleazaDetectorFacial(parametri)
% 'detectii' = matrice Nx4, unde 
%           N este numarul de detectii  
%           detectii(i,:) = [x_min, y_min, x_max, y_max]
% 'scoruriDetectii' = matrice Nx1. scoruriDetectii(i) este scorul detectiei i
% 'imageIdx' = tablou de celule Nx1. imageIdx{i} este imaginea in care apare detectia i
%               (nu punem intregul path, ci doar numele imaginii: 'albert.jpg')

% Aceasta functie returneaza toate detectiile ( = ferestre) pentru toate imaginile din parametri.numeDirectorExempleTest
% Directorul cu numele parametri.numeDirectorExempleTest contine imagini ce
% pot sau nu contine fete. Aceasta functie ar trebui sa detecteze fete atat pe setul de
% date MIT+CMU dar si pentru alte imagini (imaginile realizate cu voi la curs+laborator).
% Functia 'suprimeazaNonMaximele' suprimeaza detectii care se suprapun (protocolul de evaluare considera o detectie duplicata ca fiind falsa)
% Suprimarea non-maximelor se realizeaza pe pentru fiecare imagine.

% Functia voastra ar trebui sa calculeze pentru fiecare imagine
% descriptorul HOG asociat. Apoi glisati o fereastra de dimeniune paremtri.dimensiuneFereastra x  paremtri.dimensiuneFereastra (implicit 36x36)
% si folositi clasificatorul liniar (w,b) invatat poentru a obtine un scor. Daca acest scor este deasupra unui prag (threshold) pastrati detectia
% iar apoi mporcesati toate detectiile prin suprimarea non maximelor.
% pentru detectarea fetelor de diverse marimi folosit un detector multiscale

imgFiles = dir( fullfile( parametri.numeDirectorExempleTest, '*.jpg' ));
%initializare variabile de returnat
detectii = zeros(0,4);
scoruriDetectii = zeros(0,1);
imageIdx = cell(0,1);

%====================================================
%initialize used variables
w = parametri.w;
b = parametri.b;
scales = [1, 0.85, 0.75, 0.65, 0.55, 0.35, 0.20, 0.15, 0.1, 0.05];
hogcellsize = parametri.dimensiuneCelulaHOG;
dimension = parametri.dimensiuneFereastra/ hogcellsize;
full_dimension  = dimension ^ 2 * 31;
%====================================================


for i = 1:length(imgFiles)      
    fprintf('Rulam detectorul facial pe imaginea %s\n', imgFiles(i).name)
    img = imread(fullfile( parametri.numeDirectorExempleTest, imgFiles(i).name ));    
	 img = single(img)/255;
    if(size(img,3) > 1)
        img = rgb2gray(img);
    end    
    
	%====================================================
	
	detectii_curente = zeros(0, 4);
	imagini_curente = cell(0, 1);
	scor_curent = zeros(0, 1);
	total_scales = length(scales);
	
	%====================================================
	
	for j=1:total_scales  %take patches from images at different scales
			scale = scales(j);
	        resized = (imresize(img, scale));
	        [h1, w1] = size(resized);

	        hog_features = vl_hog(resized, hogcellsize);
	        patch_x = floor(w1 / hogcellsize) - dimension + 1;
	        patch_y =  floor(h1 / hogcellsize) - dimension + 1;

	        patch_features = zeros(patch_x * patch_y, full_dimension);

	        for x = 1:patch_x
	            for y = 1:patch_y
	                patch_features((x - 1) * patch_y + y, :) = reshape(hog_features(y : (y + dimension - 1), x : (x + dimension - 1), :), 1, full_dimension);
	            end
	        end
			
	        local_score = patch_features * w + b;
	        right_scored_indices = find(local_score > parametri.threshold);
	        selected_scores = local_score(right_scored_indices);
			
	        xs = floor(right_scored_indices ./ patch_y);
	        ys = mod(right_scored_indices, patch_y) - 1;
			
	        selected_detections = [hogcellsize * xs + 1, hogcellsize * ys + 1, hogcellsize * (xs + dimension), hogcellsize * (ys + dimension)] ./ scale;
	        selected_img = repmat({imgFiles(i).name}, size(right_scored_indices, 1), 1);
			
	        detectii_curente      = [detectii_curente;      selected_detections];
	        scor_curent = [scor_curent; selected_scores];
	        imagini_curente   = [imagini_curente;   selected_img];
	end
	
	%====================================================
	
	%filter detection in order to get rid of wrongly detected faces
	[selected_maximum] = eliminaNonMaximele(detectii_curente, scor_curent, size(img));

	scor_curent = scor_curent(selected_maximum,:);
	detectii_curente      = detectii_curente(selected_maximum,:);
	imagini_curente   = imagini_curente(selected_maximum,:);
	
	%====================================================
	
	detectii      = [detectii;      detectii_curente];
	scoruriDetectii = [scoruriDetectii; scor_curent];
	imageIdx   = [imageIdx;   imagini_curente];
	
end




