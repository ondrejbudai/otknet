function(conf) [{
  name: 'os',
  build: 'name:build',
  stages: (import '../fragments/kernel-cmdline.jsonnet')(conf)
          + conf.deps.stages.os
          + (import '../fragments/fix-bls.jsonnet')(conf)
          + (import '../fragments/locale.jsonnet')(conf)
          + (import '../fragments/keymap.jsonnet')(conf)
          + (import '../fragments/timezone.jsonnet')(conf)
          + (import '../fragments/chrony.jsonnet')(conf)
          + (import '../fragments/sysconfig.jsonnet')(conf)
          + (import '../fragments/systemd-logind.jsonnet')(conf)
          + (import '../fragments/cloud-init.jsonnet')(conf)
          + (import '../fragments/modprobe.jsonnet')(conf)
          + (import '../fragments/dracut.conf.jsonnet')(conf)
          + (import '../fragments/systemd.unit.jsonnet')(conf)
          + (import '../fragments/authselect.jsonnet')(conf)
          + (import '../fragments/sshd.config.jsonnet')(conf)
          + [
            {
              type: 'org.osbuild.fstab',
              options: {
                filesystems: [  // 100% PURE YOLO!!!
                  {
                    uuid: conf.disk_setup.const.partition_map.root.uuid,
                    vfs_type: 'xfs',
                    path: '/',
                    options: 'defaults',
                  },
                ],
              },
            },
          ]
          + (import '../fragments/bootloader.jsonnet')(conf)
          + (import '../fragments/systemd.jsonnet')(conf)
          + (import '../fragments/selinux-relabel.jsonnet')(conf, 'targeted')
          + [


          ],
}]
