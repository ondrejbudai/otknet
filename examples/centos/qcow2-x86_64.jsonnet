local x86_64 = import './arches/x86_64.jsonnet';
local centos = import './common/centos.jsonnet';
local disk = import './image-templates/disk.jsonnet';

local conf = {
  packages: {
    os: {
      weak: true,
      packages: {
        include: [
          '@core',
          'authselect-compat',
          'chrony',
          'cloud-init',
          'cloud-utils-growpart',
          'cockpit-system',
          'cockpit-ws',
          'dnf-utils',
          'dosfstools',
          'nfs-utils',
          'oddjob',
          'oddjob-mkhomedir',
          'psmisc',
          'python3-jsonschema',
          'qemu-guest-agent',
          'redhat-release',
          'redhat-release-eula',
          'rsync',
          'tar',
          'tuned',
          'tcpdump',
        ],
        exclude: [
          'aic94xx-firmware',
          'alsa-firmware',
          'alsa-lib',
          'alsa-tools-firmware',
          'biosdevname',
          'dnf-plugin-spacewalk',
          'dracut-config-rescue',
          'fedora-release',
          'fedora-repos',
          'firewalld',
          'iprutils',
          'ivtv-firmware',
          'iwl1000-firmware',
          'iwl100-firmware',
          'iwl105-firmware',
          'iwl135-firmware',
          'iwl2000-firmware',
          'iwl2030-firmware',
          'iwl3160-firmware',
          'iwl3945-firmware',
          'iwl4965-firmware',
          'iwl5000-firmware',
          'iwl5150-firmware',
          'iwl6000-firmware',
          'iwl6000g2a-firmware',
          'iwl6000g2b-firmware',
          'iwl6050-firmware',
          'iwl7260-firmware',
          'langpacks-*',
          'langpacks-en',
          'libertas-sd8787-firmware',
          'nss',
          'plymouth',
          'rng-tools',
          'udisks2',
        ],
      },
    },
  },
  timezone: 'America/New_York',
  kernel_opts: [
    'no_timer_check',
  ],
  locale: 'C.UTF-8',
  convert_disk: {
    filename: 'disk.qcow2',
    format: {
      compat: '1.1',
      type: 'qcow2',
    },
  },
};

function(target, mods={})
  if target == 'osbuild' then
    disk([centos, x86_64, conf, mods])
  else
    'df'
