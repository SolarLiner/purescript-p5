const P5 = require("p5");

exports.runP5Impl = (runner) => {
  new P5((p) => {
    /* const pp = new Proxy(p, {
      get: (t, p) => {
        console.log(`Get p5.${p}`);
        return t[p];
      },
      set: (t, p, v) => {
        console.log(`Set p5.${p} =`, v);
        t[p] = v;
      },
    }); */
    runner(p)();
  });
};
exports.addFn = (name) => (runner) => (p5) => () => {
  p5[name] = runner(p5);
};
exports.getValue = (name) => (p5) => p5[name];
exports.setValue = (name) => (value) => (p5) => (p5[name] = value);
