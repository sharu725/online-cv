// Animation is a PNG sprite sheet encoded in a base64 string.
const gooseSpriteBase64 = "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";

/**
 * CSS Filter to be applied to the loaded goose atlas
 *
 * Red  (#FF0000): invert(16%) sepia(99%) saturate(7451%) hue-rotate(8deg) brightness(103%) contrast(117%)
 * Green(#00FF00): invert(52%) sepia(47%) saturate(1999%) hue-rotate(79deg) brightness(115%) contrast(126%)
 * Blue (#0000FF): invert(8%) sepia(99%) saturate(7376%) hue-rotate(247deg) brightness(99%) contrast(144%)
 * To generate other filters using HEX @link https://codepen.io/sosuke/pen/Pjoqqp
 * To generate other filters using rgb() @link https://stackoverflow.com/a/43960991
 **/
const CSS_FILTER = "";
const CSS_TRANSFORM = "scale(1.2)"; // To double the size of the rendered image use 'scale(2.0)'

function styleGoose(goose) {
  goose = document.createElement("div");
  goose.style.position = "absolute";
  goose.style.backgroundImage = "url(\"data:image/png;base64," + gooseSpriteBase64 +"\")";
  goose.style.backgroundRepeat = "no-repeat";
  goose.style.filter = CSS_FILTER;
  goose.style.transform = CSS_TRANSFORM;
  goose.className = "gooseify";
  return goose;
}

// Drawing is manipulated by adjusting CSS properties of the base64 encoded PNG:
function draw(goose, spriteFrameCoordinates) {
  const [ spriteFrameX, spriteFrameY, spriteFrameWidth, spriteFrameHeight ] = spriteFrameCoordinates;
  goose.style.top = (goose.y - spriteFrameHeight) + "px";
  goose.style.left = goose.x + "px";
  goose.style.width = spriteFrameWidth + "px";
  goose.style.height = spriteFrameHeight + "px";
  goose.style.backgroundPosition = (-spriteFrameX) + "px " + (-spriteFrameY) + "px";
  return goose;
}

export { styleGoose, draw };
