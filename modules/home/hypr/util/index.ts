import { $, inspect } from "bun";

const shadow = new ShadowRealm();

const util = [
  {
    name: "eval",
    async exec() {
      const prompt = await tofi([], '--require-match=false --prompt="eval> "');
      if (!prompt) return;
      try {
        const res = await shadow.evaluate(prompt);
        let out = res;
        try {
          out = inspect(res);
        } catch {}
        copy(out);
      } catch (err) {
        let out = `${err}`;
        try {
          out = inspect(err);
        } catch {}
        copy(out);
      }
    },
  },
];

function tofi(choices: string[], arg = "") {
  return $`tofi ${{ raw: arg }} < ${new Response(choices.join("\n"))}`
    .text()
    .catch((err) => {
      console.error(err.stderr.toString());
      return null;
    })
    .then((e) => `${e?.match(/^(.*)\n?$/)?.[1]}`);
}
function toast(text = "", level = 1) {
  return $`hyprctl notify ${level} 2000 0 ${text}`.quiet().nothrow().text();
}
async function copy(text = "") {
  if (!(await tofi([text]))) return;
  await $`echo ${text} | wl-copy 2>/dev/null`
    .quiet()
    .text()
    .catch(() => toast("Cannot copy to clipboard", 0));
}

const choice =
  util.length == 1 ? util[0]?.name : await tofi(util.map((e) => e.name));
if (choice) {
  const func = util.find((e) => e.name == choice);
  if (!func) toast(`[util] Function "${choice}" not found`, 0);
  else func.exec();
}
