function imgMozaic = construiesteMozaic(params)

%incarca toate imaginile mici folosite pentru mozaic
params = incarcaPieseMozaic(params);

%calculeaza noile dimensiuni ale mozaicului
params = calculeazaDimensiuniMozaic(params);

%adauga piese mozaic
switch params.modAranjare
    case 'caroiaj'
        imgMozaic = adaugaPieseMozaicPeCaroiaj(params);
    case 'aleator'
        imgMozaic = adaugaPieseMozaicModAleator(params);
end