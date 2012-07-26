Content-Type: multipart/mixed; boundary="===============5680557865429412167=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: Testing Telit GT864-3G compatibility with ofono
Date: Thu, 26 Jul 2012 08:06:18 +0000
Message-ID: <ED4DEEB78293B34A9D0EAC02A474A46E194CB98F@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <CAC+thW2AnS0U5CGst4CiBfpbY5LZq=RX0-wKBmnmjbxwOkQWNQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5680557865429412167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

      I'm doing some tests with Telit GT864-3G terminal connected to USB wi=
th ofono 1.9. This modem uses UC864-E core. Since ofono provides a driver f=
or UC864-G core, I hope managing it with ofono should be quite straightforw=
ard. One difference between the two cores is that UC864-G does expose 4 ser=
ial devices: after a quick fix I got "modem" and "aux" channel correctly as=
signed. The problem I see here when I run enable-modem is ofono getting stu=
ck after trying to check PIN authentication state: note that the sim I use =
is pin-unlocked and I tried with sims by two different italian providers.
      Looking closer at the logs, attached below, it seems the problem rela=
tes with calls to +CRSM always returning error. I suspect one of those comm=
ands or maybe the timing they are executed with, is messing up the modem, s=
ince +CPIN? returns with success before the sequence of +CRSM and sistemati=
ccally fails after that (modem reboot required to recover).

      Is anybody having similar behaviour with Telit modems? Any suggestion=
 how to workaround or closer debug this issue?

      Regards,
      Andrea

      Here is the log:

      $ sudo OFONO_AT_DEBUG=3Dy /home/gizero/local/sbin/ofonod -n -d

      ofonod[5812]: oFono version 1.9
      ofonod[5812]: src/plugin.c:__ofono_plugin_init()
      ofonod[5812]: plugins/push-notification.c:push_notification_init()
      ofonod[5812]: plugins/smart-messaging.c:smart_messaging_init()
      ofonod[5812]: examples/emulator.c:example_emulator_init()
      ofonod[5812]: src/gprs-provision.c:ofono_gprs_provision_driver_regist=
er() driver: 0x818fa80 name: Example GPRS context provisioning
      ofonod[5812]: src/nettime.c:ofono_nettime_driver_register() driver: 0=
x818fa40 name: Example Network Time
      ofonod[5812]: src/history.c:ofono_history_driver_register() driver: 0=
x818fa00 name: Example Call History
      ofonod[5812]: src/cdma-provision.c:ofono_cdma_provision_driver_regist=
er() driver: 0x818f9c0 name: CDMA provisioning
      ofonod[5812]: src/gprs-provision.c:ofono_gprs_provision_driver_regist=
er() driver: 0x818f980 name: Provisioning
      ofonod[5812]: plugins/connman.c:connman_init()
      ofonod[5812]: src/private-network.c:ofono_private_network_driver_regi=
ster() driver: 0x818f940, name: ConnMan Private Network
      ofonod[5812]: plugins/dun_gw.c:dun_gw_init()
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f880, name: hfp
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f820, name: sap
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f7a0, name: telit
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f700, name: sim900
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f6a0, name: samsung
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f640, name: speedupcdma
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f5e0, name: speedup
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f580, name: alcatel
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f520, name: icera
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f4c0, name: linktop
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f460, name: nokiacdma
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f400, name: nokia
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f3a0, name: tc65
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f300, name: ste
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f2a0, name: ifx
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f240, name: palmpre
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f1e0, name: novatel
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f180, name: sierra
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f100, name: huawei
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f0a0, name: zte
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
f040, name: hso
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
efe0, name: mbm
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
ef80, name: calypso
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
ef20, name: wavecom
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
eec0, name: g1
      ofonod[5812]: src/cdma-voicecall.c:ofono_cdma_voicecall_driver_regist=
er() driver: 0x818ee40, name: cdmamodem
      ofonod[5812]: src/modem.c:ofono_devinfo_driver_register() driver: 0x8=
18ee60, name: cdmamodem
      ofonod[5812]: src/cdma-connman.c:ofono_cdma_connman_driver_register()=
 driver: 0x818ee84, name: cdmamodem
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
eda0, name: phonesim
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
ede0, name: localhfp
      ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:=
 0x818ed74, name: phonesim
      ofonod[5812]: src/ctm.c:ofono_ctm_driver_register() driver: 0x818ed60=
, name: phonesim
      ofonod[5812]: plugins/phonesim.c:parse_config() filename /home/gizero=
/local/etc/ofono/phonesim.conf
      ofonod[5812]: src/ussd.c:ofono_ussd_driver_register() driver: 0x818ed=
20, name: speedupmodem
      ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() drive=
r: 0x818ec00, name: hfpmodem
      ofonod[5812]: src/modem.c:ofono_devinfo_driver_register() driver: 0x8=
18ecbc, name: hfpmodem
      ofonod[5812]: src/network.c:ofono_netreg_driver_register() driver: 0x=
818ec60, name: hfpmodem
      ofonod[5812]: src/call-volume.c:ofono_call_volume_driver_register() d=
river: 0x818ec94, name: hfpmodem
      ofonod[5812]: src/handsfree.c:ofono_handsfree_driver_register() drive=
r: 0x818ecd8, name: hfpmodem
      ofonod[5812]: src/network.c:ofono_netreg_driver_register() driver: 0x=
818eb80, name: dunmodem
      ofonod[5812]: src/gprs.c:ofono_gprs_driver_register() driver: 0x818eb=
ac, name: dunmodem
      ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() drive=
r: 0x818eaa0, name: stemodem
      ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:=
 0x818eb2c, name: stemodem
      ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_regist=
er() driver: 0x818eb00, name: stemodem
      ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() drive=
r: 0x818e960, name: ifxmodem
      ofonod[5812]: src/audio-settings.c:ofono_audio_settings_driver_regist=
er() driver: 0x818e9b0, name: ifxmodem
      ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_regist=
er() driver: 0x818e9e0, name: ifxmodem
      ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:=
 0x818ea0c, name: ifxmodem
      ofonod[5812]: src/stk.c:ofono_stk_driver_register() driver: 0x818ea34=
, name: ifxmodem
      ofonod[5812]: src/ctm.c:ofono_ctm_driver_register() driver: 0x818ea5c=
, name: ifxmodem
      ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:=
 0x818e8e0, name: hsomodem
      ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_regist=
er() driver: 0x818e900, name: hsomodem
      ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:=
 0x818e840, name: mbmmodem
      ofonod[5812]: src/stk.c:ofono_stk_driver_register() driver: 0x818e868=
, name: mbmmodem
      ofonod[5812]: src/location-reporting.c:ofono_location_reporting_drive=
r_register() driver: 0x818e888, name: mbmmodem
      ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() drive=
r: 0x818e7a0, name: calypsomodem
      ofonod[5812]: src/stk.c:ofono_stk_driver_register() driver: 0x818e7e8=
, name: calypsomodem
      ofonod[5812]: src/ussd.c:ofono_ussd_driver_register() driver: 0x818e6=
80, name: huaweimodem
      ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() drive=
r: 0x818e6a0, name: huaweimodem
      ofonod[5812]: src/audio-settings.c:ofono_audio_settings_driver_regist=
er() driver: 0x818e6e8, name: huaweimodem
      ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_regist=
er() driver: 0x818e720, name: huaweimodem
      ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:=
 0x818e6fc, name: huaweimodem
      ofonod[5812]: src/cdma-netreg.c:ofono_cdma_netreg_driver_register() d=
river: 0x818e74c, name: huaweimodem
      ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:=
 0x818e5e0, name: iceramodem
      ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_regist=
er() driver: 0x818e620, name: iceramodem
      ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_regist=
er() driver: 0x818e580, name: ztemodem
      ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:=
 0x818e540, name: swmodem
      ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_regist=
er() driver: 0x818e4e0, name: nwmodem
      ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() drive=
r: 0x818e340, name: atmodem
      ofonod[5812]: src/modem.c:ofono_devinfo_driver_register() driver: 0x8=
18e3e0, name: atmodem
      ofonod[5812]: src/call-barring.c:ofono_call_barring_driver_register()=
 driver: 0x818e398, name: atmodem
      ofonod[5812]: src/call-forwarding.c:ofono_call_forwarding_driver_regi=
ster() driver: 0x818e0e0, name: atmodem
      ofonod[5812]: src/call-meter.c:ofono_call_meter_driver_register() dri=
ver: 0x818e120, name: atmodem
      ofonod[5812]: src/call-settings.c:ofono_call_settings_driver_register=
() driver: 0x818dfe0, name: atmodem
      ofonod[5812]: src/phonebook.c:ofono_phonebook_driver_register() drive=
r: 0x818e3b8, name: atmodem
      ofonod[5812]: src/ussd.c:ofono_ussd_driver_register() driver: 0x818e3=
04, name: atmodem
      ofonod[5812]: src/sms.c:ofono_sms_driver_register() driver: 0x818e060=
, name: atmodem
      ofonod[5812]: src/sim.c:ofono_sim_driver_register() driver: 0x818e1e0=
, name: atmodem
      ofonod[5812]: src/sim.c:ofono_sim_driver_register() driver: 0x818e240=
, name: atmodem-noef
      ofonod[5812]: src/stk.c:ofono_stk_driver_register() driver: 0x818e2e4=
, name: atmodem
      ofonod[5812]: src/network.c:ofono_netreg_driver_register() driver: 0x=
818e180, name: atmodem
      ofonod[5812]: src/cbs.c:ofono_cbs_driver_register() driver: 0x818e0c0=
, name: atmodem
      ofonod[5812]: src/call-volume.c:ofono_call_volume_driver_register() d=
river: 0x818e404, name: atmodem
      ofonod[5812]: src/gprs.c:ofono_gprs_driver_register() driver: 0x818e4=
34, name: atmodem
      ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:=
 0x818e458, name: atmodem
      ofonod[5812]: src/sim-auth.c:ofono_sim_auth_driver_register() driver:=
 0x818e470, name: atmodem
      ofonod[5812]: src/gnss.c:ofono_gnss_driver_register() driver: 0x818e4=
88, name: atmodem
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
ddc0, name: gobi
      ofonod[5812]: src/modem.c:ofono_devinfo_driver_register() driver: 0x8=
18dbe0, name: qmimodem
      ofonod[5812]: src/network.c:ofono_netreg_driver_register() driver: 0x=
818dc60, name: qmimodem
      ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() drive=
r: 0x818dc00, name: qmimodem
      ofonod[5812]: src/sim.c:ofono_sim_driver_register() driver: 0x818dca0=
, name: qmimodem-legacy
      ofonod[5812]: src/sms.c:ofono_sms_driver_register() driver: 0x818dd00=
, name: qmimodem
      ofonod[5812]: src/ussd.c:ofono_ussd_driver_register() driver: 0x818dd=
20, name: qmimodem
      ofonod[5812]: src/gprs.c:ofono_gprs_driver_register() driver: 0x818dd=
34, name: qmimodem
      ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:=
 0x818dd48, name: qmimodem
      ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_regist=
er() driver: 0x818dd60, name: qmimodem
      ofonod[5812]: src/location-reporting.c:ofono_location_reporting_drive=
r_register() driver: 0x818dd84, name: qmimodem
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
db80, name: u8500
      ofonod[5812]: src/modem.c:ofono_devinfo_driver_register() driver: 0x8=
18db60, name: u8500
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
db00, name: n900
      ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818=
daa0, name: isiusb
      ofonod[5812]: src/modem.c:ofono_devinfo_driver_register() driver: 0x8=
18d790, name: isimodem
      ofonod[5812]: src/phonebook.c:ofono_phonebook_driver_register() drive=
r: 0x818d780, name: isimodem
      ofonod[5812]: src/network.c:ofono_netreg_driver_register() driver: 0x=
818d7c0, name: isimodem
      ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() drive=
r: 0x818d800, name: isimodem
      ofonod[5812]: src/sms.c:ofono_sms_driver_register() driver: 0x818d860=
, name: isimodem
      ofonod[5812]: src/cbs.c:ofono_cbs_driver_register() driver: 0x818d880=
, name: isimodem
      ofonod[5812]: src/sim.c:ofono_sim_driver_register() driver: 0x818d8a0=
, name: isimodem
      ofonod[5812]: src/ussd.c:ofono_ussd_driver_register() driver: 0x818d8=
e8, name: isimodem
      ofonod[5812]: src/call-forwarding.c:ofono_call_forwarding_driver_regi=
ster() driver: 0x818d900, name: isimodem
      ofonod[5812]: src/call-settings.c:ofono_call_settings_driver_register=
() driver: 0x818d920, name: isimodem
      ofonod[5812]: src/call-barring.c:ofono_call_barring_driver_register()=
 driver: 0x818d950, name: isimodem
      ofonod[5812]: src/call-meter.c:ofono_call_meter_driver_register() dri=
ver: 0x818d980, name: isimodem
      ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_regist=
er() driver: 0x818d9c0, name: isimodem
      ofonod[5812]: src/gprs.c:ofono_gprs_driver_register() driver: 0x818d9=
e4, name: isimodem
      ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:=
 0x818d9f8, name: isimodem
      ofonod[5812]: src/audio-settings.c:ofono_audio_settings_driver_regist=
er() driver: 0x818da10, name: isimodem
      ofonod[5812]: src/sim.c:ofono_sim_driver_register() driver: 0x818da20=
, name: wgmodem2.5
      ofonod[5812]: plugins/udevng.c:udev_start()
      ofonod[5812]: plugins/udevng.c:enumerate_devices()
      ofonod[5812]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
      ofonod[5812]: plugins/udevng.c:check_usb_device() usb [8087:0024]
      ofonod[5812]: plugins/udevng.c:check_usb_device() usb [067b:2303]
      ofonod[5812]: plugins/udevng.c:check_usb_device() pl2303 [(null):(nul=
l)]
      ofonod[5812]: plugins/udevng.c:check_usb_device() pl2303 [067b:2303]
      ofonod[5812]: plugins/udevng.c:check_usb_device() usb [046d:c310]
      ofonod[5812]: plugins/udevng.c:check_usb_device() usbhid [(null):(nul=
l)]
      ofonod[5812]: plugins/udevng.c:check_usb_device() usbhid [(null):(nul=
l)]
      ofonod[5812]: plugins/udevng.c:check_usb_device() usbhid [(null):(nul=
l)]
      ofonod[5812]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
      ofonod[5812]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
      ofonod[5812]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
      ofonod[5812]: plugins/udevng.c:check_usb_device() usb [174c:5106]
      ofonod[5812]: plugins/udevng.c:check_usb_device() usb-storage [(null)=
:(null)]
      ofonod[5812]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
      ofonod[5812]: plugins/udevng.c:check_usb_device() usb [8087:0024]
      ofonod[5812]: plugins/udevng.c:check_usb_device() usb [067b:2303]
      ofonod[5812]: plugins/udevng.c:check_usb_device() pl2303 [(null):(nul=
l)]
      ofonod[5812]: plugins/udevng.c:check_usb_device() pl2303 [067b:2303]
      ofonod[5812]: plugins/udevng.c:check_usb_device() usb [046d:c016]
      ofonod[5812]: plugins/udevng.c:check_usb_device() usbhid [(null):(nul=
l)]
      ofonod[5812]: plugins/udevng.c:check_usb_device() usb [058f:6362]
      ofonod[5812]: plugins/udevng.c:check_usb_device() usb-storage [(null)=
:(null)]
      ofonod[5812]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
      ofonod[5812]: src/private-network.c:ofono_private_network_driver_regi=
ster() driver: 0x818fae0, name: Example Private Network Driver
      ofonod[5812]: plugins/bluetooth.c:manager_properties_cb()
      ofonod[5812]: plugins/bluetooth.c:parse_adapters()

      > here I connect the modem to the USB

      ofonod[5812]: plugins/udevng.c:check_usb_device() usb [1bc7:1003]
      ofonod[5812]: plugins/udevng.c:check_usb_device() option [(null):(nul=
l)]
      ofonod[5812]: plugins/udevng.c:check_usb_device() option [(null):(nul=
l)]
      ofonod[5812]: plugins/udevng.c:check_usb_device() option [(null):(nul=
l)]
      ofonod[5812]: plugins/udevng.c:check_usb_device() option [1bc7:1003]
      ofonod[5812]: plugins/udevng.c:add_device() /sys/devices/pci0000:00/0=
000:00:1a.0/usb1/1-1/1-1.4
      ofonod[5812]: plugins/udevng.c:add_device() /sys/devices/pci0000:00/0=
000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.1/ttyUSB3/tty/ttyUSB3
      ofonod[5812]: plugins/udevng.c:add_device() /dev/ttyUSB3 (telit) 255/=
255/255 [01] =3D=3D> (null) (null)
      ofonod[5812]: plugins/udev.c:udev_event() subsystem tty add
      ofonod[5812]: plugins/udev.c:udev_event() subsystem tty finished
      ofonod[5812]: plugins/udevng.c:check_usb_device() option [1bc7:1003]
      ofonod[5812]: plugins/udevng.c:add_device() /sys/devices/pci0000:00/0=
000:00:1a.0/usb1/1-1/1-1.4
      ofonod[5812]: plugins/udevng.c:add_device() /sys/devices/pci0000:00/0=
000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.2/ttyUSB4/tty/ttyUSB4
      ofonod[5812]: plugins/udevng.c:add_device() /dev/ttyUSB4 (telit) 255/=
255/255 [02] =3D=3D> (null) (null)
      ofonod[5812]: plugins/udev.c:udev_event() subsystem tty add
      ofonod[5812]: plugins/udev.c:udev_event() subsystem tty finished
      ofonod[5812]: plugins/udevng.c:check_usb_device() option [1bc7:1003]
      ofonod[5812]: plugins/udevng.c:add_device() /sys/devices/pci0000:00/0=
000:00:1a.0/usb1/1-1/1-1.4
      ofonod[5812]: plugins/udevng.c:add_device() /sys/devices/pci0000:00/0=
000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.0/ttyUSB2/tty/ttyUSB2
      ofonod[5812]: plugins/udevng.c:add_device() /dev/ttyUSB2 (telit) 255/=
255/255 [00] =3D=3D> (null) (null)
      ofonod[5812]: plugins/udev.c:udev_event() subsystem tty add
      ofonod[5812]: plugins/udev.c:udev_event() subsystem tty finished
      ofonod[5812]: plugins/udevng.c:check_modem_list()
      ofonod[5812]: plugins/udevng.c:create_modem() /sys/devices/pci0000:00=
/0000:00:1a.0/usb1/1-1/1-1.4
      ofonod[5812]: plugins/udevng.c:create_modem() driver=3Dtelit
      ofonod[5812]: src/modem.c:ofono_modem_create() name: (null), type: te=
lit
      ofonod[5812]: plugins/udevng.c:setup_telit() /sys/devices/pci0000:00/=
0000:00:1a.0/usb1/1-1/1-1.4
      ofonod[5812]: plugins/udevng.c:setup_telit() /dev/ttyUSB2 255/255/255=
 00 (null)
      ofonod[5812]: plugins/udevng.c:setup_telit() /dev/ttyUSB3 255/255/255=
 01 (null)
      ofonod[5812]: plugins/udevng.c:setup_telit() /dev/ttyUSB4 255/255/255=
 02 (null)
      ofonod[5812]: plugins/udevng.c:setup_telit() modem=3D/dev/ttyUSB2 aux=
=3D/dev/ttyUSB4 gps=3D(null) diag=3D/dev/ttyUSB3
      ofonod[5812]: src/modem.c:set_modem_property() modem 0x8e0f140 proper=
ty Modem
      ofonod[5812]: src/modem.c:set_modem_property() modem 0x8e0f140 proper=
ty Data
      ofonod[5812]: src/modem.c:set_modem_property() modem 0x8e0f140 proper=
ty GPS
      ofonod[5812]: src/modem.c:ofono_modem_register() 0x8e0f140
      ofonod[5812]: plugins/telit.c:telit_probe() 0x8e0f140
      ofonod[5812]: src/modem.c:emit_modem_added() 0x8e0f140
      ofonod[5812]: src/modem.c:call_modemwatches() 0x8e0f140 added:1
      ofonod[5812]: plugins/hfp_ag.c:modem_watch() modem: 0x8e0f140, added:=
 1
      ofonod[5812]: plugins/dun_gw.c:modem_watch() modem: 0x8e0f140, added:=
 1
      ofonod[5812]: examples/emulator.c:modem_watch() modem: 0x8e0f140, add=
ed: 1
      ofonod[5812]: plugins/smart-messaging.c:modem_watch() modem: 0x8e0f14=
0, added: 1
      ofonod[5812]: plugins/push-notification.c:modem_watch() modem: 0x8e0f=
140, added: 1

      $ enable-modem /telit_0

      ofonod[5812]: plugins/telit.c:telit_enable() 0x8e0f140
      ofonod[5812]: src/modem.c:get_modem_property() modem 0x8e0f140 proper=
ty Modem
      ofonod[5812]: plugins/telit.c:open_device() Modem /dev/ttyUSB2
      ofonod[5812]: Modem: > ATE0 +CMEE=3D1\r
      ofonod[5812]: Modem: < \r\nOK\r\n
      ofonod[5812]: Modem: > AT+CFUN=3D4\r
      ofonod[5812]: Modem: < \r\nOK\r\n
      ofonod[5812]: plugins/telit.c:cfun_enable_cb() 0x8e0f140
      ofonod[5812]: examples/emulator.c:powered_watch() Adding modem 0x8e0f=
140 to the list
      ofonod[5812]: examples/emulator.c:create_tcp() Created server_watch: =
38
      ofonod[5812]: examples/emulator.c:create_tcp() Created server_watch: =
39
      ofonod[5812]: src/modem.c:modem_change_state() old state: 0, new stat=
e: 1
      ofonod[5812]: plugins/telit.c:telit_pre_sim() 0x8e0f140
      ofonod[5812]: drivers/atmodem/sim.c:at_sim_probe() GIZERO at_sim_prob=
e: vendor 15
      ofonod[5812]: Modem: > AT+GCAP\r
      ofonod[5812]: src/sim.c:ofono_sim_add_state_watch() 0x8e06a90
      ofonod[5812]: src/sim.c:ofono_sim_add_state_watch() 0x8e06a90
      ofonod[5812]: src/sim.c:ofono_sim_add_state_watch() 0x8e06a90
      ofonod[5812]: Modem: < \r\n+GCAP: +CGSM,+DS,+FCLASS,+MS,+ES\r\n\r\nOK=
\r\n
      ofonod[5812]: Modem: > AT+CRC=3D1\r
      ofonod[5812]: Modem: < \r\nOK\r\n
      ofonod[5812]: Modem: > AT+CLIP=3D1\r
      ofonod[5812]: Modem: < \r\nOK\r\n
      ofonod[5812]: Modem: > AT+CDIP=3D1\r
      ofonod[5812]: Modem: < \r\nERROR\r\n
      ofonod[5812]: Modem: > AT+CNAP=3D1\r
      ofonod[5812]: Modem: < \r\nERROR\r\n
      ofonod[5812]: Modem: > AT+COLP=3D1\r
      ofonod[5812]: Modem: < \r\n+CME ERROR: 10\r\n
      ofonod[5812]: Modem: > AT+CSSN=3D1,1\r
      ofonod[5812]: Modem: < \r\n+CME ERROR: 10\r\n
      ofonod[5812]: Modem: > AT+VTD?\r
      ofonod[5812]: Modem: < \r\n+CME ERROR: 10\r\n
      ofonod[5812]: Modem: > AT+CCWA=3D1\r
      ofonod[5812]: Modem: < \r\n+CME ERROR: 10\r\n
      ofonod[5812]: drivers/atmodem/voicecall.c:at_voicecall_initialized() =
voicecall_init: registering to notifications
      ofonod[5812]: src/sim.c:ofono_sim_add_state_watch() 0x8e06a90
      ofonod[5812]: Modem: > AT#QSS=3D1\r
      ofonod[5812]: Modem: < \r\nOK\r\n
      ofonod[5812]: Modem: > AT#QSS?\r
      ofonod[5812]: Modem: < \r\n#QSS: 1,1\r\n\r\nOK\r\n
      ofonod[5812]: plugins/telit.c:telit_qss_cb() 0x8e0f140
      ofonod[5812]: plugins/telit.c:switch_sim_state_status() 0x8e0f140
      ofonod[5812]: plugins/telit.c:switch_sim_state_status() SIM inserted
      ofonod[5812]: Modem: > AT+CGMI\r
      ofonod[5812]: Modem: < \r\nTelit\r\n\r\nOK\r\n
      ofonod[5812]: Modem: > AT+CLCC\r
      ofonod[5812]: Modem: < \r\n+CME ERROR: 10\r\n
      ofonod[5812]: Modem: > AT+CGMM\r
      ofonod[5812]: Modem: < \r\nUC864-E\r\n\r\nOK\r\n
      ofonod[5812]: Modem: > AT+CGMR\r
      ofonod[5812]: Modem: < \r\n08.01.005\r\n\r\nOK\r\n
      ofonod[5812]: Modem: > AT+CGSN\r
      ofonod[5812]: Modem: < \r\n352636020412768\r\n\r\nOK\r\n
      ofonod[5812]: plugins/telit.c:sim_inserted_timeout_cb() 0x8e0f140
      ofonod[5812]: Modem: > AT+CRSM=3D192,28599\r
      ofonod[5812]: Modem: < \r\n+CME ERROR: 100\r\n
      ofonod[5812]: src/voicecall.c:ecc_g2_read_cb() 0
      ofonod[5812]: Modem: > AT+CRSM=3D192,28599\r
      ofonod[5812]: Modem: < \r\n+CME ERROR: 100\r\n
      ofonod[5812]: src/voicecall.c:ecc_g3_read_cb() 0
      ofonod[5812]: Modem: > AT+CRSM=3D192,12258\r
      ofonod[5812]: Modem: < \r\n+CME ERROR: 100\r\n
      ofonod[5812]: Modem: > AT+CRSM=3D192,28421\r
      ofonod[5812]: Modem: < \r\n+CME ERROR: 100\r\n
      ofonod[5812]: Modem: > AT+CRSM=3D192,12037\r
      ofonod[5812]: Modem: < \r\n+CME ERROR: 100\r\n
      ofonod[5812]: Modem: > AT+CPIN?\r
      ofonod[5812]: Modem: < \r\n+CME ERROR: 10\r\n
      ofonod[5812]: Querying PIN authentication state failed

According to your log, there is no SIM inserted, this is why you got those =
errors.

But the enable-modem looks good. Did you do a ./list-modems to see the curr=
ent modem info?

And if you insert a SIM, did you tried an ./online-modem?

Regards,

Bertrand


---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============5680557865429412167==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRl
eHQvaHRtbDsgY2hhcnNldD11cy1hc2NpaSI+CjxtZXRhIG5hbWU9IkdlbmVyYXRvciIgY29udGVu
dD0iTWljcm9zb2Z0IEV4Y2hhbmdlIFNlcnZlciI+CjwhLS0gY29udmVydGVkIGZyb20gcnRmIC0t
Pgo8c3R5bGU+PCEtLSAuRW1haWxRdW90ZSB7IG1hcmdpbi1sZWZ0OiAxcHQ7IHBhZGRpbmctbGVm
dDogNHB0OyBib3JkZXItbGVmdDogIzgwMDAwMCAycHggc29saWQ7IH0gLS0+PC9zdHlsZT4KPC9o
ZWFkPgo8Ym9keT4KPGZvbnQgZmFjZT0iQ2FsaWJyaSIgc2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImZv
bnQtc2l6ZToxMXB0OyI+CjxkaXY+SGksPC9kaXY+CjxkaXY+Jm5ic3A7PC9kaXY+CjxkaXYgc3R5
bGU9InBhZGRpbmctbGVmdDozNnB0OyI+SSdtIGRvaW5nIHNvbWUgdGVzdHMgd2l0aCBUZWxpdCBH
VDg2NC0zRyB0ZXJtaW5hbCBjb25uZWN0ZWQgdG8gVVNCIHdpdGggb2Zvbm8gMS45LiBUaGlzIG1v
ZGVtIHVzZXMgVUM4NjQtRSBjb3JlLiBTaW5jZSBvZm9ubyBwcm92aWRlcyBhIGRyaXZlciBmb3Ig
VUM4NjQtRyBjb3JlLCBJIGhvcGUgbWFuYWdpbmcgaXQgd2l0aCBvZm9ubyBzaG91bGQgYmUgcXVp
dGUgc3RyYWlnaHRmb3J3YXJkLiBPbmUKZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZSB0d28gY29yZXMg
aXMgdGhhdCBVQzg2NC1HIGRvZXMgZXhwb3NlIDQgc2VyaWFsIGRldmljZXM6IGFmdGVyIGEgcXVp
Y2sgZml4IEkgZ290ICZxdW90O21vZGVtJnF1b3Q7IGFuZCAmcXVvdDthdXgmcXVvdDsgY2hhbm5l
bCBjb3JyZWN0bHkgYXNzaWduZWQuIFRoZSBwcm9ibGVtIEkgc2VlIGhlcmUgd2hlbiBJIHJ1biBl
bmFibGUtbW9kZW0gaXMgb2Zvbm8gZ2V0dGluZyBzdHVjayBhZnRlciB0cnlpbmcgdG8gY2hlY2sg
UElOIGF1dGhlbnRpY2F0aW9uCnN0YXRlOiBub3RlIHRoYXQgdGhlIHNpbSBJIHVzZSBpcyBwaW4t
dW5sb2NrZWQgYW5kIEkgdHJpZWQgd2l0aCBzaW1zIGJ5IHR3byBkaWZmZXJlbnQgaXRhbGlhbiBw
cm92aWRlcnMuIDwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPkxvb2tpbmcg
Y2xvc2VyIGF0IHRoZSBsb2dzLCBhdHRhY2hlZCBiZWxvdywgaXQgc2VlbXMgdGhlIHByb2JsZW0g
cmVsYXRlcyB3aXRoIGNhbGxzIHRvICYjNDM7Q1JTTSBhbHdheXMgcmV0dXJuaW5nIGVycm9yLiBJ
IHN1c3BlY3Qgb25lIG9mIHRob3NlIGNvbW1hbmRzIG9yIG1heWJlIHRoZSB0aW1pbmcgdGhleSBh
cmUgZXhlY3V0ZWQgd2l0aCwgaXMgbWVzc2luZyB1cCB0aGUgbW9kZW0sIHNpbmNlICYjNDM7Q1BJ
Tj8KcmV0dXJucyB3aXRoIHN1Y2Nlc3MgYmVmb3JlIHRoZSBzZXF1ZW5jZSBvZiAmIzQzO0NSU00g
YW5kIHNpc3RlbWF0aWNjYWxseSBmYWlscyBhZnRlciB0aGF0IChtb2RlbSByZWJvb3QgcmVxdWly
ZWQgdG8gcmVjb3ZlcikuPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+Jm5i
c3A7PC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+SXMgYW55Ym9keSBoYXZp
bmcgc2ltaWxhciBiZWhhdmlvdXIgd2l0aCBUZWxpdCBtb2RlbXM/IEFueSBzdWdnZXN0aW9uIGhv
dyB0byB3b3JrYXJvdW5kIG9yIGNsb3NlciBkZWJ1ZyB0aGlzIGlzc3VlPzwvZGl2Pgo8ZGl2IHN0
eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPiZuYnNwOzwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5n
LWxlZnQ6MzZwdDsiPlJlZ2FyZHMsPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0
OyI+QW5kcmVhPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+Jm5ic3A7PC9k
aXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+SGVyZSBpcyB0aGUgbG9nOjwvZGl2
Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPiZuYnNwOzwvZGl2Pgo8ZGl2IHN0eWxl
PSJwYWRkaW5nLWxlZnQ6MzZwdDsiPiQgc3VkbyBPRk9OT19BVF9ERUJVRz15IC9ob21lL2dpemVy
by9sb2NhbC9zYmluL29mb25vZCAtbiAtZDwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6
MzZwdDsiPiZuYnNwOzwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25v
ZFs1ODEyXTogb0Zvbm8gdmVyc2lvbiAxLjk8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0
OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9wbHVnaW4uYzpfX29mb25vX3BsdWdpbl9pbml0KCkg
PC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBwbHVn
aW5zL3B1c2gtbm90aWZpY2F0aW9uLmM6cHVzaF9ub3RpZmljYXRpb25faW5pdCgpIDwvZGl2Pgo8
ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogcGx1Z2lucy9zbWFy
dC1tZXNzYWdpbmcuYzpzbWFydF9tZXNzYWdpbmdfaW5pdCgpIDwvZGl2Pgo8ZGl2IHN0eWxlPSJw
YWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogZXhhbXBsZXMvZW11bGF0b3IuYzpleGFt
cGxlX2VtdWxhdG9yX2luaXQoKSA8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7
Ij5vZm9ub2RbNTgxMl06IHNyYy9ncHJzLXByb3Zpc2lvbi5jOm9mb25vX2dwcnNfcHJvdmlzaW9u
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThmYTgwIG5hbWU6IEV4YW1wbGUgR1BSUyBj
b250ZXh0IHByb3Zpc2lvbmluZzwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsi
Pm9mb25vZFs1ODEyXTogc3JjL25ldHRpbWUuYzpvZm9ub19uZXR0aW1lX2RyaXZlcl9yZWdpc3Rl
cigpIGRyaXZlcjogMHg4MThmYTQwIG5hbWU6IEV4YW1wbGUgTmV0d29yayBUaW1lPC9kaXY+Cjxk
aXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvaGlzdG9yeS5j
Om9mb25vX2hpc3RvcnlfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGZhMDAgbmFtZTog
RXhhbXBsZSBDYWxsIEhpc3Rvcnk8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7
Ij5vZm9ub2RbNTgxMl06IHNyYy9jZG1hLXByb3Zpc2lvbi5jOm9mb25vX2NkbWFfcHJvdmlzaW9u
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThmOWMwIG5hbWU6IENETUEgcHJvdmlzaW9u
aW5nPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBz
cmMvZ3Bycy1wcm92aXNpb24uYzpvZm9ub19ncHJzX3Byb3Zpc2lvbl9kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4ODE4Zjk4MCBuYW1lOiBQcm92aXNpb25pbmc8L2Rpdj4KPGRpdiBzdHlsZT0i
cGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvY29ubm1hbi5jOmNvbm5t
YW5faW5pdCgpIDwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1
ODEyXTogc3JjL3ByaXZhdGUtbmV0d29yay5jOm9mb25vX3ByaXZhdGVfbmV0d29ya19kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4Zjk0MCwgbmFtZTogQ29ubk1hbiBQcml2YXRlIE5ldHdv
cms8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBs
dWdpbnMvZHVuX2d3LmM6ZHVuX2d3X2luaXQoKSA8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1s
ZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg4MThmODgwLCBuYW1lOiBoZnA8L2Rpdj4KPGRpdiBzdHlsZT0i
cGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVt
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThmODIwLCBuYW1lOiBzYXA8L2Rpdj4KPGRp
diBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm9m
b25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThmN2EwLCBuYW1lOiB0ZWxp
dDwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3Jj
L21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGY3MDAs
IG5hbWU6IHNpbTkwMDwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25v
ZFs1ODEyXTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
OiAweDgxOGY2YTAsIG5hbWU6IHNhbXN1bmc8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0
OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg4MThmNjQwLCBuYW1lOiBzcGVlZHVwY2RtYTwvZGl2Pgo8ZGl2IHN0
eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL21vZGVtLmM6b2Zvbm9f
bW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGY1ZTAsIG5hbWU6IHNwZWVkdXA8
L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9t
b2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThmNTgwLCBu
YW1lOiBhbGNhdGVsPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9k
WzU4MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
IDB4ODE4ZjUyMCwgbmFtZTogaWNlcmE8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2
cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3Rl
cigpIGRyaXZlcjogMHg4MThmNGMwLCBuYW1lOiBsaW5rdG9wPC9kaXY+CjxkaXYgc3R5bGU9InBh
ZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZjQ2MCwgbmFtZTogbm9raWFjZG1hPC9kaXY+
CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0u
YzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZjQwMCwgbmFtZTog
bm9raWE8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06
IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThm
M2EwLCBuYW1lOiB0YzY1PC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zv
bm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4ODE4ZjMwMCwgbmFtZTogc3RlPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDoz
NnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4ODE4ZjJhMCwgbmFtZTogaWZ4PC9kaXY+CjxkaXYgc3R5bGU9InBhZGRp
bmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZjI0MCwgbmFtZTogcGFsbXByZTwvZGl2Pgo8ZGl2
IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL21vZGVtLmM6b2Zv
bm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGYxZTAsIG5hbWU6IG5vdmF0
ZWw8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNy
Yy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThmMTgw
LCBuYW1lOiBzaWVycmE8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9u
b2RbNTgxMl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg4MThmMTAwLCBuYW1lOiBodWF3ZWk8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0
OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg4MThmMGEwLCBuYW1lOiB6dGU8L2Rpdj4KPGRpdiBzdHlsZT0icGFk
ZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThmMDQwLCBuYW1lOiBoc288L2Rpdj4KPGRpdiBz
dHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm9mb25v
X21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlZmUwLCBuYW1lOiBtYm08L2Rp
dj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9tb2Rl
bS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlZjgwLCBuYW1l
OiBjYWx5cHNvPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4
MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
ODE4ZWYyMCwgbmFtZTogd2F2ZWNvbTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZw
dDsiPm9mb25vZFs1ODEyXTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDgxOGVlYzAsIG5hbWU6IGcxPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmct
bGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvY2RtYS12b2ljZWNhbGwuYzpvZm9ub19jZG1h
X3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZWU0MCwgbmFtZTogY2Rt
YW1vZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJd
OiBzcmMvbW9kZW0uYzpvZm9ub19kZXZpbmZvX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4
MThlZTYwLCBuYW1lOiBjZG1hbW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2
cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9jZG1hLWNvbm5tYW4uYzpvZm9ub19jZG1hX2Nvbm5tYW5f
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGVlODQsIG5hbWU6IGNkbWFtb2RlbTwvZGl2
Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL21vZGVt
LmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGVkYTAsIG5hbWU6
IHBob25lc2ltPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4
MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
ODE4ZWRlMCwgbmFtZTogbG9jYWxoZnA8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2
cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg4MThlZDc0LCBuYW1lOiBwaG9uZXNpbTwvZGl2Pgo8ZGl2IHN0
eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL2N0bS5jOm9mb25vX2N0
bV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZWQ2MCwgbmFtZTogcGhvbmVzaW08L2Rp
dj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMv
cGhvbmVzaW0uYzpwYXJzZV9jb25maWcoKSBmaWxlbmFtZSAvaG9tZS9naXplcm8vbG9jYWwvZXRj
L29mb25vL3Bob25lc2ltLmNvbmY8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7
Ij5vZm9ub2RbNTgxMl06IHNyYy91c3NkLmM6b2Zvbm9fdXNzZF9kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6IDB4ODE4ZWQyMCwgbmFtZTogc3BlZWR1cG1vZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBh
ZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9p
Y2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlYzAwLCBuYW1lOiBoZnBtb2Rl
bTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3Jj
L21vZGVtLmM6b2Zvbm9fZGV2aW5mb19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZWNi
YywgbmFtZTogaGZwbW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5v
Zm9ub2RbNTgxMl06IHNyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg4MThlYzYwLCBuYW1lOiBoZnBtb2RlbTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRk
aW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL2NhbGwtdm9sdW1lLmM6b2Zvbm9fY2Fs
bF92b2x1bWVfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGVjOTQsIG5hbWU6IGhmcG1v
ZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBz
cmMvaGFuZHNmcmVlLmM6b2Zvbm9faGFuZHNmcmVlX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg4MThlY2Q4LCBuYW1lOiBoZnBtb2RlbTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6
MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDgxOGViODAsIG5hbWU6IGR1bm1vZGVtPC9kaXY+CjxkaXYgc3R5
bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvZ3Bycy5jOm9mb25vX2dw
cnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGViYWMsIG5hbWU6IGR1bm1vZGVtPC9k
aXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvdm9p
Y2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThl
YWEwLCBuYW1lOiBzdGVtb2RlbTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsi
Pm9mb25vZFs1ODEyXTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDgxOGViMmMsIG5hbWU6IHN0ZW1vZGVtPC9kaXY+CjxkaXYgc3R5bGU9
InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvcmFkaW8tc2V0dGluZ3MuYzpv
Zm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZWIwMCwg
bmFtZTogc3RlbW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9u
b2RbNTgxMl06IHNyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDgxOGU5NjAsIG5hbWU6IGlmeG1vZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBh
ZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvYXVkaW8tc2V0dGluZ3MuYzpvZm9u
b19hdWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZTliMCwgbmFt
ZTogaWZ4bW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2Rb
NTgxMl06IHNyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg4MThlOWUwLCBuYW1lOiBpZnhtb2RlbTwvZGl2Pgo8ZGl2IHN0
eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL2dwcnMuYzpvZm9ub19n
cHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGVhMGMsIG5hbWU6IGlm
eG1vZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJd
OiBzcmMvc3RrLmM6b2Zvbm9fc3RrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlYTM0
LCBuYW1lOiBpZnhtb2RlbTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9m
b25vZFs1ODEyXTogc3JjL2N0bS5jOm9mb25vX2N0bV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
IDB4ODE4ZWE1YywgbmFtZTogaWZ4bW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0
OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlOGUwLCBuYW1lOiBoc29tb2RlbTwvZGl2Pgo8ZGl2
IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL3JhZGlvLXNldHRp
bmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgx
OGU5MDAsIG5hbWU6IGhzb21vZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0
OyI+b2Zvbm9kWzU4MTJdOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZTg0MCwgbmFtZTogbWJtbW9kZW08L2Rpdj4KPGRpdiBzdHls
ZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9zdGsuYzpvZm9ub19zdGtf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGU4NjgsIG5hbWU6IG1ibW1vZGVtPC9kaXY+
CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvbG9jYXRp
b24tcmVwb3J0aW5nLmM6b2Zvbm9fbG9jYXRpb25fcmVwb3J0aW5nX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg4MThlODg4LCBuYW1lOiBtYm1tb2RlbTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRk
aW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNl
Y2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZTdhMCwgbmFtZTogY2FseXBzb21v
ZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBz
cmMvc3RrLmM6b2Zvbm9fc3RrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlN2U4LCBu
YW1lOiBjYWx5cHNvbW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5v
Zm9ub2RbNTgxMl06IHNyYy91c3NkLmM6b2Zvbm9fdXNzZF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4ODE4ZTY4MCwgbmFtZTogaHVhd2VpbW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGlu
Zy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNh
bGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGU2YTAsIG5hbWU6IGh1YXdlaW1vZGVt
PC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMv
YXVkaW8tc2V0dGluZ3MuYzpvZm9ub19hdWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6IDB4ODE4ZTZlOCwgbmFtZTogaHVhd2VpbW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFk
ZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25v
X3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlNzIwLCBuYW1l
OiBodWF3ZWltb2RlbTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25v
ZFs1ODEyXTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxOGU2ZmMsIG5hbWU6IGh1YXdlaW1vZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBh
ZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvY2RtYS1uZXRyZWcuYzpvZm9ub19j
ZG1hX25ldHJlZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZTc0YywgbmFtZTogaHVh
d2VpbW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgx
Ml06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg4MThlNWUwLCBuYW1lOiBpY2VyYW1vZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmct
bGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRp
b19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZTYyMCwgbmFtZTogaWNl
cmFtb2RlbTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEy
XTogc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDgxOGU1ODAsIG5hbWU6IHp0ZW1vZGVtPC9kaXY+CjxkaXYgc3R5bGU9
InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNf
Y29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZTU0MCwgbmFtZTogc3dtb2Rl
bTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3Jj
L3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxOGU0ZTAsIG5hbWU6IG53bW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGlu
Zy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNh
bGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGUzNDAsIG5hbWU6IGF0bW9kZW08L2Rp
dj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9tb2Rl
bS5jOm9mb25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGUzZTAsIG5h
bWU6IGF0bW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2Rb
NTgxMl06IHNyYy9jYWxsLWJhcnJpbmcuYzpvZm9ub19jYWxsX2JhcnJpbmdfZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDgxOGUzOTgsIG5hbWU6IGF0bW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0i
cGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9jYWxsLWZvcndhcmRpbmcuYzpv
Zm9ub19jYWxsX2ZvcndhcmRpbmdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGUwZTAs
IG5hbWU6IGF0bW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9u
b2RbNTgxMl06IHNyYy9jYWxsLW1ldGVyLmM6b2Zvbm9fY2FsbF9tZXRlcl9kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4ODE4ZTEyMCwgbmFtZTogYXRtb2RlbTwvZGl2Pgo8ZGl2IHN0eWxlPSJw
YWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL2NhbGwtc2V0dGluZ3MuYzpvZm9u
b19jYWxsX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThkZmUwLCBuYW1l
OiBhdG1vZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4
MTJdOiBzcmMvcGhvbmVib29rLmM6b2Zvbm9fcGhvbmVib29rX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg4MThlM2I4LCBuYW1lOiBhdG1vZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmct
bGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvdXNzZC5jOm9mb25vX3Vzc2RfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDgxOGUzMDQsIG5hbWU6IGF0bW9kZW08L2Rpdj4KPGRpdiBzdHls
ZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9zbXMuYzpvZm9ub19zbXNf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGUwNjAsIG5hbWU6IGF0bW9kZW08L2Rpdj4K
PGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9zaW0uYzpv
Zm9ub19zaW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGUxZTAsIG5hbWU6IGF0bW9k
ZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNy
Yy9zaW0uYzpvZm9ub19zaW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGUyNDAsIG5h
bWU6IGF0bW9kZW0tbm9lZjwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9m
b25vZFs1ODEyXTogc3JjL3N0ay5jOm9mb25vX3N0a19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
IDB4ODE4ZTJlNCwgbmFtZTogYXRtb2RlbTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6
MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDgxOGUxODAsIG5hbWU6IGF0bW9kZW08L2Rpdj4KPGRpdiBzdHls
ZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9jYnMuYzpvZm9ub19jYnNf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGUwYzAsIG5hbWU6IGF0bW9kZW08L2Rpdj4K
PGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9jYWxsLXZv
bHVtZS5jOm9mb25vX2NhbGxfdm9sdW1lX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThl
NDA0LCBuYW1lOiBhdG1vZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+
b2Zvbm9kWzU4MTJdOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDgxOGU0MzQsIG5hbWU6IGF0bW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1s
ZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlNDU4LCBuYW1lOiBhdG1vZGVtPC9kaXY+Cjxk
aXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvc2ltLWF1dGgu
YzpvZm9ub19zaW1fYXV0aF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZTQ3MCwgbmFt
ZTogYXRtb2RlbTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1
ODEyXTogc3JjL2duc3MuYzpvZm9ub19nbnNzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4
MThlNDg4LCBuYW1lOiBhdG1vZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0
OyI+b2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4ODE4ZGRjMCwgbmFtZTogZ29iaTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5n
LWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5mb19kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZGJlMCwgbmFtZTogcW1pbW9kZW08L2Rpdj4KPGRp
diBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9uZXR3b3JrLmM6
b2Zvbm9fbmV0cmVnX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThkYzYwLCBuYW1lOiBx
bWltb2RlbTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEy
XTogc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4ODE4ZGMwMCwgbmFtZTogcW1pbW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1s
ZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDgxOGRjYTAsIG5hbWU6IHFtaW1vZGVtLWxlZ2FjeTwvZGl2Pgo8ZGl2
IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL3Ntcy5jOm9mb25v
X3Ntc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZGQwMCwgbmFtZTogcW1pbW9kZW08
L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy91
c3NkLmM6b2Zvbm9fdXNzZF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZGQyMCwgbmFt
ZTogcW1pbW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2Rb
NTgxMl06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
ODE4ZGQzNCwgbmFtZTogcW1pbW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2
cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg4MThkZDQ4LCBuYW1lOiBxbWltb2RlbTwvZGl2Pgo8ZGl2IHN0
eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL3JhZGlvLXNldHRpbmdz
LmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGRk
NjAsIG5hbWU6IHFtaW1vZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+
b2Zvbm9kWzU4MTJdOiBzcmMvbG9jYXRpb24tcmVwb3J0aW5nLmM6b2Zvbm9fbG9jYXRpb25fcmVw
b3J0aW5nX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThkZDg0LCBuYW1lOiBxbWltb2Rl
bTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3Jj
L21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGRiODAs
IG5hbWU6IHU4NTAwPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9k
WzU4MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19kZXZpbmZvX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg4MThkYjYwLCBuYW1lOiB1ODUwMDwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6
MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDgxOGRiMDAsIG5hbWU6IG45MDA8L2Rpdj4KPGRpdiBzdHlsZT0icGFk
ZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThkYWEwLCBuYW1lOiBpc2l1c2I8L2Rpdj4KPGRp
diBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm9m
b25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGQ3OTAsIG5hbWU6IGlz
aW1vZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJd
OiBzcmMvcGhvbmVib29rLmM6b2Zvbm9fcGhvbmVib29rX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg4MThkNzgwLCBuYW1lOiBpc2ltb2RlbTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxl
ZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGQ3YzAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+CjxkaXYg
c3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvdm9pY2VjYWxsLmM6
b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThkODAwLCBuYW1l
OiBpc2ltb2RlbTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1
ODEyXTogc3JjL3Ntcy5jOm9mb25vX3Ntc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4
ZDg2MCwgbmFtZTogaXNpbW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7
Ij5vZm9ub2RbNTgxMl06IHNyYy9jYnMuYzpvZm9ub19jYnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDgxOGQ4ODAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmct
bGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvc2ltLmM6b2Zvbm9fc2ltX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg4MThkOGEwLCBuYW1lOiBpc2ltb2RlbTwvZGl2Pgo8ZGl2IHN0eWxl
PSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL3Vzc2QuYzpvZm9ub191c3Nk
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThkOGU4LCBuYW1lOiBpc2ltb2RlbTwvZGl2
Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL2NhbGwt
Zm9yd2FyZGluZy5jOm9mb25vX2NhbGxfZm9yd2FyZGluZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4ODE4ZDkwMCwgbmFtZTogaXNpbW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1s
ZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9jYWxsLXNldHRpbmdzLmM6b2Zvbm9fY2FsbF9z
ZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZDkyMCwgbmFtZTogaXNpbW9k
ZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNy
Yy9jYWxsLWJhcnJpbmcuYzpvZm9ub19jYWxsX2JhcnJpbmdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDgxOGQ5NTAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmct
bGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvY2FsbC1tZXRlci5jOm9mb25vX2NhbGxfbWV0
ZXJfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGQ5ODAsIG5hbWU6IGlzaW1vZGVtPC9k
aXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvcmFk
aW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4ODE4ZDljMCwgbmFtZTogaXNpbW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1s
ZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZDllNCwgbmFtZTogaXNpbW9kZW08L2Rpdj4KPGRpdiBzdHls
ZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9ncHJzLmM6b2Zvbm9fZ3By
c19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThkOWY4LCBuYW1lOiBpc2lt
b2RlbTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTog
c3JjL2F1ZGlvLXNldHRpbmdzLmM6b2Zvbm9fYXVkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDgxOGRhMTAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBh
ZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvc2ltLmM6b2Zvbm9fc2ltX2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThkYTIwLCBuYW1lOiB3Z21vZGVtMi41PC9kaXY+Cjxk
aXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZu
Zy5jOnVkZXZfc3RhcnQoKSA8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5v
Zm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6ZW51bWVyYXRlX2RldmljZXMoKSA8L2Rpdj4K
PGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRl
dm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIGh1YiBbKG51bGwpOihudWxsKV08L2Rpdj4KPGRpdiBz
dHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6
Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbODA4NzowMDI0XTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRk
aW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2Jf
ZGV2aWNlKCkgdXNiIFswNjdiOjIzMDNdPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDoz
NnB0OyI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBw
bDIzMDMgWyhudWxsKToobnVsbCldPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0
OyI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBwbDIz
MDMgWzA2N2I6MjMwM108L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9u
b2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbMDQ2ZDpj
MzEwXTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTog
cGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiaGlkIFsobnVsbCk6KG51bGwp
XTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogcGx1
Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiaGlkIFsobnVsbCk6KG51bGwpXTwv
ZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogcGx1Z2lu
cy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiaGlkIFsobnVsbCk6KG51bGwpXTwvZGl2
Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogcGx1Z2lucy91
ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgaHViIFsobnVsbCk6KG51bGwpXTwvZGl2Pgo8ZGl2
IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcu
YzpjaGVja191c2JfZGV2aWNlKCkgaHViIFsobnVsbCk6KG51bGwpXTwvZGl2Pgo8ZGl2IHN0eWxl
PSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVj
a191c2JfZGV2aWNlKCkgaHViIFsobnVsbCk6KG51bGwpXTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRk
aW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2Jf
ZGV2aWNlKCkgdXNiIFsxNzRjOjUxMDZdPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDoz
NnB0OyI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSB1
c2Itc3RvcmFnZSBbKG51bGwpOihudWxsKV08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0
OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgp
IGh1YiBbKG51bGwpOihudWxsKV08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7
Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBb
ODA4NzowMDI0XTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1
ODEyXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFswNjdiOjIzMDNd
PC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBwbHVn
aW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBwbDIzMDMgWyhudWxsKToobnVsbCldPC9k
aXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5z
L3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBwbDIzMDMgWzA2N2I6MjMwM108L2Rpdj4KPGRp
diBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5n
LmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbMDQ2ZDpjMDE2XTwvZGl2Pgo8ZGl2IHN0eWxlPSJw
YWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191
c2JfZGV2aWNlKCkgdXNiaGlkIFsobnVsbCk6KG51bGwpXTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRk
aW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2Jf
ZGV2aWNlKCkgdXNiIFswNThmOjYzNjJdPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDoz
NnB0OyI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSB1
c2Itc3RvcmFnZSBbKG51bGwpOihudWxsKV08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0
OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgp
IGh1YiBbKG51bGwpOihudWxsKV08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7
Ij5vZm9ub2RbNTgxMl06IHNyYy9wcml2YXRlLW5ldHdvcmsuYzpvZm9ub19wcml2YXRlX25ldHdv
cmtfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGZhZTAsIG5hbWU6IEV4YW1wbGUgUHJp
dmF0ZSBOZXR3b3JrIERyaXZlcjwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsi
Pm9mb25vZFs1ODEyXTogcGx1Z2lucy9ibHVldG9vdGguYzptYW5hZ2VyX3Byb3BlcnRpZXNfY2Io
KSA8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBs
dWdpbnMvYmx1ZXRvb3RoLmM6cGFyc2VfYWRhcHRlcnMoKSA8L2Rpdj4KPGRpdiBzdHlsZT0icGFk
ZGluZy1sZWZ0OjM2cHQ7Ij4mbmJzcDs8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2
cHQ7Ij4mZ3Q7IGhlcmUgSSBjb25uZWN0IHRoZSBtb2RlbSB0byB0aGUgVVNCPC9kaXY+CjxkaXYg
c3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+Jm5ic3A7PC9kaXY+CjxkaXYgc3R5bGU9InBhZGRp
bmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9k
ZXZpY2UoKSB1c2IgWzFiYzc6MTAwM108L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2
cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9w
dGlvbiBbKG51bGwpOihudWxsKV08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7
Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlv
biBbKG51bGwpOihudWxsKV08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5v
Zm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbiBb
KG51bGwpOihudWxsKV08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9u
b2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbiBbMWJj
NzoxMDAzXTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEy
XTogcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAv
MDAwMDowMDoxYS4wL3VzYjEvMS0xLzEtMS40PC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVm
dDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvc3lz
L2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFhLjAvdXNiMS8xLTEvMS0xLjQvMS0xLjQ6MS4x
L3R0eVVTQjMvdHR5L3R0eVVTQjM8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7
Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9kZXYvdHR5VVNC
MyAodGVsaXQpIDI1NS8yNTUvMjU1IFswMV0gPT0mZ3Q7IChudWxsKSAobnVsbCk8L2Rpdj4KPGRp
diBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldi5j
OnVkZXZfZXZlbnQoKSBzdWJzeXN0ZW0gdHR5IGFkZDwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5n
LWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1
YnN5c3RlbSB0dHkgZmluaXNoZWQ8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7
Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlv
biBbMWJjNzoxMDAzXTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25v
ZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BjaTAw
MDA6MDAvMDAwMDowMDoxYS4wL3VzYjEvMS0xLzEtMS40PC9kaXY+CjxkaXYgc3R5bGU9InBhZGRp
bmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2Uo
KSAvc3lzL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFhLjAvdXNiMS8xLTEvMS0xLjQvMS0x
LjQ6MS4yL3R0eVVTQjQvdHR5L3R0eVVTQjQ8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0
OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9kZXYv
dHR5VVNCNCAodGVsaXQpIDI1NS8yNTUvMjU1IFswMl0gPT0mZ3Q7IChudWxsKSAobnVsbCk8L2Rp
dj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMv
dWRldi5jOnVkZXZfZXZlbnQoKSBzdWJzeXN0ZW0gdHR5IGFkZDwvZGl2Pgo8ZGl2IHN0eWxlPSJw
YWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVu
dCgpIHN1YnN5c3RlbSB0dHkgZmluaXNoZWQ8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0
OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgp
IG9wdGlvbiBbMWJjNzoxMDAzXTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsi
Pm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2Vz
L3BjaTAwMDA6MDAvMDAwMDowMDoxYS4wL3VzYjEvMS0xLzEtMS40PC9kaXY+CjxkaXYgc3R5bGU9
InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOmFkZF9k
ZXZpY2UoKSAvc3lzL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFhLjAvdXNiMS8xLTEvMS0x
LjQvMS0xLjQ6MS4wL3R0eVVTQjIvdHR5L3R0eVVTQjI8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGlu
Zy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgp
IC9kZXYvdHR5VVNCMiAodGVsaXQpIDI1NS8yNTUvMjU1IFswMF0gPT0mZ3Q7IChudWxsKSAobnVs
bCk8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBs
dWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBzdWJzeXN0ZW0gdHR5IGFkZDwvZGl2Pgo8ZGl2IHN0
eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2LmM6dWRl
dl9ldmVudCgpIHN1YnN5c3RlbSB0dHkgZmluaXNoZWQ8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGlu
Zy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfbW9kZW1f
bGlzdCgpIDwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEy
XTogcGx1Z2lucy91ZGV2bmcuYzpjcmVhdGVfbW9kZW0oKSAvc3lzL2RldmljZXMvcGNpMDAwMDow
MC8wMDAwOjAwOjFhLjAvdXNiMS8xLTEvMS0xLjQ8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1s
ZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y3JlYXRlX21vZGVtKCkg
ZHJpdmVyPXRlbGl0PC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9k
WzU4MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9jcmVhdGUoKSBuYW1lOiAobnVsbCksIHR5
cGU6IHRlbGl0PC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4
MTJdOiBwbHVnaW5zL3VkZXZuZy5jOnNldHVwX3RlbGl0KCkgL3N5cy9kZXZpY2VzL3BjaTAwMDA6
MDAvMDAwMDowMDoxYS4wL3VzYjEvMS0xLzEtMS40PC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmct
bGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOnNldHVwX3RlbGl0KCkg
L2Rldi90dHlVU0IyIDI1NS8yNTUvMjU1IDAwIChudWxsKTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRk
aW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF90ZWxp
dCgpIC9kZXYvdHR5VVNCMyAyNTUvMjU1LzI1NSAwMSAobnVsbCk8L2Rpdj4KPGRpdiBzdHlsZT0i
cGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBf
dGVsaXQoKSAvZGV2L3R0eVVTQjQgMjU1LzI1NS8yNTUgMDIgKG51bGwpPC9kaXY+CjxkaXYgc3R5
bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOnNl
dHVwX3RlbGl0KCkgbW9kZW09L2Rldi90dHlVU0IyIGF1eD0vZGV2L3R0eVVTQjQgZ3BzPShudWxs
KSBkaWFnPS9kZXYvdHR5VVNCMzwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsi
Pm9mb25vZFs1ODEyXTogc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg4
ZTBmMTQwIHByb3BlcnR5IE1vZGVtPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0
OyI+b2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAw
eDhlMGYxNDAgcHJvcGVydHkgRGF0YTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZw
dDsiPm9mb25vZFs1ODEyXTogc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0g
MHg4ZTBmMTQwIHByb3BlcnR5IEdQUzwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZw
dDsiPm9mb25vZFs1ODEyXTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fcmVnaXN0ZXIoKSAweDhl
MGYxNDA8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06
IHBsdWdpbnMvdGVsaXQuYzp0ZWxpdF9wcm9iZSgpIDB4OGUwZjE0MDwvZGl2Pgo8ZGl2IHN0eWxl
PSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL21vZGVtLmM6ZW1pdF9tb2Rl
bV9hZGRlZCgpIDB4OGUwZjE0MDwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsi
Pm9mb25vZFs1ODEyXTogc3JjL21vZGVtLmM6Y2FsbF9tb2RlbXdhdGNoZXMoKSAweDhlMGYxNDAg
YWRkZWQ6MTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEy
XTogcGx1Z2lucy9oZnBfYWcuYzptb2RlbV93YXRjaCgpIG1vZGVtOiAweDhlMGYxNDAsIGFkZGVk
OiAxPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBw
bHVnaW5zL2R1bl9ndy5jOm1vZGVtX3dhdGNoKCkgbW9kZW06IDB4OGUwZjE0MCwgYWRkZWQ6IDE8
L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IGV4YW1w
bGVzL2VtdWxhdG9yLmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg4ZTBmMTQwLCBhZGRlZDogMTwv
ZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogcGx1Z2lu
cy9zbWFydC1tZXNzYWdpbmcuYzptb2RlbV93YXRjaCgpIG1vZGVtOiAweDhlMGYxNDAsIGFkZGVk
OiAxPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBw
bHVnaW5zL3B1c2gtbm90aWZpY2F0aW9uLmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg4ZTBmMTQw
LCBhZGRlZDogMTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPiZuYnNwOzwv
ZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPiQgZW5hYmxlLW1vZGVtIC90ZWxp
dF8wPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+Jm5ic3A7PC9kaXY+Cjxk
aXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3RlbGl0
LmM6dGVsaXRfZW5hYmxlKCkgMHg4ZTBmMTQwPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVm
dDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBt
b2RlbSAweDhlMGYxNDAgcHJvcGVydHkgTW9kZW08L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1s
ZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdGVsaXQuYzpvcGVuX2RldmljZSgpIE1v
ZGVtIC9kZXYvdHR5VVNCMjwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9m
b25vZFs1ODEyXTogTW9kZW06ICZndDsgQVRFMCAmIzQzO0NNRUU9MVxyPC9kaXY+CjxkaXYgc3R5
bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBNb2RlbTogJmx0OyBcclxuT0tc
clxuPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBN
b2RlbTogJmd0OyBBVCYjNDM7Q0ZVTj00XHI8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0
OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IE1vZGVtOiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj4KPGRpdiBz
dHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdGVsaXQuYzpj
ZnVuX2VuYWJsZV9jYigpIDB4OGUwZjE0MDwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6
MzZwdDsiPm9mb25vZFs1ODEyXTogZXhhbXBsZXMvZW11bGF0b3IuYzpwb3dlcmVkX3dhdGNoKCkg
QWRkaW5nIG1vZGVtIDB4OGUwZjE0MCB0byB0aGUgbGlzdDwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRk
aW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogZXhhbXBsZXMvZW11bGF0b3IuYzpjcmVhdGVf
dGNwKCkgQ3JlYXRlZCBzZXJ2ZXJfd2F0Y2g6IDM4PC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmct
bGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBleGFtcGxlcy9lbXVsYXRvci5jOmNyZWF0ZV90Y3Ao
KSBDcmVhdGVkIHNlcnZlcl93YXRjaDogMzk8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0
OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm1vZGVtX2NoYW5nZV9zdGF0ZSgpIG9s
ZCBzdGF0ZTogMCwgbmV3IHN0YXRlOiAxPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDoz
NnB0OyI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3RlbGl0LmM6dGVsaXRfcHJlX3NpbSgpIDB4OGUw
ZjE0MDwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTog
ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X3NpbV9wcm9iZSgpIEdJWkVSTyBhdF9zaW1fcHJvYmU6
IHZlbmRvciAxNTwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1
ODEyXTogTW9kZW06ICZndDsgQVQmIzQzO0dDQVBccjwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5n
LWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogc3JjL3NpbS5jOm9mb25vX3NpbV9hZGRfc3RhdGVf
d2F0Y2goKSAweDhlMDZhOTA8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5v
Zm9ub2RbNTgxMl06IHNyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3N0YXRlX3dhdGNoKCkgMHg4ZTA2
YTkwPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBz
cmMvc2ltLmM6b2Zvbm9fc2ltX2FkZF9zdGF0ZV93YXRjaCgpIDB4OGUwNmE5MDwvZGl2Pgo8ZGl2
IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogTW9kZW06ICZsdDsgXHJc
biYjNDM7R0NBUDogJiM0MztDR1NNLCYjNDM7RFMsJiM0MztGQ0xBU1MsJiM0MztNUywmIzQzO0VT
XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9u
b2RbNTgxMl06IE1vZGVtOiAmZ3Q7IEFUJiM0MztDUkM9MVxyPC9kaXY+CjxkaXYgc3R5bGU9InBh
ZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBNb2RlbTogJmx0OyBcclxuT0tcclxuPC9k
aXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBNb2RlbTog
Jmd0OyBBVCYjNDM7Q0xJUD0xXHI8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7
Ij5vZm9ub2RbNTgxMl06IE1vZGVtOiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj4KPGRpdiBzdHlsZT0i
cGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IE1vZGVtOiAmZ3Q7IEFUJiM0MztDRElQ
PTFccjwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTog
TW9kZW06ICZsdDsgXHJcbkVSUk9SXHJcbjwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6
MzZwdDsiPm9mb25vZFs1ODEyXTogTW9kZW06ICZndDsgQVQmIzQzO0NOQVA9MVxyPC9kaXY+Cjxk
aXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBNb2RlbTogJmx0OyBc
clxuRVJST1JcclxuPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9k
WzU4MTJdOiBNb2RlbTogJmd0OyBBVCYjNDM7Q09MUD0xXHI8L2Rpdj4KPGRpdiBzdHlsZT0icGFk
ZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IE1vZGVtOiAmbHQ7IFxyXG4mIzQzO0NNRSBF
UlJPUjogMTBcclxuPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9k
WzU4MTJdOiBNb2RlbTogJmd0OyBBVCYjNDM7Q1NTTj0xLDFccjwvZGl2Pgo8ZGl2IHN0eWxlPSJw
YWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogTW9kZW06ICZsdDsgXHJcbiYjNDM7Q01F
IEVSUk9SOiAxMFxyXG48L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9u
b2RbNTgxMl06IE1vZGVtOiAmZ3Q7IEFUJiM0MztWVEQ/XHI8L2Rpdj4KPGRpdiBzdHlsZT0icGFk
ZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IE1vZGVtOiAmbHQ7IFxyXG4mIzQzO0NNRSBF
UlJPUjogMTBcclxuPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9k
WzU4MTJdOiBNb2RlbTogJmd0OyBBVCYjNDM7Q0NXQT0xXHI8L2Rpdj4KPGRpdiBzdHlsZT0icGFk
ZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IE1vZGVtOiAmbHQ7IFxyXG4mIzQzO0NNRSBF
UlJPUjogMTBcclxuPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9k
WzU4MTJdOiBkcml2ZXJzL2F0bW9kZW0vdm9pY2VjYWxsLmM6YXRfdm9pY2VjYWxsX2luaXRpYWxp
emVkKCkgdm9pY2VjYWxsX2luaXQ6IHJlZ2lzdGVyaW5nIHRvIG5vdGlmaWNhdGlvbnM8L2Rpdj4K
PGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IHNyYy9zaW0uYzpv
Zm9ub19zaW1fYWRkX3N0YXRlX3dhdGNoKCkgMHg4ZTA2YTkwPC9kaXY+CjxkaXYgc3R5bGU9InBh
ZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBNb2RlbTogJmd0OyBBVCNRU1M9MVxyPC9k
aXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBNb2RlbTog
Jmx0OyBcclxuT0tcclxuPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zv
bm9kWzU4MTJdOiBNb2RlbTogJmd0OyBBVCNRU1M/XHI8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGlu
Zy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IE1vZGVtOiAmbHQ7IFxyXG4jUVNTOiAxLDFcclxu
XHJcbk9LXHJcbjwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1
ODEyXTogcGx1Z2lucy90ZWxpdC5jOnRlbGl0X3Fzc19jYigpIDB4OGUwZjE0MDwvZGl2Pgo8ZGl2
IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogcGx1Z2lucy90ZWxpdC5j
OnN3aXRjaF9zaW1fc3RhdGVfc3RhdHVzKCkgMHg4ZTBmMTQwPC9kaXY+CjxkaXYgc3R5bGU9InBh
ZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3RlbGl0LmM6c3dpdGNoX3Np
bV9zdGF0ZV9zdGF0dXMoKSBTSU0gaW5zZXJ0ZWQ8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1s
ZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IE1vZGVtOiAmZ3Q7IEFUJiM0MztDR01JXHI8L2Rpdj4K
PGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IE1vZGVtOiAmbHQ7
IFxyXG5UZWxpdFxyXG5cclxuT0tcclxuPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDoz
NnB0OyI+b2Zvbm9kWzU4MTJdOiBNb2RlbTogJmd0OyBBVCYjNDM7Q0xDQ1xyPC9kaXY+CjxkaXYg
c3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBNb2RlbTogJmx0OyBcclxu
JiM0MztDTUUgRVJST1I6IDEwXHJcbjwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZw
dDsiPm9mb25vZFs1ODEyXTogTW9kZW06ICZndDsgQVQmIzQzO0NHTU1ccjwvZGl2Pgo8ZGl2IHN0
eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogTW9kZW06ICZsdDsgXHJcblVD
ODY0LUVcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsi
Pm9mb25vZFs1ODEyXTogTW9kZW06ICZndDsgQVQmIzQzO0NHTVJccjwvZGl2Pgo8ZGl2IHN0eWxl
PSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogTW9kZW06ICZsdDsgXHJcbjA4LjAx
LjAwNVxyXG5cclxuT0tcclxuPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+
b2Zvbm9kWzU4MTJdOiBNb2RlbTogJmd0OyBBVCYjNDM7Q0dTTlxyPC9kaXY+CjxkaXYgc3R5bGU9
InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBNb2RlbTogJmx0OyBcclxuMzUyNjM2
MDIwNDEyNzY4XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2
cHQ7Ij5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdGVsaXQuYzpzaW1faW5zZXJ0ZWRfdGltZW91dF9j
YigpIDB4OGUwZjE0MDwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25v
ZFs1ODEyXTogTW9kZW06ICZndDsgQVQmIzQzO0NSU009MTkyLDI4NTk5XHI8L2Rpdj4KPGRpdiBz
dHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IE1vZGVtOiAmbHQ7IFxyXG4m
IzQzO0NNRSBFUlJPUjogMTAwXHJcbjwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZw
dDsiPm9mb25vZFs1ODEyXTogc3JjL3ZvaWNlY2FsbC5jOmVjY19nMl9yZWFkX2NiKCkgMDwvZGl2
Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogTW9kZW06ICZn
dDsgQVQmIzQzO0NSU009MTkyLDI4NTk5XHI8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0
OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IE1vZGVtOiAmbHQ7IFxyXG4mIzQzO0NNRSBFUlJPUjogMTAw
XHJcbjwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTog
c3JjL3ZvaWNlY2FsbC5jOmVjY19nM19yZWFkX2NiKCkgMDwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRk
aW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogTW9kZW06ICZndDsgQVQmIzQzO0NSU009MTky
LDEyMjU4XHI8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5vZm9ub2RbNTgx
Ml06IE1vZGVtOiAmbHQ7IFxyXG4mIzQzO0NNRSBFUlJPUjogMTAwXHJcbjwvZGl2Pgo8ZGl2IHN0
eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogTW9kZW06ICZndDsgQVQmIzQz
O0NSU009MTkyLDI4NDIxXHI8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0OjM2cHQ7Ij5v
Zm9ub2RbNTgxMl06IE1vZGVtOiAmbHQ7IFxyXG4mIzQzO0NNRSBFUlJPUjogMTAwXHJcbjwvZGl2
Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTogTW9kZW06ICZn
dDsgQVQmIzQzO0NSU009MTkyLDEyMDM3XHI8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0
OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IE1vZGVtOiAmbHQ7IFxyXG4mIzQzO0NNRSBFUlJPUjogMTAw
XHJcbjwvZGl2Pgo8ZGl2IHN0eWxlPSJwYWRkaW5nLWxlZnQ6MzZwdDsiPm9mb25vZFs1ODEyXTog
TW9kZW06ICZndDsgQVQmIzQzO0NQSU4/XHI8L2Rpdj4KPGRpdiBzdHlsZT0icGFkZGluZy1sZWZ0
OjM2cHQ7Ij5vZm9ub2RbNTgxMl06IE1vZGVtOiAmbHQ7IFxyXG4mIzQzO0NNRSBFUlJPUjogMTBc
clxuPC9kaXY+CjxkaXYgc3R5bGU9InBhZGRpbmctbGVmdDozNnB0OyI+b2Zvbm9kWzU4MTJdOiBR
dWVyeWluZyBQSU4gYXV0aGVudGljYXRpb24gc3RhdGUgZmFpbGVkPC9kaXY+CjxkaXY+Jm5ic3A7
PC9kaXY+CjxkaXY+QWNjb3JkaW5nIHRvIHlvdXIgbG9nLCB0aGVyZSBpcyBubyBTSU0gaW5zZXJ0
ZWQsIHRoaXMgaXMgd2h5IHlvdSBnb3QgdGhvc2UgZXJyb3JzLjwvZGl2Pgo8ZGl2PiZuYnNwOzwv
ZGl2Pgo8ZGl2PkJ1dCB0aGUgZW5hYmxlLW1vZGVtIGxvb2tzIGdvb2QuIERpZCB5b3UgZG8gYSAu
L2xpc3QtbW9kZW1zIHRvIHNlZSB0aGUgY3VycmVudCBtb2RlbSBpbmZvPzwvZGl2Pgo8ZGl2PiZu
YnNwOzwvZGl2Pgo8ZGl2PkFuZCBpZiB5b3UgaW5zZXJ0IGEgU0lNLCBkaWQgeW91IHRyaWVkIGFu
IC4vb25saW5lLW1vZGVtPzwvZGl2Pgo8ZGl2PiZuYnNwOzwvZGl2Pgo8ZGl2PlJlZ2FyZHMsPC9k
aXY+CjxkaXY+Jm5ic3A7PC9kaXY+CjxkaXY+QmVydHJhbmQ8L2Rpdj4KPGRpdj4mbmJzcDs8L2Rp
dj4KPGRpdj4mbmJzcDs8L2Rpdj4KPC9zcGFuPjwvZm9udD4KPGZvbnQgZmFjZT0ibW9ub3NwYWNl
Ij4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS08YnI+CkludGVsIENvcnBvcmF0aW9uIFNBUyAoRnJlbmNoIHNpbXBsaWZp
ZWQgam9pbnQgc3RvY2sgY29tcGFueSk8YnI+ClJlZ2lzdGVyZWQgaGVhZHF1YXJ0ZXJzOiAiTGVz
IE1vbnRhbGV0cyItIDIsIHJ1ZSBkZSBQYXJpcywgPGJyPgo5MjE5NiBNZXVkb24gQ2VkZXgsIEZy
YW5jZTxicj4KUmVnaXN0cmF0aW9uIE51bWJlcjombmJzcDsgMzAyIDQ1NiAxOTkgUi5DLlMuIE5B
TlRFUlJFPGJyPgpDYXBpdGFsOiA0LDU3MiwwMDAgRXVyb3M8YnI+Cjxicj4KVGhpcyBlLW1haWwg
YW5kIGFueSBhdHRhY2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgbWF0ZXJpYWwgZm9y
PGJyPgp0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gQW55IHJldmll
dyBvciBkaXN0cmlidXRpb248YnI+CmJ5IG90aGVycyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJ
ZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQ8YnI+CnJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3Qg
dGhlIHNlbmRlciBhbmQgZGVsZXRlIGFsbCBjb3BpZXMuPC9mb250PjwvYm9keT4KPC9odG1sPgo=

--===============5680557865429412167==--

