// Coordinates describing each keyframe of the animation within the sprite sheet

// [ w, h ]
let restingSpriteSize = [ 30, 28 ];
let runningSpriteSize = [ 32, 19 ];
let preFlightSize = [ 26, 27 ];
let flyingSize = [ 26, 27 ];

// [x, y, w, h]
const gooseSpriteCoordinates = [
  // Stationary
  [ 0, 0 ].concat(restingSpriteSize),
  [ 30, 0 ].concat(restingSpriteSize),
  [ 60, 0 ].concat(restingSpriteSize),
  [ 90, 0 ].concat(restingSpriteSize),
  [ 120, 0 ].concat(restingSpriteSize),
  [ 150, 0 ].concat(restingSpriteSize),
  // Running
  [ 0, 28 ].concat(runningSpriteSize),
  [ 32, 28 ].concat(runningSpriteSize),
  [ 64, 28 ].concat(runningSpriteSize),
  [ 96, 28 ].concat(runningSpriteSize),
  [ 0, 47 ].concat(runningSpriteSize),
  [ 32,  47 ].concat(runningSpriteSize),
  [ 64,  47 ].concat(runningSpriteSize),
  [ 96, 47 ].concat(runningSpriteSize),
  // Pre-Flight
  [ 0, 66].concat(preFlightSize),
  [ 26, 66].concat(preFlightSize),
  [ 52, 66].concat(preFlightSize),
  [ 78, 66].concat(preFlightSize),
  // Flying
  [ 0,  93 ].concat(flyingSize),
  [ 26, 93 ].concat(flyingSize),
  [ 52, 93 ].concat(flyingSize),
  [ 78, 93 ].concat(flyingSize),
  [ 0, 120 ].concat(flyingSize),
  [ 26, 120 ].concat(flyingSize),
  [ 52, 120 ].concat(flyingSize),
  [ 78, 120 ].concat(flyingSize)
];

const zeroIndexOffset = 1;
const stationaryFrameCount = 6;
const runDirectionFrameCount = 4;
const preFlightFrameCount = 2;
const flyDirectionFrameCount = 4;

const stationarySpriteIndexes = range(0, stationaryFrameCount - zeroIndexOffset);

const runLeft = range(6, runDirectionFrameCount - zeroIndexOffset);
const runRight = range(10, runDirectionFrameCount - zeroIndexOffset);
const runningSpriteIndexes = [ runLeft, runRight];

const preFlightRight = range(14, preFlightFrameCount - zeroIndexOffset);
const preFlightLeft = range(16, preFlightFrameCount - zeroIndexOffset);

const flyRight = range(18, flyDirectionFrameCount - zeroIndexOffset);
const flyLeft = range(22, flyDirectionFrameCount - zeroIndexOffset);

const descendSpriteIndexes = [ flyRight, flyLeft ];
const ascendSpriteIndexes = [ preFlightRight.concat(flyRight), preFlightLeft.concat(flyLeft) ];

// Provides an array of numbers ranging from baseIndex -> (baseIndex + rangeLength)
// TODO: Add a spec for this function.
function range(baseIndex, rangeLength){
  if(rangeLength <= baseIndex) {
    rangeLength = baseIndex + rangeLength;
  }
  return [...Array(rangeLength - baseIndex + 1).keys()].map(x => x + baseIndex);
}

export {
  gooseSpriteCoordinates,
  stationarySpriteIndexes,
  runningSpriteIndexes,
  ascendSpriteIndexes,
  descendSpriteIndexes
};
