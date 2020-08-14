exports.fullscreen = (b) => (p5) => p5.fullscreen(b);
exports.isFullscreen = (p5) => p5.fullscreen();
exports.getFrameRate = (p5) => p5.frameRate();
exports.setFrameRate = (rate) => (p5) => p5.frameRate(rate);
