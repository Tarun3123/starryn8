clc;
clear all;
close all;

img = imread('starrynight.jpg');
img = double(img);

avg_kernel = ones(5, 5) / 25;
smoothed_img = zeros(size(img));

for channel = 1:3
    smoothed_img(:,:,channel) = conv2(img(:,:,channel), avg_kernel, 'same');
end
smoothed_img = uint8(smoothed_img);
subplot(2,2,1);
imshow(smoothed_img);
title('Smoothed Image');

psnr_smoothed = psnr(smoothed_img, uint8(img));
ssim_smoothed = ssim(smoothed_img, uint8(img));
disp(['PSNR (smoothed): ', num2str(psnr_smoothed)]);
disp(['SSIM (smoothed): ', num2str(ssim_smoothed)]);

lap_kernel = [0 -1 0; -1 5 -1; 0 -1 0];
sharpened_img = zeros(size(img));

for channel = 1:3
    sharpened_img(:,:,channel) = conv2(img(:,:,channel), lap_kernel, 'same');
end
sharpened_img = uint8(sharpened_img);
subplot(2,2,2);
imshow(sharpened_img);
title('Sharpened Image');

psnr_sharpened = psnr(sharpened_img, uint8(img));
ssim_sharpened = ssim(sharpened_img, uint8(img));
disp(['PSNR (sharpened): ', num2str(psnr_sharpened)]);
disp(['SSIM (sharpened): ', num2str(ssim_sharpened)]);

sharpened_after_smoothing = zeros(size(smoothed_img));

for channel = 1:3
    sharpened_after_smoothing(:,:,channel) = conv2(smoothed_img(:,:,channel), lap_kernel, 'same');
end
sharpened_after_smoothing = uint8(sharpened_after_smoothing);
subplot(2,2,3);
imshow(sharpened_after_smoothing);
title('Sharpened After Smoothing');

psnr_smooth_sharpen = psnr(sharpened_after_smoothing, smoothed_img);
ssim_smooth_sharpen = ssim(sharpened_after_smoothing, smoothed_img);
disp(['PSNR (sharpened after smoothing): ', num2str(psnr_smooth_sharpen)]);
disp(['SSIM (sharpened after smoothing): ', num2str(ssim_smooth_sharpen)]);

smoothed_after_sharpening = zeros(size(sharpened_img));

for channel = 1:3
    smoothed_after_sharpening(:,:,channel) = conv2(sharpened_img(:,:,channel), avg_kernel, 'same');
end
smoothed_after_sharpening = uint8(smoothed_after_sharpening);
subplot(2,2,4);
imshow(smoothed_after_sharpening);
title('Smoothed After Sharpening');

psnr_sharpen_smooth = psnr(smoothed_after_sharpening, sharpened_img);
ssim_sharpen_smooth = ssim(smoothed_after_sharpening, sharpened_img);
disp(['PSNR (smoothed after sharpening): ', num2str(psnr_sharpen_smooth)]);
disp(['SSIM (smoothed after sharpening): ', num2str(ssim_sharpen_smooth)]);
