exports.createCanvas = (w) => (h) => (p5) => {
  p5.createCanvas(w, h);
};

exports.noCanvas = (p5) => p5.noCanvas();
exports.resizeCanvas = (w) => (h) => p5.noCanvas(w, h);
exports.background = (r) => (g) => (b) => (a) => (p5) =>
  p5.background(r, g, b, a);
exports.noStroke = (p5) => p5.noStroke();
exports.stroke = (r) => (g) => (b) => (a) => (p5) => p5.stroke(r, g, b, a);
exports.strokeWeight = (w) => (p5) => p5.strokeWeight(w);
exports.noFill = (p5) => p5.noFill();
exports.fill = (r) => (g) => (b) => (a) => (p5) => p5.fill(r, g, b, a);
exports.clear = (p5) => p5.clear();
