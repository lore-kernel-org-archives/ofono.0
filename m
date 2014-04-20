Content-Type: multipart/mixed; boundary="===============8351858024165727561=="
MIME-Version: 1.0
From: r.r.zaripov <r.r.zaripov@gmail.com>
Subject: Huawei E171 modem removed after execute online-modem script.
Date: Mon, 21 Apr 2014 00:55:45 +0400
Message-ID: <CAGNC_aNqCRxhP-J_a5HB=_5K+Zv6xn0-dE-9f1yHKUHjqfRLiA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8351858024165727561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello all,

I'm trying setup Huawei E171 3G dongle with ofono, but have some problems.
Modem correct detected, and enable-modem works fine. But after online-modem
execution, modem is removed and added same modem with new number.
I'm trying understand whats going on from debug log, the problem is in
registration state?

ofonod[9917]: PCUI: > AT+CREG?\r
ofonod[9917]: PCUI: < \r\n+CREG: 2,18339188\r\n\r\nOK\r\n
ofonod[9917]: src/network.c:init_registration_status() Error during
registration status query

Best regards,
Renat Zaripov

P.S. Full log:

ofonod[9917]: oFono version 1.14
ofonod[9917]: Can't enable deferred setup: Protocol not available (92)
ofonod[9917]: src/plugin.c:__ofono_plugin_init()
ofonod[9917]: plugins/push-notification.c:push_notification_init()
ofonod[9917]: plugins/smart-messaging.c:smart_messaging_init()
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819abe0,
name: stktest
ofonod[9917]: src/modem.c:ofono_modem_create() name: stktest, type: stktest
ofonod[9917]: src/modem.c:ofono_modem_register() 0x98a2ef0
ofonod[9917]: plugins/stktest.c:stktest_probe() 0x98a2ef0
ofonod[9917]: src/modem.c:emit_modem_added() 0x98a2ef0
ofonod[9917]: src/modem.c:call_modemwatches() 0x98a2ef0 added:1
ofonod[9917]: plugins/smart-messaging.c:modem_watch() modem: 0x98a2ef0,
added: 1
ofonod[9917]: plugins/push-notification.c:modem_watch() modem: 0x98a2ef0,
added: 1
ofonod[9917]: examples/emulator.c:example_emulator_init()
ofonod[9917]: examples/emulator.c:modem_watch() modem: 0x98a2ef0, added: 1
ofonod[9917]: src/gprs-provision.c:ofono_gprs_provision_driver_register()
driver: 0x819ab40 name: Example GPRS context provisioning
ofonod[9917]: src/nettime.c:ofono_nettime_driver_register() driver:
0x819ab00 name: Example Network Time
ofonod[9917]: src/history.c:ofono_history_driver_register() driver:
0x819aac0 name: Example Call History
ofonod[9917]: src/cdma-provision.c:ofono_cdma_provision_driver_register()
driver: 0x819aa80 name: CDMA provisioning
ofonod[9917]: src/gprs-provision.c:ofono_gprs_provision_driver_register()
driver: 0x819aa40 name: Provisioning
ofonod[9917]: plugins/dun_gw_bluez5.c:dun_gw_init()
ofonod[9917]: plugins/dun_gw_bluez5.c:modem_watch() modem: 0x98a2ef0,
added: 1
ofonod[9917]: plugins/hfp_ag_bluez5.c:modem_watch() modem: 0x98a2ef0,
added: 1
ofonod[9917]: src/handsfree-audio.c:ofono_handsfree_card_driver_register()
driver: 0x819a8c0
ofonod[9917]: plugins/he910.c:he910_init()
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a840,
name: he910
ofonod[9917]: plugins/connman.c:connman_init()
ofonod[9917]: src/private-network.c:ofono_private_network_driver_register()
driver: 0x819a800, name: ConnMan Private Network
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a7a0,
name: sim900
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a740,
name: samsung
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a6e0,
name: speedupcdma
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a680,
name: speedup
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a620,
name: alcatel
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a5c0,
name: icera
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a560,
name: linktop
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a500,
name: nokiacdma
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a4a0,
name: nokia
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a440,
name: tc65
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a3a0,
name: ste
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a340,
name: ifx
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a2e0,
name: palmpre
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a280,
name: novatel
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a220,
name: sierra
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a1a0,
name: huawei
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a140,
name: zte
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a0e0,
name: hso
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a080,
name: mbm
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x819a020,
name: calypso
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x8199fc0,
name: wavecom
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x8199f60,
name: g1
ofonod[9917]: src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register()
driver: 0x8199ee0, name: cdmamodem
ofonod[9917]: src/modem.c:ofono_devinfo_driver_register() driver:
0x8199f00, name: cdmamodem
ofonod[9917]: src/cdma-connman.c:ofono_cdma_connman_driver_register()
driver: 0x8199f24, name: cdmamodem
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x8199e40,
name: phonesim
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x8199e80,
name: localhfp
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8199e14, name: phonesim
ofonod[9917]: src/ctm.c:ofono_ctm_driver_register() driver: 0x8199e00,
name: phonesim
ofonod[9917]: plugins/phonesim.c:parse_config() filename
/etc/ofono/phonesim.conf
ofonod[9917]: src/ussd.c:ofono_ussd_driver_register() driver: 0x8199dc0,
name: speedupmodem
ofonod[9917]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8199c60, name: hfpmodem
ofonod[9917]: src/modem.c:ofono_devinfo_driver_register() driver:
0x8199d1c, name: hfpmodem
ofonod[9917]: src/network.c:ofono_netreg_driver_register() driver:
0x8199cc0, name: hfpmodem
ofonod[9917]: src/call-volume.c:ofono_call_volume_driver_register() driver:
0x8199cf4, name: hfpmodem
ofonod[9917]: src/handsfree.c:ofono_handsfree_driver_register() driver:
0x8199d38, name: hfpmodem
ofonod[9917]: src/siri.c:ofono_siri_driver_register() driver: 0x8199d64,
name: hfpmodem
ofonod[9917]: src/network.c:ofono_netreg_driver_register() driver:
0x8199be0, name: dunmodem
ofonod[9917]: src/gprs.c:ofono_gprs_driver_register() driver: 0x8199c0c,
name: dunmodem
ofonod[9917]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8199b00, name: stemodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8199b8c, name: stemodem
ofonod[9917]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8199b60, name: stemodem
ofonod[9917]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x81999c0, name: ifxmodem
ofonod[9917]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x8199a10, name: ifxmodem
ofonod[9917]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8199a40, name: ifxmodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8199a6c, name: ifxmodem
ofonod[9917]: src/stk.c:ofono_stk_driver_register() driver: 0x8199a94,
name: ifxmodem
ofonod[9917]: src/ctm.c:ofono_ctm_driver_register() driver: 0x8199abc,
name: ifxmodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8199940, name: hsomodem
ofonod[9917]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8199960, name: hsomodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x81998a0, name: mbmmodem
ofonod[9917]: src/stk.c:ofono_stk_driver_register() driver: 0x81998c8,
name: mbmmodem
ofonod[9917]:
src/location-reporting.c:ofono_location_reporting_driver_register() driver:
0x81998e8, name: mbmmodem
ofonod[9917]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8199800, name: calypsomodem
ofonod[9917]: src/stk.c:ofono_stk_driver_register() driver: 0x8199848,
name: calypsomodem
ofonod[9917]: src/ussd.c:ofono_ussd_driver_register() driver: 0x81996e0,
name: huaweimodem
ofonod[9917]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8199700, name: huaweimodem
ofonod[9917]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x8199748, name: huaweimodem
ofonod[9917]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8199780, name: huaweimodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x819975c, name: huaweimodem
ofonod[9917]: src/cdma-netreg.c:ofono_cdma_netreg_driver_register() driver:
0x81997ac, name: huaweimodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8199640, name: iceramodem
ofonod[9917]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8199680, name: iceramodem
ofonod[9917]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x81995e0, name: ztemodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x81995a0, name: swmodem
ofonod[9917]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8199540, name: nwmodem
ofonod[9917]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x81993a0, name: atmodem
ofonod[9917]: src/modem.c:ofono_devinfo_driver_register() driver:
0x8199440, name: atmodem
ofonod[9917]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x81993f8, name: atmodem
ofonod[9917]: src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x8199140, name: atmodem
ofonod[9917]: src/call-meter.c:ofono_call_meter_driver_register() driver:
0x8199180, name: atmodem
ofonod[9917]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x8199040, name: atmodem
ofonod[9917]: src/phonebook.c:ofono_phonebook_driver_register() driver:
0x8199418, name: atmodem
ofonod[9917]: src/ussd.c:ofono_ussd_driver_register() driver: 0x8199374,
name: atmodem
ofonod[9917]: src/sms.c:ofono_sms_driver_register() driver: 0x81990c0,
name: atmodem
ofonod[9917]: src/sim.c:ofono_sim_driver_register() driver: 0x8199240,
name: atmodem
ofonod[9917]: src/sim.c:ofono_sim_driver_register() driver: 0x81992a0,
name: atmodem-noef
ofonod[9917]: src/stk.c:ofono_stk_driver_register() driver: 0x8199354,
name: atmodem
ofonod[9917]: src/network.c:ofono_netreg_driver_register() driver:
0x81991e0, name: atmodem
ofonod[9917]: src/cbs.c:ofono_cbs_driver_register() driver: 0x8199120,
name: atmodem
ofonod[9917]: src/call-volume.c:ofono_call_volume_driver_register() driver:
0x8199464, name: atmodem
ofonod[9917]: src/gprs.c:ofono_gprs_driver_register() driver: 0x8199494,
name: atmodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x81994b8, name: atmodem
ofonod[9917]: src/sim-auth.c:ofono_sim_auth_driver_register() driver:
0x81994d0, name: atmodem
ofonod[9917]: src/gnss.c:ofono_gnss_driver_register() driver: 0x81994e8,
name: atmodem
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x8198e20,
name: gobi
ofonod[9917]: src/modem.c:ofono_devinfo_driver_register() driver:
0x8198be0, name: qmimodem
ofonod[9917]: src/network.c:ofono_netreg_driver_register() driver:
0x8198c60, name: qmimodem
ofonod[9917]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8198c00, name: qmimodem
ofonod[9917]: src/sim.c:ofono_sim_driver_register() driver: 0x8198ca0,
name: qmimodem-legacy
ofonod[9917]: src/sim.c:ofono_sim_driver_register() driver: 0x8198d00,
name: qmimodem
ofonod[9917]: src/sms.c:ofono_sms_driver_register() driver: 0x8198d60,
name: qmimodem
ofonod[9917]: src/ussd.c:ofono_ussd_driver_register() driver: 0x8198d80,
name: qmimodem
ofonod[9917]: src/gprs.c:ofono_gprs_driver_register() driver: 0x8198d94,
name: qmimodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8198da8, name: qmimodem
ofonod[9917]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8198dc0, name: qmimodem
ofonod[9917]:
src/location-reporting.c:ofono_location_reporting_driver_register() driver:
0x8198de4, name: qmimodem
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x8198b80,
name: u8500
ofonod[9917]: src/modem.c:ofono_devinfo_driver_register() driver:
0x8198b60, name: u8500
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x8198b00,
name: n900
ofonod[9917]: src/modem.c:ofono_modem_driver_register() driver: 0x8198aa0,
name: isiusb
ofonod[9917]: src/modem.c:ofono_devinfo_driver_register() driver:
0x8198790, name: isimodem
ofonod[9917]: src/phonebook.c:ofono_phonebook_driver_register() driver:
0x8198780, name: isimodem
ofonod[9917]: src/network.c:ofono_netreg_driver_register() driver:
0x81987c0, name: isimodem
ofonod[9917]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8198800, name: isimodem
ofonod[9917]: src/sms.c:ofono_sms_driver_register() driver: 0x8198860,
name: isimodem
ofonod[9917]: src/cbs.c:ofono_cbs_driver_register() driver: 0x8198880,
name: isimodem
ofonod[9917]: src/sim.c:ofono_sim_driver_register() driver: 0x81988a0,
name: isimodem
ofonod[9917]: src/ussd.c:ofono_ussd_driver_register() driver: 0x81988e8,
name: isimodem
ofonod[9917]: src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x8198900, name: isimodem
ofonod[9917]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x8198920, name: isimodem
ofonod[9917]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x8198950, name: isimodem
ofonod[9917]: src/call-meter.c:ofono_call_meter_driver_register() driver:
0x8198980, name: isimodem
ofonod[9917]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x81989c0, name: isimodem
ofonod[9917]: src/gprs.c:ofono_gprs_driver_register() driver: 0x81989e4,
name: isimodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x81989f8, name: isimodem
ofonod[9917]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x8198a10, name: isimodem
ofonod[9917]: src/sim.c:ofono_sim_driver_register() driver: 0x8198a20,
name: wgmodem2.5
ofonod[9917]: plugins/udevng.c:udev_start()
ofonod[9917]: plugins/udevng.c:enumerate_devices()
ofonod[9917]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[9917]: plugins/udevng.c:check_usb_device() usb [8087:0020]
ofonod[9917]: plugins/udevng.c:check_usb_device() usb [8086:1406]
ofonod[9917]: plugins/udevng.c:check_usb_device() i2400m_usb [(null):(null)]
ofonod[9917]: plugins/udevng.c:check_usb_device() i2400m_usb [8086:1406]
ofonod[9917]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[9917]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[9917]: plugins/udevng.c:check_usb_device() usb [8087:0020]
ofonod[9917]: plugins/udevng.c:check_usb_device() usb [12d1:1001]
ofonod[9917]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[9917]: plugins/udevng.c:check_usb_device() option [12d1:1001]
ofonod[9917]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2
ofonod[9917]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/ttyUSB0/tty/t=
tyUSB0
ofonod[9917]: plugins/udevng.c:add_device() /dev/ttyUSB0 (huawei)
255/255/255 [00] =3D=3D> (null) (null)
ofonod[9917]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[9917]: plugins/udevng.c:check_usb_device() option [12d1:1001]
ofonod[9917]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2
ofonod[9917]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.1/ttyUSB1/tty/t=
tyUSB1
ofonod[9917]: plugins/udevng.c:add_device() /dev/ttyUSB1 (huawei)
255/255/255 [01] =3D=3D> (null) (null)
ofonod[9917]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[9917]: plugins/udevng.c:check_usb_device() option [12d1:1001]
ofonod[9917]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2
ofonod[9917]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.2/ttyUSB2/tty/t=
tyUSB2
ofonod[9917]: plugins/udevng.c:add_device() /dev/ttyUSB2 (huawei)
255/255/255 [02] =3D=3D> (null) (null)
ofonod[9917]: plugins/udevng.c:check_usb_device() usb [5986:0148]
ofonod[9917]: plugins/udevng.c:check_usb_device() uvcvideo [(null):(null)]
ofonod[9917]: plugins/udevng.c:check_usb_device() uvcvideo [(null):(null)]
ofonod[9917]: plugins/udevng.c:check_usb_device() usb [04b4:0060]
ofonod[9917]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
ofonod[9917]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
ofonod[9917]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
ofonod[9917]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[9917]: plugins/udevng.c:create_modem()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2
ofonod[9917]: plugins/udevng.c:create_modem() driver=3Dhuawei
ofonod[9917]: src/modem.c:ofono_modem_create() name: (null), type: huawei
ofonod[9917]: plugins/udevng.c:setup_huawei()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2
ofonod[9917]: plugins/udevng.c:setup_huawei() /dev/ttyUSB0 255/255/255 00
(null)
ofonod[9917]: plugins/udevng.c:setup_huawei() /dev/ttyUSB1 255/255/255 01
(null)
ofonod[9917]: plugins/udevng.c:setup_huawei() /dev/ttyUSB2 255/255/255 02
(null)
ofonod[9917]: plugins/udevng.c:setup_huawei() mdm=3D/dev/ttyUSB0
pcui=3D/dev/ttyUSB2 diag=3D(null) qmi=3D(null) net=3D(null)
ofonod[9917]: src/modem.c:set_modem_property() modem 0x98ac5a8 property
Device
ofonod[9917]: src/modem.c:set_modem_property() modem 0x98ac5a8 property
Modem
ofonod[9917]: src/modem.c:set_modem_property() modem 0x98ac5a8 property Pcui
ofonod[9917]: src/modem.c:set_modem_property() modem 0x98ac5a8 property Diag
ofonod[9917]: src/modem.c:set_modem_property() modem 0x98ac5a8 property
NetworkInterface
ofonod[9917]: src/modem.c:ofono_modem_register() 0x98ac5a8
ofonod[9917]: plugins/huawei.c:huawei_probe() 0x98ac5a8
ofonod[9917]: src/modem.c:emit_modem_added() 0x98ac5a8
ofonod[9917]: src/modem.c:call_modemwatches() 0x98ac5a8 added:1
ofonod[9917]: plugins/hfp_ag_bluez5.c:modem_watch() modem: 0x98ac5a8,
added: 1
ofonod[9917]: plugins/dun_gw_bluez5.c:modem_watch() modem: 0x98ac5a8,
added: 1
ofonod[9917]: examples/emulator.c:modem_watch() modem: 0x98ac5a8, added: 1
ofonod[9917]: plugins/smart-messaging.c:modem_watch() modem: 0x98ac5a8,
added: 1
ofonod[9917]: plugins/push-notification.c:modem_watch() modem: 0x98ac5a8,
added: 1
ofonod[9917]: src/private-network.c:ofono_private_network_driver_register()
driver: 0x819aba0, name: Example Private Network Driver
ofonod[9917]: plugins/huawei.c:huawei_enable() 0x98ac5a8
ofonod[9917]: src/modem.c:get_modem_property() modem 0x98ac5a8 property
Modem
ofonod[9917]: plugins/huawei.c:open_device() Modem /dev/ttyUSB0
ofonod[9917]: src/modem.c:get_modem_property() modem 0x98ac5a8 property Pcui
ofonod[9917]: plugins/huawei.c:open_device() Pcui /dev/ttyUSB2
ofonod[9917]: Modem: > ATE0 +CMEE=3D1\r
ofonod[9917]: PCUI: > ATE0 +CMEE=3D1\r
ofonod[9917]: Modem: < ATE0 +CMEE=3D1\r\r\nOK\r\n
ofonod[9917]: PCUI: < \r\nOK\r\n
ofonod[9917]: PCUI: > ATI\r
ofonod[9917]: PCUI: < \r\nManufacturer: huawei\r\nModel: E171\r\nRevision:
11.126.85.01.143\r\nIMEI: 356356045386477\r\n+GCAP:
+CGSM,+DS,+ES\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT^RFSWITCH=3D?\r
ofonod[9917]: PCUI: < \r\nCOMMAND NOT SUPPORT\r\n
ofonod[9917]: PCUI: > AT+CFUN=3D1\r
ofonod[9917]: PCUI: < \r\n^RSSI:14\r\n
ofonod[9917]: PCUI: < \r\nOK\r\n
ofonod[9917]: plugins/huawei.c:cfun_enable()
ofonod[9917]: PCUI: > AT^SYSINFO\r
ofonod[9917]: PCUI: < \r\n^SYSINFO:2,3,0,5,1,,4\r\n\r\nOK\r\n
ofonod[9917]: plugins/huawei.c:sysinfo_enable_cb() 255 -> 1
ofonod[9917]: Modem: > AT&C0\r
ofonod[9917]: PCUI: > AT&C0\r
ofonod[9917]: PCUI: < \r\nOK\r\n
ofonod[9917]: PCUI: > AT+CSCS=3D"GSM"\r
ofonod[9917]: PCUI: < \r\nOK\r\n
ofonod[9917]: PCUI: > AT^U2DIAG?\r
ofonod[9917]: PCUI: < \r\n0\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT^GETPORTMODE\r
ofonod[9917]: Modem: < \r\nOK\r\n
ofonod[9917]: PCUI: <
\r\n^GETPORTMODE:TYPE:WCDMA:Qualcomm,MDM:0,DIAG:1,PCUI:2\r\n\r\nOK\r\n
ofonod[9917]: Modem: > AT+CSCS=3D"GSM"\r
ofonod[9917]: PCUI: > AT^USSDMODE=3D?\r
ofonod[9917]: PCUI: < \r\n^USSDMODE:(0-1)\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT^DIALMODE=3D?\r
ofonod[9917]: PCUI: < \r\nERROR\r\n
ofonod[9917]: PCUI: > AT^CVOICE=3D?\r
ofonod[9917]: PCUI: < \r\n^CVOICE:(0)\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT+CFUN=3D5\r
ofonod[9917]: Modem: < \r\nOK\r\n
ofonod[9917]: PCUI: < \r\nOK\r\n
ofonod[9917]: plugins/huawei.c:cfun_offline()
ofonod[9917]: examples/emulator.c:powered_watch() Adding modem 0x98ac5a8 to
the list
ofonod[9917]: examples/emulator.c:create_tcp() Created server_watch: 44
ofonod[9917]: examples/emulator.c:create_tcp() Created server_watch: 45
ofonod[9917]: src/modem.c:modem_change_state() old state: 0, new state: 1
ofonod[9917]: plugins/huawei.c:huawei_pre_sim() 0x98ac5a8
ofonod[9917]: PCUI: > AT^USSDMODE?\r
ofonod[9917]: src/sim.c:ofono_sim_add_state_watch() 0x98aa100
ofonod[9917]: src/sim.c:ofono_sim_add_state_watch() 0x98aa100
ofonod[9917]: src/sim.c:ofono_sim_add_state_watch() 0x98aa100
ofonod[9917]: PCUI: < \r\n^USSDMODE:1\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT^CVOICE?\r
ofonod[9917]: PCUI: < \r\n^CVOICE:0,8000,16,20\r\n\r\nOK\r\n
ofonod[9917]: Voice channel: 8000 Hz, 16 bits, 20ms period
ofonod[9917]: PCUI: > AT+GCAP\r
ofonod[9917]: PCUI: < \r\n+GCAP: +CGSM,+DS,+ES\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT+CRSM=3D192,12258,0,0,255\r
ofonod[9917]: PCUI: < \r\n+CRSM:
144,0,"0000000A2FE204000F00FF01060000002F0604"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00,
19
ofonod[9917]: PCUI: > AT^DDSETEX=3D?\r
ofonod[9917]: PCUI: < \r\n^DDSETEX:(2)\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT+CGMI\r
ofonod[9917]: PCUI: < \r\nhuawei\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT+CRSM=3D176,12258,0,0,10\r
ofonod[9917]: PCUI: < \r\n+CRSM: 144,0,"980701025473915114FF"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00,
10
ofonod[9917]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0,
tocopy: 10
ofonod[9917]: PCUI: > AT+CGMM\r
ofonod[9917]: PCUI: < \r\nE171\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT+CRSM=3D192,28421,0,0,255\r
ofonod[9917]: PCUI: < \r\n+CRSM:
144,0,"000000056F0504000100FF01060000002F060B"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00,
19
ofonod[9917]: PCUI: > AT+CGMR\r
ofonod[9917]: PCUI: < \r\n11.126.85.01.143\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT+CRSM=3D176,28421,0,0,5\r
ofonod[9917]: PCUI: < \r\n+CRSM: 144,0,"FFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00,
5
ofonod[9917]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0,
tocopy: 5
ofonod[9917]: PCUI: > AT+CGSN\r
ofonod[9917]: PCUI: < \r\n356356045386477\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT+CRSM=3D192,12037,0,0,255\r
ofonod[9917]: PCUI: < \r\n+CRSM:
144,0,"0000000A2F05040001004401060000002F0605"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00,
19
ofonod[9917]: PCUI: > AT+CRSM=3D176,12037,0,0,10\r
ofonod[9917]: PCUI: < \r\n+CRSM: 144,0,"FFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00,
10
ofonod[9917]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0,
tocopy: 10
ofonod[9917]: PCUI: > AT+CPIN?\r
ofonod[9917]: PCUI: < \r\n+CPIN: READY\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
ofonod[9917]: drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[9917]: PCUI: > AT^CPIN?\r
ofonod[9917]: PCUI: < \r\n^CPIN: READY,,10,3,10,3\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D9,
val=3D10
ofonod[9917]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D1,
val=3D3
ofonod[9917]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D11,
val=3D10
ofonod[9917]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D4,
val=3D3
ofonod[9917]: PCUI: > AT+CRSM=3D192,28590,0,0,255\r
ofonod[9917]: PCUI: < \r\n+CRSM:
144,0,"000000016FAE04000400FF01060000002F0603"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00,
19
ofonod[9917]: PCUI: > AT+CRSM=3D176,28590,0,0,1\r
ofonod[9917]: PCUI: < \r\n+CRSM: 144,0,"03"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00,
1
ofonod[9917]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0,
tocopy: 1
ofonod[9917]: PCUI: > AT+CRSM=3D192,28589,0,0,255\r
ofonod[9917]: PCUI: < \r\n+CRSM:
144,0,"000000036FAD04000400FF01060000002F0603"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00,
19
ofonod[9917]: PCUI: > AT+CRSM=3D176,28589,0,0,3\r
ofonod[9917]: PCUI: < \r\n+CRSM: 144,0,"00FFFF"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00,
3
ofonod[9917]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0,
tocopy: 3
ofonod[9917]: EFad should contain@least four bytes
ofonod[9917]: PCUI: > AT+CRSM=3D192,28438,0,0,255\r
ofonod[9917]: PCUI: < \r\n+CME ERROR: 21\r\n
ofonod[9917]: PCUI: > AT+CRSM=3D192,28472,0,0,255\r
ofonod[9917]: PCUI: < \r\n+CRSM:
144,0,"000000106F3804001400FF01060000002F0606"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00,
19
ofonod[9917]: PCUI: > AT+CRSM=3D176,28472,0,0,16\r
ofonod[9917]: PCUI: < \r\n+CRSM:
144,0,"FF3FFFFF3FFF3F0FFF0C00FC00000000"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00,
16
ofonod[9917]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0,
tocopy: 16
ofonod[9917]: PCUI: > AT+CRSM=3D192,28474,0,0,255\r
ofonod[9917]: PCUI: < \r\n+CRSM:
144,0,"000026166F3A040011002201060127002F0616"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00,
19
ofonod[9917]: PCUI: > AT+CIMI\r
ofonod[9917]: PCUI: < \r\n250020453719154\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_cimi_cb() cimi_cb: 250020453719154
ofonod[9917]: src/modem.c:modem_change_state() old state: 1, new state: 2
ofonod[9917]: plugins/huawei.c:huawei_post_sim() 0x98ac5a8
ofonod[9917]: drivers/atmodem/gprs-context.c:at_gprs_context_probe()
ofonod[9917]: Example History Probe for modem: 0x98ac5a8
ofonod[9917]: Example Network Time Probe for modem: 0x98ac5a8
ofonod[9917]: src/modem.c:get_modem_property() modem 0x98ac5a8 property
AlwaysOnline
ofonod[9917]: PCUI: > AT+CRC=3D1\r
ofonod[9917]: PCUI: < \r\nOK\r\n
ofonod[9917]: PCUI: > AT+CLIP=3D1\r
ofonod[9917]: PCUI: < \r\nOK\r\n
ofonod[9917]: PCUI: > AT+COLP=3D1\r
ofonod[9917]: PCUI: < \r\nOK\r\n
ofonod[9917]: PCUI: > AT+CCWA=3D1\r
ofonod[9917]: PCUI: < \r\nOK\r\n
ofonod[9917]:
drivers/huaweimodem/voicecall.c:huawei_voicecall_initialized() registering
to notifications
ofonod[9917]: src/sim.c:ofono_sim_add_state_watch() 0x98aa100
ofonod[9917]: plugins/bluez5.c:bt_register_profile() Bluetooth: Registering
0000111f-0000-1000-8000-00805f9b34fb (hfp_ag) profile
ofonod[9917]: PCUI: > AT^CVOICE=3D?\r
ofonod[9917]: RegisterProfile() replied an error:
org.freedesktop.DBus.Error.UnknownMethod, Method "RegisterProfile" with
signature "osa{sv}" on interface "org.bluez.ProfileManager1" doesn't exist
ofonod[9917]: PCUI: < \r\n^CVOICE:(0)\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT+CSCS=3D?\r
ofonod[9917]: PCUI: < \r\n+CSCS: ("IRA","GSM","UCS2")\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT^SYSCFG=3D?\r
ofonod[9917]: PCUI: <
\r\n^SYSCFG:(2,13,14,16),(0-3),((400380,"GSM900/GSM1800/WCDMA2100"),(280000=
,"GSM850/GSM1900"),(3fffffff,"All
Bands")),(0-2),(0-4)\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT+CSMS=3D?\r
ofonod[9917]: PCUI: < \r\n+CSMS: (0-1)\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sms.c:at_csms_query_cb() CSMS query parsed
successfully
ofonod[9917]: PCUI: > AT+CGDCONT=3D?\r
ofonod[9917]: PCUI: < \r\n+CGDCONT: (1-16),"IP",,,(0-2),(0-3)\r\n+CGDCONT:
(1-16),"PPP",,,(0-2),(0-3)\r\n+CGDCONT:
(1-16),"IPV6",,,(0-2),(0-3)\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT+CRSM=3D192,28480,0,0,255\r
ofonod[9917]: PCUI: < \r\n+CRSM:
144,0,"000000C36F40040011004401060127002F0618"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00,
19
ofonod[9917]: PCUI: > AT+CPBS=3D?\r
ofonod[9917]: PCUI: < \r\n+CPBS: ("SM","EN","ON")\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT+CSMS=3D1\r
ofonod[9917]: PCUI: < \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT+CGREG=3D?\r
ofonod[9917]: PCUI: < \r\n+CGREG: (0-2)\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT+CRSM=3D178,28480,1,4,39\r
ofonod[9917]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00,
39
ofonod[9917]: PCUI: > AT+CSMS?\r
ofonod[9917]: PCUI: < \r\n+CSMS: 1,1,1,1\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT+CGREG=3D2\r
ofonod[9917]: PCUI: < \r\nOK\r\n
ofonod[9917]: PCUI: > AT+CGAUTO=3D0\r
ofonod[9917]: PCUI: < \r\nCOMMAND NOT SUPPORT\r\n
ofonod[9917]: PCUI: > AT+CGEREP=3D2,1\r
ofonod[9917]: PCUI: < \r\nOK\r\n
ofonod[9917]: plugins/bluez5.c:bt_register_profile() Bluetooth: Registering
00001103-0000-1000-8000-00805f9b34fb (dun_gw) profile
ofonod[9917]: PCUI: > AT+CRSM=3D178,28480,2,4,39\r
ofonod[9917]: RegisterProfile() replied an error:
org.freedesktop.DBus.Error.UnknownMethod, Method "RegisterProfile" with
signature "osa{sv}" on interface "org.bluez.ProfileManager1" doesn't exist
ofonod[9917]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00,
39
ofonod[9917]: PCUI: > AT+CMGF=3D?\r
ofonod[9917]: PCUI: < \r\n+CMGF: (0-1)\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT+CRSM=3D178,28480,3,4,39\r
ofonod[9917]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00,
39
ofonod[9917]: PCUI: > AT+CPMS=3D?\r
ofonod[9917]: PCUI: < \r\n+CPMS:
("ME","MT","SM","SR"),("ME","MT","SM","SR"),("ME","MT","SM","SR")\r\n\r\nOK=
\r\n
ofonod[9917]: PCUI: > AT+CRSM=3D178,28480,4,4,39\r
ofonod[9917]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00,
39
ofonod[9917]: PCUI: > AT+CMGF=3D0\r
ofonod[9917]: PCUI: < \r\nOK\r\n
ofonod[9917]: PCUI: > AT+CRSM=3D178,28480,5,4,39\r
ofonod[9917]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00,
39
ofonod[9917]: PCUI: > AT+CPMS=3D"ME","ME","ME"\r
ofonod[9917]: PCUI: < \r\n+CPMS: 1,23,1,23,1,23\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT+CRSM=3D192,20256,0,0,255\r
ofonod[9917]: PCUI: < \r\n+CME ERROR: 21\r\n
ofonod[9917]: PCUI: > AT+CNMI=3D?\r
ofonod[9917]: PCUI: < \r\n+CNMI:
(0,1,2),(0,1,2,3),(0,2),(0,1,2),(0,1)\r\n\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sms.c:build_cnmi_string()
ofonod[9917]: PCUI: > AT+CNMI=3D1,1,2,1,0\r
ofonod[9917]: PCUI: < \r\nOK\r\n
ofonod[9917]: src/sms.c:sms_restore_tx_queue()
ofonod[9917]: plugins/push-notification.c:sms_watch() registered
ofonod[9917]: plugins/smart-messaging.c:sms_watch() registered
ofonod[9917]: PCUI: > AT+CMGL=3D4\r
ofonod[9917]: PCUI: < \r\n+CMTI: "ME",0\r\n
ofonod[9917]: PCUI: < \r\n+CMGL:
0,0,,22\r\n07919740430900F3040B919740869560F900004140023220556103C7F319\r\n=
\r\nOK\r\n
ofonod[9917]: drivers/atmodem/sms.c:at_cmgl_notify()
ofonod[9917]: drivers/atmodem/sms.c:at_cmgl_notify() Found an old SMS PDU:
07919740430900F3040B919740869560F900004140023220556103C7F319, with len: 22
ofonod[9917]: src/sms.c:ofono_sms_deliver_notify() len 30 tpdu len 22
ofonod[9917]: src/sms.c:handle_deliver()
ofonod[9917]: src/sms.c:sms_dispatch()
ofonod[9917]: src/sms.c:sms_dispatch() dst -1 src -1
ofonod[9917]: Incoming SMS on modem: 0x98ac5a8
ofonod[9917]: InternalMessageId: FD7393E67EFD2791751DFEEB42D083E1748574FB
ofonod[9917]: From: +79046859069
ofonod[9917]: Local Sent Time: 2014-04-20T23:02:55+0400
ofonod[9917]: Remote Sent Time: 2014-04-20T23:02:55+0400
ofonod[9917]: Text: Ggg
ofonod[9917]: drivers/atmodem/sms.c:at_cmgl_done()
ofonod[9917]: PCUI: > AT+CGSMS=3D3\r
ofonod[9917]: PCUI: < \r\nOK\r\n
ofonod[9917]: PCUI: > AT+CMGD=3D0\r
ofonod[9917]: PCUI: < \r\nOK\r\n
ofonod[9917]: PCUI: < \r\n^BOOT:45386477,0,0,0,20\r\n
ofonod[9917]: PCUI: < \r\n^RSSI:99\r\n
ofonod[9917]: PCUI: < \r\n^SRVST:0\r\n
ofonod[9917]: PCUI: < \r\n^MODE:0,0\r\n
ofonod[9917]: PCUI: < \r\n+CGREG: 2\r\n
ofonod[9917]: src/gprs.c:ofono_gprs_status_notify() /huawei_0 status 2
ofonod[9917]: PCUI: < \r\n^BOOT:45386477,0,0,0,20\r\n
ofonod[9917]: PCUI: < \r\n^BOOT:45386477,0,0,0,20\r\n
ofonod[9917]: src/modem.c:get_modem_property() modem 0x98ac5a8 property
AlwaysOnline
ofonod[9917]: plugins/huawei.c:huawei_set_online() modem 0x98ac5a8 online
ofonod[9917]: PCUI: > AT+CFUN=3D1\r
ofonod[9917]: PCUI: < \r\nOK\r\n
ofonod[9917]: PCUI: > AT^SYSINFO\r
ofonod[9917]: PCUI: < \r\n^SYSINFO:0,3,0,0,1,,0\r\n\r\nOK\r\n
ofonod[9917]: plugins/huawei.c:sysinfo_online_cb() 1 -> 1
ofonod[9917]: src/modem.c:modem_change_state() old state: 2, new state: 3
ofonod[9917]: plugins/huawei.c:huawei_post_online() 0x98ac5a8
ofonod[9917]: PCUI: > AT+CREG=3D?\r
ofonod[9917]: PCUI: < \r\n+CREG: (0-2)\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT+CSCB=3D?\r
ofonod[9917]: PCUI: < \r\n+CSCB: (0-1)\r\n\r\nOK\r\n
ofonod[9917]: PCUI: > AT+CUSD=3D1\r
ofonod[9917]: PCUI: < \r\nOK\r\n
ofonod[9917]: PCUI: > AT+CRSM=3D192,28618,0,0,255\r
ofonod[9917]: PCUI: < \r\n+CME ERROR: 21\r\n
ofonod[9917]: Unable to read waiting messages numbers from SIM
ofonod[9917]: PCUI: > AT+CREG=3D2\r
ofonod[9917]: PCUI: < \r\nOK\r\n
ofonod[9917]: src/sim.c:ofono_sim_add_spn_watch() 0x98aa100
ofonod[9917]: src/network.c:__ofono_netreg_add_status_watch() 0x98b1080
ofonod[9917]: src/network.c:__ofono_netreg_add_status_watch() 0x98b1080
ofonod[9917]: PCUI: > AT+CSCB=3D0\r
ofonod[9917]: PCUI: < \r\n+CMS ERROR: 302\r\n
ofonod[9917]: src/cbs.c:cbs_got_imsi() Got IMSI: 250020453719154
ofonod[9917]: src/network.c:__ofono_netreg_add_status_watch() 0x98b1080
ofonod[9917]: PCUI: > AT+CRSM=3D192,28617,0,0,255\r
ofonod[9917]: PCUI: < \r\n+CME ERROR: 21\r\n
ofonod[9917]: Unable to read mailbox identifies from SIM
ofonod[9917]: PCUI: > AT+CREG?\r
ofonod[9917]: PCUI: < \r\n+CREG: 2,18339188\r\n\r\nOK\r\n
ofonod[9917]: src/network.c:init_registration_status() Error during
registration status query
ofonod[9917]: PCUI: > AT+CRSM=3D192,28433,0,0,255\r
ofonod[9917]: PCUI: < \r\n+CME ERROR: 21\r\n
ofonod[9917]: src/message-waiting.c:mw_cphs_mwis_read_cb() No CPHS MWIS on
SIM
ofonod[9917]: PCUI: > AT+CRSM=3D192,28435,0,0,255\r
ofonod[9917]: PCUI: < \r\n+CME ERROR: 21\r\n
ofonod[9917]: PCUI: > AT+CRSM=3D192,28613,0,0,255\r
ofonod[9917]: PCUI: < \r\n+CME ERROR: 21\r\n
ofonod[9917]: src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff: 39,
toread: 17
ofonod[9917]: src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff: 39,
toread: 20
ofonod[9917]: src/cbs.c:sim_cbmid_read_cb() Got cbmid:
4096,4097,4098,4099,4100,4101,4102,4103,4104,4105
ofonod[9917]: drivers/atmodem/cbs.c:at_cbs_set_topics()
ofonod[9917]: PCUI: > AT+CSCB=3D0\r
ofonod[9917]: PCUI: < \r\n+CMS ERROR: 302\r\n
ofonod[9917]: PCUI: >
AT+CSCB=3D0,"0-1,3,5,7,11,13,43,130,333,500,555,666,900,4096,4097,4098,4099=
,4100,4101,4102,4103,4104,4105,4352-4356"\r
ofonod[9917]: plugins/udevng.c:remove_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/ttyUSB0/tty/t=
tyUSB0
ofonod[9917]: plugins/udevng.c:destroy_modem()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2
ofonod[9917]: src/modem.c:ofono_modem_remove() 0x98ac5a8
ofonod[9917]: src/modem.c:modem_unregister() 0x98ac5a8
ofonod[9917]: src/modem.c:modem_change_state() old state: 3, new state: 0
ofonod[9917]: src/modem.c:flush_atoms()
ofonod[9917]: src/message-waiting.c:mw_remove() atom: 0x98b17c0
ofonod[9917]: src/call-barring.c:call_barring_remove() atom: 0x98ac9f0
ofonod[9917]: src/call-settings.c:call_settings_remove() atom: 0x98ac908
ofonod[9917]: src/call-forwarding.c:call_forwarding_remove() atom: 0x98b1738
ofonod[9917]: src/ussd.c:ussd_remove() atom: 0x98b1660
ofonod[9917]: src/network.c:__ofono_netreg_remove_status_watch() 0x98b1080
ofonod[9917]: src/cbs.c:cbs_remove() atom: 0x98b15a0
ofonod[9917]: src/sim.c:ofono_sim_remove_spn_watch() 0x98aa100
ofonod[9917]: src/network.c:netreg_remove() atom: 0x98b0d28
ofonod[9917]: Example Network Time Remove for modem: 0x98ac5a8
ofonod[9917]: Example History Remove for modem: 0x98ac5a8
ofonod[9917]: src/gprs.c:gprs_context_unregister() 0x98acb68, 0x98aaa68
ofonod[9917]: src/gprs.c:gprs_context_remove() atom: 0x98acb88
ofonod[9917]: drivers/atmodem/gprs-context.c:at_gprs_context_remove()
ofonod[9917]: plugins/bluez5.c:bt_unregister_profile() Bluetooth:
Unregistering profile /bluetooth/profile/dun_gw
ofonod[9917]: src/gprs.c:gprs_unregister() 0x98aaa68
ofonod[9917]: src/gprs.c:gprs_remove() atom: 0x98aaad0
ofonod[9917]: plugins/push-notification.c:push_notification_cleanup()
0x98ac088
ofonod[9917]: plugins/smart-messaging.c:smart_messaging_cleanup() 0x98a3bd0
ofonod[9917]: src/sms.c:sms_remove() atom: 0x98aa9d8
ofonod[9917]: src/radio-settings.c:radio_settings_remove() atom: 0x98aa820
ofonod[9917]: src/phonebook.c:phonebook_remove() atom: 0x98abe48
ofonod[9917]: src/audio-settings.c:audio_settings_remove() atom: 0x98aa088
ofonod[9917]: src/voicecall.c:voicecall_remove() atom: 0x98ae300
ofonod[9917]: plugins/bluez5.c:bt_unregister_profile() Bluetooth:
Unregistering profile /bluetooth/profile/hfp_ag
ofonod[9917]: src/sim.c:sim_remove() atom: 0x98aa228
ofonod[9917]: src/modem.c:devinfo_remove() atom: 0x98ae870
ofonod[9917]: plugins/huawei.c:huawei_disable() 0x98ac5a8
ofonod[9917]: plugins/huawei.c:huawei_remove() 0x98ac5a8
ofonod[9917]: src/modem.c:unregister_property() property 0x98abec0
ofonod[9917]: src/modem.c:unregister_property() property 0x98a68e8
ofonod[9917]: src/modem.c:unregister_property() property 0x98abea0
ofonod[9917]: src/modem.c:unregister_property() property 0x98a64e8
ofonod[9917]: src/modem.c:unregister_property() property 0x98a6920
ofonod[9917]: src/modem.c:emit_modem_removed() 0x98ac5a8
ofonod[9917]: src/modem.c:call_modemwatches() 0x98ac5a8 added:0
ofonod[9917]: plugins/hfp_ag_bluez5.c:modem_watch() modem: 0x98ac5a8,
added: 0
ofonod[9917]: plugins/dun_gw_bluez5.c:modem_watch() modem: 0x98ac5a8,
added: 0
ofonod[9917]: examples/emulator.c:modem_watch() modem: 0x98ac5a8, added: 0
ofonod[9917]: examples/emulator.c:modem_watch() Removing modem 0x98ac5a8
from the list
ofonod[9917]: plugins/smart-messaging.c:modem_watch() modem: 0x98ac5a8,
added: 0
ofonod[9917]: plugins/push-notification.c:modem_watch() modem: 0x98ac5a8,
added: 0
ofonod[9917]: plugins/udevng.c:destroy_modem() /dev/ttyUSB0
ofonod[9917]: plugins/udevng.c:destroy_modem() /dev/ttyUSB1
ofonod[9917]: plugins/udevng.c:destroy_modem() /dev/ttyUSB2
ofonod[9917]: plugins/udev.c:udev_event() subsystem tty remove
ofonod[9917]: plugins/udev.c:remove_modem()
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/ttyUSB0/tty/ttyUS=
B0
ofonod[9917]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[9917]: plugins/udevng.c:remove_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0
ofonod[9917]: plugins/udev.c:udev_event() subsystem tty remove
ofonod[9917]: plugins/udev.c:remove_modem()
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.1/ttyUSB1/tty/ttyUS=
B1
ofonod[9917]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[9917]: plugins/udevng.c:remove_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.1/ttyUSB1/tty/t=
tyUSB1
ofonod[9917]: plugins/udev.c:udev_event() subsystem tty remove
ofonod[9917]: plugins/udev.c:remove_modem()
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.2/ttyUSB2/tty/ttyUS=
B2
ofonod[9917]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[9917]: plugins/udevng.c:remove_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.1
ofonod[9917]: plugins/udevng.c:remove_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.2/ttyUSB2/tty/t=
tyUSB2
ofonod[9917]: plugins/udevng.c:remove_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.2
ofonod[9917]: plugins/udevng.c:remove_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2
ofonod[9917]: UnregisterProfile() replied an error:
org.freedesktop.DBus.Error.UnknownMethod, Method "UnregisterProfile" with
signature "o" on interface "org.bluez.ProfileManager1" doesn't exist
ofonod[9917]: UnregisterProfile() replied an error:
org.freedesktop.DBus.Error.UnknownMethod, Method "UnregisterProfile" with
signature "o" on interface "org.bluez.ProfileManager1" doesn't exist
ofonod[9917]: plugins/udevng.c:check_usb_device() usb [12d1:1001]
ofonod[9917]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[9917]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[9917]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[9917]: plugins/udev.c:udev_event() subsystem tty add
ofonod[9917]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[9917]: plugins/udevng.c:check_usb_device() option [12d1:1001]
ofonod[9917]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2
ofonod[9917]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.1/ttyUSB1/tty/t=
tyUSB1
ofonod[9917]: plugins/udevng.c:add_device() /dev/ttyUSB1 (huawei)
255/255/255 [01] =3D=3D> (null) (null)
ofonod[9917]: plugins/udev.c:udev_event() subsystem tty add
ofonod[9917]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[9917]: plugins/udevng.c:check_usb_device() option [12d1:1001]
ofonod[9917]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2
ofonod[9917]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.2/ttyUSB2/tty/t=
tyUSB2
ofonod[9917]: plugins/udevng.c:add_device() /dev/ttyUSB2 (huawei)
255/255/255 [02] =3D=3D> (null) (null)
ofonod[9917]: plugins/udev.c:udev_event() subsystem tty add
ofonod[9917]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[9917]: plugins/udevng.c:check_usb_device() option [12d1:1001]
ofonod[9917]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2
ofonod[9917]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/ttyUSB0/tty/t=
tyUSB0
ofonod[9917]: plugins/udevng.c:add_device() /dev/ttyUSB0 (huawei)
255/255/255 [00] =3D=3D> (null) (null)
ofonod[9917]: plugins/udevng.c:check_modem_list()
ofonod[9917]: plugins/udevng.c:create_modem()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2
ofonod[9917]: plugins/udevng.c:create_modem() driver=3Dhuawei
ofonod[9917]: src/modem.c:ofono_modem_create() name: (null), type: huawei
ofonod[9917]: plugins/udevng.c:setup_huawei()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2
ofonod[9917]: plugins/udevng.c:setup_huawei() /dev/ttyUSB0 255/255/255 00
(null)
ofonod[9917]: plugins/udevng.c:setup_huawei() /dev/ttyUSB1 255/255/255 01
(null)
ofonod[9917]: plugins/udevng.c:setup_huawei() /dev/ttyUSB2 255/255/255 02
(null)
ofonod[9917]: plugins/udevng.c:setup_huawei() mdm=3D/dev/ttyUSB0
pcui=3D/dev/ttyUSB2 diag=3D(null) qmi=3D(null) net=3D(null)
ofonod[9917]: src/modem.c:set_modem_property() modem 0x98b1788 property
Device
ofonod[9917]: src/modem.c:set_modem_property() modem 0x98b1788 property
Modem
ofonod[9917]: src/modem.c:set_modem_property() modem 0x98b1788 property Pcui
ofonod[9917]: src/modem.c:set_modem_property() modem 0x98b1788 property Diag
ofonod[9917]: src/modem.c:set_modem_property() modem 0x98b1788 property
NetworkInterface
ofonod[9917]: src/modem.c:ofono_modem_register() 0x98b1788
ofonod[9917]: plugins/huawei.c:huawei_probe() 0x98b1788
ofonod[9917]: src/modem.c:emit_modem_added() 0x98b1788
ofonod[9917]: src/modem.c:call_modemwatches() 0x98b1788 added:1
ofonod[9917]: plugins/hfp_ag_bluez5.c:modem_watch() modem: 0x98b1788,
added: 1
ofonod[9917]: plugins/dun_gw_bluez5.c:modem_watch() modem: 0x98b1788,
added: 1
ofonod[9917]: examples/emulator.c:modem_watch() modem: 0x98b1788, added: 1
ofonod[9917]: plugins/smart-messaging.c:modem_watch() modem: 0x98b1788,
added: 1
ofonod[9917]: plugins/push-notification.c:modem_watch() modem: 0x98b1788,
added: 1
ofonod[9917]: Terminating
ofonod[9917]: src/plugin.c:__ofono_plugin_cleanup()
ofonod[9917]: plugins/push-notification.c:push_notification_exit()
ofonod[9917]: plugins/smart-messaging.c:smart_messaging_exit()
ofonod[9917]: src/modem.c:ofono_modem_remove() 0x98a2ef0
ofonod[9917]: src/modem.c:modem_unregister() 0x98a2ef0
ofonod[9917]: plugins/stktest.c:stktest_remove() 0x98a2ef0
ofonod[9917]: src/modem.c:emit_modem_removed() 0x98a2ef0
ofonod[9917]: src/modem.c:call_modemwatches() 0x98a2ef0 added:0
ofonod[9917]: plugins/hfp_ag_bluez5.c:modem_watch() modem: 0x98a2ef0,
added: 0
ofonod[9917]: plugins/dun_gw_bluez5.c:modem_watch() modem: 0x98a2ef0,
added: 0
ofonod[9917]: examples/emulator.c:modem_watch() modem: 0x98a2ef0, added: 0
ofonod[9917]: examples/emulator.c:modem_watch() Removing modem 0x98a2ef0
from the list
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819abe0, name: stktest
ofonod[9917]: examples/emulator.c:example_emulator_exit()
ofonod[9917]: src/gprs-provision.c:ofono_gprs_provision_driver_unregister()
driver: 0x819ab40 name: Example GPRS context provisioning
ofonod[9917]: src/nettime.c:ofono_nettime_driver_unregister() driver:
0x819ab00 name: Example Network Time
ofonod[9917]: src/history.c:ofono_history_driver_unregister() driver:
0x819aac0 name: Example Call History
ofonod[9917]: src/cdma-provision.c:ofono_cdma_provision_driver_unregister()
driver: 0x819aa80 name: CDMA provisioning
ofonod[9917]: src/gprs-provision.c:ofono_gprs_provision_driver_unregister()
driver: 0x819aa40 name: Provisioning
ofonod[9917]: plugins/bluez5.c:bt_unregister_profile() Bluetooth:
Unregistering profile /bluetooth/profile/dun_gw
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a840, name: he910
ofonod[9917]:
src/private-network.c:ofono_private_network_driver_unregister() driver:
0x819a800, name: ConnMan Private Network
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a7a0, name: sim900
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a740, name: samsung
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a6e0, name: speedupcdma
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a680, name: speedup
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a620, name: alcatel
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a5c0, name: icera
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a560, name: linktop
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a500, name: nokiacdma
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a4a0, name: nokia
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a440, name: tc65
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a3a0, name: ste
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a340, name: ifx
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a2e0, name: palmpre
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a280, name: novatel
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a220, name: sierra
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a1a0, name: huawei
ofonod[9917]: src/modem.c:modem_unregister() 0x98b1788
ofonod[9917]: plugins/huawei.c:huawei_remove() 0x98b1788
ofonod[9917]: src/modem.c:unregister_property() property 0x98abf40
ofonod[9917]: src/modem.c:unregister_property() property 0x98a3d88
ofonod[9917]: src/modem.c:unregister_property() property 0x98b2508
ofonod[9917]: src/modem.c:unregister_property() property 0x98a0070
ofonod[9917]: src/modem.c:unregister_property() property 0x98abde0
ofonod[9917]: src/modem.c:emit_modem_removed() 0x98b1788
ofonod[9917]: src/modem.c:call_modemwatches() 0x98b1788 added:0
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a140, name: zte
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a0e0, name: hso
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a080, name: mbm
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x819a020, name: calypso
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x8199fc0, name: wavecom
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x8199f60, name: g1
ofonod[9917]: src/cdma-voicecall.c:ofono_cdma_voicecall_driver_unregister()
driver: 0x8199ee0, name: cdmamodem
ofonod[9917]: src/modem.c:ofono_devinfo_driver_unregister() driver:
0x8199f00, name: cdmamodem
ofonod[9917]: src/cdma-connman.c:ofono_cdma_connman_driver_unregister()
driver: 0x8199f24, name: cdmamodem
ofonod[9917]: src/ctm.c:ofono_ctm_driver_unregister() driver: 0x8199e00,
name: phonesim
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
0x8199e14, name: phonesim
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x8199e40, name: phonesim
ofonod[9917]: src/ussd.c:ofono_ussd_driver_unregister() driver: 0x8199dc0,
name: speedupmodem
ofonod[9917]: src/voicecall.c:ofono_voicecall_driver_unregister() driver:
0x8199c60, name: hfpmodem
ofonod[9917]: src/modem.c:ofono_devinfo_driver_unregister() driver:
0x8199d1c, name: hfpmodem
ofonod[9917]: src/network.c:ofono_netreg_driver_unregister() driver:
0x8199cc0, name: hfpmodem
ofonod[9917]: src/call-volume.c:ofono_call_volume_driver_unregister()
driver: 0x8199cf4, name: hfpmodem
ofonod[9917]: src/handsfree.c:ofono_handsfree_driver_unregister() driver:
0x8199d38, name: hfpmodem
ofonod[9917]: src/siri.c:ofono_siri_driver_unregister() driver: 0x8199d64,
name: hfpmodem
ofonod[9917]: src/network.c:ofono_netreg_driver_unregister() driver:
0x8199be0, name: dunmodem
ofonod[9917]: src/gprs.c:ofono_gprs_driver_unregister() driver: 0x8199c0c,
name: dunmodem
ofonod[9917]: src/voicecall.c:ofono_voicecall_driver_unregister() driver:
0x8199b00, name: stemodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
0x8199b8c, name: stemodem
ofonod[9917]: src/radio-settings.c:ofono_radio_settings_driver_unregister()
driver: 0x8199b60, name: stemodem
ofonod[9917]: src/stk.c:ofono_stk_driver_unregister() driver: 0x8199a94,
name: ifxmodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
0x8199a6c, name: ifxmodem
ofonod[9917]: src/radio-settings.c:ofono_radio_settings_driver_unregister()
driver: 0x8199a40, name: ifxmodem
ofonod[9917]: src/audio-settings.c:ofono_audio_settings_driver_unregister()
driver: 0x8199a10, name: ifxmodem
ofonod[9917]: src/voicecall.c:ofono_voicecall_driver_unregister() driver:
0x81999c0, name: ifxmodem
ofonod[9917]: src/ctm.c:ofono_ctm_driver_unregister() driver: 0x8199abc,
name: ifxmodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
0x8199940, name: hsomodem
ofonod[9917]: src/radio-settings.c:ofono_radio_settings_driver_unregister()
driver: 0x8199960, name: hsomodem
ofonod[9917]:
src/location-reporting.c:ofono_location_reporting_driver_unregister()
driver: 0x81998e8, name: mbmmodem
ofonod[9917]: src/stk.c:ofono_stk_driver_unregister() driver: 0x81998c8,
name: mbmmodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
0x81998a0, name: mbmmodem
ofonod[9917]: src/stk.c:ofono_stk_driver_unregister() driver: 0x8199848,
name: calypsomodem
ofonod[9917]: src/voicecall.c:ofono_voicecall_driver_unregister() driver:
0x8199800, name: calypsomodem
ofonod[9917]: src/cdma-netreg.c:ofono_cdma_netreg_driver_unregister()
driver: 0x81997ac, name: huaweimodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
0x819975c, name: huaweimodem
ofonod[9917]: src/radio-settings.c:ofono_radio_settings_driver_unregister()
driver: 0x8199780, name: huaweimodem
ofonod[9917]: src/audio-settings.c:ofono_audio_settings_driver_unregister()
driver: 0x8199748, name: huaweimodem
ofonod[9917]: src/voicecall.c:ofono_voicecall_driver_unregister() driver:
0x8199700, name: huaweimodem
ofonod[9917]: src/ussd.c:ofono_ussd_driver_unregister() driver: 0x81996e0,
name: huaweimodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
0x8199640, name: iceramodem
ofonod[9917]: src/radio-settings.c:ofono_radio_settings_driver_unregister()
driver: 0x8199680, name: iceramodem
ofonod[9917]: src/radio-settings.c:ofono_radio_settings_driver_unregister()
driver: 0x81995e0, name: ztemodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
0x81995a0, name: swmodem
ofonod[9917]: src/radio-settings.c:ofono_radio_settings_driver_unregister()
driver: 0x8199540, name: nwmodem
ofonod[9917]: src/sim-auth.c:ofono_sim_auth_driver_unregister() driver:
0x81994d0, name: atmodem
ofonod[9917]: src/stk.c:ofono_stk_driver_unregister() driver: 0x8199354,
name: atmodem
ofonod[9917]: src/sim.c:ofono_sim_driver_unregister() driver: 0x8199240,
name: atmodem
ofonod[9917]: src/sim.c:ofono_sim_driver_unregister() driver: 0x81992a0,
name: atmodem-noef
ofonod[9917]: src/sms.c:ofono_sms_driver_unregister() driver: 0x81990c0,
name: atmodem
ofonod[9917]: src/ussd.c:ofono_ussd_driver_unregister() driver: 0x8199374,
name: atmodem
ofonod[9917]: src/phonebook.c:ofono_phonebook_driver_unregister() driver:
0x8199418, name: atmodem
ofonod[9917]: src/call-settings.c:ofono_call_settings_driver_unregister()
driver: 0x8199040, name: atmodem
ofonod[9917]: src/call-meter.c:ofono_call_meter_driver_unregister() driver:
0x8199180, name: atmodem
ofonod[9917]:
src/call-forwarding.c:ofono_call_forwarding_driver_unregister() driver:
0x8199140, name: atmodem
ofonod[9917]: src/call-barring.c:ofono_call_barring_driver_unregister()
driver: 0x81993f8, name: atmodem
ofonod[9917]: src/network.c:ofono_netreg_driver_unregister() driver:
0x81991e0, name: atmodem
ofonod[9917]: src/modem.c:ofono_devinfo_driver_unregister() driver:
0x8199440, name: atmodem
ofonod[9917]: src/voicecall.c:ofono_voicecall_driver_unregister() driver:
0x81993a0, name: atmodem
ofonod[9917]: src/cbs.c:ofono_cbs_driver_unregister() driver: 0x8199120,
name: atmodem
ofonod[9917]: src/call-volume.c:ofono_call_volume_driver_unregister()
driver: 0x8199464, name: atmodem
ofonod[9917]: src/gprs.c:ofono_gprs_driver_unregister() driver: 0x8199494,
name: atmodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
0x81994b8, name: atmodem
ofonod[9917]: src/gnss.c:ofono_gnss_driver_unregister() driver: 0x81994e8,
name: atmodem
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x8198e20, name: gobi
ofonod[9917]:
src/location-reporting.c:ofono_location_reporting_driver_unregister()
driver: 0x8198de4, name: qmimodem
ofonod[9917]: src/radio-settings.c:ofono_radio_settings_driver_unregister()
driver: 0x8198dc0, name: qmimodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
0x8198da8, name: qmimodem
ofonod[9917]: src/gprs.c:ofono_gprs_driver_unregister() driver: 0x8198d94,
name: qmimodem
ofonod[9917]: src/ussd.c:ofono_ussd_driver_unregister() driver: 0x8198d80,
name: qmimodem
ofonod[9917]: src/sms.c:ofono_sms_driver_unregister() driver: 0x8198d60,
name: qmimodem
ofonod[9917]: src/sim.c:ofono_sim_driver_unregister() driver: 0x8198d00,
name: qmimodem
ofonod[9917]: src/sim.c:ofono_sim_driver_unregister() driver: 0x8198ca0,
name: qmimodem-legacy
ofonod[9917]: src/voicecall.c:ofono_voicecall_driver_unregister() driver:
0x8198c00, name: qmimodem
ofonod[9917]: src/network.c:ofono_netreg_driver_unregister() driver:
0x8198c60, name: qmimodem
ofonod[9917]: src/modem.c:ofono_devinfo_driver_unregister() driver:
0x8198be0, name: qmimodem
ofonod[9917]: src/modem.c:ofono_devinfo_driver_unregister() driver:
0x8198b60, name: u8500
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x8198b80, name: u8500
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x8198b00, name: n900
ofonod[9917]: src/modem.c:ofono_modem_driver_unregister() driver:
0x8198aa0, name: isiusb
ofonod[9917]: src/modem.c:ofono_devinfo_driver_unregister() driver:
0x8198790, name: isimodem
ofonod[9917]: src/phonebook.c:ofono_phonebook_driver_unregister() driver:
0x8198780, name: isimodem
ofonod[9917]: src/network.c:ofono_netreg_driver_unregister() driver:
0x81987c0, name: isimodem
ofonod[9917]: src/voicecall.c:ofono_voicecall_driver_unregister() driver:
0x8198800, name: isimodem
ofonod[9917]: src/sms.c:ofono_sms_driver_unregister() driver: 0x8198860,
name: isimodem
ofonod[9917]: src/cbs.c:ofono_cbs_driver_unregister() driver: 0x8198880,
name: isimodem
ofonod[9917]: src/sim.c:ofono_sim_driver_unregister() driver: 0x81988a0,
name: isimodem
ofonod[9917]: src/ussd.c:ofono_ussd_driver_unregister() driver: 0x81988e8,
name: isimodem
ofonod[9917]:
src/call-forwarding.c:ofono_call_forwarding_driver_unregister() driver:
0x8198900, name: isimodem
ofonod[9917]: src/call-settings.c:ofono_call_settings_driver_unregister()
driver: 0x8198920, name: isimodem
ofonod[9917]: src/call-barring.c:ofono_call_barring_driver_unregister()
driver: 0x8198950, name: isimodem
ofonod[9917]: src/call-meter.c:ofono_call_meter_driver_unregister() driver:
0x8198980, name: isimodem
ofonod[9917]: src/radio-settings.c:ofono_radio_settings_driver_unregister()
driver: 0x81989c0, name: isimodem
ofonod[9917]: src/gprs.c:ofono_gprs_driver_unregister() driver: 0x81989e4,
name: isimodem
ofonod[9917]: src/gprs.c:ofono_gprs_context_driver_unregister() driver:
0x81989f8, name: isimodem
ofonod[9917]: src/audio-settings.c:ofono_audio_settings_driver_unregister()
driver: 0x8198a10, name: isimodem
ofonod[9917]: src/sim.c:ofono_sim_driver_unregister() driver: 0x8198a20,
name: wgmodem2.5
ofonod[9917]: plugins/udevng.c:destroy_modem()
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2
ofonod[9917]: src/modem.c:ofono_modem_remove() 0x98b1788
ofonod[9917]: plugins/udevng.c:destroy_modem() /dev/ttyUSB0
ofonod[9917]: plugins/udevng.c:destroy_modem() /dev/ttyUSB1
ofonod[9917]: plugins/udevng.c:destroy_modem() /dev/ttyUSB2
ofonod[9917]:
src/private-network.c:ofono_private_network_driver_unregister() driver:
0x819aba0, name: Example Private Network Driver
ofonod[9917]: Exit

--===============8351858024165727561==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+SGVsbG8gYWxsLDxicj48YnI+PC9kaXY+SSYj
Mzk7bSB0cnlpbmcgc2V0dXAgSHVhd2VpIEUxNzEgM0cgZG9uZ2xlIHdpdGggb2Zvbm8sIGJ1dCBo
YXZlIHNvbWUgcHJvYmxlbXMuPGJyPk1vZGVtIGNvcnJlY3QgZGV0ZWN0ZWQsIGFuZCBlbmFibGUt
bW9kZW0gd29ya3MgZmluZS4gQnV0IGFmdGVyIG9ubGluZS1tb2RlbSBleGVjdXRpb24sIG1vZGVt
IGlzIHJlbW92ZWQgYW5kIGFkZGVkIHNhbWUgbW9kZW0gd2l0aCBuZXcgbnVtYmVyLjxicj4KCkkm
IzM5O20gdHJ5aW5nIHVuZGVyc3RhbmQgd2hhdHMgZ29pbmcgb24gZnJvbSBkZWJ1ZyBsb2csIHRo
ZSBwcm9ibGVtIGlzIGluIHJlZ2lzdHJhdGlvbiBzdGF0ZT88YnI+PGJyPm9mb25vZFs5OTE3XTog
UENVSTogJmd0OyBBVCtDUkVHP1xyPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuK0NS
RUc6IDIsMTgzMzkxODhcclxuXHJcbk9LXHJcbjxicj5vZm9ub2RbOTkxN106IHNyYy9uZXR3b3Jr
LmM6aW5pdF9yZWdpc3RyYXRpb25fc3RhdHVzKCkgRXJyb3IgZHVyaW5nIHJlZ2lzdHJhdGlvbiBz
dGF0dXMgcXVlcnk8YnI+Cgo8YnI+PC9kaXY+QmVzdCByZWdhcmRzLDxicj48L2Rpdj5SZW5hdCBa
YXJpcG92PGJyPjxkaXY+PGRpdj48YnI+UC5TLiBGdWxsIGxvZzo8YnI+PGJyPm9mb25vZFs5OTE3
XTogb0Zvbm8gdmVyc2lvbiAxLjE0PGJyPm9mb25vZFs5OTE3XTogQ2FuJiMzOTt0IGVuYWJsZSBk
ZWZlcnJlZCBzZXR1cDogUHJvdG9jb2wgbm90IGF2YWlsYWJsZSAoOTIpPGJyPm9mb25vZFs5OTE3
XTogc3JjL3BsdWdpbi5jOl9fb2Zvbm9fcGx1Z2luX2luaXQoKSA8YnI+CgpvZm9ub2RbOTkxN106
IHBsdWdpbnMvcHVzaC1ub3RpZmljYXRpb24uYzpwdXNoX25vdGlmaWNhdGlvbl9pbml0KCkgPGJy
Pm9mb25vZFs5OTE3XTogcGx1Z2lucy9zbWFydC1tZXNzYWdpbmcuYzpzbWFydF9tZXNzYWdpbmdf
aW5pdCgpIDxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg4MTlhYmUwLCBuYW1lOiBzdGt0ZXN0PGJyPgoKb2Zvbm9kWzk5
MTddOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9jcmVhdGUoKSBuYW1lOiBzdGt0ZXN0LCB0eXBl
OiBzdGt0ZXN0PGJyPm9mb25vZFs5OTE3XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fcmVnaXN0
ZXIoKSAweDk4YTJlZjA8YnI+b2Zvbm9kWzk5MTddOiBwbHVnaW5zL3N0a3Rlc3QuYzpzdGt0ZXN0
X3Byb2JlKCkgMHg5OGEyZWYwPGJyPm9mb25vZFs5OTE3XTogc3JjL21vZGVtLmM6ZW1pdF9tb2Rl
bV9hZGRlZCgpIDB4OThhMmVmMDxicj4KCm9mb25vZFs5OTE3XTogc3JjL21vZGVtLmM6Y2FsbF9t
b2RlbXdhdGNoZXMoKSAweDk4YTJlZjAgYWRkZWQ6MTxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMv
c21hcnQtbWVzc2FnaW5nLmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg5OGEyZWYwLCBhZGRlZDog
MTxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvcHVzaC1ub3RpZmljYXRpb24uYzptb2RlbV93YXRj
aCgpIG1vZGVtOiAweDk4YTJlZjAsIGFkZGVkOiAxPGJyPgoKb2Zvbm9kWzk5MTddOiBleGFtcGxl
cy9lbXVsYXRvci5jOmV4YW1wbGVfZW11bGF0b3JfaW5pdCgpIDxicj5vZm9ub2RbOTkxN106IGV4
YW1wbGVzL2VtdWxhdG9yLmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg5OGEyZWYwLCBhZGRlZDog
MTxicj5vZm9ub2RbOTkxN106IHNyYy9ncHJzLXByb3Zpc2lvbi5jOm9mb25vX2dwcnNfcHJvdmlz
aW9uX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTlhYjQwIG5hbWU6IEV4YW1wbGUgR1BS
UyBjb250ZXh0IHByb3Zpc2lvbmluZzxicj4KCm9mb25vZFs5OTE3XTogc3JjL25ldHRpbWUuYzpv
Zm9ub19uZXR0aW1lX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTlhYjAwIG5hbWU6IEV4
YW1wbGUgTmV0d29yayBUaW1lPGJyPm9mb25vZFs5OTE3XTogc3JjL2hpc3RvcnkuYzpvZm9ub19o
aXN0b3J5X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTlhYWMwIG5hbWU6IEV4YW1wbGUg
Q2FsbCBIaXN0b3J5PGJyPm9mb25vZFs5OTE3XTogc3JjL2NkbWEtcHJvdmlzaW9uLmM6b2Zvbm9f
Y2RtYV9wcm92aXNpb25fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOWFhODAgbmFtZTog
Q0RNQSBwcm92aXNpb25pbmc8YnI+CgpvZm9ub2RbOTkxN106IHNyYy9ncHJzLXByb3Zpc2lvbi5j
Om9mb25vX2dwcnNfcHJvdmlzaW9uX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTlhYTQw
IG5hbWU6IFByb3Zpc2lvbmluZzxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvZHVuX2d3X2JsdWV6
NS5jOmR1bl9nd19pbml0KCkgPGJyPm9mb25vZFs5OTE3XTogcGx1Z2lucy9kdW5fZ3dfYmx1ZXo1
LmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg5OGEyZWYwLCBhZGRlZDogMTxicj4KCm9mb25vZFs5
OTE3XTogcGx1Z2lucy9oZnBfYWdfYmx1ZXo1LmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg5OGEy
ZWYwLCBhZGRlZDogMTxicj5vZm9ub2RbOTkxN106IHNyYy9oYW5kc2ZyZWUtYXVkaW8uYzpvZm9u
b19oYW5kc2ZyZWVfY2FyZF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5YThjMDxicj5v
Zm9ub2RbOTkxN106IHBsdWdpbnMvaGU5MTAuYzpoZTkxMF9pbml0KCkgPGJyPgoKb2Zvbm9kWzk5
MTddOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
ODE5YTg0MCwgbmFtZTogaGU5MTA8YnI+b2Zvbm9kWzk5MTddOiBwbHVnaW5zL2Nvbm5tYW4uYzpj
b25ubWFuX2luaXQoKSA8YnI+b2Zvbm9kWzk5MTddOiBzcmMvcHJpdmF0ZS1uZXR3b3JrLmM6b2Zv
bm9fcHJpdmF0ZV9uZXR3b3JrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTlhODAwLCBu
YW1lOiBDb25uTWFuIFByaXZhdGUgTmV0d29yazxicj4KCm9mb25vZFs5OTE3XTogc3JjL21vZGVt
LmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOWE3YTAsIG5hbWU6
IHNpbTkwMDxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg4MTlhNzQwLCBuYW1lOiBzYW1zdW5nPGJyPm9mb25vZFs5OTE3
XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgx
OWE2ZTAsIG5hbWU6IHNwZWVkdXBjZG1hPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpv
Zm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5YTY4MCwgbmFtZTogc3Bl
ZWR1cDxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg4MTlhNjIwLCBuYW1lOiBhbGNhdGVsPGJyPm9mb25vZFs5OTE3XTog
c3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOWE1
YzAsIG5hbWU6IGljZXJhPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9ub19tb2Rl
bV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5YTU2MCwgbmFtZTogbGlua3RvcDxicj5v
Zm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg4MTlhNTAwLCBuYW1lOiBub2tpYWNkbWE8YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9k
ZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5YTRhMCwgbmFt
ZTogbm9raWE8YnI+CgpvZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTlhNDQwLCBuYW1lOiB0YzY1PGJyPm9mb25vZFs5OTE3
XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgx
OWEzYTAsIG5hbWU6IHN0ZTxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOm9mb25vX21vZGVt
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTlhMzQwLCBuYW1lOiBpZng8YnI+CgpvZm9u
b2RbOTkxN106IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg4MTlhMmUwLCBuYW1lOiBwYWxtcHJlPGJyPm9mb25vZFs5OTE3XTogc3JjL21vZGVtLmM6
b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOWEyODAsIG5hbWU6IG5v
dmF0ZWw8YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4ODE5YTIyMCwgbmFtZTogc2llcnJhPGJyPgoKb2Zvbm9kWzk5MTdd
OiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5
YTFhMCwgbmFtZTogaHVhd2VpPGJyPm9mb25vZFs5OTE3XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9k
ZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOWExNDAsIG5hbWU6IHp0ZTxicj5vZm9u
b2RbOTkxN106IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg4MTlhMGUwLCBuYW1lOiBoc288YnI+CgpvZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOm9m
b25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTlhMDgwLCBuYW1lOiBtYm08
YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4ODE5YTAyMCwgbmFtZTogY2FseXBzbzxicj5vZm9ub2RbOTkxN106IHNyYy9t
b2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5ZmMwLCBu
YW1lOiB3YXZlY29tPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OWY2MCwgbmFtZTogZzE8YnI+b2Zvbm9kWzk5
MTddOiBzcmMvY2RtYS12b2ljZWNhbGwuYzpvZm9ub19jZG1hX3ZvaWNlY2FsbF9kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4ODE5OWVlMCwgbmFtZTogY2RtYW1vZGVtPGJyPm9mb25vZFs5OTE3
XTogc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5mb19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
ODE5OWYwMCwgbmFtZTogY2RtYW1vZGVtPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvY2RtYS1jb25u
bWFuLmM6b2Zvbm9fY2RtYV9jb25ubWFuX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5
ZjI0LCBuYW1lOiBjZG1hbW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9ub19t
b2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OWU0MCwgbmFtZTogcGhvbmVzaW08
YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4ODE5OWU4MCwgbmFtZTogbG9jYWxoZnA8YnI+CgpvZm9ub2RbOTkxN106IHNy
Yy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4
MTk5ZTE0LCBuYW1lOiBwaG9uZXNpbTxicj5vZm9ub2RbOTkxN106IHNyYy9jdG0uYzpvZm9ub19j
dG1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTllMDAsIG5hbWU6IHBob25lc2ltPGJy
Pm9mb25vZFs5OTE3XTogcGx1Z2lucy9waG9uZXNpbS5jOnBhcnNlX2NvbmZpZygpIGZpbGVuYW1l
IC9ldGMvb2Zvbm8vcGhvbmVzaW0uY29uZjxicj4KCm9mb25vZFs5OTE3XTogc3JjL3Vzc2QuYzpv
Zm9ub191c3NkX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5ZGMwLCBuYW1lOiBzcGVl
ZHVwbW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxs
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5YzYwLCBuYW1lOiBoZnBtb2RlbTxicj5v
Zm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxOTlkMWMsIG5hbWU6IGhmcG1vZGVtPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMv
bmV0d29yay5jOm9mb25vX25ldHJlZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OWNj
MCwgbmFtZTogaGZwbW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvY2FsbC12b2x1bWUuYzpvZm9u
b19jYWxsX3ZvbHVtZV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OWNmNCwgbmFtZTog
aGZwbW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvaGFuZHNmcmVlLmM6b2Zvbm9faGFuZHNmcmVl
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5ZDM4LCBuYW1lOiBoZnBtb2RlbTxicj4K
Cm9mb25vZFs5OTE3XTogc3JjL3NpcmkuYzpvZm9ub19zaXJpX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg4MTk5ZDY0LCBuYW1lOiBoZnBtb2RlbTxicj5vZm9ub2RbOTkxN106IHNyYy9uZXR3
b3JrLmM6b2Zvbm9fbmV0cmVnX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5YmUwLCBu
YW1lOiBkdW5tb2RlbTxicj5vZm9ub2RbOTkxN106IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OWMwYywgbmFtZTogZHVubW9kZW08YnI+CgpvZm9u
b2RbOTkxN106IHNyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDgxOTliMDAsIG5hbWU6IHN0ZW1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3Jj
L2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgx
OTliOGMsIG5hbWU6IHN0ZW1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL3JhZGlvLXNldHRpbmdz
LmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTli
NjAsIG5hbWU6IHN0ZW1vZGVtPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvdm9pY2VjYWxsLmM6b2Zv
bm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5OWMwLCBuYW1lOiBp
Znhtb2RlbTxicj5vZm9ub2RbOTkxN106IHNyYy9hdWRpby1zZXR0aW5ncy5jOm9mb25vX2F1ZGlv
X3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5YTEwLCBuYW1lOiBpZnht
b2RlbTxicj5vZm9ub2RbOTkxN106IHNyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3Nl
dHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5YTQwLCBuYW1lOiBpZnhtb2Rl
bTxicj4KCm9mb25vZFs5OTE3XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTlhNmMsIG5hbWU6IGlmeG1vZGVtPGJyPm9mb25vZFs5
OTE3XTogc3JjL3N0ay5jOm9mb25vX3N0a19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5
OWE5NCwgbmFtZTogaWZ4bW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvY3RtLmM6b2Zvbm9fY3Rt
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5YWJjLCBuYW1lOiBpZnhtb2RlbTxicj4K
Cm9mb25vZFs5OTE3XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDgxOTk5NDAsIG5hbWU6IGhzb21vZGVtPGJyPm9mb25vZFs5OTE3XTog
c3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDgxOTk5NjAsIG5hbWU6IGhzb21vZGVtPGJyPm9mb25vZFs5OTE3XTogc3Jj
L2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgx
OTk4YTAsIG5hbWU6IG1ibW1vZGVtPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvc3RrLmM6b2Zvbm9f
c3RrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5OGM4LCBuYW1lOiBtYm1tb2RlbTxi
cj5vZm9ub2RbOTkxN106IHNyYy9sb2NhdGlvbi1yZXBvcnRpbmcuYzpvZm9ub19sb2NhdGlvbl9y
ZXBvcnRpbmdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTk4ZTgsIG5hbWU6IG1ibW1v
ZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OTgwMCwgbmFtZTogY2FseXBzb21vZGVtPGJyPgoK
b2Zvbm9kWzk5MTddOiBzcmMvc3RrLmM6b2Zvbm9fc3RrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg4MTk5ODQ4LCBuYW1lOiBjYWx5cHNvbW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvdXNz
ZC5jOm9mb25vX3Vzc2RfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTk2ZTAsIG5hbWU6
IGh1YXdlaW1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNl
Y2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OTcwMCwgbmFtZTogaHVhd2VpbW9k
ZW08YnI+CgpvZm9ub2RbOTkxN106IHNyYy9hdWRpby1zZXR0aW5ncy5jOm9mb25vX2F1ZGlvX3Nl
dHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5NzQ4LCBuYW1lOiBodWF3ZWlt
b2RlbTxicj5vZm9ub2RbOTkxN106IHNyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3Nl
dHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5NzgwLCBuYW1lOiBodWF3ZWlt
b2RlbTxicj4KCm9mb25vZFs5OTE3XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTk3NWMsIG5hbWU6IGh1YXdlaW1vZGVtPGJyPm9m
b25vZFs5OTE3XTogc3JjL2NkbWEtbmV0cmVnLmM6b2Zvbm9fY2RtYV9uZXRyZWdfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDgxOTk3YWMsIG5hbWU6IGh1YXdlaW1vZGVtPGJyPm9mb25vZFs5
OTE3XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDgxOTk2NDAsIG5hbWU6IGljZXJhbW9kZW08YnI+CgpvZm9ub2RbOTkxN106IHNyYy9y
YWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg4MTk5NjgwLCBuYW1lOiBpY2VyYW1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL3Jh
ZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDgxOTk1ZTAsIG5hbWU6IHp0ZW1vZGVtPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvZ3By
cy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OTVh
MCwgbmFtZTogc3dtb2RlbTxicj5vZm9ub2RbOTkxN106IHNyYy9yYWRpby1zZXR0aW5ncy5jOm9m
b25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5NTQwLCBu
YW1lOiBud21vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNl
Y2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OTNhMCwgbmFtZTogYXRtb2RlbTxi
cj4KCm9mb25vZFs5OTE3XTogc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5mb19kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4ODE5OTQ0MCwgbmFtZTogYXRtb2RlbTxicj5vZm9ub2RbOTkxN106IHNy
Yy9jYWxsLWJhcnJpbmcuYzpvZm9ub19jYWxsX2JhcnJpbmdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDgxOTkzZjgsIG5hbWU6IGF0bW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvY2FsbC1m
b3J3YXJkaW5nLmM6b2Zvbm9fY2FsbF9mb3J3YXJkaW5nX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg4MTk5MTQwLCBuYW1lOiBhdG1vZGVtPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvY2FsbC1t
ZXRlci5jOm9mb25vX2NhbGxfbWV0ZXJfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTkx
ODAsIG5hbWU6IGF0bW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvY2FsbC1zZXR0aW5ncy5jOm9m
b25vX2NhbGxfc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTkwNDAsIG5h
bWU6IGF0bW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvcGhvbmVib29rLmM6b2Zvbm9fcGhvbmVi
b29rX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5NDE4LCBuYW1lOiBhdG1vZGVtPGJy
PgoKb2Zvbm9kWzk5MTddOiBzcmMvdXNzZC5jOm9mb25vX3Vzc2RfZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxOTkzNzQsIG5hbWU6IGF0bW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvc21z
LmM6b2Zvbm9fc21zX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5MGMwLCBuYW1lOiBh
dG1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL3NpbS5jOm9mb25vX3NpbV9kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4ODE5OTI0MCwgbmFtZTogYXRtb2RlbTxicj4KCm9mb25vZFs5OTE3XTog
c3JjL3NpbS5jOm9mb25vX3NpbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OTJhMCwg
bmFtZTogYXRtb2RlbS1ub2VmPGJyPm9mb25vZFs5OTE3XTogc3JjL3N0ay5jOm9mb25vX3N0a19k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OTM1NCwgbmFtZTogYXRtb2RlbTxicj5vZm9u
b2RbOTkxN106IHNyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg4MTk5MWUwLCBuYW1lOiBhdG1vZGVtPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvY2Jz
LmM6b2Zvbm9fY2JzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5MTIwLCBuYW1lOiBh
dG1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL2NhbGwtdm9sdW1lLmM6b2Zvbm9fY2FsbF92b2x1
bWVfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTk0NjQsIG5hbWU6IGF0bW9kZW08YnI+
b2Zvbm9kWzk5MTddOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDgxOTk0OTQsIG5hbWU6IGF0bW9kZW08YnI+CgpvZm9ub2RbOTkxN106IHNyYy9ncHJz
LmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5NGI4
LCBuYW1lOiBhdG1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL3NpbS1hdXRoLmM6b2Zvbm9fc2lt
X2F1dGhfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTk0ZDAsIG5hbWU6IGF0bW9kZW08
YnI+b2Zvbm9kWzk5MTddOiBzcmMvZ25zcy5jOm9mb25vX2duc3NfZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxOTk0ZTgsIG5hbWU6IGF0bW9kZW08YnI+CgpvZm9ub2RbOTkxN106IHNyYy9t
b2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk4ZTIwLCBu
YW1lOiBnb2JpPGJyPm9mb25vZFs5OTE3XTogc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5mb19kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OGJlMCwgbmFtZTogcW1pbW9kZW08YnI+b2Zvbm9k
Wzk5MTddOiBzcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4ODE5OGM2MCwgbmFtZTogcW1pbW9kZW08YnI+CgpvZm9ub2RbOTkxN106IHNyYy92b2lj
ZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOThj
MDAsIG5hbWU6IHFtaW1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL3NpbS5jOm9mb25vX3NpbV9k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OGNhMCwgbmFtZTogcW1pbW9kZW0tbGVnYWN5
PGJyPm9mb25vZFs5OTE3XTogc3JjL3NpbS5jOm9mb25vX3NpbV9kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6IDB4ODE5OGQwMCwgbmFtZTogcW1pbW9kZW08YnI+CgpvZm9ub2RbOTkxN106IHNyYy9z
bXMuYzpvZm9ub19zbXNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOThkNjAsIG5hbWU6
IHFtaW1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL3Vzc2QuYzpvZm9ub191c3NkX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg4MTk4ZDgwLCBuYW1lOiBxbWltb2RlbTxicj5vZm9ub2RbOTkx
N106IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5
OGQ5NCwgbmFtZTogcW1pbW9kZW08YnI+CgpvZm9ub2RbOTkxN106IHNyYy9ncHJzLmM6b2Zvbm9f
Z3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk4ZGE4LCBuYW1lOiBx
bWltb2RlbTxicj5vZm9ub2RbOTkxN106IHNyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlv
X3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk4ZGMwLCBuYW1lOiBxbWlt
b2RlbTxicj5vZm9ub2RbOTkxN106IHNyYy9sb2NhdGlvbi1yZXBvcnRpbmcuYzpvZm9ub19sb2Nh
dGlvbl9yZXBvcnRpbmdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOThkZTQsIG5hbWU6
IHFtaW1vZGVtPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OGI4MCwgbmFtZTogdTg1MDA8YnI+b2Zvbm9kWzk5
MTddOiBzcmMvbW9kZW0uYzpvZm9ub19kZXZpbmZvX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg4MTk4YjYwLCBuYW1lOiB1ODUwMDxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOm9mb25v
X21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk4YjAwLCBuYW1lOiBuOTAwPGJy
PgoKb2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4ODE5OGFhMCwgbmFtZTogaXNpdXNiPGJyPm9mb25vZFs5OTE3XTogc3JjL21v
ZGVtLmM6b2Zvbm9fZGV2aW5mb19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5ODc5MCwg
bmFtZTogaXNpbW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvcGhvbmVib29rLmM6b2Zvbm9fcGhv
bmVib29rX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk4NzgwLCBuYW1lOiBpc2ltb2Rl
bTxicj4KCm9mb25vZFs5OTE3XTogc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDgxOTg3YzAsIG5hbWU6IGlzaW1vZGVtPGJyPm9mb25vZFs5OTE3
XTogc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4ODE5ODgwMCwgbmFtZTogaXNpbW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvc21zLmM6
b2Zvbm9fc21zX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk4ODYwLCBuYW1lOiBpc2lt
b2RlbTxicj4KCm9mb25vZFs5OTE3XTogc3JjL2Nicy5jOm9mb25vX2Nic19kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4ODE5ODg4MCwgbmFtZTogaXNpbW9kZW08YnI+b2Zvbm9kWzk5MTddOiBz
cmMvc2ltLmM6b2Zvbm9fc2ltX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk4OGEwLCBu
YW1lOiBpc2ltb2RlbTxicj5vZm9ub2RbOTkxN106IHNyYy91c3NkLmM6b2Zvbm9fdXNzZF9kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5ODhlOCwgbmFtZTogaXNpbW9kZW08YnI+CgpvZm9u
b2RbOTkxN106IHNyYy9jYWxsLWZvcndhcmRpbmcuYzpvZm9ub19jYWxsX2ZvcndhcmRpbmdfZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTg5MDAsIG5hbWU6IGlzaW1vZGVtPGJyPm9mb25v
ZFs5OTE3XTogc3JjL2NhbGwtc2V0dGluZ3MuYzpvZm9ub19jYWxsX3NldHRpbmdzX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg4MTk4OTIwLCBuYW1lOiBpc2ltb2RlbTxicj4KCm9mb25vZFs5
OTE3XTogc3JjL2NhbGwtYmFycmluZy5jOm9mb25vX2NhbGxfYmFycmluZ19kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4ODE5ODk1MCwgbmFtZTogaXNpbW9kZW08YnI+b2Zvbm9kWzk5MTddOiBz
cmMvY2FsbC1tZXRlci5jOm9mb25vX2NhbGxfbWV0ZXJfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
OiAweDgxOTg5ODAsIG5hbWU6IGlzaW1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL3JhZGlvLXNl
dHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAw
eDgxOTg5YzAsIG5hbWU6IGlzaW1vZGVtPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvZ3Bycy5jOm9m
b25vX2dwcnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTg5ZTQsIG5hbWU6IGlzaW1v
ZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTg5ZjgsIG5hbWU6IGlzaW1vZGVtPGJyPm9mb25vZFs5
OTE3XTogc3JjL2F1ZGlvLXNldHRpbmdzLmM6b2Zvbm9fYXVkaW9fc2V0dGluZ3NfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDgxOThhMTAsIG5hbWU6IGlzaW1vZGVtPGJyPgoKb2Zvbm9kWzk5
MTddOiBzcmMvc2ltLmM6b2Zvbm9fc2ltX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk4
YTIwLCBuYW1lOiB3Z21vZGVtMi41PGJyPm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzp1
ZGV2X3N0YXJ0KCkgPGJyPm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzplbnVtZXJhdGVf
ZGV2aWNlcygpIDxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2Rl
dmljZSgpIGh1YiBbKG51bGwpOihudWxsKV08YnI+CgpvZm9ub2RbOTkxN106IHBsdWdpbnMvdWRl
dm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbODA4NzowMDIwXTxicj5vZm9ub2RbOTkxN106
IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbODA4NjoxNDA2XTxicj5v
Zm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIGkyNDAwbV91
c2IgWyhudWxsKToobnVsbCldPGJyPm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVj
a191c2JfZGV2aWNlKCkgaTI0MDBtX3VzYiBbODA4NjoxNDA2XTxicj4KCm9mb25vZFs5OTE3XTog
cGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgaHViIFsobnVsbCk6KG51bGwpXTxi
cj5vZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIGh1YiBb
KG51bGwpOihudWxsKV08YnI+b2Zvbm9kWzk5MTddOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3Vz
Yl9kZXZpY2UoKSB1c2IgWzgwODc6MDAyMF08YnI+b2Zvbm9kWzk5MTddOiBwbHVnaW5zL3VkZXZu
Zy5jOmNoZWNrX3VzYl9kZXZpY2UoKSB1c2IgWzEyZDE6MTAwMV08YnI+CgpvZm9ub2RbOTkxN106
IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbiBbKG51bGwpOihudWxs
KV08YnI+b2Zvbm9kWzk5MTddOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBv
cHRpb24gWzEyZDE6MTAwMV08YnI+b2Zvbm9kWzk5MTddOiBwbHVnaW5zL3VkZXZuZy5jOmFkZF9k
ZXZpY2UoKSAvc3lzL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFkLjAvdXNiMi8yLTEvMi0x
LjI8YnI+CgpvZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9zeXMv
ZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWQuMC91c2IyLzItMS8yLTEuMi8yLTEuMjoxLjAv
dHR5VVNCMC90dHkvdHR5VVNCMDxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6YWRk
X2RldmljZSgpIC9kZXYvdHR5VVNCMCAoaHVhd2VpKSAyNTUvMjU1LzI1NSBbMDBdID09Jmd0OyAo
bnVsbCkgKG51bGwpPGJyPgoKb2Zvbm9kWzk5MTddOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3Vz
Yl9kZXZpY2UoKSBvcHRpb24gWyhudWxsKToobnVsbCldPGJyPm9mb25vZFs5OTE3XTogcGx1Z2lu
cy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgb3B0aW9uIFsxMmQxOjEwMDFdPGJyPm9mb25v
ZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BjaTAw
MDA6MDAvMDAwMDowMDoxZC4wL3VzYjIvMi0xLzItMS4yPGJyPgoKb2Zvbm9kWzk5MTddOiBwbHVn
aW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvc3lzL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAw
OjFkLjAvdXNiMi8yLTEvMi0xLjIvMi0xLjI6MS4xL3R0eVVTQjEvdHR5L3R0eVVTQjE8YnI+b2Zv
bm9kWzk5MTddOiBwbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvZGV2L3R0eVVTQjEgKGh1
YXdlaSkgMjU1LzI1NS8yNTUgWzAxXSA9PSZndDsgKG51bGwpIChudWxsKTxicj4KCm9mb25vZFs5
OTE3XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgb3B0aW9uIFsobnVsbCk6
KG51bGwpXTxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2Rldmlj
ZSgpIG9wdGlvbiBbMTJkMToxMDAxXTxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6
YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWQuMC91c2IyLzIt
MS8yLTEuMjxicj4KCm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkg
L3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZC4wL3VzYjIvMi0xLzItMS4yLzItMS4y
OjEuMi90dHlVU0IyL3R0eS90dHlVU0IyPGJyPm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcu
YzphZGRfZGV2aWNlKCkgL2Rldi90dHlVU0IyIChodWF3ZWkpIDI1NS8yNTUvMjU1IFswMl0gPT0m
Z3Q7IChudWxsKSAobnVsbCk8YnI+CgpvZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6Y2hl
Y2tfdXNiX2RldmljZSgpIHVzYiBbNTk4NjowMTQ4XTxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMv
dWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHV2Y3ZpZGVvIFsobnVsbCk6KG51bGwpXTxicj5v
Zm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHV2Y3ZpZGVv
IFsobnVsbCk6KG51bGwpXTxicj4KCm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVj
a191c2JfZGV2aWNlKCkgdXNiIFswNGI0OjAwNjBdPGJyPm9mb25vZFs5OTE3XTogcGx1Z2lucy91
ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiaGlkIFsobnVsbCk6KG51bGwpXTxicj5vZm9u
b2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYmhpZCBbKG51
bGwpOihudWxsKV08YnI+CgpvZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNi
X2RldmljZSgpIHVzYmhpZCBbKG51bGwpOihudWxsKV08YnI+b2Zvbm9kWzk5MTddOiBwbHVnaW5z
L3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBodWIgWyhudWxsKToobnVsbCldPGJyPm9mb25v
ZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzpjcmVhdGVfbW9kZW0oKSAvc3lzL2RldmljZXMvcGNp
MDAwMDowMC8wMDAwOjAwOjFkLjAvdXNiMi8yLTEvMi0xLjI8YnI+CgpvZm9ub2RbOTkxN106IHBs
dWdpbnMvdWRldm5nLmM6Y3JlYXRlX21vZGVtKCkgZHJpdmVyPWh1YXdlaTxicj5vZm9ub2RbOTkx
N106IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2NyZWF0ZSgpIG5hbWU6IChudWxsKSwgdHlwZTog
aHVhd2VpPGJyPm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSAv
c3lzL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFkLjAvdXNiMi8yLTEvMi0xLjI8YnI+Cgpv
Zm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfaHVhd2VpKCkgL2Rldi90dHlVU0Iw
IDI1NS8yNTUvMjU1IDAwIChudWxsKTxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6
c2V0dXBfaHVhd2VpKCkgL2Rldi90dHlVU0IxIDI1NS8yNTUvMjU1IDAxIChudWxsKTxicj5vZm9u
b2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfaHVhd2VpKCkgL2Rldi90dHlVU0IyIDI1
NS8yNTUvMjU1IDAyIChudWxsKTxicj4KCm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzpz
ZXR1cF9odWF3ZWkoKSBtZG09L2Rldi90dHlVU0IwIHBjdWk9L2Rldi90dHlVU0IyIGRpYWc9KG51
bGwpIHFtaT0obnVsbCkgbmV0PShudWxsKTxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOnNl
dF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OThhYzVhOCBwcm9wZXJ0eSBEZXZpY2U8YnI+b2Zv
bm9kWzk5MTddOiBzcmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDk4YWM1
YTggcHJvcGVydHkgTW9kZW08YnI+CgpvZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOnNldF9tb2Rl
bV9wcm9wZXJ0eSgpIG1vZGVtIDB4OThhYzVhOCBwcm9wZXJ0eSBQY3VpPGJyPm9mb25vZFs5OTE3
XTogc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg5OGFjNWE4IHByb3Bl
cnR5IERpYWc8YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHko
KSBtb2RlbSAweDk4YWM1YTggcHJvcGVydHkgTmV0d29ya0ludGVyZmFjZTxicj4KCm9mb25vZFs5
OTE3XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fcmVnaXN0ZXIoKSAweDk4YWM1YTg8YnI+b2Zv
bm9kWzk5MTddOiBwbHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9wcm9iZSgpIDB4OThhYzVhODxicj5v
Zm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOmVtaXRfbW9kZW1fYWRkZWQoKSAweDk4YWM1YTg8YnI+
b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpjYWxsX21vZGVtd2F0Y2hlcygpIDB4OThhYzVhOCBh
ZGRlZDoxPGJyPgoKb2Zvbm9kWzk5MTddOiBwbHVnaW5zL2hmcF9hZ19ibHVlejUuYzptb2RlbV93
YXRjaCgpIG1vZGVtOiAweDk4YWM1YTgsIGFkZGVkOiAxPGJyPm9mb25vZFs5OTE3XTogcGx1Z2lu
cy9kdW5fZ3dfYmx1ZXo1LmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg5OGFjNWE4LCBhZGRlZDog
MTxicj5vZm9ub2RbOTkxN106IGV4YW1wbGVzL2VtdWxhdG9yLmM6bW9kZW1fd2F0Y2goKSBtb2Rl
bTogMHg5OGFjNWE4LCBhZGRlZDogMTxicj4KCm9mb25vZFs5OTE3XTogcGx1Z2lucy9zbWFydC1t
ZXNzYWdpbmcuYzptb2RlbV93YXRjaCgpIG1vZGVtOiAweDk4YWM1YTgsIGFkZGVkOiAxPGJyPm9m
b25vZFs5OTE3XTogcGx1Z2lucy9wdXNoLW5vdGlmaWNhdGlvbi5jOm1vZGVtX3dhdGNoKCkgbW9k
ZW06IDB4OThhYzVhOCwgYWRkZWQ6IDE8YnI+b2Zvbm9kWzk5MTddOiBzcmMvcHJpdmF0ZS1uZXR3
b3JrLmM6b2Zvbm9fcHJpdmF0ZV9uZXR3b3JrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4
MTlhYmEwLCBuYW1lOiBFeGFtcGxlIFByaXZhdGUgTmV0d29yayBEcml2ZXI8YnI+CgpvZm9ub2Rb
OTkxN106IHBsdWdpbnMvaHVhd2VpLmM6aHVhd2VpX2VuYWJsZSgpIDB4OThhYzVhODxicj5vZm9u
b2RbOTkxN106IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OThhYzVh
OCBwcm9wZXJ0eSBNb2RlbTxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvaHVhd2VpLmM6b3Blbl9k
ZXZpY2UoKSBNb2RlbSAvZGV2L3R0eVVTQjA8YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpn
ZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDk4YWM1YTggcHJvcGVydHkgUGN1aTxicj4KCm9m
b25vZFs5OTE3XTogcGx1Z2lucy9odWF3ZWkuYzpvcGVuX2RldmljZSgpIFBjdWkgL2Rldi90dHlV
U0IyPGJyPm9mb25vZFs5OTE3XTogTW9kZW06ICZndDsgQVRFMCArQ01FRT0xXHI8YnI+b2Zvbm9k
Wzk5MTddOiBQQ1VJOiAmZ3Q7IEFURTAgK0NNRUU9MVxyPGJyPm9mb25vZFs5OTE3XTogTW9kZW06
ICZsdDsgQVRFMCArQ01FRT0xXHJcclxuT0tcclxuPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmx0
OyBcclxuT0tcclxuPGJyPgoKb2Zvbm9kWzk5MTddOiBQQ1VJOiAmZ3Q7IEFUSVxyPGJyPm9mb25v
ZFs5OTE3XTogUENVSTogJmx0OyBcclxuTWFudWZhY3R1cmVyOiBodWF3ZWlcclxuTW9kZWw6IEUx
NzFcclxuUmV2aXNpb246IDExLjEyNi44NS4wMS4xNDNcclxuSU1FSTogMzU2MzU2MDQ1Mzg2NDc3
XHJcbitHQ0FQOiArQ0dTTSwrRFMsK0VTXHJcblxyXG5PS1xyXG48YnI+b2Zvbm9kWzk5MTddOiBQ
Q1VJOiAmZ3Q7IEFUXlJGU1dJVENIPT9ccjxicj4KCm9mb25vZFs5OTE3XTogUENVSTogJmx0OyBc
clxuQ09NTUFORCBOT1QgU1VQUE9SVFxyXG48YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmZ3Q7IEFU
K0NGVU49MVxyPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuXlJTU0k6MTRcclxuPGJy
Pm9mb25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPm9mb25vZFs5OTE3XTogcGx1
Z2lucy9odWF3ZWkuYzpjZnVuX2VuYWJsZSgpIDxicj4KCm9mb25vZFs5OTE3XTogUENVSTogJmd0
OyBBVF5TWVNJTkZPXHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG5eU1lTSU5GTzoy
LDMsMCw1LDEsLDRcclxuXHJcbk9LXHJcbjxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvaHVhd2Vp
LmM6c3lzaW5mb19lbmFibGVfY2IoKSAyNTUgLSZndDsgMTxicj5vZm9ub2RbOTkxN106IE1vZGVt
OiAmZ3Q7IEFUJmFtcDtDMFxyPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVCZhbXA7QzBc
cjxicj4KCm9mb25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPm9mb25vZFs5OTE3
XTogUENVSTogJmd0OyBBVCtDU0NTPSZxdW90O0dTTSZxdW90O1xyPGJyPm9mb25vZFs5OTE3XTog
UENVSTogJmx0OyBcclxuT0tcclxuPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVF5VMkRJ
QUc/XHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG4wXHJcblxyXG5PS1xyXG48YnI+
CgpvZm9ub2RbOTkxN106IFBDVUk6ICZndDsgQVReR0VUUE9SVE1PREVccjxicj5vZm9ub2RbOTkx
N106IE1vZGVtOiAmbHQ7IFxyXG5PS1xyXG48YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxy
XG5eR0VUUE9SVE1PREU6VFlQRTpXQ0RNQTpRdWFsY29tbSxNRE06MCxESUFHOjEsUENVSToyXHJc
blxyXG5PS1xyXG48YnI+b2Zvbm9kWzk5MTddOiBNb2RlbTogJmd0OyBBVCtDU0NTPSZxdW90O0dT
TSZxdW90O1xyPGJyPgoKb2Zvbm9kWzk5MTddOiBQQ1VJOiAmZ3Q7IEFUXlVTU0RNT0RFPT9ccjxi
cj5vZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbl5VU1NETU9ERTooMC0xKVxyXG5cclxuT0tc
clxuPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVF5ESUFMTU9ERT0/XHI8YnI+b2Zvbm9k
Wzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG5FUlJPUlxyXG48YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAm
Z3Q7IEFUXkNWT0lDRT0/XHI8YnI+CgpvZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbl5DVk9J
Q0U6KDApXHJcblxyXG5PS1xyXG48YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmZ3Q7IEFUK0NGVU49
NVxyPGJyPm9mb25vZFs5OTE3XTogTW9kZW06ICZsdDsgXHJcbk9LXHJcbjxicj5vZm9ub2RbOTkx
N106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvaHVhd2Vp
LmM6Y2Z1bl9vZmZsaW5lKCkgPGJyPgoKb2Zvbm9kWzk5MTddOiBleGFtcGxlcy9lbXVsYXRvci5j
OnBvd2VyZWRfd2F0Y2goKSBBZGRpbmcgbW9kZW0gMHg5OGFjNWE4IHRvIHRoZSBsaXN0PGJyPm9m
b25vZFs5OTE3XTogZXhhbXBsZXMvZW11bGF0b3IuYzpjcmVhdGVfdGNwKCkgQ3JlYXRlZCBzZXJ2
ZXJfd2F0Y2g6IDQ0PGJyPm9mb25vZFs5OTE3XTogZXhhbXBsZXMvZW11bGF0b3IuYzpjcmVhdGVf
dGNwKCkgQ3JlYXRlZCBzZXJ2ZXJfd2F0Y2g6IDQ1PGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvbW9k
ZW0uYzptb2RlbV9jaGFuZ2Vfc3RhdGUoKSBvbGQgc3RhdGU6IDAsIG5ldyBzdGF0ZTogMTxicj5v
Zm9ub2RbOTkxN106IHBsdWdpbnMvaHVhd2VpLmM6aHVhd2VpX3ByZV9zaW0oKSAweDk4YWM1YTg8
YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmZ3Q7IEFUXlVTU0RNT0RFP1xyPGJyPm9mb25vZFs5OTE3
XTogc3JjL3NpbS5jOm9mb25vX3NpbV9hZGRfc3RhdGVfd2F0Y2goKSAweDk4YWExMDA8YnI+Cgpv
Zm9ub2RbOTkxN106IHNyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3N0YXRlX3dhdGNoKCkgMHg5OGFh
MTAwPGJyPm9mb25vZFs5OTE3XTogc3JjL3NpbS5jOm9mb25vX3NpbV9hZGRfc3RhdGVfd2F0Y2go
KSAweDk4YWExMDA8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG5eVVNTRE1PREU6MVxy
XG5cclxuT0tcclxuPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVF5DVk9JQ0U/XHI8YnI+
CgpvZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbl5DVk9JQ0U6MCw4MDAwLDE2LDIwXHJcblxy
XG5PS1xyXG48YnI+b2Zvbm9kWzk5MTddOiBWb2ljZSBjaGFubmVsOiA4MDAwIEh6LCAxNiBiaXRz
LCAyMG1zIHBlcmlvZDxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZndDsgQVQrR0NBUFxyPGJyPm9m
b25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuK0dDQVA6ICtDR1NNLCtEUywrRVNcclxuXHJcbk9L
XHJcbjxicj4KCm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwxMjI1OCwwLDAs
MjU1XHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7
MDAwMDAwMEEyRkUyMDQwMDBGMDBGRjAxMDYwMDAwMDAyRjA2MDQmcXVvdDtcclxuXHJcbk9LXHJc
bjxicj5vZm9ub2RbOTkxN106IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2luZm9fY2Io
KSBjcnNtX2luZm9fY2I6IDkwLCAwMCwgMTk8YnI+CgpvZm9ub2RbOTkxN106IFBDVUk6ICZndDsg
QVReRERTRVRFWD0/XHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG5eRERTRVRFWDoo
MilcclxuXHJcbk9LXHJcbjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZndDsgQVQrQ0dNSVxyPGJy
Pm9mb25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuaHVhd2VpXHJcblxyXG5PS1xyXG48YnI+b2Zv
bm9kWzk5MTddOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc2LDEyMjU4LDAsMCwxMFxyPGJyPgoKb2Zv
bm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7OTgwNzAxMDI1NDcz
OTE1MTE0RkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj5vZm9ub2RbOTkxN106IGRyaXZlcnMvYXRt
b2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTA8YnI+
b2Zvbm9kWzk5MTddOiBzcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9m
ZjogMCwgZGF0YW9mZjogMCwgdG9jb3B5OiAxMDxicj4KCm9mb25vZFs5OTE3XTogUENVSTogJmd0
OyBBVCtDR01NXHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG5FMTcxXHJcblxyXG5P
S1xyXG48YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NDIxLDAsMCwy
NTVccjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDsw
MDAwMDAwNTZGMDUwNDAwMDEwMEZGMDEwNjAwMDAwMDJGMDYwQiZxdW90O1xyXG5cclxuT0tcclxu
PGJyPgoKb2Zvbm9kWzk5MTddOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2Ni
KCkgY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDE5PGJyPm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBB
VCtDR01SXHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG4xMS4xMjYuODUuMDEuMTQz
XHJcblxyXG5PS1xyXG48YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc2LDI4
NDIxLDAsMCw1XHI8YnI+CgpvZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQs
MCwmcXVvdDtGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+b2Zvbm9kWzk5MTddOiBk
cml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwg
MDAsIDU8YnI+b2Zvbm9kWzk5MTddOiBzcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9ja19j
YigpIGJ1Zm9mZjogMCwgZGF0YW9mZjogMCwgdG9jb3B5OiA1PGJyPgoKb2Zvbm9kWzk5MTddOiBQ
Q1VJOiAmZ3Q7IEFUK0NHU05ccjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbjM1NjM1
NjA0NTM4NjQ3N1xyXG5cclxuT0tcclxuPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVCtD
UlNNPTE5MiwxMjAzNywwLDAsMjU1XHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG4r
Q1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAwMEEyRjA1MDQwMDAxMDA0NDAxMDYwMDAwMDAyRjA2MDUm
cXVvdDtcclxuXHJcbk9LXHJcbjxicj4KCm9mb25vZFs5OTE3XTogZHJpdmVycy9hdG1vZGVtL3Np
bS5jOmF0X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAxOTxicj5vZm9ub2Rb
OTkxN106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzYsMTIwMzcsMCwwLDEwXHI8YnI+b2Zvbm9kWzk5
MTddOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZG
RkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4KCm9mb25vZFs5OTE3XTogZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAxMDxicj5vZm9u
b2RbOTkxN106IHNyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrX2NiKCkgYnVmb2ZmOiAw
LCBkYXRhb2ZmOiAwLCB0b2NvcHk6IDEwPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVCtD
UElOP1xyPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuK0NQSU46IFJFQURZXHJcblxy
XG5PS1xyXG48YnI+CgpvZm9ub2RbOTkxN106IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcGlu
X2NiKCkgY3JzbV9waW5fY2I6IFJFQURZPGJyPm9mb25vZFs5OTE3XTogZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmF0X3Bpbl9yZXRyaWVzX3F1ZXJ5KCkgPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmd0
OyBBVF5DUElOP1xyPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuXkNQSU46IFJFQURZ
LCwxMCwzLDEwLDNcclxuXHJcbk9LXHJcbjxicj4KCm9mb25vZFs5OTE3XTogZHJpdmVycy9hdG1v
ZGVtL3NpbS5jOmh1YXdlaV9jcGluX2NiKCkgcmV0cnkgY291bnRlciBpZD05LCB2YWw9MTA8YnI+
b2Zvbm9kWzk5MTddOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6aHVhd2VpX2NwaW5fY2IoKSByZXRy
eSBjb3VudGVyIGlkPTEsIHZhbD0zPGJyPm9mb25vZFs5OTE3XTogZHJpdmVycy9hdG1vZGVtL3Np
bS5jOmh1YXdlaV9jcGluX2NiKCkgcmV0cnkgY291bnRlciBpZD0xMSwgdmFsPTEwPGJyPgoKb2Zv
bm9kWzk5MTddOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6aHVhd2VpX2NwaW5fY2IoKSByZXRyeSBj
b3VudGVyIGlkPTQsIHZhbD0zPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVCtDUlNNPTE5
MiwyODU5MCwwLDAsMjU1XHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTog
MTQ0LDAsJnF1b3Q7MDAwMDAwMDE2RkFFMDQwMDA0MDBGRjAxMDYwMDAwMDAyRjA2MDMmcXVvdDtc
clxuXHJcbk9LXHJcbjxicj4KCm9mb25vZFs5OTE3XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0
X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAxOTxicj5vZm9ub2RbOTkxN106
IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzYsMjg1OTAsMCwwLDFccjxicj5vZm9ub2RbOTkxN106IFBD
VUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMyZxdW90O1xyXG5cclxuT0tcclxuPGJy
Pm9mb25vZFs5OTE3XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNy
c21fcmVhZF9jYjogOTAsIDAwLCAxPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvc2ltZnMuYzpzaW1f
ZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9mZjogMCwgZGF0YW9mZjogMCwgdG9jb3B5OiAxPGJy
Pm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODU4OSwwLDAsMjU1XHI8YnI+
b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDM2
RkFEMDQwMDA0MDBGRjAxMDYwMDAwMDAyRjA2MDMmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4KCm9m
b25vZFs5OTE3XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpIGNyc21f
aW5mb19jYjogOTAsIDAwLCAxOTxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZndDsgQVQrQ1JTTT0x
NzYsMjg1ODksMCwwLDNccjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAx
NDQsMCwmcXVvdDswMEZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj5vZm9ub2RbOTkxN106IGRy
aXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAw
MCwgMzxicj4KCm9mb25vZFs5OTE3XTogc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tf
Y2IoKSBidWZvZmY6IDAsIGRhdGFvZmY6IDAsIHRvY29weTogMzxicj5vZm9ub2RbOTkxN106IEVG
YWQgc2hvdWxkIGNvbnRhaW4gYXQgbGVhc3QgZm91ciBieXRlczxicj5vZm9ub2RbOTkxN106IFBD
VUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg0MzgsMCwwLDI1NVxyPGJyPm9mb25vZFs5OTE3XTogUENV
STogJmx0OyBcclxuK0NNRSBFUlJPUjogMjFcclxuPGJyPgoKb2Zvbm9kWzk5MTddOiBQQ1VJOiAm
Z3Q7IEFUK0NSU009MTkyLDI4NDcyLDAsMCwyNTVccjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZs
dDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMDAwMDAxMDZGMzgwNDAwMTQwMEZGMDEwNjAwMDAw
MDJGMDYwNiZxdW90O1xyXG5cclxuT0tcclxuPGJyPm9mb25vZFs5OTE3XTogZHJpdmVycy9hdG1v
ZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAxOTxicj4K
Cm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVCtDUlNNPTE3NiwyODQ3MiwwLDAsMTZccjxicj5v
Zm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDtGRjNGRkZGRjNG
RkYzRjBGRkYwQzAwRkMwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPm9mb25vZFs5OTE3
XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjog
OTAsIDAwLCAxNjxicj4KCm9mb25vZFs5OTE3XTogc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRf
YmxvY2tfY2IoKSBidWZvZmY6IDAsIGRhdGFvZmY6IDAsIHRvY29weTogMTY8YnI+b2Zvbm9kWzk5
MTddOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NDc0LDAsMCwyNTVccjxicj5vZm9ub2RbOTkx
N106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMDAwMjYxNjZGM0EwNDAwMTEw
MDIyMDEwNjAxMjcwMDJGMDYxNiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgoKb2Zvbm9kWzk5MTdd
OiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkgY3JzbV9pbmZvX2NiOiA5
MCwgMDAsIDE5PGJyPm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVCtDSU1JXHI8YnI+b2Zvbm9k
Wzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG4yNTAwMjA0NTM3MTkxNTRcclxuXHJcbk9LXHJcbjxicj5v
Zm9ub2RbOTkxN106IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jaW1pX2NiKCkgY2ltaV9jYjog
MjUwMDIwNDUzNzE5MTU0PGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzptb2RlbV9jaGFu
Z2Vfc3RhdGUoKSBvbGQgc3RhdGU6IDEsIG5ldyBzdGF0ZTogMjxicj5vZm9ub2RbOTkxN106IHBs
dWdpbnMvaHVhd2VpLmM6aHVhd2VpX3Bvc3Rfc2ltKCkgMHg5OGFjNWE4PGJyPm9mb25vZFs5OTE3
XTogZHJpdmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5jOmF0X2dwcnNfY29udGV4dF9wcm9iZSgp
IDxicj5vZm9ub2RbOTkxN106IEV4YW1wbGUgSGlzdG9yeSBQcm9iZSBmb3IgbW9kZW06IDB4OThh
YzVhODxicj4KCm9mb25vZFs5OTE3XTogRXhhbXBsZSBOZXR3b3JrIFRpbWUgUHJvYmUgZm9yIG1v
ZGVtOiAweDk4YWM1YTg8YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJv
cGVydHkoKSBtb2RlbSAweDk4YWM1YTggcHJvcGVydHkgQWx3YXlzT25saW5lPGJyPm9mb25vZFs5
OTE3XTogUENVSTogJmd0OyBBVCtDUkM9MVxyPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmx0OyBc
clxuT0tcclxuPGJyPgoKb2Zvbm9kWzk5MTddOiBQQ1VJOiAmZ3Q7IEFUK0NMSVA9MVxyPGJyPm9m
b25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPm9mb25vZFs5OTE3XTogUENVSTog
Jmd0OyBBVCtDT0xQPTFccjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxi
cj5vZm9ub2RbOTkxN106IFBDVUk6ICZndDsgQVQrQ0NXQT0xXHI8YnI+b2Zvbm9kWzk5MTddOiBQ
Q1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+CgpvZm9ub2RbOTkxN106IGRyaXZlcnMvaHVhd2VpbW9k
ZW0vdm9pY2VjYWxsLmM6aHVhd2VpX3ZvaWNlY2FsbF9pbml0aWFsaXplZCgpIHJlZ2lzdGVyaW5n
IHRvIG5vdGlmaWNhdGlvbnM8YnI+b2Zvbm9kWzk5MTddOiBzcmMvc2ltLmM6b2Zvbm9fc2ltX2Fk
ZF9zdGF0ZV93YXRjaCgpIDB4OThhYTEwMDxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvYmx1ZXo1
LmM6YnRfcmVnaXN0ZXJfcHJvZmlsZSgpIEJsdWV0b290aDogUmVnaXN0ZXJpbmcgMDAwMDExMWYt
MDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiIChoZnBfYWcpIHByb2ZpbGU8YnI+CgpvZm9ub2Rb
OTkxN106IFBDVUk6ICZndDsgQVReQ1ZPSUNFPT9ccjxicj5vZm9ub2RbOTkxN106IFJlZ2lzdGVy
UHJvZmlsZSgpIHJlcGxpZWQgYW4gZXJyb3I6IG9yZy5mcmVlZGVza3RvcC5EQnVzLkVycm9yLlVu
a25vd25NZXRob2QsIE1ldGhvZCAmcXVvdDtSZWdpc3RlclByb2ZpbGUmcXVvdDsgd2l0aCBzaWdu
YXR1cmUgJnF1b3Q7b3Nhe3N2fSZxdW90OyBvbiBpbnRlcmZhY2UgJnF1b3Q7b3JnLmJsdWV6LlBy
b2ZpbGVNYW5hZ2VyMSZxdW90OyBkb2VzbiYjMzk7dCBleGlzdDxicj4KCm9mb25vZFs5OTE3XTog
UENVSTogJmx0OyBcclxuXkNWT0lDRTooMClcclxuXHJcbk9LXHJcbjxicj5vZm9ub2RbOTkxN106
IFBDVUk6ICZndDsgQVQrQ1NDUz0/XHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG4r
Q1NDUzogKCZxdW90O0lSQSZxdW90OywmcXVvdDtHU00mcXVvdDssJnF1b3Q7VUNTMiZxdW90Oylc
clxuXHJcbk9LXHJcbjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZndDsgQVReU1lTQ0ZHPT9ccjxi
cj4KCm9mb25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuXlNZU0NGRzooMiwxMywxNCwxNiksKDAt
MyksKCg0MDAzODAsJnF1b3Q7R1NNOTAwL0dTTTE4MDAvV0NETUEyMTAwJnF1b3Q7KSwoMjgwMDAw
LCZxdW90O0dTTTg1MC9HU00xOTAwJnF1b3Q7KSwoM2ZmZmZmZmYsJnF1b3Q7QWxsIEJhbmRzJnF1
b3Q7KSksKDAtMiksKDAtNClcclxuXHJcbk9LXHJcbjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZn
dDsgQVQrQ1NNUz0/XHI8YnI+CgpvZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbitDU01TOiAo
MC0xKVxyXG5cclxuT0tcclxuPGJyPm9mb25vZFs5OTE3XTogZHJpdmVycy9hdG1vZGVtL3Ntcy5j
OmF0X2NzbXNfcXVlcnlfY2IoKSBDU01TIHF1ZXJ5IHBhcnNlZCBzdWNjZXNzZnVsbHk8YnI+b2Zv
bm9kWzk5MTddOiBQQ1VJOiAmZ3Q7IEFUK0NHRENPTlQ9P1xyPGJyPm9mb25vZFs5OTE3XTogUENV
STogJmx0OyBcclxuK0NHRENPTlQ6ICgxLTE2KSwmcXVvdDtJUCZxdW90OywsLCgwLTIpLCgwLTMp
XHJcbitDR0RDT05UOiAoMS0xNiksJnF1b3Q7UFBQJnF1b3Q7LCwsKDAtMiksKDAtMylcclxuK0NH
RENPTlQ6ICgxLTE2KSwmcXVvdDtJUFY2JnF1b3Q7LCwsKDAtMiksKDAtMylcclxuXHJcbk9LXHJc
bjxicj4KCm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODQ4MCwwLDAsMjU1
XHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAw
MDAwQzM2RjQwMDQwMDExMDA0NDAxMDYwMTI3MDAyRjA2MTgmcXVvdDtcclxuXHJcbk9LXHJcbjxi
cj5vZm9ub2RbOTkxN106IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2luZm9fY2IoKSBj
cnNtX2luZm9fY2I6IDkwLCAwMCwgMTk8YnI+CgpvZm9ub2RbOTkxN106IFBDVUk6ICZndDsgQVQr
Q1BCUz0/XHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG4rQ1BCUzogKCZxdW90O1NN
JnF1b3Q7LCZxdW90O0VOJnF1b3Q7LCZxdW90O09OJnF1b3Q7KVxyXG5cclxuT0tcclxuPGJyPm9m
b25vZFs5OTE3XTogUENVSTogJmd0OyBBVCtDU01TPTFccjxicj5vZm9ub2RbOTkxN106IFBDVUk6
ICZsdDsgXHJcbitDU01TOiAxLDEsMVxyXG5cclxuT0tcclxuPGJyPgoKb2Zvbm9kWzk5MTddOiBQ
Q1VJOiAmZ3Q7IEFUK0NHUkVHPT9ccjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbitD
R1JFRzogKDAtMilcclxuXHJcbk9LXHJcbjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZndDsgQVQr
Q1JTTT0xNzgsMjg0ODAsMSw0LDM5XHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG4r
Q1JTTTogMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xy
XG48YnI+CgpvZm9ub2RbOTkxN106IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRf
Y2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzk8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmZ3Q7
IEFUK0NTTVM/XHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG4rQ1NNUzogMSwxLDEs
MVxyXG5cclxuT0tcclxuPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVCtDR1JFRz0yXHI8
YnI+CgpvZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj5vZm9ub2RbOTkxN106
IFBDVUk6ICZndDsgQVQrQ0dBVVRPPTBccjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJc
bkNPTU1BTkQgTk9UIFNVUFBPUlRcclxuPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVCtD
R0VSRVA9MiwxXHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9m
b25vZFs5OTE3XTogcGx1Z2lucy9ibHVlejUuYzpidF9yZWdpc3Rlcl9wcm9maWxlKCkgQmx1ZXRv
b3RoOiBSZWdpc3RlcmluZyAwMDAwMTEwMy0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIgKGR1
bl9ndykgcHJvZmlsZTxicj4Kb2Zvbm9kWzk5MTddOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4
NDgwLDIsNCwzOVxyPGJyPm9mb25vZFs5OTE3XTogUmVnaXN0ZXJQcm9maWxlKCkgcmVwbGllZCBh
biBlcnJvcjogb3JnLmZyZWVkZXNrdG9wLkRCdXMuRXJyb3IuVW5rbm93bk1ldGhvZCwgTWV0aG9k
ICZxdW90O1JlZ2lzdGVyUHJvZmlsZSZxdW90OyB3aXRoIHNpZ25hdHVyZSAmcXVvdDtvc2F7c3Z9
JnF1b3Q7IG9uIGludGVyZmFjZSAmcXVvdDtvcmcuYmx1ZXouUHJvZmlsZU1hbmFnZXIxJnF1b3Q7
IGRvZXNuJiMzOTt0IGV4aXN0PGJyPgoKb2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JT
TTogMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48
YnI+b2Zvbm9kWzk5MTddOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkg
Y3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM5PGJyPgoKb2Zvbm9kWzk5MTddOiBQQ1VJOiAmZ3Q7IEFU
K0NNR0Y9P1xyPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuK0NNR0Y6ICgwLTEpXHJc
blxyXG5PS1xyXG48YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NDgw
LDMsNCwzOVxyPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZx
dW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgoKb2Zvbm9k
Wzk5MTddOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFk
X2NiOiA5MCwgMDAsIDM5PGJyPm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVCtDUE1TPT9ccjxi
cj5vZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbitDUE1TOiAoJnF1b3Q7TUUmcXVvdDssJnF1
b3Q7TVQmcXVvdDssJnF1b3Q7U00mcXVvdDssJnF1b3Q7U1ImcXVvdDspLCgmcXVvdDtNRSZxdW90
OywmcXVvdDtNVCZxdW90OywmcXVvdDtTTSZxdW90OywmcXVvdDtTUiZxdW90OyksKCZxdW90O01F
JnF1b3Q7LCZxdW90O01UJnF1b3Q7LCZxdW90O1NNJnF1b3Q7LCZxdW90O1NSJnF1b3Q7KVxyXG5c
clxuT0tcclxuPGJyPgoKb2Zvbm9kWzk5MTddOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NDgw
LDQsNCwzOVxyPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZx
dW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJyPm9mb25vZFs5
OTE3XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9j
YjogOTAsIDAwLCAzOTxicj4KCm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVCtDTUdGPTBccjxi
cj5vZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj5vZm9ub2RbOTkxN106IFBD
VUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg0ODAsNSw0LDM5XHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7
XHJcblxyXG5PS1xyXG48YnI+CgpvZm9ub2RbOTkxN106IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzph
dF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzk8YnI+b2Zvbm9kWzk5MTdd
OiBQQ1VJOiAmZ3Q7IEFUK0NQTVM9JnF1b3Q7TUUmcXVvdDssJnF1b3Q7TUUmcXVvdDssJnF1b3Q7
TUUmcXVvdDtccjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbitDUE1TOiAxLDIzLDEs
MjMsMSwyM1xyXG5cclxuT0tcclxuPGJyPgoKb2Zvbm9kWzk5MTddOiBQQ1VJOiAmZ3Q7IEFUK0NS
U009MTkyLDIwMjU2LDAsMCwyNTVccjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbitD
TUUgRVJST1I6IDIxXHJcbjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZndDsgQVQrQ05NST0/XHI8
YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG4rQ05NSTogKDAsMSwyKSwoMCwxLDIsMyks
KDAsMiksKDAsMSwyKSwoMCwxKVxyXG5cclxuT0tcclxuPGJyPgoKb2Zvbm9kWzk5MTddOiBkcml2
ZXJzL2F0bW9kZW0vc21zLmM6YnVpbGRfY25taV9zdHJpbmcoKSA8YnI+b2Zvbm9kWzk5MTddOiBQ
Q1VJOiAmZ3Q7IEFUK0NOTUk9MSwxLDIsMSwwXHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7
IFxyXG5PS1xyXG48YnI+b2Zvbm9kWzk5MTddOiBzcmMvc21zLmM6c21zX3Jlc3RvcmVfdHhfcXVl
dWUoKSA8YnI+b2Zvbm9kWzk5MTddOiBwbHVnaW5zL3B1c2gtbm90aWZpY2F0aW9uLmM6c21zX3dh
dGNoKCkgcmVnaXN0ZXJlZDxicj4KCm9mb25vZFs5OTE3XTogcGx1Z2lucy9zbWFydC1tZXNzYWdp
bmcuYzpzbXNfd2F0Y2goKSByZWdpc3RlcmVkPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBB
VCtDTUdMPTRccjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbitDTVRJOiAmcXVvdDtN
RSZxdW90OywwXHJcbjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbitDTUdMOiAwLDAs
LDIyXHJcbjA3OTE5NzQwNDMwOTAwRjMwNDBCOTE5NzQwODY5NTYwRjkwMDAwNDE0MDAyMzIyMDU1
NjEwM0M3RjMxOVxyXG5cclxuT0tcclxuPGJyPgoKb2Zvbm9kWzk5MTddOiBkcml2ZXJzL2F0bW9k
ZW0vc21zLmM6YXRfY21nbF9ub3RpZnkoKSA8YnI+b2Zvbm9kWzk5MTddOiBkcml2ZXJzL2F0bW9k
ZW0vc21zLmM6YXRfY21nbF9ub3RpZnkoKSBGb3VuZCBhbiBvbGQgU01TIFBEVTogMDc5MTk3NDA0
MzA5MDBGMzA0MEI5MTk3NDA4Njk1NjBGOTAwMDA0MTQwMDIzMjIwNTU2MTAzQzdGMzE5LCB3aXRo
IGxlbjogMjI8YnI+b2Zvbm9kWzk5MTddOiBzcmMvc21zLmM6b2Zvbm9fc21zX2RlbGl2ZXJfbm90
aWZ5KCkgbGVuIDMwIHRwZHUgbGVuIDIyPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvc21zLmM6aGFu
ZGxlX2RlbGl2ZXIoKSA8YnI+b2Zvbm9kWzk5MTddOiBzcmMvc21zLmM6c21zX2Rpc3BhdGNoKCkg
PGJyPm9mb25vZFs5OTE3XTogc3JjL3Ntcy5jOnNtc19kaXNwYXRjaCgpIGRzdCAtMSBzcmMgLTE8
YnI+b2Zvbm9kWzk5MTddOiBJbmNvbWluZyBTTVMgb24gbW9kZW06IDB4OThhYzVhODxicj5vZm9u
b2RbOTkxN106IEludGVybmFsTWVzc2FnZUlkOiBGRDczOTNFNjdFRkQyNzkxNzUxREZFRUI0MkQw
ODNFMTc0ODU3NEZCPGJyPgoKb2Zvbm9kWzk5MTddOiBGcm9tOiArNzkwNDY4NTkwNjk8YnI+b2Zv
bm9kWzk5MTddOiBMb2NhbCBTZW50IFRpbWU6IDIwMTQtMDQtMjBUMjM6MDI6NTUrMDQwMDxicj5v
Zm9ub2RbOTkxN106IFJlbW90ZSBTZW50IFRpbWU6IDIwMTQtMDQtMjBUMjM6MDI6NTUrMDQwMDxi
cj5vZm9ub2RbOTkxN106IFRleHQ6IEdnZzxicj5vZm9ub2RbOTkxN106IGRyaXZlcnMvYXRtb2Rl
bS9zbXMuYzphdF9jbWdsX2RvbmUoKSA8YnI+CgpvZm9ub2RbOTkxN106IFBDVUk6ICZndDsgQVQr
Q0dTTVM9M1xyPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPm9mb25v
ZFs5OTE3XTogUENVSTogJmd0OyBBVCtDTUdEPTBccjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZs
dDsgXHJcbk9LXHJcbjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbl5CT09UOjQ1Mzg2
NDc3LDAsMCwwLDIwXHJcbjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZsdDsgXHJcbl5SU1NJOjk5
XHJcbjxicj4KCm9mb25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuXlNSVlNUOjBcclxuPGJyPm9m
b25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuXk1PREU6MCwwXHJcbjxicj5vZm9ub2RbOTkxN106
IFBDVUk6ICZsdDsgXHJcbitDR1JFRzogMlxyXG48YnI+b2Zvbm9kWzk5MTddOiBzcmMvZ3Bycy5j
Om9mb25vX2dwcnNfc3RhdHVzX25vdGlmeSgpIC9odWF3ZWlfMCBzdGF0dXMgMjxicj5vZm9ub2Rb
OTkxN106IFBDVUk6ICZsdDsgXHJcbl5CT09UOjQ1Mzg2NDc3LDAsMCwwLDIwXHJcbjxicj4KCm9m
b25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuXkJPT1Q6NDUzODY0NzcsMCwwLDAsMjBcclxuPGJy
Pm9mb25vZFs5OTE3XTogc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg5
OGFjNWE4IHByb3BlcnR5IEFsd2F5c09ubGluZTxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvaHVh
d2VpLmM6aHVhd2VpX3NldF9vbmxpbmUoKSBtb2RlbSAweDk4YWM1YTggb25saW5lPGJyPgoKb2Zv
bm9kWzk5MTddOiBQQ1VJOiAmZ3Q7IEFUK0NGVU49MVxyPGJyPm9mb25vZFs5OTE3XTogUENVSTog
Jmx0OyBcclxuT0tcclxuPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVF5TWVNJTkZPXHI8
YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG5eU1lTSU5GTzowLDMsMCwwLDEsLDBcclxu
XHJcbk9LXHJcbjxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvaHVhd2VpLmM6c3lzaW5mb19vbmxp
bmVfY2IoKSAxIC0mZ3Q7IDE8YnI+CgpvZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOm1vZGVtX2No
YW5nZV9zdGF0ZSgpIG9sZCBzdGF0ZTogMiwgbmV3IHN0YXRlOiAzPGJyPm9mb25vZFs5OTE3XTog
cGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfcG9zdF9vbmxpbmUoKSAweDk4YWM1YTg8YnI+b2Zvbm9k
Wzk5MTddOiBQQ1VJOiAmZ3Q7IEFUK0NSRUc9P1xyPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmx0
OyBcclxuK0NSRUc6ICgwLTIpXHJcblxyXG5PS1xyXG48YnI+CgpvZm9ub2RbOTkxN106IFBDVUk6
ICZndDsgQVQrQ1NDQj0/XHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG4rQ1NDQjog
KDAtMSlcclxuXHJcbk9LXHJcbjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZndDsgQVQrQ1VTRD0x
XHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+b2Zvbm9kWzk5MTdd
OiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NjE4LDAsMCwyNTVccjxicj4KCm9mb25vZFs5OTE3
XTogUENVSTogJmx0OyBcclxuK0NNRSBFUlJPUjogMjFcclxuPGJyPm9mb25vZFs5OTE3XTogVW5h
YmxlIHRvIHJlYWQgd2FpdGluZyBtZXNzYWdlcyBudW1iZXJzIGZyb20gU0lNPGJyPm9mb25vZFs5
OTE3XTogUENVSTogJmd0OyBBVCtDUkVHPTJccjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZsdDsg
XHJcbk9LXHJcbjxicj5vZm9ub2RbOTkxN106IHNyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3Nwbl93
YXRjaCgpIDB4OThhYTEwMDxicj4KCm9mb25vZFs5OTE3XTogc3JjL25ldHdvcmsuYzpfX29mb25v
X25ldHJlZ19hZGRfc3RhdHVzX3dhdGNoKCkgMHg5OGIxMDgwPGJyPm9mb25vZFs5OTE3XTogc3Jj
L25ldHdvcmsuYzpfX29mb25vX25ldHJlZ19hZGRfc3RhdHVzX3dhdGNoKCkgMHg5OGIxMDgwPGJy
Pm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVCtDU0NCPTBccjxicj5vZm9ub2RbOTkxN106IFBD
VUk6ICZsdDsgXHJcbitDTVMgRVJST1I6IDMwMlxyXG48YnI+CgpvZm9ub2RbOTkxN106IHNyYy9j
YnMuYzpjYnNfZ290X2ltc2koKSBHb3QgSU1TSTogMjUwMDIwNDUzNzE5MTU0PGJyPm9mb25vZFs5
OTE3XTogc3JjL25ldHdvcmsuYzpfX29mb25vX25ldHJlZ19hZGRfc3RhdHVzX3dhdGNoKCkgMHg5
OGIxMDgwPGJyPm9mb25vZFs5OTE3XTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODYxNywwLDAs
MjU1XHI8YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG4rQ01FIEVSUk9SOiAyMVxyXG48
YnI+CgpvZm9ub2RbOTkxN106IFVuYWJsZSB0byByZWFkIG1haWxib3ggaWRlbnRpZmllcyBmcm9t
IFNJTTxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZndDsgQVQrQ1JFRz9ccjxicj5vZm9ub2RbOTkx
N106IFBDVUk6ICZsdDsgXHJcbitDUkVHOiAyLDE4MzM5MTg4XHJcblxyXG5PS1xyXG48YnI+b2Zv
bm9kWzk5MTddOiBzcmMvbmV0d29yay5jOmluaXRfcmVnaXN0cmF0aW9uX3N0YXR1cygpIEVycm9y
IGR1cmluZyByZWdpc3RyYXRpb24gc3RhdHVzIHF1ZXJ5PGJyPgoKb2Zvbm9kWzk5MTddOiBQQ1VJ
OiAmZ3Q7IEFUK0NSU009MTkyLDI4NDMzLDAsMCwyNTVccjxicj5vZm9ub2RbOTkxN106IFBDVUk6
ICZsdDsgXHJcbitDTUUgRVJST1I6IDIxXHJcbjxicj5vZm9ub2RbOTkxN106IHNyYy9tZXNzYWdl
LXdhaXRpbmcuYzptd19jcGhzX213aXNfcmVhZF9jYigpIE5vIENQSFMgTVdJUyBvbiBTSU08YnI+
b2Zvbm9kWzk5MTddOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NDM1LDAsMCwyNTVccjxicj4K
Cm9mb25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuK0NNRSBFUlJPUjogMjFcclxuPGJyPm9mb25v
ZFs5OTE3XTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODYxMywwLDAsMjU1XHI8YnI+b2Zvbm9k
Wzk5MTddOiBQQ1VJOiAmbHQ7IFxyXG4rQ01FIEVSUk9SOiAyMVxyXG48YnI+b2Zvbm9kWzk5MTdd
OiBzcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9jaygpIGJ1Zm9mZjogMCwgc2Vla29mZjog
MzksIHRvcmVhZDogMTc8YnI+CgpvZm9ub2RbOTkxN106IHNyYy9zaW1mcy5jOnNpbV9mc19vcF9y
ZWFkX2Jsb2NrKCkgYnVmb2ZmOiAwLCBzZWVrb2ZmOiAzOSwgdG9yZWFkOiAyMDxicj5vZm9ub2Rb
OTkxN106IHNyYy9jYnMuYzpzaW1fY2JtaWRfcmVhZF9jYigpIEdvdCBjYm1pZDogNDA5Niw0MDk3
LDQwOTgsNDA5OSw0MTAwLDQxMDEsNDEwMiw0MTAzLDQxMDQsNDEwNTxicj5vZm9ub2RbOTkxN106
IGRyaXZlcnMvYXRtb2RlbS9jYnMuYzphdF9jYnNfc2V0X3RvcGljcygpIDxicj4KCm9mb25vZFs5
OTE3XTogUENVSTogJmd0OyBBVCtDU0NCPTBccjxicj5vZm9ub2RbOTkxN106IFBDVUk6ICZsdDsg
XHJcbitDTVMgRVJST1I6IDMwMlxyXG48YnI+b2Zvbm9kWzk5MTddOiBQQ1VJOiAmZ3Q7IEFUK0NT
Q0I9MCwmcXVvdDswLTEsMyw1LDcsMTEsMTMsNDMsMTMwLDMzMyw1MDAsNTU1LDY2Niw5MDAsNDA5
Niw0MDk3LDQwOTgsNDA5OSw0MTAwLDQxMDEsNDEwMiw0MTAzLDQxMDQsNDEwNSw0MzUyLTQzNTYm
cXVvdDtccjxicj4KCm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzpyZW1vdmVfZGV2aWNl
KCkgL3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZC4wL3VzYjIvMi0xLzItMS4yLzIt
MS4yOjEuMC90dHlVU0IwL3R0eS90dHlVU0IwPGJyPm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2
bmcuYzpkZXN0cm95X21vZGVtKCkgL3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZC4w
L3VzYjIvMi0xLzItMS4yPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9ub19tb2Rl
bV9yZW1vdmUoKSAweDk4YWM1YTg8YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzptb2RlbV91
bnJlZ2lzdGVyKCkgMHg5OGFjNWE4PGJyPm9mb25vZFs5OTE3XTogc3JjL21vZGVtLmM6bW9kZW1f
Y2hhbmdlX3N0YXRlKCkgb2xkIHN0YXRlOiAzLCBuZXcgc3RhdGU6IDA8YnI+b2Zvbm9kWzk5MTdd
OiBzcmMvbW9kZW0uYzpmbHVzaF9hdG9tcygpIDxicj4KCm9mb25vZFs5OTE3XTogc3JjL21lc3Nh
Z2Utd2FpdGluZy5jOm13X3JlbW92ZSgpIGF0b206IDB4OThiMTdjMDxicj5vZm9ub2RbOTkxN106
IHNyYy9jYWxsLWJhcnJpbmcuYzpjYWxsX2JhcnJpbmdfcmVtb3ZlKCkgYXRvbTogMHg5OGFjOWYw
PGJyPm9mb25vZFs5OTE3XTogc3JjL2NhbGwtc2V0dGluZ3MuYzpjYWxsX3NldHRpbmdzX3JlbW92
ZSgpIGF0b206IDB4OThhYzkwODxicj5vZm9ub2RbOTkxN106IHNyYy9jYWxsLWZvcndhcmRpbmcu
YzpjYWxsX2ZvcndhcmRpbmdfcmVtb3ZlKCkgYXRvbTogMHg5OGIxNzM4PGJyPgoKb2Zvbm9kWzk5
MTddOiBzcmMvdXNzZC5jOnVzc2RfcmVtb3ZlKCkgYXRvbTogMHg5OGIxNjYwPGJyPm9mb25vZFs5
OTE3XTogc3JjL25ldHdvcmsuYzpfX29mb25vX25ldHJlZ19yZW1vdmVfc3RhdHVzX3dhdGNoKCkg
MHg5OGIxMDgwPGJyPm9mb25vZFs5OTE3XTogc3JjL2Nicy5jOmNic19yZW1vdmUoKSBhdG9tOiAw
eDk4YjE1YTA8YnI+b2Zvbm9kWzk5MTddOiBzcmMvc2ltLmM6b2Zvbm9fc2ltX3JlbW92ZV9zcG5f
d2F0Y2goKSAweDk4YWExMDA8YnI+CgpvZm9ub2RbOTkxN106IHNyYy9uZXR3b3JrLmM6bmV0cmVn
X3JlbW92ZSgpIGF0b206IDB4OThiMGQyODxicj5vZm9ub2RbOTkxN106IEV4YW1wbGUgTmV0d29y
ayBUaW1lIFJlbW92ZSBmb3IgbW9kZW06IDB4OThhYzVhODxicj5vZm9ub2RbOTkxN106IEV4YW1w
bGUgSGlzdG9yeSBSZW1vdmUgZm9yIG1vZGVtOiAweDk4YWM1YTg8YnI+b2Zvbm9kWzk5MTddOiBz
cmMvZ3Bycy5jOmdwcnNfY29udGV4dF91bnJlZ2lzdGVyKCkgMHg5OGFjYjY4LCAweDk4YWFhNjg8
YnI+CgpvZm9ub2RbOTkxN106IHNyYy9ncHJzLmM6Z3Byc19jb250ZXh0X3JlbW92ZSgpIGF0b206
IDB4OThhY2I4ODxicj5vZm9ub2RbOTkxN106IGRyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQu
YzphdF9ncHJzX2NvbnRleHRfcmVtb3ZlKCkgPGJyPm9mb25vZFs5OTE3XTogcGx1Z2lucy9ibHVl
ejUuYzpidF91bnJlZ2lzdGVyX3Byb2ZpbGUoKSBCbHVldG9vdGg6IFVucmVnaXN0ZXJpbmcgcHJv
ZmlsZSAvYmx1ZXRvb3RoL3Byb2ZpbGUvZHVuX2d3PGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvZ3By
cy5jOmdwcnNfdW5yZWdpc3RlcigpIDB4OThhYWE2ODxicj5vZm9ub2RbOTkxN106IHNyYy9ncHJz
LmM6Z3Byc19yZW1vdmUoKSBhdG9tOiAweDk4YWFhZDA8YnI+b2Zvbm9kWzk5MTddOiBwbHVnaW5z
L3B1c2gtbm90aWZpY2F0aW9uLmM6cHVzaF9ub3RpZmljYXRpb25fY2xlYW51cCgpIDB4OThhYzA4
ODxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvc21hcnQtbWVzc2FnaW5nLmM6c21hcnRfbWVzc2Fn
aW5nX2NsZWFudXAoKSAweDk4YTNiZDA8YnI+CgpvZm9ub2RbOTkxN106IHNyYy9zbXMuYzpzbXNf
cmVtb3ZlKCkgYXRvbTogMHg5OGFhOWQ4PGJyPm9mb25vZFs5OTE3XTogc3JjL3JhZGlvLXNldHRp
bmdzLmM6cmFkaW9fc2V0dGluZ3NfcmVtb3ZlKCkgYXRvbTogMHg5OGFhODIwPGJyPm9mb25vZFs5
OTE3XTogc3JjL3Bob25lYm9vay5jOnBob25lYm9va19yZW1vdmUoKSBhdG9tOiAweDk4YWJlNDg8
YnI+b2Zvbm9kWzk5MTddOiBzcmMvYXVkaW8tc2V0dGluZ3MuYzphdWRpb19zZXR0aW5nc19yZW1v
dmUoKSBhdG9tOiAweDk4YWEwODg8YnI+CgpvZm9ub2RbOTkxN106IHNyYy92b2ljZWNhbGwuYzp2
b2ljZWNhbGxfcmVtb3ZlKCkgYXRvbTogMHg5OGFlMzAwPGJyPm9mb25vZFs5OTE3XTogcGx1Z2lu
cy9ibHVlejUuYzpidF91bnJlZ2lzdGVyX3Byb2ZpbGUoKSBCbHVldG9vdGg6IFVucmVnaXN0ZXJp
bmcgcHJvZmlsZSAvYmx1ZXRvb3RoL3Byb2ZpbGUvaGZwX2FnPGJyPm9mb25vZFs5OTE3XTogc3Jj
L3NpbS5jOnNpbV9yZW1vdmUoKSBhdG9tOiAweDk4YWEyMjg8YnI+CgpvZm9ub2RbOTkxN106IHNy
Yy9tb2RlbS5jOmRldmluZm9fcmVtb3ZlKCkgYXRvbTogMHg5OGFlODcwPGJyPm9mb25vZFs5OTE3
XTogcGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfZGlzYWJsZSgpIDB4OThhYzVhODxicj5vZm9ub2Rb
OTkxN106IHBsdWdpbnMvaHVhd2VpLmM6aHVhd2VpX3JlbW92ZSgpIDB4OThhYzVhODxicj5vZm9u
b2RbOTkxN106IHNyYy9tb2RlbS5jOnVucmVnaXN0ZXJfcHJvcGVydHkoKSBwcm9wZXJ0eSAweDk4
YWJlYzA8YnI+CgpvZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOnVucmVnaXN0ZXJfcHJvcGVydHko
KSBwcm9wZXJ0eSAweDk4YTY4ZTg8YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzp1bnJlZ2lz
dGVyX3Byb3BlcnR5KCkgcHJvcGVydHkgMHg5OGFiZWEwPGJyPm9mb25vZFs5OTE3XTogc3JjL21v
ZGVtLmM6dW5yZWdpc3Rlcl9wcm9wZXJ0eSgpIHByb3BlcnR5IDB4OThhNjRlODxicj5vZm9ub2Rb
OTkxN106IHNyYy9tb2RlbS5jOnVucmVnaXN0ZXJfcHJvcGVydHkoKSBwcm9wZXJ0eSAweDk4YTY5
MjA8YnI+CgpvZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOmVtaXRfbW9kZW1fcmVtb3ZlZCgpIDB4
OThhYzVhODxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOmNhbGxfbW9kZW13YXRjaGVzKCkg
MHg5OGFjNWE4IGFkZGVkOjA8YnI+b2Zvbm9kWzk5MTddOiBwbHVnaW5zL2hmcF9hZ19ibHVlejUu
Yzptb2RlbV93YXRjaCgpIG1vZGVtOiAweDk4YWM1YTgsIGFkZGVkOiAwPGJyPm9mb25vZFs5OTE3
XTogcGx1Z2lucy9kdW5fZ3dfYmx1ZXo1LmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg5OGFjNWE4
LCBhZGRlZDogMDxicj4KCm9mb25vZFs5OTE3XTogZXhhbXBsZXMvZW11bGF0b3IuYzptb2RlbV93
YXRjaCgpIG1vZGVtOiAweDk4YWM1YTgsIGFkZGVkOiAwPGJyPm9mb25vZFs5OTE3XTogZXhhbXBs
ZXMvZW11bGF0b3IuYzptb2RlbV93YXRjaCgpIFJlbW92aW5nIG1vZGVtIDB4OThhYzVhOCBmcm9t
IHRoZSBsaXN0PGJyPm9mb25vZFs5OTE3XTogcGx1Z2lucy9zbWFydC1tZXNzYWdpbmcuYzptb2Rl
bV93YXRjaCgpIG1vZGVtOiAweDk4YWM1YTgsIGFkZGVkOiAwPGJyPgoKb2Zvbm9kWzk5MTddOiBw
bHVnaW5zL3B1c2gtbm90aWZpY2F0aW9uLmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg5OGFjNWE4
LCBhZGRlZDogMDxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6ZGVzdHJveV9tb2Rl
bSgpIC9kZXYvdHR5VVNCMDxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6ZGVzdHJv
eV9tb2RlbSgpIC9kZXYvdHR5VVNCMTxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6
ZGVzdHJveV9tb2RlbSgpIC9kZXYvdHR5VVNCMjxicj4KCm9mb25vZFs5OTE3XTogcGx1Z2lucy91
ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSB0dHkgcmVtb3ZlPGJyPm9mb25vZFs5OTE3XTog
cGx1Z2lucy91ZGV2LmM6cmVtb3ZlX21vZGVtKCkgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAw
OjFkLjAvdXNiMi8yLTEvMi0xLjIvMi0xLjI6MS4wL3R0eVVTQjAvdHR5L3R0eVVTQjA8YnI+b2Zv
bm9kWzk5MTddOiBwbHVnaW5zL3VkZXYuYzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSBmaW5p
c2hlZDxicj4KCm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzpyZW1vdmVfZGV2aWNlKCkg
L3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZC4wL3VzYjIvMi0xLzItMS4yLzItMS4y
OjEuMDxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBzdWJzeXN0
ZW0gdHR5IHJlbW92ZTxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldi5jOnJlbW92ZV9tb2Rl
bSgpIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZC4wL3VzYjIvMi0xLzItMS4yLzItMS4y
OjEuMS90dHlVU0IxL3R0eS90dHlVU0IxPGJyPgoKb2Zvbm9kWzk5MTddOiBwbHVnaW5zL3VkZXYu
Yzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSBmaW5pc2hlZDxicj5vZm9ub2RbOTkxN106IHBs
dWdpbnMvdWRldm5nLmM6cmVtb3ZlX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAw
MDA6MDA6MWQuMC91c2IyLzItMS8yLTEuMi8yLTEuMjoxLjEvdHR5VVNCMS90dHkvdHR5VVNCMTxi
cj5vZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBzdWJzeXN0ZW0gdHR5
IHJlbW92ZTxicj4KCm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2LmM6cmVtb3ZlX21vZGVtKCkg
L2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFkLjAvdXNiMi8yLTEvMi0xLjIvMi0xLjI6MS4y
L3R0eVVTQjIvdHR5L3R0eVVTQjI8YnI+b2Zvbm9kWzk5MTddOiBwbHVnaW5zL3VkZXYuYzp1ZGV2
X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSBmaW5pc2hlZDxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMv
dWRldm5nLmM6cmVtb3ZlX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6
MWQuMC91c2IyLzItMS8yLTEuMi8yLTEuMjoxLjE8YnI+CgpvZm9ub2RbOTkxN106IHBsdWdpbnMv
dWRldm5nLmM6cmVtb3ZlX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6
MWQuMC91c2IyLzItMS8yLTEuMi8yLTEuMjoxLjIvdHR5VVNCMi90dHkvdHR5VVNCMjxicj5vZm9u
b2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6cmVtb3ZlX2RldmljZSgpIC9zeXMvZGV2aWNlcy9w
Y2kwMDAwOjAwLzAwMDA6MDA6MWQuMC91c2IyLzItMS8yLTEuMi8yLTEuMjoxLjI8YnI+CgpvZm9u
b2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6cmVtb3ZlX2RldmljZSgpIC9zeXMvZGV2aWNlcy9w
Y2kwMDAwOjAwLzAwMDA6MDA6MWQuMC91c2IyLzItMS8yLTEuMjxicj5vZm9ub2RbOTkxN106IFVu
cmVnaXN0ZXJQcm9maWxlKCkgcmVwbGllZCBhbiBlcnJvcjogb3JnLmZyZWVkZXNrdG9wLkRCdXMu
RXJyb3IuVW5rbm93bk1ldGhvZCwgTWV0aG9kICZxdW90O1VucmVnaXN0ZXJQcm9maWxlJnF1b3Q7
IHdpdGggc2lnbmF0dXJlICZxdW90O28mcXVvdDsgb24gaW50ZXJmYWNlICZxdW90O29yZy5ibHVl
ei5Qcm9maWxlTWFuYWdlcjEmcXVvdDsgZG9lc24mIzM5O3QgZXhpc3Q8YnI+CgpvZm9ub2RbOTkx
N106IFVucmVnaXN0ZXJQcm9maWxlKCkgcmVwbGllZCBhbiBlcnJvcjogb3JnLmZyZWVkZXNrdG9w
LkRCdXMuRXJyb3IuVW5rbm93bk1ldGhvZCwgTWV0aG9kICZxdW90O1VucmVnaXN0ZXJQcm9maWxl
JnF1b3Q7IHdpdGggc2lnbmF0dXJlICZxdW90O28mcXVvdDsgb24gaW50ZXJmYWNlICZxdW90O29y
Zy5ibHVlei5Qcm9maWxlTWFuYWdlcjEmcXVvdDsgZG9lc24mIzM5O3QgZXhpc3Q8YnI+CgpvZm9u
b2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbMTJkMTox
MDAxXTxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgp
IG9wdGlvbiBbKG51bGwpOihudWxsKV08YnI+b2Zvbm9kWzk5MTddOiBwbHVnaW5zL3VkZXZuZy5j
OmNoZWNrX3VzYl9kZXZpY2UoKSBvcHRpb24gWyhudWxsKToobnVsbCldPGJyPgoKb2Zvbm9kWzk5
MTddOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBvcHRpb24gWyhudWxsKToo
bnVsbCldPGJyPm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5
c3RlbSB0dHkgYWRkPGJyPm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgp
IHN1YnN5c3RlbSB0dHkgZmluaXNoZWQ8YnI+b2Zvbm9kWzk5MTddOiBwbHVnaW5zL3VkZXZuZy5j
OmNoZWNrX3VzYl9kZXZpY2UoKSBvcHRpb24gWzEyZDE6MTAwMV08YnI+CgpvZm9ub2RbOTkxN106
IHBsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAw
MDA6MDA6MWQuMC91c2IyLzItMS8yLTEuMjxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5n
LmM6YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWQuMC91c2Iy
LzItMS8yLTEuMi8yLTEuMjoxLjEvdHR5VVNCMS90dHkvdHR5VVNCMTxicj4KCm9mb25vZFs5OTE3
XTogcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL2Rldi90dHlVU0IxIChodWF3ZWkpIDI1
NS8yNTUvMjU1IFswMV0gPT0mZ3Q7IChudWxsKSAobnVsbCk8YnI+b2Zvbm9kWzk5MTddOiBwbHVn
aW5zL3VkZXYuYzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSBhZGQ8YnI+b2Zvbm9kWzk5MTdd
OiBwbHVnaW5zL3VkZXYuYzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSBmaW5pc2hlZDxicj4K
Cm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgb3B0aW9u
IFsxMmQxOjEwMDFdPGJyPm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNl
KCkgL3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZC4wL3VzYjIvMi0xLzItMS4yPGJy
Pm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2Vz
L3BjaTAwMDA6MDAvMDAwMDowMDoxZC4wL3VzYjIvMi0xLzItMS4yLzItMS4yOjEuMi90dHlVU0Iy
L3R0eS90dHlVU0IyPGJyPgoKb2Zvbm9kWzk5MTddOiBwbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZp
Y2UoKSAvZGV2L3R0eVVTQjIgKGh1YXdlaSkgMjU1LzI1NS8yNTUgWzAyXSA9PSZndDsgKG51bGwp
IChudWxsKTxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBzdWJz
eXN0ZW0gdHR5IGFkZDxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQo
KSBzdWJzeXN0ZW0gdHR5IGZpbmlzaGVkPGJyPgoKb2Zvbm9kWzk5MTddOiBwbHVnaW5zL3VkZXZu
Zy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBvcHRpb24gWzEyZDE6MTAwMV08YnI+b2Zvbm9kWzk5MTdd
OiBwbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvc3lzL2RldmljZXMvcGNpMDAwMDowMC8w
MDAwOjAwOjFkLjAvdXNiMi8yLTEvMi0xLjI8YnI+b2Zvbm9kWzk5MTddOiBwbHVnaW5zL3VkZXZu
Zy5jOmFkZF9kZXZpY2UoKSAvc3lzL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFkLjAvdXNi
Mi8yLTEvMi0xLjIvMi0xLjI6MS4wL3R0eVVTQjAvdHR5L3R0eVVTQjA8YnI+CgpvZm9ub2RbOTkx
N106IHBsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9kZXYvdHR5VVNCMCAoaHVhd2VpKSAy
NTUvMjU1LzI1NSBbMDBdID09Jmd0OyAobnVsbCkgKG51bGwpPGJyPm9mb25vZFs5OTE3XTogcGx1
Z2lucy91ZGV2bmcuYzpjaGVja19tb2RlbV9saXN0KCkgPGJyPm9mb25vZFs5OTE3XTogcGx1Z2lu
cy91ZGV2bmcuYzpjcmVhdGVfbW9kZW0oKSAvc3lzL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAw
OjFkLjAvdXNiMi8yLTEvMi0xLjI8YnI+CgpvZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6
Y3JlYXRlX21vZGVtKCkgZHJpdmVyPWh1YXdlaTxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5j
Om9mb25vX21vZGVtX2NyZWF0ZSgpIG5hbWU6IChudWxsKSwgdHlwZTogaHVhd2VpPGJyPm9mb25v
ZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSAvc3lzL2RldmljZXMvcGNp
MDAwMDowMC8wMDAwOjAwOjFkLjAvdXNiMi8yLTEvMi0xLjI8YnI+CgpvZm9ub2RbOTkxN106IHBs
dWdpbnMvdWRldm5nLmM6c2V0dXBfaHVhd2VpKCkgL2Rldi90dHlVU0IwIDI1NS8yNTUvMjU1IDAw
IChudWxsKTxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfaHVhd2VpKCkg
L2Rldi90dHlVU0IxIDI1NS8yNTUvMjU1IDAxIChudWxsKTxicj5vZm9ub2RbOTkxN106IHBsdWdp
bnMvdWRldm5nLmM6c2V0dXBfaHVhd2VpKCkgL2Rldi90dHlVU0IyIDI1NS8yNTUvMjU1IDAyIChu
dWxsKTxicj4KCm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSBt
ZG09L2Rldi90dHlVU0IwIHBjdWk9L2Rldi90dHlVU0IyIGRpYWc9KG51bGwpIHFtaT0obnVsbCkg
bmV0PShudWxsKTxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0
eSgpIG1vZGVtIDB4OThiMTc4OCBwcm9wZXJ0eSBEZXZpY2U8YnI+b2Zvbm9kWzk5MTddOiBzcmMv
bW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDk4YjE3ODggcHJvcGVydHkgTW9k
ZW08YnI+CgpvZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1v
ZGVtIDB4OThiMTc4OCBwcm9wZXJ0eSBQY3VpPGJyPm9mb25vZFs5OTE3XTogc3JjL21vZGVtLmM6
c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg5OGIxNzg4IHByb3BlcnR5IERpYWc8YnI+b2Zv
bm9kWzk5MTddOiBzcmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDk4YjE3
ODggcHJvcGVydHkgTmV0d29ya0ludGVyZmFjZTxicj4KCm9mb25vZFs5OTE3XTogc3JjL21vZGVt
LmM6b2Zvbm9fbW9kZW1fcmVnaXN0ZXIoKSAweDk4YjE3ODg8YnI+b2Zvbm9kWzk5MTddOiBwbHVn
aW5zL2h1YXdlaS5jOmh1YXdlaV9wcm9iZSgpIDB4OThiMTc4ODxicj5vZm9ub2RbOTkxN106IHNy
Yy9tb2RlbS5jOmVtaXRfbW9kZW1fYWRkZWQoKSAweDk4YjE3ODg8YnI+b2Zvbm9kWzk5MTddOiBz
cmMvbW9kZW0uYzpjYWxsX21vZGVtd2F0Y2hlcygpIDB4OThiMTc4OCBhZGRlZDoxPGJyPgoKb2Zv
bm9kWzk5MTddOiBwbHVnaW5zL2hmcF9hZ19ibHVlejUuYzptb2RlbV93YXRjaCgpIG1vZGVtOiAw
eDk4YjE3ODgsIGFkZGVkOiAxPGJyPm9mb25vZFs5OTE3XTogcGx1Z2lucy9kdW5fZ3dfYmx1ZXo1
LmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg5OGIxNzg4LCBhZGRlZDogMTxicj5vZm9ub2RbOTkx
N106IGV4YW1wbGVzL2VtdWxhdG9yLmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg5OGIxNzg4LCBh
ZGRlZDogMTxicj4KCm9mb25vZFs5OTE3XTogcGx1Z2lucy9zbWFydC1tZXNzYWdpbmcuYzptb2Rl
bV93YXRjaCgpIG1vZGVtOiAweDk4YjE3ODgsIGFkZGVkOiAxPGJyPm9mb25vZFs5OTE3XTogcGx1
Z2lucy9wdXNoLW5vdGlmaWNhdGlvbi5jOm1vZGVtX3dhdGNoKCkgbW9kZW06IDB4OThiMTc4OCwg
YWRkZWQ6IDE8YnI+b2Zvbm9kWzk5MTddOiBUZXJtaW5hdGluZzxicj5vZm9ub2RbOTkxN106IHNy
Yy9wbHVnaW4uYzpfX29mb25vX3BsdWdpbl9jbGVhbnVwKCkgPGJyPgoKb2Zvbm9kWzk5MTddOiBw
bHVnaW5zL3B1c2gtbm90aWZpY2F0aW9uLmM6cHVzaF9ub3RpZmljYXRpb25fZXhpdCgpIDxicj5v
Zm9ub2RbOTkxN106IHBsdWdpbnMvc21hcnQtbWVzc2FnaW5nLmM6c21hcnRfbWVzc2FnaW5nX2V4
aXQoKSA8YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9yZW1vdmUoKSAw
eDk4YTJlZjA8YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzptb2RlbV91bnJlZ2lzdGVyKCkg
MHg5OGEyZWYwPGJyPgoKb2Zvbm9kWzk5MTddOiBwbHVnaW5zL3N0a3Rlc3QuYzpzdGt0ZXN0X3Jl
bW92ZSgpIDB4OThhMmVmMDxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOmVtaXRfbW9kZW1f
cmVtb3ZlZCgpIDB4OThhMmVmMDxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOmNhbGxfbW9k
ZW13YXRjaGVzKCkgMHg5OGEyZWYwIGFkZGVkOjA8YnI+b2Zvbm9kWzk5MTddOiBwbHVnaW5zL2hm
cF9hZ19ibHVlejUuYzptb2RlbV93YXRjaCgpIG1vZGVtOiAweDk4YTJlZjAsIGFkZGVkOiAwPGJy
PgoKb2Zvbm9kWzk5MTddOiBwbHVnaW5zL2R1bl9nd19ibHVlejUuYzptb2RlbV93YXRjaCgpIG1v
ZGVtOiAweDk4YTJlZjAsIGFkZGVkOiAwPGJyPm9mb25vZFs5OTE3XTogZXhhbXBsZXMvZW11bGF0
b3IuYzptb2RlbV93YXRjaCgpIG1vZGVtOiAweDk4YTJlZjAsIGFkZGVkOiAwPGJyPm9mb25vZFs5
OTE3XTogZXhhbXBsZXMvZW11bGF0b3IuYzptb2RlbV93YXRjaCgpIFJlbW92aW5nIG1vZGVtIDB4
OThhMmVmMCBmcm9tIHRoZSBsaXN0PGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9u
b19tb2RlbV9kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTlhYmUwLCBuYW1lOiBzdGt0
ZXN0PGJyPm9mb25vZFs5OTE3XTogZXhhbXBsZXMvZW11bGF0b3IuYzpleGFtcGxlX2VtdWxhdG9y
X2V4aXQoKSA8YnI+b2Zvbm9kWzk5MTddOiBzcmMvZ3Bycy1wcm92aXNpb24uYzpvZm9ub19ncHJz
X3Byb3Zpc2lvbl9kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTlhYjQwIG5hbWU6IEV4
YW1wbGUgR1BSUyBjb250ZXh0IHByb3Zpc2lvbmluZzxicj4KCm9mb25vZFs5OTE3XTogc3JjL25l
dHRpbWUuYzpvZm9ub19uZXR0aW1lX2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOWFi
MDAgbmFtZTogRXhhbXBsZSBOZXR3b3JrIFRpbWU8YnI+b2Zvbm9kWzk5MTddOiBzcmMvaGlzdG9y
eS5jOm9mb25vX2hpc3RvcnlfZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5YWFjMCBu
YW1lOiBFeGFtcGxlIENhbGwgSGlzdG9yeTxicj4Kb2Zvbm9kWzk5MTddOiBzcmMvY2RtYS1wcm92
aXNpb24uYzpvZm9ub19jZG1hX3Byb3Zpc2lvbl9kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjog
MHg4MTlhYTgwIG5hbWU6IENETUEgcHJvdmlzaW9uaW5nPGJyPgpvZm9ub2RbOTkxN106IHNyYy9n
cHJzLXByb3Zpc2lvbi5jOm9mb25vX2dwcnNfcHJvdmlzaW9uX2RyaXZlcl91bnJlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxOWFhNDAgbmFtZTogUHJvdmlzaW9uaW5nPGJyPm9mb25vZFs5OTE3XTogcGx1
Z2lucy9ibHVlejUuYzpidF91bnJlZ2lzdGVyX3Byb2ZpbGUoKSBCbHVldG9vdGg6IFVucmVnaXN0
ZXJpbmcgcHJvZmlsZSAvYmx1ZXRvb3RoL3Byb2ZpbGUvZHVuX2d3PGJyPgoKb2Zvbm9kWzk5MTdd
OiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4
MTlhODQwLCBuYW1lOiBoZTkxMDxicj5vZm9ub2RbOTkxN106IHNyYy9wcml2YXRlLW5ldHdvcmsu
YzpvZm9ub19wcml2YXRlX25ldHdvcmtfZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5
YTgwMCwgbmFtZTogQ29ubk1hbiBQcml2YXRlIE5ldHdvcms8YnI+CgpvZm9ub2RbOTkxN106IHNy
Yy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOWE3
YTAsIG5hbWU6IHNpbTkwMDxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOm9mb25vX21vZGVt
X2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOWE3NDAsIG5hbWU6IHNhbXN1bmc8YnI+
b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfdW5yZWdpc3Rlcigp
IGRyaXZlcjogMHg4MTlhNmUwLCBuYW1lOiBzcGVlZHVwY2RtYTxicj4KCm9mb25vZFs5OTE3XTog
c3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5
YTY4MCwgbmFtZTogc3BlZWR1cDxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOm9mb25vX21v
ZGVtX2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOWE2MjAsIG5hbWU6IGFsY2F0ZWw8
YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfdW5yZWdpc3Rl
cigpIGRyaXZlcjogMHg4MTlhNWMwLCBuYW1lOiBpY2VyYTxicj4KCm9mb25vZFs5OTE3XTogc3Jj
L21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5YTU2
MCwgbmFtZTogbGlua3RvcDxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOm9mb25vX21vZGVt
X2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOWE1MDAsIG5hbWU6IG5va2lhY2RtYTxi
cj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl91bnJlZ2lzdGVy
KCkgZHJpdmVyOiAweDgxOWE0YTAsIG5hbWU6IG5va2lhPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMv
bW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTlhNDQw
LCBuYW1lOiB0YzY1PGJyPm9mb25vZFs5OTE3XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJp
dmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5YTNhMCwgbmFtZTogc3RlPGJyPm9mb25vZFs5
OTE3XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6
IDB4ODE5YTM0MCwgbmFtZTogaWZ4PGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9u
b19tb2RlbV9kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTlhMmUwLCBuYW1lOiBwYWxt
cHJlPGJyPm9mb25vZFs5OTE3XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3VucmVn
aXN0ZXIoKSBkcml2ZXI6IDB4ODE5YTI4MCwgbmFtZTogbm92YXRlbDxicj5vZm9ub2RbOTkxN106
IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgx
OWEyMjAsIG5hbWU6IHNpZXJyYTxicj4KCm9mb25vZFs5OTE3XTogc3JjL21vZGVtLmM6b2Zvbm9f
bW9kZW1fZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5YTFhMCwgbmFtZTogaHVhd2Vp
PGJyPm9mb25vZFs5OTE3XTogc3JjL21vZGVtLmM6bW9kZW1fdW5yZWdpc3RlcigpIDB4OThiMTc4
ODxicj5vZm9ub2RbOTkxN106IHBsdWdpbnMvaHVhd2VpLmM6aHVhd2VpX3JlbW92ZSgpIDB4OThi
MTc4ODxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOnVucmVnaXN0ZXJfcHJvcGVydHkoKSBw
cm9wZXJ0eSAweDk4YWJmNDA8YnI+CgpvZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOnVucmVnaXN0
ZXJfcHJvcGVydHkoKSBwcm9wZXJ0eSAweDk4YTNkODg8YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9k
ZW0uYzp1bnJlZ2lzdGVyX3Byb3BlcnR5KCkgcHJvcGVydHkgMHg5OGIyNTA4PGJyPm9mb25vZFs5
OTE3XTogc3JjL21vZGVtLmM6dW5yZWdpc3Rlcl9wcm9wZXJ0eSgpIHByb3BlcnR5IDB4OThhMDA3
MDxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOnVucmVnaXN0ZXJfcHJvcGVydHkoKSBwcm9w
ZXJ0eSAweDk4YWJkZTA8YnI+CgpvZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOmVtaXRfbW9kZW1f
cmVtb3ZlZCgpIDB4OThiMTc4ODxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOmNhbGxfbW9k
ZW13YXRjaGVzKCkgMHg5OGIxNzg4IGFkZGVkOjA8YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0u
YzpvZm9ub19tb2RlbV9kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTlhMTQwLCBuYW1l
OiB6dGU8YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfdW5y
ZWdpc3RlcigpIGRyaXZlcjogMHg4MTlhMGUwLCBuYW1lOiBoc288YnI+CgpvZm9ub2RbOTkxN106
IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgx
OWEwODAsIG5hbWU6IG1ibTxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOm9mb25vX21vZGVt
X2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOWEwMjAsIG5hbWU6IGNhbHlwc288YnI+
b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfdW5yZWdpc3Rlcigp
IGRyaXZlcjogMHg4MTk5ZmMwLCBuYW1lOiB3YXZlY29tPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMv
bW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5ZjYw
LCBuYW1lOiBnMTxicj5vZm9ub2RbOTkxN106IHNyYy9jZG1hLXZvaWNlY2FsbC5jOm9mb25vX2Nk
bWFfdm9pY2VjYWxsX2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTllZTAsIG5hbWU6
IGNkbWFtb2RlbTxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJp
dmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OWYwMCwgbmFtZTogY2RtYW1vZGVtPGJyPgoK
b2Zvbm9kWzk5MTddOiBzcmMvY2RtYS1jb25ubWFuLmM6b2Zvbm9fY2RtYV9jb25ubWFuX2RyaXZl
cl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTlmMjQsIG5hbWU6IGNkbWFtb2RlbTxicj5vZm9u
b2RbOTkxN106IHNyYy9jdG0uYzpvZm9ub19jdG1fZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6
IDB4ODE5OWUwMCwgbmFtZTogcGhvbmVzaW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvZ3Bycy5jOm9m
b25vX2dwcnNfY29udGV4dF9kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5ZTE0LCBu
YW1lOiBwaG9uZXNpbTxicj4KCm9mb25vZFs5OTE3XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1f
ZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OWU0MCwgbmFtZTogcGhvbmVzaW08YnI+
b2Zvbm9kWzk5MTddOiBzcmMvdXNzZC5jOm9mb25vX3Vzc2RfZHJpdmVyX3VucmVnaXN0ZXIoKSBk
cml2ZXI6IDB4ODE5OWRjMCwgbmFtZTogc3BlZWR1cG1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3Jj
L3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjog
MHg4MTk5YzYwLCBuYW1lOiBoZnBtb2RlbTxicj4KCm9mb25vZFs5OTE3XTogc3JjL21vZGVtLmM6
b2Zvbm9fZGV2aW5mb19kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5ZDFjLCBuYW1l
OiBoZnBtb2RlbTxicj5vZm9ub2RbOTkxN106IHNyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX2Ry
aXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTljYzAsIG5hbWU6IGhmcG1vZGVtPGJyPm9m
b25vZFs5OTE3XTogc3JjL2NhbGwtdm9sdW1lLmM6b2Zvbm9fY2FsbF92b2x1bWVfZHJpdmVyX3Vu
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OWNmNCwgbmFtZTogaGZwbW9kZW08YnI+CgpvZm9ub2Rb
OTkxN106IHNyYy9oYW5kc2ZyZWUuYzpvZm9ub19oYW5kc2ZyZWVfZHJpdmVyX3VucmVnaXN0ZXIo
KSBkcml2ZXI6IDB4ODE5OWQzOCwgbmFtZTogaGZwbW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMv
c2lyaS5jOm9mb25vX3NpcmlfZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OWQ2NCwg
bmFtZTogaGZwbW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvbmV0d29yay5jOm9mb25vX25ldHJl
Z19kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5YmUwLCBuYW1lOiBkdW5tb2RlbTxi
cj4KCm9mb25vZFs5OTE3XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2RyaXZlcl91bnJlZ2lzdGVy
KCkgZHJpdmVyOiAweDgxOTljMGMsIG5hbWU6IGR1bm1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3Jj
L3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjog
MHg4MTk5YjAwLCBuYW1lOiBzdGVtb2RlbTxicj5vZm9ub2RbOTkxN106IHNyYy9ncHJzLmM6b2Zv
bm9fZ3Byc19jb250ZXh0X2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTliOGMsIG5h
bWU6IHN0ZW1vZGVtPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9u
b19yYWRpb19zZXR0aW5nc19kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5YjYwLCBu
YW1lOiBzdGVtb2RlbTxicj5vZm9ub2RbOTkxN106IHNyYy9zdGsuYzpvZm9ub19zdGtfZHJpdmVy
X3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OWE5NCwgbmFtZTogaWZ4bW9kZW08YnI+b2Zvbm9k
Wzk5MTddOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfdW5yZWdpc3Rlcigp
IGRyaXZlcjogMHg4MTk5YTZjLCBuYW1lOiBpZnhtb2RlbTxicj4KCm9mb25vZFs5OTE3XTogc3Jj
L3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3VucmVnaXN0ZXIo
KSBkcml2ZXI6IDB4ODE5OWE0MCwgbmFtZTogaWZ4bW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMv
YXVkaW8tc2V0dGluZ3MuYzpvZm9ub19hdWRpb19zZXR0aW5nc19kcml2ZXJfdW5yZWdpc3Rlcigp
IGRyaXZlcjogMHg4MTk5YTEwLCBuYW1lOiBpZnhtb2RlbTxicj4KCm9mb25vZFs5OTE3XTogc3Jj
L3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjog
MHg4MTk5OWMwLCBuYW1lOiBpZnhtb2RlbTxicj5vZm9ub2RbOTkxN106IHNyYy9jdG0uYzpvZm9u
b19jdG1fZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OWFiYywgbmFtZTogaWZ4bW9k
ZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJf
dW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5OTQwLCBuYW1lOiBoc29tb2RlbTxicj4KCm9mb25v
ZFs5OTE3XTogc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVy
X3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OTk2MCwgbmFtZTogaHNvbW9kZW08YnI+b2Zvbm9k
Wzk5MTddOiBzcmMvbG9jYXRpb24tcmVwb3J0aW5nLmM6b2Zvbm9fbG9jYXRpb25fcmVwb3J0aW5n
X2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTk4ZTgsIG5hbWU6IG1ibW1vZGVtPGJy
PgoKb2Zvbm9kWzk5MTddOiBzcmMvc3RrLmM6b2Zvbm9fc3RrX2RyaXZlcl91bnJlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxOTk4YzgsIG5hbWU6IG1ibW1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL2dw
cnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5
OThhMCwgbmFtZTogbWJtbW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvc3RrLmM6b2Zvbm9fc3Rr
X2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTk4NDgsIG5hbWU6IGNhbHlwc29tb2Rl
bTxicj4KCm9mb25vZFs5OTE3XTogc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2
ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5ODAwLCBuYW1lOiBjYWx5cHNvbW9kZW08YnI+
b2Zvbm9kWzk5MTddOiBzcmMvY2RtYS1uZXRyZWcuYzpvZm9ub19jZG1hX25ldHJlZ19kcml2ZXJf
dW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5N2FjLCBuYW1lOiBodWF3ZWltb2RlbTxicj5vZm9u
b2RbOTkxN106IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl91bnJlZ2lzdGVy
KCkgZHJpdmVyOiAweDgxOTk3NWMsIG5hbWU6IGh1YXdlaW1vZGVtPGJyPgoKb2Zvbm9kWzk5MTdd
OiBzcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfdW5yZWdp
c3RlcigpIGRyaXZlcjogMHg4MTk5NzgwLCBuYW1lOiBodWF3ZWltb2RlbTxicj5vZm9ub2RbOTkx
N106IHNyYy9hdWRpby1zZXR0aW5ncy5jOm9mb25vX2F1ZGlvX3NldHRpbmdzX2RyaXZlcl91bnJl
Z2lzdGVyKCkgZHJpdmVyOiAweDgxOTk3NDgsIG5hbWU6IGh1YXdlaW1vZGVtPGJyPgoKb2Zvbm9k
Wzk5MTddOiBzcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl91bnJlZ2lzdGVy
KCkgZHJpdmVyOiAweDgxOTk3MDAsIG5hbWU6IGh1YXdlaW1vZGVtPGJyPm9mb25vZFs5OTE3XTog
c3JjL3Vzc2QuYzpvZm9ub191c3NkX2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTk2
ZTAsIG5hbWU6IGh1YXdlaW1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL2dwcnMuYzpvZm9ub19n
cHJzX2NvbnRleHRfZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OTY0MCwgbmFtZTog
aWNlcmFtb2RlbTxicj4KCm9mb25vZFs5OTE3XTogc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9f
cmFkaW9fc2V0dGluZ3NfZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OTY4MCwgbmFt
ZTogaWNlcmFtb2RlbTxicj5vZm9ub2RbOTkxN106IHNyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25v
X3JhZGlvX3NldHRpbmdzX2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTk1ZTAsIG5h
bWU6IHp0ZW1vZGVtPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29u
dGV4dF9kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5NWEwLCBuYW1lOiBzd21vZGVt
PGJyPm9mb25vZFs5OTE3XTogc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGlu
Z3NfZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OTU0MCwgbmFtZTogbndtb2RlbTxi
cj5vZm9ub2RbOTkxN106IHNyYy9zaW0tYXV0aC5jOm9mb25vX3NpbV9hdXRoX2RyaXZlcl91bnJl
Z2lzdGVyKCkgZHJpdmVyOiAweDgxOTk0ZDAsIG5hbWU6IGF0bW9kZW08YnI+CgpvZm9ub2RbOTkx
N106IHNyYy9zdGsuYzpvZm9ub19zdGtfZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5
OTM1NCwgbmFtZTogYXRtb2RlbTxicj5vZm9ub2RbOTkxN106IHNyYy9zaW0uYzpvZm9ub19zaW1f
ZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OTI0MCwgbmFtZTogYXRtb2RlbTxicj5v
Zm9ub2RbOTkxN106IHNyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2
ZXI6IDB4ODE5OTJhMCwgbmFtZTogYXRtb2RlbS1ub2VmPGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMv
c21zLmM6b2Zvbm9fc21zX2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTkwYzAsIG5h
bWU6IGF0bW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvdXNzZC5jOm9mb25vX3Vzc2RfZHJpdmVy
X3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OTM3NCwgbmFtZTogYXRtb2RlbTxicj5vZm9ub2Rb
OTkxN106IHNyYy9waG9uZWJvb2suYzpvZm9ub19waG9uZWJvb2tfZHJpdmVyX3VucmVnaXN0ZXIo
KSBkcml2ZXI6IDB4ODE5OTQxOCwgbmFtZTogYXRtb2RlbTxicj4KCm9mb25vZFs5OTE3XTogc3Jj
L2NhbGwtc2V0dGluZ3MuYzpvZm9ub19jYWxsX3NldHRpbmdzX2RyaXZlcl91bnJlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxOTkwNDAsIG5hbWU6IGF0bW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvY2Fs
bC1tZXRlci5jOm9mb25vX2NhbGxfbWV0ZXJfZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4
ODE5OTE4MCwgbmFtZTogYXRtb2RlbTxicj5vZm9ub2RbOTkxN106IHNyYy9jYWxsLWZvcndhcmRp
bmcuYzpvZm9ub19jYWxsX2ZvcndhcmRpbmdfZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4
ODE5OTE0MCwgbmFtZTogYXRtb2RlbTxicj4KCm9mb25vZFs5OTE3XTogc3JjL2NhbGwtYmFycmlu
Zy5jOm9mb25vX2NhbGxfYmFycmluZ19kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5
M2Y4LCBuYW1lOiBhdG1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL25ldHdvcmsuYzpvZm9ub19u
ZXRyZWdfZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OTFlMCwgbmFtZTogYXRtb2Rl
bTxicj5vZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJpdmVyX3VucmVn
aXN0ZXIoKSBkcml2ZXI6IDB4ODE5OTQ0MCwgbmFtZTogYXRtb2RlbTxicj4KCm9mb25vZFs5OTE3
XTogc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfdW5yZWdpc3RlcigpIGRy
aXZlcjogMHg4MTk5M2EwLCBuYW1lOiBhdG1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL2Nicy5j
Om9mb25vX2Nic19kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk5MTIwLCBuYW1lOiBh
dG1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL2NhbGwtdm9sdW1lLmM6b2Zvbm9fY2FsbF92b2x1
bWVfZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OTQ2NCwgbmFtZTogYXRtb2RlbTxi
cj4KCm9mb25vZFs5OTE3XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2RyaXZlcl91bnJlZ2lzdGVy
KCkgZHJpdmVyOiAweDgxOTk0OTQsIG5hbWU6IGF0bW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMv
Z3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4
MTk5NGI4LCBuYW1lOiBhdG1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL2duc3MuYzpvZm9ub19n
bnNzX2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTk0ZTgsIG5hbWU6IGF0bW9kZW08
YnI+CgpvZm9ub2RbOTkxN106IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl91bnJlZ2lz
dGVyKCkgZHJpdmVyOiAweDgxOThlMjAsIG5hbWU6IGdvYmk8YnI+b2Zvbm9kWzk5MTddOiBzcmMv
bG9jYXRpb24tcmVwb3J0aW5nLmM6b2Zvbm9fbG9jYXRpb25fcmVwb3J0aW5nX2RyaXZlcl91bnJl
Z2lzdGVyKCkgZHJpdmVyOiAweDgxOThkZTQsIG5hbWU6IHFtaW1vZGVtPGJyPm9mb25vZFs5OTE3
XTogc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3VucmVn
aXN0ZXIoKSBkcml2ZXI6IDB4ODE5OGRjMCwgbmFtZTogcW1pbW9kZW08YnI+CgpvZm9ub2RbOTkx
N106IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJp
dmVyOiAweDgxOThkYTgsIG5hbWU6IHFtaW1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL2dwcnMu
YzpvZm9ub19ncHJzX2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOThkOTQsIG5hbWU6
IHFtaW1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL3Vzc2QuYzpvZm9ub191c3NkX2RyaXZlcl91
bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOThkODAsIG5hbWU6IHFtaW1vZGVtPGJyPgoKb2Zvbm9k
Wzk5MTddOiBzcmMvc21zLmM6b2Zvbm9fc21zX2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAw
eDgxOThkNjAsIG5hbWU6IHFtaW1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL3NpbS5jOm9mb25v
X3NpbV9kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk4ZDAwLCBuYW1lOiBxbWltb2Rl
bTxicj5vZm9ub2RbOTkxN106IHNyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVyX3VucmVnaXN0ZXIo
KSBkcml2ZXI6IDB4ODE5OGNhMCwgbmFtZTogcW1pbW9kZW0tbGVnYWN5PGJyPgoKb2Zvbm9kWzk5
MTddOiBzcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl91bnJlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxOThjMDAsIG5hbWU6IHFtaW1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL25l
dHdvcmsuYzpvZm9ub19uZXRyZWdfZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5OGM2
MCwgbmFtZTogcW1pbW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9ub19kZXZp
bmZvX2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOThiZTAsIG5hbWU6IHFtaW1vZGVt
PGJyPgoKb2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9ub19kZXZpbmZvX2RyaXZlcl91bnJl
Z2lzdGVyKCkgZHJpdmVyOiAweDgxOThiNjAsIG5hbWU6IHU4NTAwPGJyPm9mb25vZFs5OTE3XTog
c3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5
OGI4MCwgbmFtZTogdTg1MDA8YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9ub19tb2Rl
bV9kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk4YjAwLCBuYW1lOiBuOTAwPGJyPgoK
b2Zvbm9kWzk5MTddOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfdW5yZWdpc3Rlcigp
IGRyaXZlcjogMHg4MTk4YWEwLCBuYW1lOiBpc2l1c2I8YnI+b2Zvbm9kWzk5MTddOiBzcmMvbW9k
ZW0uYzpvZm9ub19kZXZpbmZvX2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTg3OTAs
IG5hbWU6IGlzaW1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL3Bob25lYm9vay5jOm9mb25vX3Bo
b25lYm9va19kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk4NzgwLCBuYW1lOiBpc2lt
b2RlbTxicj4KCm9mb25vZFs5OTE3XTogc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfZHJpdmVy
X3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5ODdjMCwgbmFtZTogaXNpbW9kZW08YnI+b2Zvbm9k
Wzk5MTddOiBzcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl91bnJlZ2lzdGVy
KCkgZHJpdmVyOiAweDgxOTg4MDAsIG5hbWU6IGlzaW1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3Jj
L3Ntcy5jOm9mb25vX3Ntc19kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk4ODYwLCBu
YW1lOiBpc2ltb2RlbTxicj4KCm9mb25vZFs5OTE3XTogc3JjL2Nicy5jOm9mb25vX2Nic19kcml2
ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk4ODgwLCBuYW1lOiBpc2ltb2RlbTxicj5vZm9u
b2RbOTkxN106IHNyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6
IDB4ODE5ODhhMCwgbmFtZTogaXNpbW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvdXNzZC5jOm9m
b25vX3Vzc2RfZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5ODhlOCwgbmFtZTogaXNp
bW9kZW08YnI+CgpvZm9ub2RbOTkxN106IHNyYy9jYWxsLWZvcndhcmRpbmcuYzpvZm9ub19jYWxs
X2ZvcndhcmRpbmdfZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5ODkwMCwgbmFtZTog
aXNpbW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvY2FsbC1zZXR0aW5ncy5jOm9mb25vX2NhbGxf
c2V0dGluZ3NfZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5ODkyMCwgbmFtZTogaXNp
bW9kZW08YnI+CgpvZm9ub2RbOTkxN106IHNyYy9jYWxsLWJhcnJpbmcuYzpvZm9ub19jYWxsX2Jh
cnJpbmdfZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5ODk1MCwgbmFtZTogaXNpbW9k
ZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvY2FsbC1tZXRlci5jOm9mb25vX2NhbGxfbWV0ZXJfZHJp
dmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5ODk4MCwgbmFtZTogaXNpbW9kZW08YnI+b2Zv
bm9kWzk5MTddOiBzcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2
ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk4OWMwLCBuYW1lOiBpc2ltb2RlbTxicj4KCm9m
b25vZFs5OTE3XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJp
dmVyOiAweDgxOTg5ZTQsIG5hbWU6IGlzaW1vZGVtPGJyPm9mb25vZFs5OTE3XTogc3JjL2dwcnMu
YzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3VucmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5ODlm
OCwgbmFtZTogaXNpbW9kZW08YnI+b2Zvbm9kWzk5MTddOiBzcmMvYXVkaW8tc2V0dGluZ3MuYzpv
Zm9ub19hdWRpb19zZXR0aW5nc19kcml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk4YTEw
LCBuYW1lOiBpc2ltb2RlbTxicj4KCm9mb25vZFs5OTE3XTogc3JjL3NpbS5jOm9mb25vX3NpbV9k
cml2ZXJfdW5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk4YTIwLCBuYW1lOiB3Z21vZGVtMi41PGJy
Pm9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzpkZXN0cm95X21vZGVtKCkgL3N5cy9kZXZp
Y2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZC4wL3VzYjIvMi0xLzItMS4yPGJyPm9mb25vZFs5OTE3
XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fcmVtb3ZlKCkgMHg5OGIxNzg4PGJyPgoKb2Zvbm9k
Wzk5MTddOiBwbHVnaW5zL3VkZXZuZy5jOmRlc3Ryb3lfbW9kZW0oKSAvZGV2L3R0eVVTQjA8YnI+
b2Zvbm9kWzk5MTddOiBwbHVnaW5zL3VkZXZuZy5jOmRlc3Ryb3lfbW9kZW0oKSAvZGV2L3R0eVVT
QjE8YnI+b2Zvbm9kWzk5MTddOiBwbHVnaW5zL3VkZXZuZy5jOmRlc3Ryb3lfbW9kZW0oKSAvZGV2
L3R0eVVTQjI8YnI+b2Zvbm9kWzk5MTddOiBzcmMvcHJpdmF0ZS1uZXR3b3JrLmM6b2Zvbm9fcHJp
dmF0ZV9uZXR3b3JrX2RyaXZlcl91bnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOWFiYTAsIG5hbWU6
IEV4YW1wbGUgUHJpdmF0ZSBOZXR3b3JrIERyaXZlcjxicj4KCm9mb25vZFs5OTE3XTogRXhpdDxi
cj48L2Rpdj48L2Rpdj48L2Rpdj4K

--===============8351858024165727561==--

