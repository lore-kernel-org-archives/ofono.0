Content-Type: multipart/mixed; boundary="===============3664023993647426667=="
MIME-Version: 1.0
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
Subject: crash when unplugged modem when it was still initializing
Date: Tue, 24 Jan 2012 23:19:33 +0200
Message-ID: <CAHiDW_HxRFdVs0ijyR6q3RARuGB57L_JKkrccVU2mVOCE7D2kA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3664023993647426667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
I happened to unplug my dongle quite soon after starting ofono. It
promptly aborted.
This is with git master from today.

 - Jussi

$ sudo src/ofonod -n -d
ofonod[16006]: oFono version 1.3
ofonod[16006]: src/plugin.c:__ofono_plugin_init()
ofonod[16006]: plugins/push-notification.c:push_notification_init()
ofonod[16006]: plugins/smart-messaging.c:smart_messaging_init()
ofonod[16006]: examples/emulator.c:example_emulator_init()
ofonod[16006]: src/gprs-provision.c:ofono_gprs_provision_driver_register()
driver: 0x81765c0 name: Example GPRS context provisioning
ofonod[16006]: src/nettime.c:ofono_nettime_driver_register() driver:
0x8176580 name: Example Network Time
ofonod[16006]: src/history.c:ofono_history_driver_register() driver:
0x8176540 name: Example Call History
ofonod[16006]: src/cdma-provision.c:ofono_cdma_provision_driver_register()
driver: 0x8176500 name: CDMA provisioning
ofonod[16006]: src/gprs-provision.c:ofono_gprs_provision_driver_register()
driver: 0x81764c0 name: Provisioning
ofonod[16006]: plugins/connman.c:connman_init()
ofonod[16006]: src/private-network.c:ofono_private_network_driver_register()
driver: 0x8176480, name: ConnMan Private Network
ofonod[16006]: plugins/dun_gw.c:dun_gw_init()
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8176380, name: hfp
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8176320, name: sap
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x81762a0, name: telit
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8176200, name: sim900
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x81761a0, name: samsung
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8176140, name: speedupcdma
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x81760e0, name: speedup
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8176080, name: alcatel
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8176020, name: linktop
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8175fc0, name: nokiacdma
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8175f60, name: nokia
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8175f00, name: tc65
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8175e60, name: ste
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8175e00, name: ifx
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8175da0, name: palmpre
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8175d40, name: novatel
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8175ce0, name: sierra
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8175c60, name: huawei
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8175c00, name: zte
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8175ba0, name: hso
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8175b40, name: mbm
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8175ae0, name: calypso
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8175a80, name: wavecom
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8175a20, name: gobi
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x81759c0, name: g1
ofonod[16006]: src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register()
driver: 0x8175940, name: cdmamodem
ofonod[16006]: src/modem.c:ofono_devinfo_driver_register() driver:
0x8175960, name: cdmamodem
ofonod[16006]: src/cdma-connman.c:ofono_cdma_connman_driver_register()
driver: 0x8175984, name: cdmamodem
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x81758a0, name: phonesim
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x81758e0, name: localhfp
ofonod[16006]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8175874, name: phonesim
ofonod[16006]: src/ctm.c:ofono_ctm_driver_register() driver:
0x8175860, name: phonesim
ofonod[16006]: plugins/phonesim.c:parse_config() filename
/etc/ofono/phonesim.conf
ofonod[16006]: Reading of /etc/ofono/phonesim.conf failed: No such
file or directory
ofonod[16006]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x8175740, name: hfpmodem
ofonod[16006]: src/modem.c:ofono_devinfo_driver_register() driver:
0x81757fc, name: hfpmodem
ofonod[16006]: src/network.c:ofono_netreg_driver_register() driver:
0x81757a0, name: hfpmodem
ofonod[16006]: src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x81757d4, name: hfpmodem
ofonod[16006]: src/handsfree.c:ofono_handsfree_driver_register()
driver: 0x8175818, name: hfpmodem
ofonod[16006]: src/network.c:ofono_netreg_driver_register() driver:
0x81756c0, name: dunmodem
ofonod[16006]: src/gprs.c:ofono_gprs_driver_register() driver:
0x81756ec, name: dunmodem
ofonod[16006]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x81755e0, name: stemodem
ofonod[16006]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x817566c, name: stemodem
ofonod[16006]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8175640, name: stemodem
ofonod[16006]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x81754a0, name: ifxmodem
ofonod[16006]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x81754f0, name: ifxmodem
ofonod[16006]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8175520, name: ifxmodem
ofonod[16006]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x817554c, name: ifxmodem
ofonod[16006]: src/stk.c:ofono_stk_driver_register() driver:
0x8175570, name: ifxmodem
ofonod[16006]: src/ctm.c:ofono_ctm_driver_register() driver:
0x8175598, name: ifxmodem
ofonod[16006]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8175420, name: hsomodem
ofonod[16006]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8175440, name: hsomodem
ofonod[16006]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8175380, name: mbmmodem
ofonod[16006]: src/stk.c:ofono_stk_driver_register() driver:
0x81753a4, name: mbmmodem
ofonod[16006]: src/location-reporting.c:ofono_location_reporting_driver_reg=
ister()
driver: 0x81753c4, name: mbmmodem
ofonod[16006]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x81752e0, name: calypsomodem
ofonod[16006]: src/stk.c:ofono_stk_driver_register() driver:
0x8175328, name: calypsomodem
ofonod[16006]: src/ussd.c:ofono_ussd_driver_register() driver:
0x81751c0, name: huaweimodem
ofonod[16006]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x81751e0, name: huaweimodem
ofonod[16006]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x8175228, name: huaweimodem
ofonod[16006]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8175260, name: huaweimodem
ofonod[16006]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x817523c, name: huaweimodem
ofonod[16006]: src/cdma-netreg.c:ofono_cdma_netreg_driver_register()
driver: 0x817528c, name: huaweimodem
ofonod[16006]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8175160, name: nwmodem
ofonod[16006]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x8174fc0, name: atmodem
ofonod[16006]: src/modem.c:ofono_devinfo_driver_register() driver:
0x8175060, name: atmodem
ofonod[16006]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x8175018, name: atmodem
ofonod[16006]: src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x8174d80, name: atmodem
ofonod[16006]: src/call-meter.c:ofono_call_meter_driver_register()
driver: 0x8174dc0, name: atmodem
ofonod[16006]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x8174c80, name: atmodem
ofonod[16006]: src/phonebook.c:ofono_phonebook_driver_register()
driver: 0x8175038, name: atmodem
ofonod[16006]: src/ussd.c:ofono_ussd_driver_register() driver:
0x8174f94, name: atmodem
ofonod[16006]: src/sms.c:ofono_sms_driver_register() driver:
0x8174d00, name: atmodem
ofonod[16006]: src/sim.c:ofono_sim_driver_register() driver:
0x8174e80, name: atmodem
ofonod[16006]: src/sim.c:ofono_sim_driver_register() driver:
0x8174ee0, name: atmodem-noef
ofonod[16006]: src/stk.c:ofono_stk_driver_register() driver:
0x8174f74, name: atmodem
ofonod[16006]: src/network.c:ofono_netreg_driver_register() driver:
0x8174e20, name: atmodem
ofonod[16006]: src/cbs.c:ofono_cbs_driver_register() driver:
0x8174d60, name: atmodem
ofonod[16006]: src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x8175084, name: atmodem
ofonod[16006]: src/gprs.c:ofono_gprs_driver_register() driver:
0x81750b4, name: atmodem
ofonod[16006]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x81750d8, name: atmodem
ofonod[16006]: src/sim-auth.c:ofono_sim_auth_driver_register() driver:
0x81750ec, name: atmodem
ofonod[16006]: src/gnss.c:ofono_gnss_driver_register() driver:
0x8175104, name: atmodem
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8174a60, name: u8500
ofonod[16006]: src/modem.c:ofono_devinfo_driver_register() driver:
0x8174a40, name: u8500
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x81749e0, name: n900
ofonod[16006]: src/modem.c:ofono_modem_driver_register() driver:
0x8174980, name: isiusb
ofonod[16006]: src/modem.c:ofono_devinfo_driver_register() driver:
0x8174670, name: isimodem
ofonod[16006]: src/phonebook.c:ofono_phonebook_driver_register()
driver: 0x8174660, name: isimodem
ofonod[16006]: src/network.c:ofono_netreg_driver_register() driver:
0x81746a0, name: isimodem
ofonod[16006]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x81746e0, name: isimodem
ofonod[16006]: src/sms.c:ofono_sms_driver_register() driver:
0x8174740, name: isimodem
ofonod[16006]: src/cbs.c:ofono_cbs_driver_register() driver:
0x8174760, name: isimodem
ofonod[16006]: src/sim.c:ofono_sim_driver_register() driver:
0x8174780, name: isimodem
ofonod[16006]: src/ussd.c:ofono_ussd_driver_register() driver:
0x81747c8, name: isimodem
ofonod[16006]: src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x81747e0, name: isimodem
ofonod[16006]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x8174800, name: isimodem
ofonod[16006]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x8174830, name: isimodem
ofonod[16006]: src/call-meter.c:ofono_call_meter_driver_register()
driver: 0x8174860, name: isimodem
ofonod[16006]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x81748a0, name: isimodem
ofonod[16006]: src/gprs.c:ofono_gprs_driver_register() driver:
0x81748c4, name: isimodem
ofonod[16006]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x81748d8, name: isimodem
ofonod[16006]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x81748ec, name: isimodem
ofonod[16006]: src/sim.c:ofono_sim_driver_register() driver:
0x8174900, name: wgmodem2.5
ofonod[16006]: plugins/udevng.c:udev_start()
ofonod[16006]: plugins/udevng.c:enumerate_devices()
ofonod[16006]: plugins/udevng.c:check_usb_device() option [12d1:140c]
ofonod[16006]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0/ttyUSB3/tty/t=
tyUSB3
ofonod[16006]: plugins/udevng.c:add_device() /dev/ttyUSB3 (huawei)
255/255/255 [00] =3D=3D> (null) (null)
ofonod[16006]: plugins/udevng.c:check_usb_device() option [12d1:140c]
ofonod[16006]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.1/ttyUSB2/tty/t=
tyUSB2
ofonod[16006]: plugins/udevng.c:add_device() /dev/ttyUSB2 (huawei)
255/255/255 [01] =3D=3D> (null) (null)
ofonod[16006]: plugins/udevng.c:check_usb_device() option [12d1:140c]
ofonod[16006]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.2/ttyUSB1/tty/t=
tyUSB1
ofonod[16006]: plugins/udevng.c:add_device() /dev/ttyUSB1 (huawei)
255/255/255 [02] =3D=3D> (null) (null)
ofonod[16006]: plugins/udevng.c:check_usb_device() option [12d1:140c]
ofonod[16006]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.3/ttyUSB0/tty/t=
tyUSB0
ofonod[16006]: plugins/udevng.c:add_device() /dev/ttyUSB0 (huawei)
255/255/255 [03] =3D=3D> (null) (null)
ofonod[16006]: plugins/udevng.c:create_modem()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1
ofonod[16006]: plugins/udevng.c:create_modem() driver=3Dhuawei
ofonod[16006]: src/modem.c:ofono_modem_create() name: (null), type: huawei
ofonod[16006]: plugins/udevng.c:setup_huawei()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1
ofonod[16006]: plugins/udevng.c:setup_huawei() /dev/ttyUSB3
255/255/255 00 (null)
ofonod[16006]: plugins/udevng.c:setup_huawei() /dev/ttyUSB2
255/255/255 01 (null)
ofonod[16006]: plugins/udevng.c:setup_huawei() /dev/ttyUSB1
255/255/255 02 (null)
ofonod[16006]: plugins/udevng.c:setup_huawei() /dev/ttyUSB0
255/255/255 03 (null)
ofonod[16006]: plugins/udevng.c:setup_huawei() modem=3D/dev/ttyUSB3
pcui=3D/dev/ttyUSB0 diag=3D(null)
ofonod[16006]: src/modem.c:set_modem_property() modem 0x8b62bd8 property Mo=
dem
ofonod[16006]: src/modem.c:set_modem_property() modem 0x8b62bd8 property Pc=
ui
ofonod[16006]: src/modem.c:set_modem_property() modem 0x8b62bd8 property Di=
ag
ofonod[16006]: src/modem.c:ofono_modem_register() 0x8b62bd8
ofonod[16006]: plugins/huawei.c:huawei_probe() 0x8b62bd8
ofonod[16006]: src/modem.c:emit_modem_added() 0x8b62bd8
ofonod[16006]: src/modem.c:call_modemwatches() 0x8b62bd8 added:1
ofonod[16006]: plugins/hfp_ag.c:modem_watch() modem: 0x8b62bd8, added: 1
ofonod[16006]: plugins/dun_gw.c:modem_watch() modem: 0x8b62bd8, added: 1
ofonod[16006]: examples/emulator.c:modem_watch() modem: 0x8b62bd8, added: 1
ofonod[16006]: plugins/smart-messaging.c:modem_watch() modem:
0x8b62bd8, added: 1
ofonod[16006]: plugins/push-notification.c:modem_watch() modem:
0x8b62bd8, added: 1
ofonod[16006]: src/private-network.c:ofono_private_network_driver_register()
driver: 0x8176620, name: Example Private Network Driver
ofonod[16006]: plugins/huawei.c:huawei_enable() 0x8b62bd8
ofonod[16006]: src/modem.c:get_modem_property() modem 0x8b62bd8 property Mo=
dem
ofonod[16006]: plugins/huawei.c:open_device() Modem /dev/ttyUSB3
ofonod[16006]: src/modem.c:get_modem_property() modem 0x8b62bd8 property Pc=
ui
ofonod[16006]: plugins/huawei.c:open_device() Pcui /dev/ttyUSB0
ofonod[16006]: plugins/bluetooth.c:manager_properties_cb()
ofonod[16006]: plugins/bluetooth.c:parse_adapters()
ofonod[16006]: plugins/bluetooth.c:parse_adapters() Calling
GetProperties on /org/bluez/1807/hci0
ofonod[16006]: plugins/bluetooth.c:adapter_properties_cb()
ofonod[16006]: plugins/bluetooth.c:parse_devices()
ofonod[16006]: plugins/bluetooth.c:adapter_properties_cb() Adapter
Address: C4:17:FE:F2:D6:EA, Path: /org/bluez/1807/hci0
ofonod[16006]: plugins/bluetooth.c:device_properties_cb()
ofonod[16006]: plugins/bluetooth.c:device_properties_cb()
ofonod[16006]: Using device:
/org/bluez/1807/hci0/dev_A0_75_91_53_30_96, devaddr:
A0:75:91:53:30:96, adapter: C4:17:FE:F2:D6:EA
ofonod[16006]: src/modem.c:ofono_modem_create() name:
hfp/C417FEF2D6EA_A07591533096, type: hfp
ofonod[16006]: src/modem.c:ofono_modem_register() 0x8b55498
ofonod[16006]: plugins/hfp_hf.c:hfp_register_ofono_handsfree()
Registering oFono Agent to bluetooth daemon
ofonod[16006]: src/modem.c:emit_modem_added() 0x8b55498
ofonod[16006]: src/modem.c:call_modemwatches() 0x8b55498 added:1
ofonod[16006]: plugins/hfp_ag.c:modem_watch() modem: 0x8b55498, added: 1
ofonod[16006]: plugins/dun_gw.c:modem_watch() modem: 0x8b55498, added: 1
ofonod[16006]: examples/emulator.c:modem_watch() modem: 0x8b55498, added: 1
ofonod[16006]: plugins/smart-messaging.c:modem_watch() modem:
0x8b55498, added: 1
ofonod[16006]: plugins/push-notification.c:modem_watch() modem:
0x8b55498, added: 1
ofonod[16006]: plugins/hfp_hf.c:hfp_enable() 0x8b55498
ofonod[16006]: plugins/hfp_hf.c:hfp_connect_reply() Connect reply:
Method "Connect" with signature "" on interface
"org.bluez.HandsfreeGateway" doesn't exist
ofonod[16006]: plugins/huawei.c:cfun_enable()
ofonod[16006]: plugins/huawei.c:sysinfo_enable_cb() 255 -> 0
ofonod[16006]: plugins/huawei.c:cfun_offline()
ofonod[16006]: examples/emulator.c:powered_watch() Adding modem
0x8b62bd8 to the list
ofonod[16006]: examples/emulator.c:create_tcp() Created server_watch: 58
ofonod[16006]: examples/emulator.c:create_tcp() Created server_watch: 59
ofonod[16006]: src/modem.c:modem_change_state() old state: 0, new state: 1
ofonod[16006]: plugins/huawei.c:huawei_pre_sim() 0x8b62bd8
ofonod[16006]: src/sim.c:ofono_sim_add_state_watch() 0x8b62970
ofonod[16006]: src/sim.c:ofono_sim_add_state_watch() 0x8b62970
ofonod[16006]: src/sim.c:ofono_sim_add_state_watch() 0x8b62970
ofonod[16006]: Modem and NDIS support (CDC support: unknown)
ofonod[16006]: Voice channel: 8000 Hz, 16 bits, 20ms period
ofonod[16006]: plugins/udevng.c:remove_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0/ttyUSB3/tty/t=
tyUSB3
ofonod[16006]: plugins/udevng.c:destroy_modem()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1
ofonod[16006]: src/modem.c:ofono_modem_remove() 0x8b62bd8
ofonod[16006]: src/modem.c:modem_unregister() 0x8b62bd8
ofonod[16006]: src/modem.c:modem_change_state() old state: 1, new state: 0
ofonod[16006]: src/modem.c:flush_atoms()
ofonod[16006]: Aborting (signal 11) [src/ofonod]
ofonod[16006]: ++++++++ backtrace ++++++++
ofonod[16006]: #0  0xb7766400 in
ofonod[16006]: #1  0x8115d84 in sim_fs_file_watch_remove() at src/simfs.c:2=
16
ofonod[16006]: #2  0x80f294a in ofono_sim_remove_file_watch() at src/sim.c:=
2127
ofonod[16006]: #3  0x80cf2e8 in __ofono_atom_unregister() at src/modem.c:275
ofonod[16006]: #4  0x80cf370 in flush_atoms() at src/modem.c:423
ofonod[16006]: #5  0x80cf537 in set_powered() at src/modem.c:863
ofonod[16006]: #6  0x80cf7b3 in modem_unregister() at src/modem.c:2006
ofonod[16006]: #7  0x80d1213 in ofono_modem_remove() at src/modem.c:2076
ofonod[16006]: #8  0x805ae32 in destroy_modem() at plugins/udevng.c:698
ofonod[16006]: #9  0xb7649968 in /lib/i386-linux-gnu/libglib-2.0.so.0
ofonod[16006]: #10 0xb7649f98 in /lib/i386-linux-gnu/libglib-2.0.so.0
ofonod[16006]: #11 0x805b18a in remove_device() at plugins/udevng.c:750
ofonod[16006]: #12 0xb76a29ce in /lib/i386-linux-gnu/libglib-2.0.so.0
ofonod[16006]: #13 0xb765ca3f in /lib/i386-linux-gnu/libglib-2.0.so.0
ofonod[16006]: #14 0xb765d170 in /lib/i386-linux-gnu/libglib-2.0.so.0
ofonod[16006]: #15 0xb765d77b in /lib/i386-linux-gnu/libglib-2.0.so.0
ofonod[16006]: #16 0x80548c9 in main() at src/main.c:262
ofonod[16006]: #17 0xb745ce46 in /lib/i386-linux-gnu/i686/cmov/libc.so.6
ofonod[16006]: +++++++++++++++++++++++++++

--===============3664023993647426667==--

