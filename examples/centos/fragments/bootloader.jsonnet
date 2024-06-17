function(conf)
  if conf.bootloader.type == 'grub2' then [
    {
      type: 'org.osbuild.grub2',
      options: {
        root_fs_uuid: conf.disk_setup.const.partition_map.root.uuid, // TODO!
        // boot_fs_uuid: '83058295-e028-41cf-9468-932e682f586b', // TODO!
        kernel_opts: std.join(' ', conf.kernel_opts),
        [if std.objectHas(conf.bootloader, "legacy") then "legacy"]: conf.bootloader.legacy,
        [if std.objectHas(conf.bootloader, "uefi") then "uefi"]: conf.bootloader.uefi,
        saved_entry: 'ffffffffffffffffffffffffffffffff-0-0.noarch', // TODO!
        write_cmdline: false, // TODO!
        config: {
          default: 'saved', // TODO!
        },
      },
    },

  ] else error 'unsupported bootloader type'
