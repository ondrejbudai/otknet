function(conf) [
  {
    type: 'org.osbuild.kernel-cmdline',
    options: {
      root_fs_uuid: conf.disk_setup.const.partition_map.root.uuid,
      kernel_opts: std.join(' ', conf.kernel_opts),
    },
  },
]
