function(conf) [
  {
    type: 'org.osbuild.fix-bls',
    options: {
       // The default prefix for fix-bls is /boot, which is needed for boot-less partitioning.
       // Override it if we have a separate /boot partition.
      [if std.objectHas(conf.disk_setup.const.partition_map, "boot") then "prefix"]: "/",
    },
  },
]
