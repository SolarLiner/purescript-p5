exports.arcImpl = (x) => (y) => (w) => (h) => (start) => (stop) => (mode) => (
  p5
) => p5.arc(x, y, w, h, start, stop, mode);
exports.lineImpl = (x1) => (y1) => (x2) => (y2) => (p5) =>
  p5.line(x1, y1, x2, y2);
