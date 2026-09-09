const bucketize = (value) =>
  Math.min(255, Math.max(0, Math.round(value / 24) * 24));

const dominantColorFromImage = (image) => {
  const canvas = document.createElement("canvas");
  const context = canvas.getContext("2d", { willReadFrequently: true });
  if (!context) return null;

  const size = 24;
  canvas.width = size;
  canvas.height = size;
  context.drawImage(image, 0, 0, size, size);

  const { data } = context.getImageData(0, 0, size, size);
  const counts = new Map();

  for (let i = 0; i < data.length; i += 4) {
    const alpha = data[i + 3];
    if (alpha < 128) continue;

    const red = data[i];
    const green = data[i + 1];
    const blue = data[i + 2];

    if (red + green + blue < 45) continue;

    const key = [bucketize(red), bucketize(green), bucketize(blue)].join(",");
    counts.set(key, (counts.get(key) || 0) + 1);
  }

  if (counts.size === 0) return null;

  const [rgb] = [...counts.entries()].sort((a, b) => b[1] - a[1])[0];
  return `rgb(${rgb})`;
};

const applyAvatarBorder = (image) => {
  const color = dominantColorFromImage(image);
  if (color) image.style.borderColor = color;
};

const setupAvatarBorders = () => {
  document
    .querySelectorAll("img[data-dominant-avatar='true']")
    .forEach((image) => {
      if (image.complete && image.naturalWidth > 0) {
        applyAvatarBorder(image);
      } else {
        image.addEventListener("load", () => applyAvatarBorder(image), {
          once: true,
        });
      }
    });
};

document.addEventListener("turbo:load", setupAvatarBorders);
document.addEventListener("DOMContentLoaded", setupAvatarBorders);
