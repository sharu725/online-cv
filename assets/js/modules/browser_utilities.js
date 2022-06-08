function allTextNodes(element, cb) {
  if(element.childNodes.length > 0)
    for(let i = 0; i < element.childNodes.length; i++)
      allTextNodes(element.childNodes[i], cb);

  if(element.nodeType == Node.TEXT_NODE && /\S/.test(element.nodeValue))
    cb(element);
}

function collidesWithDOM(gooseRect, DOMObjectsDimensions, moveSpeed) {
  for (const DOMObjectDimensions of DOMObjectsDimensions) {
    if(gooseRect.top + gooseRect.height < DOMObjectDimensions.top)
      continue;
    if(gooseRect.top + gooseRect.height > DOMObjectDimensions.top + moveSpeed)
      continue;
    if(DOMObjectDimensions.left > gooseRect.left + gooseRect.width)
      continue;
    if(DOMObjectDimensions.left + DOMObjectDimensions.width < gooseRect.left)
      continue;
    return true;
  }
  return false;
}

function documentSize() {
  return [
    document.documentElement.clientWidth,
    document.documentElement.clientHeight
  ];
}

function getKey(ev) {
  ev = ev ? ev : this.event;
  return ev.keyCode ? ev.keyCode : ev.which;
}

// TODO: There is a bug where if one presses a key and changes the focus out of the browser
// the key is stickied "down". Meaning we get caught in a loop of key presses.
function hasFocus(goose) {
  if (!document.hasFocus() || !goose) {
    return false;
  } else {
    return true;
  }
}

function listenerAdd(el, ev, cb) {
  if (el.addEventListener)
    el.addEventListener(ev, cb, false);
  else
    el.attachEvent("on" + ev, cb);
}

function initDOMObjectsDimensions() {
  let DOMObjectsDimensions = [];
  allTextNodes(document.body, function(e) {
    let range = document.createRange();
    range.selectNodeContents(e);
    let rects = range.getClientRects();

    for (const rect of rects) {
      DOMObjectsDimensions.push({
        top: rect.top + windowScroll()[1],
        left: rect.left,
        width: rect.width,
        height: rect.height
      });
    }
  });
  return DOMObjectsDimensions;
}

function initBounds() {
  let bounds = documentSize();
  let windowHeight = windowSize()[1];
  if(bounds[1] < windowHeight) {
    bounds[1] = windowHeight;
  }
  return {
    width: bounds[0],
    height: bounds[1]
  };
}

function windowScroll() {
  let x = 0;
  let y = 0;

  if (self.pageYOffset) {
    x = self.pageXOffset;
    y = self.pageYOffset;
  } else if (document.documentElement && document.documentElement.scrollTop) {
    x = document.documentElement.scrollLeft;
    y = document.documentElement.scrollTop;
  } else if (document.body) {
    x = document.body.scrollLeft;
    y = document.body.scrollTop;
  }

  return [x, y];
}

function windowSize() {
  let wx, wy;
  if (window.innerWidth) {
    wx = window.innerWidth;
    wy = window.innerHeight;
  }
  if (!wx && document.documentElement) {
    wx = document.documentElement.clientWidth;
    wy = document.documentElement.clientHeight;
  }
  if (!wx) {
    let body = document.body || document.getElementsByTagName("body")[0];
    if (body) {
      if (body.clientWidth) {
        wx = body.clientWidth;
        wy = body.clientHeight;
      } else if (body.offsetWidth) {
        wx = body.offsetWidth;
        wy = body.offsetHeight;
      }
    }
  }

  return [wx, wy];
}

export {
  collidesWithDOM,
  getKey,
  hasFocus,
  initBounds,
  initDOMObjectsDimensions,
  listenerAdd
};
