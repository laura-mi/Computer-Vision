function params = calculeazaDimensiuniMozaic(params)
%calculeaza dimensiunile mozaicului
%obtine imaginea de referinta redimensionata avand aceleasi dimensiuni ca mozaicul

%==================================================
initial_height = size(params.imgReferinta, 1);
initial_width = size(params.imgReferinta, 2);
W = params.dimensiuneImagini(2);
H = params.dimensiuneImagini(1);

ratio = initial_width / initial_height;
final_width = int32(params.numarPieseMozaicOrizontala * W);
params.numarPieseMozaicVerticala = int32((final_width / ratio) / H);
final_height = params.numarPieseMozaicVerticala * H;

params.imgReferintaRedimensionata = imresize(params.imgReferinta, [final_height, final_width]);
%==================================================