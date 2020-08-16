exports.arcImpl = (x) => (y) => (w) => (h) => (start) => (stop) => (mode) => (
  p5
) => p5.arc(x, y, w, h, start, stop, mode);
exports.lineImpl = (x1) => (y1) => (x2) => (y2) => (p5) =>
  p5.line(x1, y1, x2, y2);
exports.ellipseImpl = (x) => (y) => (w) => (h) => (p5) =>
  p5.ellipse(x, y, w, h);
exports.circleImpl = (x) => (y) => (r) => (p5) => p5.circle(x, y, r);
exports.quadImpl = (x1) => (y1) => (x2) => (y2) => (x3) => (y3) => (x4) => (
  y4
) => (p5) => p5.quad(x1, y1, x2, y2, x3, y3, x4, y4);
exports.triangleImpl = (x1) => (y1) => (x2) => (y2) => (x3) => (y3) => (p5) =>
  p5.triangle(x1, y1, x2, y2, x3, y3);
exports.squareImpl = (x) => (y) => (s) => (p5) => p5.square(x, y, s);
exports.squareRoundedImpl = (x) => (y) => (s) => (rtl) => (rtr) => (rbr) => (
  rbl
) => (p5) => p5.square(x, y, s, rtl, rtr, rbr, rbl);
exports.rectImpl = (x) => (y) => (w) => (h) => (p5) => p5.rect(x, y, w, h);
exports.rectRoundedImpl = (x) => (y) => (w) => (h) => (rtl) => (rtr) => (
  rbr
) => (rbl) => p5.rect(x, y, w, h, rtl, rtr, rbr, rbl);
exports.pointImpl = (x) => (y) => p5.point(x, y);
