function ploteazaDrumVertical(img,E,drum,culoareDrum)
%ploteaza drumul vertical in imagine
%
%input: img - imaginea initiala
%       E - energia la fiecare pixel calculata pe baza gradientului
%       drum - drumul ce leaga sus de jos
%       culoareDrum  - specifica culoarea cu care se vor plota pixelii din drum. Valori posibile:
%                    [r b g]' - triplete RGB (e.g [255 0 0]' - rosu)          

imgDrum = img;
for i = 1:size(drum,1)
    imgDrum(drum(i,1),drum(i,2),:) = uint8(culoareDrum);
end

figure,
subplot(1,2,1); imshow(imgDrum);

if(E ~= -1)
subplot(1,2,2); imshow(E,[]);