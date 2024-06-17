function(conf) [{
  name: 'disk',
  build: 'name:build',
  stages: std.native('external')('otk-make-partition-stages', conf.disk_setup) + [
    local mountsDevs = std.native('external')('otk-make-partition-mounts-devices', conf.disk_setup);
    {
      type: 'org.osbuild.copy',
      inputs: {
        'root-tree': {
          type: 'org.osbuild.tree',
          origin: 'org.osbuild.pipeline',
          references: [
            'name:os',
          ],
        },
      },
      options: {
        paths: [
          {
            from: 'input://root-tree/',
            to: 'mount://%s/' % mountsDevs.root_mount_name,
          },
        ],
      },
      devices: mountsDevs.devices,
      mounts: mountsDevs.mounts,
    },

    // TODO: add org.osbuild.grub2.inst; this is blocked on not having a bios boot partition
  ],
}]
