import {
  ifApp,
  ifVar,
  letterKeyCodes,
  map,
  numberKeyCodes,
  rule,
  toSetVar,
  withMapper,
  type RuleBuilder,
} from "karabiner.ts";
import * as fs from "node:fs";
import * as path from "node:path";

// ────────────────────────────────────────────────────────────
// Shared Constants
// ────────────────────────────────────────────────────────────

const TERMINAL_APPS = [
  "^com\\.apple\\.Terminal$",
  "^net\\.kovidgoyal\\.kitty$",
  "^com\\.mitchellh\\.ghostty$",
];
const IDE_APPS = [
  "^com\\.microsoft\\.VSCode$",
  "^com\\.google\\.antigravity$",
];

const inTerminal = ifApp(TERMINAL_APPS);
const inTerminalOrIDE = ifApp([...TERMINAL_APPS, ...IDE_APPS]);

const HYPER_KEYS = [
  ...letterKeyCodes,
  "open_bracket",
  "close_bracket",
] as any[];

// ────────────────────────────────────────────────────────────
// Custom 1: Misc
// ────────────────────────────────────────────────────────────

// caps_lock → left_control (in terminal apps), alone → caps_lock, held → caps_lock
function capsLockToControl(): RuleBuilder {
  return rule("Change caps_lock to control", inTerminalOrIDE).manipulators([
    map("caps_lock", { optional: ["shift"] })
      .to("left_control")
      .toIfAlone("caps_lock")
      .toIfHeldDown({
        key_code: "caps_lock",
        hold_down_milliseconds: 100,
      })
      .parameters({
        "basic.to_if_alone_timeout_milliseconds": 250,
        "basic.to_if_held_down_threshold_milliseconds": 250,
      }),
  ]);
}

// left_option alone → escape
function escapeOnOptionL(): RuleBuilder {
  return rule("Post Escape if Option_L is pressed alone").manipulators([
    map("left_option", { optional: "any" })
      .to("left_option")
      .toIfAlone("escape")
      .parameters({ "basic.to_if_alone_timeout_milliseconds": 250 }),
  ]);
}

// left_shift alone → escape
function escapeOnShiftL(): RuleBuilder {
  return rule("Post Escape if Shift_L is pressed alone").manipulators([
    map("left_shift", { optional: "any" })
      .to("left_shift")
      .toIfAlone("escape")
      .parameters({ "basic.to_if_alone_timeout_milliseconds": 250 }),
  ]);
}

// right_shift alone → escape
function escapeOnShiftR(): RuleBuilder {
  return rule("Post Escape if Shift_R is pressed alone").manipulators([
    map("right_shift", { optional: "any" })
      .to("right_shift")
      .toIfAlone("escape")
      .parameters({ "basic.to_if_alone_timeout_milliseconds": 250 }),
  ]);
}

// right_option + arrows → PageUp, PageDown, Home, End
function optionRArrows(): RuleBuilder {
  return rule("Option_R + arrow to PageUp, PageDown, Home, End").manipulators([
    map("up_arrow", "right_option").to("page_up"),
    map("down_arrow", "right_option").to("page_down"),
    map("left_arrow", "right_option").to("home"),
    map("right_arrow", "right_option").to("end"),
  ]);
}

// shift + del → forward delete
function shiftForwardDelete(): RuleBuilder {
  return rule("Change [shift + del] to forward delete").manipulators([
    map("delete_or_backspace", "shift").to("delete_forward"),
  ]);
}

// option + del → forward delete
function optionForwardDelete(): RuleBuilder {
  return rule("Change [opt + del] to forward delete").manipulators([
    map("delete_or_backspace", "option").to("delete_forward"),
  ]);
}

// caps_lock remap for Moonlight streaming
function capsLockMoonlight(): RuleBuilder {
  const inMoonlight = ifApp("^com\\.moonlight-stream\\.Moonlight$");
  return rule(
    "Change caps_lock: single click to shift, hold to caps_lock, combined with other keys to ctrl (Moonlight only)",
    inMoonlight,
  ).manipulators([
    map("caps_lock")
      .to("left_control")
      .toIfAlone("left_shift")
      .toIfHeldDown({
        key_code: "caps_lock",
        hold_down_milliseconds: 100,
      })
      .parameters({
        "basic.to_if_alone_timeout_milliseconds": 250,
        "basic.to_if_held_down_threshold_milliseconds": 250,
      }),
  ]);
}

// ────────────────────────────────────────────────────────────
// Custom 2: Hyper Key — 3 mutually exclusive variants
//   Trigger key + letter → Cmd+Opt+Ctrl+Shift + letter
// ────────────────────────────────────────────────────────────

function hyperKeyFn(): RuleBuilder {
  return rule(
    "Change Fn + letter to 'cmd + opt + ctrl + shift' + letter",
  ).manipulators([withMapper(HYPER_KEYS)((k) => map(k, "fn").to(k, "Hyper"))]);
}

function hyperKeyOptionR(): RuleBuilder {
  return rule(
    "Change Option_R + letter to 'cmd + opt + ctrl + shift' + letter",
  ).manipulators([
    withMapper(HYPER_KEYS)((k) => map(k, "right_option").to(k, "Hyper")),
  ]);
}

function hyperKeyControlR(): RuleBuilder {
  return rule(
    "Change Control_R + letter to 'cmd + opt + ctrl + shift' + letter",
  ).manipulators([
    withMapper(HYPER_KEYS)((k) => map(k, "right_control").to(k, "Hyper")),
  ]);
}

// ────────────────────────────────────────────────────────────
// Custom 3: Tmux Prefix Mode
//   Trigger sets tmux_prefix_mode, then keys send Ctrl+A + key
// ────────────────────────────────────────────────────────────

function tmuxPrefixTab(): RuleBuilder {
  return rule("Tmux Prefix Mode [Tab as trigger key]", inTerminal).manipulators(
    [
      map("tab", { optional: ["caps_lock", "shift"] })
        .toVar("tmux_prefix_mode", 1)
        .toIfAlone("tab")
        .toAfterKeyUp(toSetVar("tmux_prefix_mode", 0)),
    ],
  );
}

function tmuxPrefixCapsLock(): RuleBuilder {
  return rule(
    "Tmux Prefix Mode [caps_lock as trigger key]",
    inTerminal,
  ).manipulators([
    map("caps_lock", { optional: ["shift"] })
      .toVar("tmux_prefix_mode", 1)
      .toIfAlone("caps_lock")
      .toIfHeldDown({
        key_code: "caps_lock",
        hold_down_milliseconds: 100,
      })
      .toAfterKeyUp(toSetVar("tmux_prefix_mode", 0))
      .parameters({
        "basic.to_if_alone_timeout_milliseconds": 250,
        "basic.to_if_held_down_threshold_milliseconds": 250,
      }),
  ]);
}

function tmuxPrefixMappings(): RuleBuilder {
  const TMUX_KEYS = [
    ...letterKeyCodes,
    ...numberKeyCodes,
    "comma",
    "period",
    "slash",
    "semicolon",
    "quote",
    "open_bracket",
    "close_bracket",
    "spacebar",
  ] as any[];

  return rule(
    "Tmux Prefix Mode [ctrl+A as prefix]",
    ifVar("tmux_prefix_mode"),
  ).manipulators([
    withMapper(TMUX_KEYS)((k) =>
      map(k, { optional: ["shift"] })
        .to("a", "left_control")
        .to(k),
    ),
  ]);
}

// ────────────────────────────────────────────────────────────
// Custom 4: Navigation in Terminal Apps (emacs mode)
//   macOS-style shortcuts → shell/readline equivalents
// ────────────────────────────────────────────────────────────

function terminalNavigation(): RuleBuilder[] {
  return [
    // Cmd+← → Ctrl+A (line begin)
    rule("Cmd + Left | Move cursor to line begin", inTerminal).manipulators([
      map("left_arrow", "command").to("a", "left_control"),
    ]),
    // Cmd+→ → Ctrl+E (line end)
    rule("Cmd + Right | Move cursor to line end", inTerminal).manipulators([
      map("right_arrow", "command").to("e", "left_control"),
    ]),
    // Opt+← → Esc,b (word back)
    rule("Opt + Left | Move cursor one word behind", inTerminal).manipulators([
      map("left_arrow", "option").to("escape").to("b"),
    ]),
    // Opt+→ → Esc,f (word forward)
    rule("Opt + Right | Move cursor one word ahead", inTerminal).manipulators([
      map("right_arrow", "option").to("escape").to("f"),
    ]),
    // Opt+Del → Ctrl+W (delete word)
    rule("Opt + Del | Delete one word", inTerminal).manipulators([
      map("delete_or_backspace", "option").to("w", "left_control"),
    ]),
    // Opt+Fn+Del → Esc,d (delete word ahead)
    rule("Opt + Fn+Del | Delete one word ahead", inTerminal).manipulators([
      map("delete_or_backspace", ["option", "fn"]).to("escape").to("d"),
    ]),
    // Cmd+Del → Ctrl+U (delete to line begin)
    rule("Cmd + Del | Delete to line begin", inTerminal).manipulators([
      map("delete_or_backspace", "command").to("u", "left_control"),
    ]),
    // Cmd+Fn+Del → Ctrl+K (delete to line end)
    rule("Cmd + Fn+Del | Delete to line end", inTerminal).manipulators([
      map("delete_or_backspace", ["command", "fn"]).to("k", "left_control"),
    ]),
  ];
}

// ────────────────────────────────────────────────────────────
// Output: Write to complex_modifications JSON files
// ────────────────────────────────────────────────────────────

function buildRules(rules: RuleBuilder[]) {
  return rules.map((r) => r.build());
}

function writeComplexModification(
  filename: string,
  title: string,
  rules: RuleBuilder[],
) {
  const outputDir = path.resolve(__dirname, "../assets/complex_modifications");
  const outputPath = path.join(outputDir, filename);
  const json = {
    title,
    rules: buildRules(rules),
  };
  fs.mkdirSync(outputDir, { recursive: true });
  fs.writeFileSync(outputPath, JSON.stringify(json, null, 2) + "\n");
  console.log(`✅ Written ${outputPath}`);
}

// ── Build ──

writeComplexModification("custom_1.json", "Custom 1: Misc", [
  capsLockToControl(),
  escapeOnOptionL(),
  escapeOnShiftL(),
  escapeOnShiftR(),
  optionRArrows(),
  shiftForwardDelete(),
  optionForwardDelete(),
  capsLockMoonlight(),
]);

writeComplexModification(
  "custom_2.json",
  "Custom 2: Hyper key 'cmd + opt + ctrl + shift'",
  [
    hyperKeyFn(),
    hyperKeyOptionR(),
    hyperKeyControlR(),
  ],
);

writeComplexModification("custom_3.json", "Custom 3: Tmux", [
  tmuxPrefixTab(),
  tmuxPrefixCapsLock(),
  tmuxPrefixMappings(),
]);

writeComplexModification(
  "custom_4.json",
  "Custom 4: Navigation in Terminal Apps (emacs mode)",
  [...terminalNavigation()],
);
