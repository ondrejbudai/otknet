function(conf)
if std.objectHas(conf, "convert_disk") then
[{
  build: 'name:build',
  name: 'qcow2',
  stages: [
    {
      inputs: {
        image: {
          origin: 'org.osbuild.pipeline',
          references: {
            'name:image': {
              file: conf.partition_table.modifications.filename,
            },
          },
          type: 'org.osbuild.files',
        },
      },
      options: conf.convert_disk,
      type: 'org.osbuild.qemu',
    },
  ],
}]
else []
