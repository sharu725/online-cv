function initialGooseXPosition(x_bounds_width) {
  let elem = document.querySelector("#goose-landing-zone");
  let rect = elem.getBoundingClientRect();
  return rect.left - 7;
}

function determineDirection(x, oldX) {
  return (x > oldX) ? 0 : 1;
}

function handleXOutOfBounds(x, spriteFrameW, boundsWidth) {
  if(x < 0) {
    x = 0;
  } else if(x + spriteFrameW > boundsWidth){
    x = boundsWidth - spriteFrameW;
  }
  return x;
}

function leftArrowTransform(x, moveSpeed, spriteFrameW, boundsWidth) {
  return handleXOutOfBounds(x - moveSpeed, spriteFrameW, boundsWidth);
}

function rightArrowTransform(x, moveSpeed, spriteFrameW, boundsWidth) {
  return handleXOutOfBounds(x + moveSpeed, spriteFrameW, boundsWidth);
}

function downArrowTransform(y, moveSpeed) { return y + moveSpeed; }

function upArrowTransform(ascend, jumpHeight) {
  ascend.height = jumpHeight;
  ascend.spriteIndex = -1;
  return ascend;
}

function randomizeStationaryAnimation(step, stationarystep) {
  const stationaryPauseLength = 20;

  // Random jumps between the stationary goose frames. Uses stationaryStep as a timer.
  if(stationarystep <= 0) {
    stationarystep = Math.floor(Math.random() * stationaryPauseLength) + stationaryPauseLength;
    step = Math.floor(Math.random() * 100000);
  } else {
    stationarystep--;
  }
  return [ step, stationarystep ];
}

function nextStationarySpriteIndex(stationarySpriteIndexes, step) {
  const stationaryAnimationFrameCount = stationarySpriteIndexes.length;
  return step % stationaryAnimationFrameCount;
}

function nextAscendSpriteIndex(directionalascendSpriteIndexes, step) {
  const directionalAscendAnimationFrameCount = directionalascendSpriteIndexes.length;
  return directionalascendSpriteIndexes[step % directionalAscendAnimationFrameCount];
}

function nextDescendSpriteIndex(directionaldescendSpriteIndexes, step) {
  const descendAnimationFrameCount = directionaldescendSpriteIndexes.length;
  return directionaldescendSpriteIndexes[step % descendAnimationFrameCount];
}

function nextRunningSpriteIndex(directionalrunningSpriteIndexes, step) {
  const stepsPerFrame = 2;

  const runningAnimationFrameCount = directionalrunningSpriteIndexes.length;
  return directionalrunningSpriteIndexes[Math.floor(step / stepsPerFrame) % runningAnimationFrameCount];
}

function ascendGooseY(goose, ascendHeight, boundsHeight, spriteFrameH) {
  goose.y = goose.y - ascendHeight;
  goose.y = handleYOutOfBounds(goose.y, boundsHeight, spriteFrameH);
  return goose.y;
}

function handleYOutOfBounds(y, boundsHeight, spriteFrameH) {
  if(y + 1 > boundsHeight) {
    y = boundsHeight - 1;
  } else if(y - spriteFrameH < 0) {
    y = spriteFrameH;
  }
  return y;
}

export {
  initialGooseXPosition,
  determineDirection,
  leftArrowTransform,
  rightArrowTransform,
  downArrowTransform,
  upArrowTransform,
  ascendGooseY,
  randomizeStationaryAnimation,
  nextStationarySpriteIndex,
  nextAscendSpriteIndex,
  nextDescendSpriteIndex,
  nextRunningSpriteIndex,
  handleXOutOfBounds
};
