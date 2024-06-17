function(conf) if std.objectHas(conf, 'keymap') then [
  {
    type: 'org.osbuild.keymap',
    options: {
      keymap: conf.keymap,
      'x11-keymap': {
        layouts: [
          conf.keymap,
        ],
      },
    },
  },
] else []
