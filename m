Content-Type: multipart/mixed; boundary="===============2479271357265424958=="
MIME-Version: 1.0
From: Homam Dabis <hdabis@digisoft.tv>
Subject: Problem reconnecting when 3G dongle is re-inserted
Date: Mon, 10 Mar 2014 18:17:04 +0000
Message-ID: <CAK+sfotBtysK1yCTt64m3guFwfzWb_=4szj0U2b5Wswgt1m1Cg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2479271357265424958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I have the following: Huawei E303 3G USB dongle, connman 1.20 and ofono
1.14.

I can connect to a particular APN using connman and ofono.

However, if I remove and re insert the dongle I am unable to reconnect to
the service. If I restart either connman or ofono then reconnection to
service is ok.

Connman has the following config:

[General]
BackgroundScanning=3Dfalse
DefaultAutoConnectTechnologies=3Dcellular
PreferredTechnologies=3Dcellular,wifi
SingleConnectedTechnology=3Dfalse
TetheringTechnologies=3Dwifi
PersistentTetheringMode=3Dtrue


In ofono the log for connect/remove and reconnect is:

root(a)i100:~# OFONO_AT_DEBUG=3D1 ofonod -n -d  > /ofono.log
ofonod[30943]: oFono version 1.14
ofonod[30943]: /ofono-1.14/src/plugin.c:__ofono_plugin_init()
ofonod[30943]:
/ofono-1.14/plugins/push-notification.c:push_notification_init()
ofonod[30943]: /ofono-1.14/plugins/smart-messaging.c:smart_messaging_init()
ofonod[30943]:
/ofono-1.14/src/cdma-provision.c:ofono_cdma_provision_driver_register()
driver: 0x556c1bb0 name: CDMA provisioning
ofonod[30943]:
/ofono-1.14/src/gprs-provision.c:ofono_gprs_provision_driver_register()
driver: 0x556c1b80 name: Provisioning
ofonod[30943]: /ofono-1.14/plugins/dun_gw_bluez5.c:dun_gw_init()
ofonod[30943]:
/ofono-1.14/src/handsfree-audio.c:ofono_handsfree_card_driver_register()
driver: 0x556c1a50
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1a60, name: hfp
ofonod[30943]: /ofono-1.14/plugins/he910.c:he910_init()
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c19e0, name: he910
ofonod[30943]: /ofono-1.14/plugins/connman.c:connman_init()
ofonod[30943]:
/ofono-1.14/src/private-network.c:ofono_private_network_driver_register()
driver: 0x556c19b0, name: ConnMan Private Network
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1960, name: sim900
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1910, name: samsung
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c18c0, name: speedupcdma
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1870, name: speedup
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1820, name: alcatel
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c17c0, name: icera
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1770, name: linktop
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1720, name: nokiacdma
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c16d0, name: nokia
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1680, name: tc65
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c15f0, name: ste
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1590, name: ifx
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1540, name: palmpre
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c14f0, name: novatel
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c14a0, name: sierra
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1420, name: huawei
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c13d0, name: zte
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1370, name: hso
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1320, name: mbm
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c12d0, name: calypso
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1280, name: wavecom
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1230, name: g1
ofonod[30943]:
/ofono-1.14/src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register()
driver: 0x556c11a0, name: cdmamodem
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
driver: 0x556c11c0, name: cdmamodem
ofonod[30943]:
/ofono-1.14/src/cdma-connman.c:ofono_cdma_connman_driver_register() driver:
0x556c11f0, name: cdmamodem
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c111c, name: phonesim
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1154, name: localhfp
ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c1104, name: phonesim
ofonod[30943]: /ofono-1.14/src/ctm.c:ofono_ctm_driver_register() driver:
0x556c10f0, name: phonesim
ofonod[30943]: /ofono-1.14/plugins/phonesim.c:parse_config() filename
/etc/ofono/phonesim.conf
ofonod[30943]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
0x556c10b0, name: speedupmodem
ofonod[30943]:
/ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
0x556c0f50, name: hfpmodem
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
driver: 0x556c1010, name: hfpmodem
ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
driver: 0x556c0fa0, name: hfpmodem
ofonod[30943]:
/ofono-1.14/src/call-volume.c:ofono_call_volume_driver_register() driver:
0x556c0fe0, name: hfpmodem
ofonod[30943]:
/ofono-1.14/src/handsfree.c:ofono_handsfree_driver_register() driver:
0x556c1030, name: hfpmodem
ofonod[30943]: /ofono-1.14/src/siri.c:ofono_siri_driver_register() driver:
0x556c1060, name: hfpmodem
ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
driver: 0x556c0ec0, name: dunmodem
ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
0x556c0ef0, name: dunmodem
ofonod[30943]:
/ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
0x556c0df0, name: stemodem
ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0e70, name: stemodem
ofonod[30943]:
/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x556c0e40, name: stemodem
ofonod[30943]:
/ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
0x556c0cb0, name: ifxmodem
ofonod[30943]:
/ofono-1.14/src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x556c0d00, name: ifxmodem
ofonod[30943]:
/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x556c0d20, name: ifxmodem
ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0d50, name: ifxmodem
ofonod[30943]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
0x556c0d80, name: ifxmodem
ofonod[30943]: /ofono-1.14/src/ctm.c:ofono_ctm_driver_register() driver:
0x556c0db0, name: ifxmodem
ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0c40, name: hsomodem
ofonod[30943]:
/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x556c0c60, name: hsomodem
ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0bb0, name: mbmmodem
ofonod[30943]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
0x556c0be0, name: mbmmodem
ofonod[30943]:
/ofono-1.14/src/location-reporting.c:ofono_location_reporting_driver_regist=
er()
driver: 0x556c0c00, name: mbmmodem
ofonod[30943]:
/ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
0x556c0b20, name: calypsomodem
ofonod[30943]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
0x556c0b70, name: calypsomodem
ofonod[30943]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
0x556c0a00, name: huaweimodem
ofonod[30943]:
/ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
0x556c0a20, name: huaweimodem
ofonod[30943]:
/ofono-1.14/src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x556c0a70, name: huaweimodem
ofonod[30943]:
/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x556c0ab0, name: huaweimodem
ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0a90, name: huaweimodem
ofonod[30943]:
/ofono-1.14/src/cdma-netreg.c:ofono_cdma_netreg_driver_register() driver:
0x556c0ae0, name: huaweimodem
ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0970, name: iceramodem
ofonod[30943]:
/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x556c09a0, name: iceramodem
ofonod[30943]:
/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x556c0920, name: ztemodem
ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c08e0, name: swmodem
ofonod[30943]:
/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x556c0890, name: nwmodem
ofonod[30943]:
/ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
0x556c06b0, name: atmodem
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
driver: 0x556c0760, name: atmodem
ofonod[30943]:
/ofono-1.14/src/call-barring.c:ofono_call_barring_driver_register() driver:
0x556c0710, name: atmodem
ofonod[30943]:
/ofono-1.14/src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x556c0480, name: atmodem
ofonod[30943]:
/ofono-1.14/src/call-meter.c:ofono_call_meter_driver_register() driver:
0x556c04b0, name: atmodem
ofonod[30943]:
/ofono-1.14/src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x556c0390, name: atmodem
ofonod[30943]:
/ofono-1.14/src/phonebook.c:ofono_phonebook_driver_register() driver:
0x556c0730, name: atmodem
ofonod[30943]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
0x556c0680, name: atmodem
ofonod[30943]: /ofono-1.14/src/sms.c:ofono_sms_driver_register() driver:
0x556c0400, name: atmodem
ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
0x556c0560, name: atmodem
ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
0x556c05a8, name: atmodem-noef
ofonod[30943]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
0x556c0660, name: atmodem
ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
driver: 0x556c0500, name: atmodem
ofonod[30943]: /ofono-1.14/src/cbs.c:ofono_cbs_driver_register() driver:
0x556c0460, name: atmodem
ofonod[30943]:
/ofono-1.14/src/call-volume.c:ofono_call_volume_driver_register() driver:
0x556c0790, name: atmodem
ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
0x556c07d0, name: atmodem
ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0800, name: atmodem
ofonod[30943]: /ofono-1.14/src/sim-auth.c:ofono_sim_auth_driver_register()
driver: 0x556c0820, name: atmodem
ofonod[30943]: /ofono-1.14/src/gnss.c:ofono_gnss_driver_register() driver:
0x556c0840, name: atmodem
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c01b0, name: gobi
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
driver: 0x556bff80, name: qmimodem
ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
driver: 0x556bfff0, name: qmimodem
ofonod[30943]:
/ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
0x556bffa0, name: qmimodem
ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
0x556c0020, name: qmimodem-legacy
ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
0x556c0070, name: qmimodem
ofonod[30943]: /ofono-1.14/src/sms.c:ofono_sms_driver_register() driver:
0x556c00c0, name: qmimodem
ofonod[30943]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
0x556c00e0, name: qmimodem
ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
0x556c0100, name: qmimodem
ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0120, name: qmimodem
ofonod[30943]:
/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x556c0140, name: qmimodem
ofonod[30943]:
/ofono-1.14/src/location-reporting.c:ofono_location_reporting_driver_regist=
er()
driver: 0x556c0170, name: qmimodem
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556bff2c, name: u8500
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
driver: 0x556bff10, name: u8500
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556bfec0, name: n900
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556bfe70, name: isiusb
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
driver: 0x556bfb90, name: isimodem
ofonod[30943]:
/ofono-1.14/src/phonebook.c:ofono_phonebook_driver_register() driver:
0x556bfb80, name: isimodem
ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
driver: 0x556bfbb0, name: isimodem
ofonod[30943]:
/ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
0x556bfbe0, name: isimodem
ofonod[30943]: /ofono-1.14/src/sms.c:ofono_sms_driver_register() driver:
0x556bfc30, name: isimodem
ofonod[30943]: /ofono-1.14/src/cbs.c:ofono_cbs_driver_register() driver:
0x556bfc50, name: isimodem
ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
0x556bfc70, name: isimodem
ofonod[30943]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
0x556bfcc0, name: isimodem
ofonod[30943]:
/ofono-1.14/src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x556bfce0, name: isimodem
ofonod[30943]:
/ofono-1.14/src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x556bfd00, name: isimodem
ofonod[30943]:
/ofono-1.14/src/call-barring.c:ofono_call_barring_driver_register() driver:
0x556bfd30, name: isimodem
ofonod[30943]:
/ofono-1.14/src/call-meter.c:ofono_call_meter_driver_register() driver:
0x556bfd50, name: isimodem
ofonod[30943]:
/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x556bfd80, name: isimodem
ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
0x556bfdb0, name: isimodem
ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556bfdd0, name: isimodem
ofonod[30943]:
/ofono-1.14/src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x556bfdf0, name: isimodem
ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
0x556bfe00, name: wgmodem2.5
ofonod[30943]: /ofono-1.14/plugins/udevng.c:udev_start()
ofonod[30943]: /ofono-1.14/plugins/udevng.c:enumerate_devices()
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() hub
[(null):(null)]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
[0bda:8176]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() rtl8192cu
[(null):(null)]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() rtl8192cu
[0bda:8176]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() rtl8192cu
[0bda:8176]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() hub
[(null):(null)]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
[12d1:1001]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
[(null):(null)]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
[12d1:1001]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0/ttyUSB0/tty/ttyUSB0
ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB0
(huawei) 255/255/255 [00] =3D=3D> (null) (null)
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
[(null):(null)]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
[12d1:1001]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.1/ttyUSB1/tty/ttyUSB1
ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB1
(huawei) 255/255/255 [01] =3D=3D> (null) (null)
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
[(null):(null)]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
[12d1:1001]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.2/ttyUSB2/tty/ttyUSB2
ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB2
(huawei) 255/255/255 [02] =3D=3D> (null) (null)
ofonod[30943]: /ofono-1.14/plugins/udevng.c:create_modem()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[30943]: /ofono-1.14/plugins/udevng.c:create_modem() driver=3Dhuawei
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_create() name: (null),
type: huawei
ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB0
255/255/255 00 (null)
ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB1
255/255/255 01 (null)
ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB2
255/255/255 02 (null)
ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() mdm=3D/dev/ttyUS=
B0
pcui=3D/dev/ttyUSB2 diag=3D(null) qmi=3D(null) net=3D(null)
ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
0x556eb380 property Device
ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
0x556eb380 property Modem
ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
0x556eb380 property Pcui
ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
0x556eb380 property Diag
ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
0x556eb380 property NetworkInterface
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_register() 0x556eb380
ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_probe() 0x556eb380
ofonod[30943]: /ofono-1.14/src/modem.c:emit_modem_added() 0x556eb380
ofonod[30943]: /ofono-1.14/src/modem.c:call_modemwatches() 0x556eb380
added:1
ofonod[30943]: /ofono-1.14/plugins/hfp_ag_bluez5.c:modem_watch() modem:
0x556eb380, added: 1
ofonod[30943]: /ofono-1.14/plugins/dun_gw_bluez5.c:modem_watch() modem:
0x556eb380, added: 1
ofonod[30943]: /ofono-1.14/plugins/smart-messaging.c:modem_watch() modem:
0x556eb380, added: 1
ofonod[30943]: /ofono-1.14/plugins/push-notification.c:modem_watch() modem:
0x556eb380, added: 1
ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_enable() 0x556eb380
ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
0x556eb380 property Modem
ofonod[30943]: /ofono-1.14/plugins/huawei.c:open_device() Modem /dev/ttyUSB0
ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
0x556eb380 property Pcui
ofonod[30943]: /ofono-1.14/plugins/huawei.c:open_device() Pcui /dev/ttyUSB2
ofonod[30943]: Modem: > ATE0 +CMEE=3D1\r
ofonod[30943]: PCUI: > ATE0 +CMEE=3D1\r
ofonod[30943]: Modem: < \r\nOK\r\n
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > ATI\r
ofonod[30943]: PCUI: < \r\nManufacturer: huawei\r\nModel: E303\r\nRevision:
22.318.05.00.00\r\nIMEI: 862566020005697\r\n+GCAP:
+CGSM,+DS,+ES\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT^RFSWITCH=3D?\r
ofonod[30943]: PCUI: < \r\nERROR\r\n
ofonod[30943]: PCUI: > AT+CFUN=3D1\r
ofonod[30943]: PCUI: < \r\n^SIMST:0,0\r\n
ofonod[30943]: PCUI: < \r\nOK\r\n\r\n^SIMST:1,0\r\n
ofonod[30943]: /ofono-1.14/plugins/huawei.c:cfun_enable()
ofonod[30943]: /ofono-1.14/plugins/huawei.c:simst_notify() 255 -> 1
ofonod[30943]: PCUI: > AT^SYSINFO\r
ofonod[30943]: PCUI: < \r\n+CREG: 2\r\n\r\n+CGREG:
2\r\n\r\n^SYSINFO:0,3,0,0,1,0,0\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/plugins/huawei.c:sysinfo_enable_cb() 1 -> 1
ofonod[30943]: Modem: > AT&C0\r
ofonod[30943]: PCUI: > AT&C0\r
ofonod[30943]: Modem: < \r\nOK\r\n
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: Modem: > AT+CSCS=3D"GSM"\r
ofonod[30943]: PCUI: > AT+CSCS=3D"GSM"\r
ofonod[30943]: Modem: < \r\nOK\r\n
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT^U2DIAG?\r
ofonod[30943]: PCUI: < \r\n^U2DIAG: 119\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT^GETPORTMODE\r
ofonod[30943]: PCUI: < \r\n^GETPORTMODE: TYPE: WCDMA: huawei,\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT^USSDMODE=3D?\r
ofonod[30943]: PCUI: < \r\n^USSDMODE: (0-1)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT^DIALMODE=3D?\r
ofonod[30943]: PCUI: < \r\n^DIALMODE: (0-2),(0-255)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT^CVOICE=3D?\r
ofonod[30943]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CFUN=3D5\r
ofonod[30943]: PCUI: < \r\n+CREG: 0\r\n\r\n+CGREG: 0\r\n
ofonod[30943]: PCUI: < \r\nOK\r\n\r\n^MODE: 0,0\r\n
ofonod[30943]: /ofono-1.14/plugins/huawei.c:cfun_offline()
ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: 0,
new state: 1
ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_pre_sim() 0x556eb380
ofonod[30943]: PCUI: > AT^USSDMODE?\r
ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556dc660
ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556dc660
ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556dc660
ofonod[30943]: PCUI: < \r\n^USSDMODE: 1\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT^DIALMODE?\r
ofonod[30943]: PCUI: < \r\n^DIALMODE:3,2\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT^CVOICE?\r
ofonod[30943]: PCUI: < \r\n^CVOICE: 1, 8000, 16, 20\r\n\r\nOK\r\n
ofonod[30943]: Voice channel: 8000 Hz, 16 bits, 20ms period
ofonod[30943]: PCUI: > AT+GCAP\r
ofonod[30943]: PCUI: < \r\n+GCAP: +CGSM,+DS,+ES\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D192,12258,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183022FE2A5038001718A01058B032F06038002000A880110"\r\n\r\=
nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[30943]: PCUI: > AT^DDSETEX=3D?\r
ofonod[30943]: PCUI: < \r\n^DDSETEX: (2)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CGMI\r
ofonod[30943]: PCUI: < \r\nhuawei\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D176,12258,0,0,10\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"985303050107085305F6"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 10
ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[30943]: PCUI: > AT+CGMM\r
ofonod[30943]: PCUI: < \r\nE303\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D192,28421,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026F05A5038001718A01058B036F06048002000A880110"\r\n\r\=
nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[30943]: PCUI: > AT+CGMR\r
ofonod[30943]: PCUI: < \r\n22.318.05.00.00\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D176,28421,0,0,10\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 10
ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[30943]: PCUI: > AT+CGSN\r
ofonod[30943]: PCUI: < \r\n862566020005697\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D192,12037,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183022F05A5038001718A01058B032F06048002000A880128"\r\n\r\=
nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[30943]: PCUI: > AT+CRSM=3D176,12037,0,0,10\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 10
ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[30943]: PCUI: > AT+CPIN?\r
ofonod[30943]: PCUI: < \r\n+CPIN: READY\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb:
READY
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[30943]: PCUI: > AT^CPIN?\r
ofonod[30943]: PCUI: < \r\n^CPIN: READY,,10,3,10,3\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
counter id=3D9, val=3D10
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
counter id=3D1, val=3D3
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
counter id=3D11, val=3D10
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
counter id=3D4, val=3D3
ofonod[30943]: PCUI: > AT+CRSM=3D192,28590,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D192,28589,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026FADA5038001718A01058B036F060680020004880118"\r\n\r\=
nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[30943]: PCUI: > AT+CRSM=3D176,28589,0,0,4\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"00000002"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 4
ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 4
ofonod[30943]: PCUI: > AT+CRSM=3D192,28438,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D192,28472,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026F38A5038001718A01058B036F06028002000A880120"\r\n\r\=
nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[30943]: PCUI: > AT+CRSM=3D176,28472,0,0,10\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"7EEE111C27F659000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 10
ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[30943]: PCUI: > AT+CRSM=3D192,28502,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026F56A5038001718A01058B036F060780020001880128"\r\n\r\=
nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[30943]: PCUI: > AT+CRSM=3D176,28502,0,0,1\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"00"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 1
ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 1
ofonod[30943]: PCUI: > AT+CIMI\r
ofonod[30943]: PCUI: < \r\n272050100413580\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_cimi_cb() cimi_cb:
272050100413580
ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: 1,
new state: 2
ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_post_sim() 0x556eb380
ofonod[30943]:
/ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_context_probe()
ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
0x556eb380 property AlwaysOnline
ofonod[30943]: PCUI: > AT+CRC=3D1\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
0x556eb380 property AlwaysOnline
ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_set_online() modem
0x556eb380 online
ofonod[30943]: PCUI: > AT+CLIP=3D1\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+COLP=3D1\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+CCWA=3D1\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]:
/ofono-1.14/drivers/huaweimodem/voicecall.c:huawei_voicecall_initialized()
registering to notifications
ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556dc660
ofonod[30943]: /ofono-1.14/plugins/bluez5.c:bt_register_profile()
Bluetooth: Registering 0000111f-0000-1000-8000-00805f9b34fb (hfp_ag) profile
ofonod[30943]: PCUI: > AT^CVOICE=3D?\r
ofonod[30943]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CSCS=3D?\r
ofonod[30943]: PCUI: < \r\n+CSCS: ("IRA","UCS2","GSM")\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT^SYSCFG=3D?\r
ofonod[30943]: PCUI: < \r\n^SYSCFG:
(2,13,14,16),(0-3),((2000000400380,"GSM900/GSM1800/WCDMA900/WCDMA2100"),(28=
0000,"GSM850/GSM1900"),(3fffffff,"All
bands")),(0-2),(0-4)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CSMS=3D?\r
ofonod[30943]: PCUI: < \r\n+CSMS: (0,1)\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sms.c:at_csms_query_cb() CSMS
query parsed successfully
ofonod[30943]: PCUI: > AT+CGDCONT=3D?\r
ofonod[30943]: PCUI: < \r\n+CGDCONT:
(1-11),"IP",,,(0-2),(0-3),(0,1),(0,1)\r\n+CGDCONT:
(1-11),"PPP",,,(0-2),(0-3),(0,1),(0,1)\r\n\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CFUN=3D1\r
ofonod[30943]: PCUI: < \r\n^SIMST:0,0\r\n
ofonod[30943]: /ofono-1.14/plugins/huawei.c:simst_notify() 1 -> 0
ofonod[30943]: RegisterProfile() replied an error:
org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
unknown return code 1
ofonod[30943]: PCUI: < \r\nOK\r\n\r\n^SIMST:1,0\r\n
ofonod[30943]: /ofono-1.14/plugins/huawei.c:simst_notify() 0 -> 1
ofonod[30943]: PCUI: > AT+CRSM=3D192,28480,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CREG: 2\r\n\r\n+CGREG: 2\r\n
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100220683026F40A5038001718A01058B036F0605800200CC8800"\r\=
n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[30943]: PCUI: > AT+CPBS=3D?\r
ofonod[30943]: PCUI: < \r\n+CPBS: ("SM","EN","ON","FD")\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CSMS=3D1\r
ofonod[30943]: PCUI: < \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CGREG=3D?\r
ofonod[30943]: PCUI: < \r\n+CGREG: (0-2)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT^SYSINFO\r
ofonod[30943]: PCUI: < \r\n^SYSINFO:0,3,0,0,1,0,0\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/plugins/huawei.c:sysinfo_online_cb() 1 -> 1
ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: 2,
new state: 3
ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_post_online() 0x556eb380
ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,1,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"4D79204E756D626572FFFFFFFFFFFFFFFFFFFFFF0791538313977848FFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT+CSMS?\r
ofonod[30943]: PCUI: < \r\n+CSMS: 1,1,1,1\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CGREG=3D2\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+CGAUTO=3D0\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+CGEREP=3D2,1\r
ofonod[30943]: PCUI: < \r\nERROR\r\n
ofonod[30943]: /ofono-1.14/plugins/bluez5.c:bt_register_profile()
Bluetooth: Registering 00001103-0000-1000-8000-00805f9b34fb (dun_gw) profile
ofonod[30943]: PCUI: > AT+CREG=3D?\r
ofonod[30943]: PCUI: < \r\n+CREG: (0-2)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CSCB=3D?\r
ofonod[30943]: PCUI: < \r\n+CSCB:(0,1)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CUSD=3D1\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,2,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT+CMGF=3D?\r
ofonod[30943]: RegisterProfile() replied an error:
org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
unknown return code 1
ofonod[30943]: PCUI: < \r\n+CMGF: (0,1)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CREG=3D2\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_spn_watch() 0x556dc660
ofonod[30943]: /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
0x556dcf18
ofonod[30943]: PCUI: > AT+CSCB=3D0\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_got_imsi() Got IMSI:
272050100413580
ofonod[30943]: /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
0x556dcf18
ofonod[30943]: PCUI: > AT+CPMS=3D?\r
ofonod[30943]: PCUI: < \r\n+CPMS:
("SM","ME"),("SM","ME"),("SM","ME")\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,3,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT+CREG?\r
ofonod[30943]: PCUI: < \r\n+CREG: 2,2\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_status_notify()
/huawei_0 status 2 tech -1
ofonod[30943]: /ofono-1.14/src/network.c:current_operator_callback()
0x556dcf18, (nil)
ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 2, -1, -1, -1,
(null)(null)
ofonod[30943]: /ofono-1.14/src/gprs.c:netreg_status_changed() 2
ofonod[30943]: PCUI: > AT+CMGF=3D0\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,4,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT+CPMS=3D"ME","ME","ME"\r
ofonod[30943]: PCUI: < \r\n^MODE: 5,4\r\n
ofonod[30943]: PCUI: < \r\n+CPMS: 0,20,0,20,0,20\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,5,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT+CNMI=3D?\r
ofonod[30943]: PCUI: < \r\n+CNMI:
(0-2),(0-3),(0,2),(0-2),(0,1)\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sms.c:build_cnmi_string()
ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,6,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT+CNMI=3D1,1,2,1,0\r
ofonod[30943]: Duplicate EFsdn entries for `Emergency Services'
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
0x556dcf18
ofonod[30943]: /ofono-1.14/src/sms.c:sms_restore_tx_queue()
ofonod[30943]: /ofono-1.14/plugins/push-notification.c:sms_watch()
registered
ofonod[30943]: /ofono-1.14/plugins/smart-messaging.c:sms_watch() registered
ofonod[30943]: PCUI: > AT+CRSM=3D192,28618,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100060583026FCAA5038001718A01058B036F06058002001E8800"\r\=
n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[30943]: PCUI: > AT+CMGL=3D4\r
ofonod[30943]: PCUI: < \r\n^RSSI: 13\r\n\r\n^HCSQ:"WCDMA",42,34,49\r\n
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sms.c:at_cmgl_done()
ofonod[30943]: PCUI: > AT+CGSMS=3D3\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,1,4,6\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,2,4,6\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,3,4,6\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,4,4,6\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,5,4,6\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[30943]: PCUI: > AT+CRSM=3D192,28617,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100050583026FC9A5038001718A01058B036F0602800200198800"\r\=
n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,1,4,5\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,2,4,5\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,3,4,5\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,4,4,5\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,5,4,5\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[30943]: PCUI: > AT+CRSM=3D192,28433,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/src/message-waiting.c:mw_cphs_mwis_read_cb() No
CPHS MWIS on SIM
ofonod[30943]: PCUI: > AT+CRSM=3D192,28619,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100100583026FCBA5038001718A01058B036F0605800200508800"\r\=
n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,1,4,16\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,2,4,16\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,3,4,16\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,4,4,16\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,5,4,16\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block() bufoff: 0,
seekoff: 39, toread: 17
ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block() bufoff: 0,
seekoff: 39, toread: 10
ofonod[30943]: /ofono-1.14/drivers/atmodem/cbs.c:at_cbs_set_topics()
ofonod[30943]: PCUI: > AT+CSCB=3D0\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+CSCB=3D0,"0,50,214,4352-4356"\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D192,28437,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D192,28615,0,0,255\r
ofonod[30943]: PCUI: < \r\n^SRVST: 2\r\n\r\n+CGREG: 1,"0040","02C1155A"\r\n
ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_status_notify() /huawei_0
status 1
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100220583026FC7A5038001718A01058B036F0602800200AA8800"\r\=
n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,1,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"4D61696CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0791538333331317FFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,2,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,3,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,4,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]:
/ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid 1
ofonod[30943]: Modem: > AT+CGDCONT=3D1,"IP","3Ireland"\r
ofonod[30943]: Modem: < \r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/gprs-context.c:at_cgdcont_cb()
ok 1
ofonod[30943]: Modem: > ATD*99***1#\r
ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,5,4,34\r
ofonod[30943]: Modem: < \r\nCONNECT\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/gprs-context.c:at_cgdata_cb() ok
1
ofonod[30943]: /ofono-1.14/drivers/atmodem/gprs-context.c:setup_ppp()
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: < \r\n+CREG: 1,"0040","02C1155A"\r\n
ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_status_notify()
/huawei_0 status 1 tech 2
ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, -1, -1, 2,
(null)(null)
ofonod[30943]: /ofono-1.14/src/gprs.c:netreg_status_changed() 1
ofonod[30943]: PCUI: > AT+COPS=3D3,2\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+COPS?\r
ofonod[30943]: PCUI: < \r\n+COPS: 0,2,"27205",2\r\n\r\nOK\r\n
ofonod[30943]:
/ofono-1.14/drivers/atmodem/network-registration.c:cops_numeric_cb() Cops
numeric got mcc: 272, mnc: 05
ofonod[30943]: PCUI: > AT+CSQ\r
ofonod[30943]: PCUI: < \r\n+CSQ: 13,99\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/network-registration.c:csq_cb()
csq_cb: 13
ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_strength_notify()
strength 41
ofonod[30943]: PCUI: > AT+COPS=3D3,0\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+COPS?\r
ofonod[30943]: PCUI: < \r\n+COPS: 0,0,"3 IRL",2\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/network-registration.c:cops_cb()
cops_cb: 3 IRL, 272 05 2
ofonod[30943]: /ofono-1.14/src/network.c:current_operator_callback()
0x556dcf18, (nil)
ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, -1, -1, 2,
27205
ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, 0, 0
ofonod[30943]: /ofono-1.14/src/gprs.c:netreg_status_changed() 1
ofonod[30943]: PCUI: < \r\n^RSSI: 10\r\n\r\n^HCSQ:"WCDMA",37,28,47\r\n
ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_strength_notify()
strength 32



Homam
























ofonod[30943]: PCUI: < \r\n^RSSI: 12\r\n\r\n^HCSQ:"WCDMA",42,33,47\r\n
ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_strength_notify()
strength 38
ofonod[30943]: PCUI: < \r\n^MODE: 5,7\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/gprs-context.c:ppp_connect()
ofonod[30943]: IP: 10.205.206.243
ofonod[30943]: DNS: 172.30.224.65, 172.30.224.65
ofonod[30943]: /ofono-1.14/src/gprs.c:pri_activate_callback() 0x556e65a8
ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem net add
ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem net
finished

ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_modem_list()



















ofonod[30943]: PCUI: <
\r\n^DSFLOWRPT:00000002,000001ED,0000029E,00000000000003A6,00000000000004D4=
,00000000,00000000\r\n




















ofonod[30943]: PCUI: <
\r\n^DSFLOWRPT:00000004,00000000,00000000,00000000000003A6,00000000000004D4=
,00000000,00000000\r\n
ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0/ttyUSB0/tty/ttyUSB0
ofonod[30943]: /ofono-1.14/plugins/udevng.c:destroy_modem()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_remove() 0x556eb380
ofonod[30943]: /ofono-1.14/src/modem.c:modem_unregister() 0x556eb380
ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: 3,
new state: 0
ofonod[30943]: /ofono-1.14/src/modem.c:flush_atoms()
ofonod[30943]: /ofono-1.14/src/message-waiting.c:mw_remove() atom:
0x556e5950
ofonod[30943]: /ofono-1.14/src/call-barring.c:call_barring_remove() atom:
0x556e56b8
ofonod[30943]: /ofono-1.14/src/call-settings.c:call_settings_remove() atom:
0x556e55d0
ofonod[30943]: /ofono-1.14/src/call-forwarding.c:call_forwarding_remove()
atom: 0x556e54f8
ofonod[30943]: /ofono-1.14/src/ussd.c:ussd_remove() atom: 0x556e5438
ofonod[30943]:
/ofono-1.14/src/network.c:__ofono_netreg_remove_status_watch() 0x556dcf18
ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_remove() atom: 0x556e52c8
ofonod[30943]:
/ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_detach_shutdown() cid 1
ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_remove_spn_watch() 0x556dc660
ofonod[30943]: /ofono-1.14/src/network.c:netreg_remove() atom: 0x556ddb88
ofonod[30943]: /ofono-1.14/src/gprs.c:gprs_context_unregister() 0x556e46a8,
0x556dd840
ofonod[30943]: /ofono-1.14/src/gprs.c:gprs_context_remove() atom: 0x556e46c8
ofonod[30943]:
/ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_context_remove()
ofonod[30943]: /ofono-1.14/plugins/bluez5.c:bt_unregister_profile()
Bluetooth: Unregistering profile /bluetooth/profile/dun_gw
ofonod[30943]: /ofono-1.14/src/gprs.c:gprs_unregister() 0x556dd840
ofonod[30943]: /ofono-1.14/src/gprs.c:gprs_remove() atom: 0x556dd8a8
ofonod[30943]:
/ofono-1.14/plugins/push-notification.c:push_notification_cleanup()
0x556df190
ofonod[30943]:
/ofono-1.14/plugins/smart-messaging.c:smart_messaging_cleanup() 0x556df160
ofonod[30943]: /ofono-1.14/src/sms.c:sms_remove() atom: 0x556dd780
ofonod[30943]: /ofono-1.14/src/radio-settings.c:radio_settings_remove()
atom: 0x556ddbf8
ofonod[30943]: /ofono-1.14/src/phonebook.c:phonebook_remove() atom:
0x556ddb08
ofonod[30943]: /ofono-1.14/src/audio-settings.c:audio_settings_remove()
atom: 0x556dda28
ofonod[30943]: /ofono-1.14/src/voicecall.c:voicecall_remove() atom:
0x556d68c8
ofonod[30943]: /ofono-1.14/plugins/bluez5.c:bt_unregister_profile()
Bluetooth: Unregistering profile /bluetooth/profile/hfp_ag
ofonod[30943]: /ofono-1.14/src/sim.c:sim_remove() atom: 0x556dc788
ofonod[30943]: /ofono-1.14/src/modem.c:devinfo_remove() atom: 0x556dd070
ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_disable() 0x556eb380
ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_remove() 0x556eb380
ofonod[30943]: /ofono-1.14/src/modem.c:unregister_property() property
0x556eb128
ofonod[30943]: /ofono-1.14/src/modem.c:unregister_property() property
0x556eb2b0
ofonod[30943]: /ofono-1.14/src/modem.c:unregister_property() property
0x556eb108
ofonod[30943]: /ofono-1.14/src/modem.c:unregister_property() property
0x556eb440
ofonod[30943]: /ofono-1.14/src/modem.c:unregister_property() property
0x556eb0d0
ofonod[30943]: /ofono-1.14/src/modem.c:emit_modem_removed() 0x556eb380
ofonod[30943]: /ofono-1.14/src/modem.c:call_modemwatches() 0x556eb380
added:0
ofonod[30943]: /ofono-1.14/plugins/hfp_ag_bluez5.c:modem_watch() modem:
0x556eb380, added: 0
ofonod[30943]: /ofono-1.14/plugins/dun_gw_bluez5.c:modem_watch() modem:
0x556eb380, added: 0
ofonod[30943]: /ofono-1.14/plugins/smart-messaging.c:modem_watch() modem:
0x556eb380, added: 0
ofonod[30943]: /ofono-1.14/plugins/push-notification.c:modem_watch() modem:
0x556eb380, added: 0
ofonod[30943]: /ofono-1.14/plugins/udevng.c:destroy_modem() /dev/ttyUSB0
ofonod[30943]: /ofono-1.14/plugins/udevng.c:destroy_modem() /dev/ttyUSB1
ofonod[30943]: /ofono-1.14/plugins/udevng.c:destroy_modem() /dev/ttyUSB2
ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty remove
ofonod[30943]: /ofono-1.14/plugins/udev.c:remove_modem()
/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0/ttyUSB0/tty/ttyUSB0
ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
finished
ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0
ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty remove
ofonod[30943]: /ofono-1.14/plugins/udev.c:remove_modem()
/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.1/ttyUSB1/tty/ttyUSB1
ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
finished
ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.1/ttyUSB1/tty/ttyUSB1
ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty remove
ofonod[30943]: /ofono-1.14/plugins/udev.c:remove_modem()
/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.2/ttyUSB2/tty/ttyUSB2
ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
finished
ofonod[30943]: UnregisterProfile() replied an error:
org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
unknown return code 1
ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.1
ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem net remove
ofonod[30943]: /ofono-1.14/plugins/udev.c:remove_modem()
/devices/virtual/net/ppp0
ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem net
finished
ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.2/ttyUSB2/tty/ttyUSB2
ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.2
ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
/sys/devices/virtual/net/ppp0
ofonod[30943]: UnregisterProfile() replied an error:
org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
unknown return code 1



















ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
[12d1:1f01]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
[(null):(null)]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0
ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_modem_list()
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
[12d1:1001]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
[(null):(null)]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
[(null):(null)]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
[(null):(null)]
ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty add
ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
finished
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
[12d1:1001]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.1/ttyUSB1/tty/ttyUSB1
ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB1
(huawei) 255/255/255 [01] =3D=3D> (null) (null)
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
[12d1:1001]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0/ttyUSB0/tty/ttyUSB0
ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB0
(huawei) 255/255/255 [00] =3D=3D> (null) (null)
ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty add
ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
finished
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
[12d1:1001]
ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.2/ttyUSB2/tty/ttyUSB2
ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB2
(huawei) 255/255/255 [02] =3D=3D> (null) (null)
ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty add
ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
finished
ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_modem_list()
ofonod[30943]: /ofono-1.14/plugins/udevng.c:create_modem()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[30943]: /ofono-1.14/plugins/udevng.c:create_modem() driver=3Dhuawei
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_create() name: (null),
type: huawei
ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB0
255/255/255 00 (null)
ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB1
255/255/255 01 (null)
ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB2
255/255/255 02 (null)
ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() mdm=3D/dev/ttyUS=
B0
pcui=3D/dev/ttyUSB2 diag=3D(null) qmi=3D(null) net=3D(null)
ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
0x556dd280 property Device
ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
0x556dd280 property Modem
ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
0x556dd280 property Pcui
ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
0x556dd280 property Diag
ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
0x556dd280 property NetworkInterface
ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_register() 0x556dd280
ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_probe() 0x556dd280
ofonod[30943]: /ofono-1.14/src/modem.c:emit_modem_added() 0x556dd280
ofonod[30943]: /ofono-1.14/src/modem.c:call_modemwatches() 0x556dd280
added:1
ofonod[30943]: /ofono-1.14/plugins/hfp_ag_bluez5.c:modem_watch() modem:
0x556dd280, added: 1
ofonod[30943]: /ofono-1.14/plugins/dun_gw_bluez5.c:modem_watch() modem:
0x556dd280, added: 1
ofonod[30943]: /ofono-1.14/plugins/smart-messaging.c:modem_watch() modem:
0x556dd280, added: 1
ofonod[30943]: /ofono-1.14/plugins/push-notification.c:modem_watch() modem:
0x556dd280, added: 1
ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_enable() 0x556dd280
ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
0x556dd280 property Modem
ofonod[30943]: /ofono-1.14/plugins/huawei.c:open_device() Modem /dev/ttyUSB0
ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
0x556dd280 property Pcui
ofonod[30943]: /ofono-1.14/plugins/huawei.c:open_device() Pcui /dev/ttyUSB2
ofonod[30943]: PCUI: > ATE0 +CMEE=3D1\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > ATI\r
ofonod[30943]: PCUI: < \r\nManufacturer: huawei\r\nModel: E303\r\nRevision:
22.318.05.00.00\r\nIMEI: 862566020005697\r\n+GCAP:
+CGSM,+DS,+ES\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT^RFSWITCH=3D?\r
ofonod[30943]: PCUI: < \r\nERROR\r\n
ofonod[30943]: PCUI: > AT+CFUN=3D1\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: /ofono-1.14/plugins/huawei.c:cfun_enable()
ofonod[30943]: PCUI: > AT^SYSINFO\r
ofonod[30943]: PCUI: < \r\n^SYSINFO:2,3,0,5,1,0,4\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/plugins/huawei.c:sysinfo_enable_cb() 255 -> 1
ofonod[30943]: PCUI: > AT&C0\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+CSCS=3D"GSM"\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT^U2DIAG?\r
ofonod[30943]: PCUI: < \r\n^U2DIAG: 119\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT^GETPORTMODE\r
ofonod[30943]: PCUI: < \r\n^GETPORTMODE: TYPE: WCDMA: huawei,\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT^USSDMODE=3D?\r
ofonod[30943]: PCUI: < \r\n^USSDMODE: (0-1)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT^DIALMODE=3D?\r
ofonod[30943]: PCUI: < \r\n^DIALMODE: (0-2),(0-255)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT^CVOICE=3D?\r
ofonod[30943]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CFUN=3D5\r
ofonod[30943]: PCUI: < \r\nOK\r\n\r\n^SRVST: 0\r\n\r\n^MODE: 0,0\r\n
ofonod[30943]: /ofono-1.14/plugins/huawei.c:cfun_offline()
ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: 0,
new state: 1
ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_pre_sim() 0x556dd280
ofonod[30943]: PCUI: > AT^USSDMODE?\r
ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556e7628
ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556e7628
ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556e7628
ofonod[30943]: PCUI: < \r\n^USSDMODE: 1\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT^DIALMODE?\r
ofonod[30943]: PCUI: < \r\n^DIALMODE:3,2\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT^CVOICE?\r
ofonod[30943]: PCUI: < \r\n^CVOICE: 1, 8000, 16, 20\r\n\r\nOK\r\n
ofonod[30943]: Voice channel: 8000 Hz, 16 bits, 20ms period
ofonod[30943]: PCUI: > AT+GCAP\r
ofonod[30943]: PCUI: < \r\n+GCAP: +CGSM,+DS,+ES\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D192,12258,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183022FE2A5038001718A01058B032F06038002000A880110"\r\n\r\=
nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[30943]: PCUI: > AT^DDSETEX=3D?\r
ofonod[30943]: PCUI: < \r\n^DDSETEX: (2)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CGMI\r
ofonod[30943]: PCUI: < \r\nhuawei\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D176,12258,0,0,10\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"985303050107085305F6"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 10
ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[30943]: PCUI: > AT+CGMM\r
ofonod[30943]: PCUI: < \r\nE303\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D192,28421,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026F05A5038001718A01058B036F06048002000A880110"\r\n\r\=
nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[30943]: PCUI: > AT+CGMR\r
ofonod[30943]: PCUI: < \r\n22.318.05.00.00\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D176,28421,0,0,10\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 10
ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[30943]: PCUI: > AT+CGSN\r
ofonod[30943]: PCUI: < \r\n862566020005697\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D192,12037,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183022F05A5038001718A01058B032F06048002000A880128"\r\n\r\=
nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[30943]: PCUI: > AT+CRSM=3D176,12037,0,0,10\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 10
ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[30943]: PCUI: > AT+CPIN?\r
ofonod[30943]: PCUI: < \r\n+CPIN: READY\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb:
READY
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[30943]: PCUI: > AT^CPIN?\r
ofonod[30943]: PCUI: < \r\n^CPIN: READY,,10,3,10,3\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
counter id=3D9, val=3D10
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
counter id=3D1, val=3D3
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
counter id=3D11, val=3D10
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
counter id=3D4, val=3D3
ofonod[30943]: PCUI: > AT+CRSM=3D192,28590,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D192,28589,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026FADA5038001718A01058B036F060680020004880118"\r\n\r\=
nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[30943]: PCUI: > AT+CRSM=3D176,28589,0,0,4\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"00000002"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 4
ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 4
ofonod[30943]: PCUI: > AT+CRSM=3D192,28438,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D192,28472,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026F38A5038001718A01058B036F06028002000A880120"\r\n\r\=
nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[30943]: PCUI: > AT+CRSM=3D176,28472,0,0,10\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"7EEE111C27F659000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 10
ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[30943]: PCUI: > AT+CRSM=3D192,28502,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026F56A5038001718A01058B036F060780020001880128"\r\n\r\=
nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[30943]: PCUI: > AT+CRSM=3D176,28502,0,0,1\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"00"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 1
ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 1
ofonod[30943]: PCUI: > AT+CIMI\r
ofonod[30943]: PCUI: < \r\n272050100413580\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_cimi_cb() cimi_cb:
272050100413580
ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: 1,
new state: 2
ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_post_sim() 0x556dd280
ofonod[30943]:
/ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_context_probe()
ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
0x556dd280 property AlwaysOnline
ofonod[30943]: PCUI: > AT+CRC=3D1\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+CLIP=3D1\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+COLP=3D1\r
ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
0x556dd280 property AlwaysOnline
ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_set_online() modem
0x556dd280 online
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+CCWA=3D1\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]:
/ofono-1.14/drivers/huaweimodem/voicecall.c:huawei_voicecall_initialized()
registering to notifications
ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556e7628
ofonod[30943]: /ofono-1.14/plugins/bluez5.c:bt_register_profile()
Bluetooth: Registering 0000111f-0000-1000-8000-00805f9b34fb (hfp_ag) profile
ofonod[30943]: PCUI: > AT^CVOICE=3D?\r
ofonod[30943]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CSCS=3D?\r
ofonod[30943]: PCUI: < \r\n+CSCS: ("IRA","UCS2","GSM")\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT^SYSCFG=3D?\r
ofonod[30943]: PCUI: < \r\n^SYSCFG:
(2,13,14,16),(0-3),((2000000400380,"GSM900/GSM1800/WCDMA900/WCDMA2100"),(28=
0000,"GSM850/GSM1900"),(3fffffff,"All
bands")),(0-2),(0-4)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CSMS=3D?\r
ofonod[30943]: PCUI: < \r\n+CSMS: (0,1)\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sms.c:at_csms_query_cb() CSMS
query parsed successfully
ofonod[30943]: PCUI: > AT+CGDCONT=3D?\r
ofonod[30943]: PCUI: < \r\n+CGDCONT:
(1-11),"IP",,,(0-2),(0-3),(0,1),(0,1)\r\n+CGDCONT:
(1-11),"PPP",,,(0-2),(0-3),(0,1),(0,1)\r\n\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D192,28480,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100220683026F40A5038001718A01058B036F0605800200CC8800"\r\=
n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[30943]: PCUI: > AT+CFUN=3D1\r
ofonod[30943]: RegisterProfile() replied an error:
org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
unknown return code 1
ofonod[30943]: PCUI: < \r\n^SIMST:0,0\r\n
ofonod[30943]: /ofono-1.14/plugins/huawei.c:simst_notify() 1 -> 0
ofonod[30943]: PCUI: < \r\nOK\r\n\r\n^SIMST:1,0\r\n
ofonod[30943]: /ofono-1.14/plugins/huawei.c:simst_notify() 0 -> 1
ofonod[30943]: PCUI: > AT+CPBS=3D?\r
ofonod[30943]: PCUI: < \r\n+CPBS: ("SM","EN","ON","FD")\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CSMS=3D1\r
ofonod[30943]: PCUI: < \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CGREG=3D?\r
ofonod[30943]: PCUI: < \r\n+CGREG: (0-2)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,1,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"4D79204E756D626572FFFFFFFFFFFFFFFFFFFFFF0791538313977848FFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT^SYSINFO\r
ofonod[30943]: PCUI: < \r\n^SYSINFO:0,3,0,0,1,0,0\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/plugins/huawei.c:sysinfo_online_cb() 1 -> 1
ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: 2,
new state: 3
ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_post_online() 0x556dd280
ofonod[30943]: PCUI: > AT+CSMS?\r
ofonod[30943]: PCUI: < \r\n+CSMS: 1,1,1,1\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CGREG=3D2\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+CGAUTO=3D0\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+CGEREP=3D2,1\r
ofonod[30943]: PCUI: < \r\nERROR\r\n
ofonod[30943]: /ofono-1.14/plugins/bluez5.c:bt_register_profile()
Bluetooth: Registering 00001103-0000-1000-8000-00805f9b34fb (dun_gw) profile
ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,2,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT+CREG=3D?\r
ofonod[30943]: PCUI: < \r\n+CREG: (0-2)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CSCB=3D?\r
ofonod[30943]: PCUI: < \r\n+CSCB:(0,1)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CUSD=3D1\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: RegisterProfile() replied an error:
org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
unknown return code 1
ofonod[30943]: PCUI: > AT+CMGF=3D?\r
ofonod[30943]: PCUI: < \r\n+CMGF: (0,1)\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,3,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT+CREG=3D2\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_spn_watch() 0x556e7628
ofonod[30943]: /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
0x556e70d8
ofonod[30943]: PCUI: > AT+CSCB=3D0\r
ofonod[30943]: PCUI: < \r\n^MODE: 5,4\r\n
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_got_imsi() Got IMSI:
272050100413580
ofonod[30943]: /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
0x556e70d8
ofonod[30943]: PCUI: > AT+CPMS=3D?\r
ofonod[30943]: PCUI: < \r\n+CPMS:
("SM","ME"),("SM","ME"),("SM","ME")\r\n\r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,4,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT+CREG?\r
ofonod[30943]: PCUI: < \r\n+CREG: 2,2\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_status_notify()
/huawei_1 status 2 tech -1
ofonod[30943]: /ofono-1.14/src/network.c:current_operator_callback()
0x556e70d8, (nil)
ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 2, -1, -1, -1,
(null)(null)
ofonod[30943]: /ofono-1.14/src/gprs.c:netreg_status_changed() 2
ofonod[30943]: PCUI: > AT+CMGF=3D0\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,5,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT+CPMS=3D"ME","ME","ME"\r
ofonod[30943]: PCUI: < \r\n+CPMS: 0,20,0,20,0,20\r\n\r\nOK\r\n\r\n^RSSI:
13\r\n\r\n^HCSQ:"WCDMA",40,34,53\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,6,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT+CNMI=3D?\r
ofonod[30943]: PCUI: < \r\n+CNMI:
(0-2),(0-3),(0,2),(0-2),(0,1)\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sms.c:build_cnmi_string()
ofonod[30943]: PCUI: > AT+CNMI=3D1,1,2,1,0\r
ofonod[30943]: Duplicate EFsdn entries for `Emergency Services'
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
0x556e70d8
ofonod[30943]: /ofono-1.14/src/sms.c:sms_restore_tx_queue()
ofonod[30943]: /ofono-1.14/plugins/push-notification.c:sms_watch()
registered
ofonod[30943]: /ofono-1.14/plugins/smart-messaging.c:sms_watch() registered
ofonod[30943]: PCUI: > AT+CRSM=3D192,28618,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100060583026FCAA5038001718A01058B036F06058002001E8800"\r\=
n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[30943]: PCUI: > AT+CMGL=3D4\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sms.c:at_cmgl_done()
ofonod[30943]: PCUI: > AT+CGSMS=3D3\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,1,4,6\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,2,4,6\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,3,4,6\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,4,4,6\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,5,4,6\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[30943]: PCUI: > AT+CRSM=3D192,28617,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100050583026FC9A5038001718A01058B036F0602800200198800"\r\=
n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,1,4,5\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,2,4,5\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,3,4,5\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,4,4,5\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,5,4,5\r
ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[30943]: PCUI: > AT+CRSM=3D192,28433,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/src/message-waiting.c:mw_cphs_mwis_read_cb() No
CPHS MWIS on SIM
ofonod[30943]: PCUI: > AT+CRSM=3D192,28619,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100100583026FCBA5038001718A01058B036F0605800200508800"\r\=
n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,1,4,16\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,2,4,16\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,3,4,16\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,4,4,16\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,5,4,16\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block() bufoff: 0,
seekoff: 39, toread: 17
ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block() bufoff: 0,
seekoff: 39, toread: 10
ofonod[30943]: /ofono-1.14/drivers/atmodem/cbs.c:at_cbs_set_topics()
ofonod[30943]: PCUI: > AT+CSCB=3D0\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+CSCB=3D0,"0,50,214,4352-4356"\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+CRSM=3D192,28437,0,0,255\r
ofonod[30943]: PCUI: < \r\n^SRVST: 2\r\n\r\n+CGREG:
1,"0040","02C10178"\r\n\r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_status_notify() /huawei_1
status 1
ofonod[30943]: PCUI: > AT+CRSM=3D192,28615,0,0,255\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100220583026FC7A5038001718A01058B036F0602800200AA8800"\r\=
n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,1,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"4D61696CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0791538333331317FFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,2,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,3,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,4,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,5,4,34\r
ofonod[30943]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[30943]: PCUI: < \r\n+CREG: 1,"0040","02C10178"\r\n
ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_status_notify()
/huawei_1 status 1 tech 2
ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, -1, -1, 2,
(null)(null)
ofonod[30943]: /ofono-1.14/src/gprs.c:netreg_status_changed() 1
ofonod[30943]: PCUI: > AT+COPS=3D3,2\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+COPS?\r
ofonod[30943]: PCUI: < \r\n+COPS: 0,2,"27205",2\r\n\r\nOK\r\n
ofonod[30943]:
/ofono-1.14/drivers/atmodem/network-registration.c:cops_numeric_cb() Cops
numeric got mcc: 272, mnc: 05
ofonod[30943]: PCUI: > AT+CSQ\r
ofonod[30943]: PCUI: < \r\n+CSQ: 13,99\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/network-registration.c:csq_cb()
csq_cb: 13
ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_strength_notify()
strength 41
ofonod[30943]: PCUI: > AT+COPS=3D3,0\r
ofonod[30943]: PCUI: < \r\nOK\r\n
ofonod[30943]: PCUI: > AT+COPS?\r
ofonod[30943]: PCUI: < \r\n+COPS: 0,0,"3 IRL",2\r\n\r\nOK\r\n
ofonod[30943]: /ofono-1.14/drivers/atmodem/network-registration.c:cops_cb()
cops_cb: 3 IRL, 272 05 2
ofonod[30943]: /ofono-1.14/src/network.c:current_operator_callback()
0x556e70d8, (nil)
ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, -1, -1, 2,
27205
ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, 0, 0
ofonod[30943]: /ofono-1.14/src/gprs.c:netreg_status_changed() 1
ofonod[30943]:
/ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid 1
ofonod[30943]: /ofono-1.14/src/gprs.c:pri_activate_callback() 0x556eb070
ofonod[30943]: /ofono-1.14/src/gprs.c:pri_activate_callback() Activating
context failed with error: Unknown error type

--===============2479271357265424958==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSw8L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PkkgaGF2ZSB0aGUgZm9sbG93aW5nOiBIdWF3ZWkgRTMwMyAzRyBVU0IgZG9uZ2xlLCBj
b25ubWFuIDEuMjAgYW5kIG9mb25vIDEuMTQuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGNh
biBjb25uZWN0IHRvIGEgcGFydGljdWxhciBBUE4gdXNpbmcgY29ubm1hbiBhbmQgb2Zvbm8uPC9k
aXY+CjxkaXY+PGJyPjwvZGl2PjxkaXY+SG93ZXZlciwgaWYgSSByZW1vdmUgYW5kIHJlIGluc2Vy
dCB0aGUgZG9uZ2xlIEkgYW0gdW5hYmxlIHRvIHJlY29ubmVjdCB0byB0aGUgc2VydmljZS4gSWYg
SSByZXN0YXJ0IGVpdGhlciBjb25ubWFuIG9yIG9mb25vIHRoZW4gcmVjb25uZWN0aW9uIHRvIHNl
cnZpY2UgaXMgb2suPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Db25ubWFuIGhhcyB0aGUgZm9s
bG93aW5nIGNvbmZpZzo8L2Rpdj4KPGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PltHZW5lcmFsXTwv
ZGl2PjxkaXY+QmFja2dyb3VuZFNjYW5uaW5nPWZhbHNlPC9kaXY+PGRpdj5EZWZhdWx0QXV0b0Nv
bm5lY3RUZWNobm9sb2dpZXM9Y2VsbHVsYXI8L2Rpdj48ZGl2PlByZWZlcnJlZFRlY2hub2xvZ2ll
cz1jZWxsdWxhcix3aWZpPC9kaXY+PGRpdj5TaW5nbGVDb25uZWN0ZWRUZWNobm9sb2d5PWZhbHNl
PC9kaXY+PGRpdj5UZXRoZXJpbmdUZWNobm9sb2dpZXM9d2lmaTwvZGl2Pgo8ZGl2PlBlcnNpc3Rl
bnRUZXRoZXJpbmdNb2RlPXRydWU8L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PkluIG9mb25vIHRoZSBsb2cgZm9yIGNvbm5lY3QvcmVtb3ZlIGFuZCByZWNvbm5l
Y3QgaXM6PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PnJvb3RAaTEwMDp+IyBPRk9OT19B
VF9ERUJVRz0xIG9mb25vZCAtbiAtZCCgJmd0OyAvb2Zvbm8ubG9nPC9kaXY+CjxkaXY+b2Zvbm9k
WzMwOTQzXTogb0Zvbm8gdmVyc2lvbiAxLjE0PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9zcmMvcGx1Z2luLmM6X19vZm9ub19wbHVnaW5faW5pdCgpoDwvZGl2PjxkaXY+b2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9wdXNoLW5vdGlmaWNhdGlvbi5jOnB1c2hf
bm90aWZpY2F0aW9uX2luaXQoKaA8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3BsdWdpbnMvc21hcnQtbWVzc2FnaW5nLmM6c21hcnRfbWVzc2FnaW5nX2luaXQoKaA8L2Rpdj4K
PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvY2RtYS1wcm92aXNpb24uYzpvZm9u
b19jZG1hX3Byb3Zpc2lvbl9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzFiYjAgbmFt
ZTogQ0RNQSBwcm92aXNpb25pbmc8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3NyYy9ncHJzLXByb3Zpc2lvbi5jOm9mb25vX2dwcnNfcHJvdmlzaW9uX2RyaXZlcl9yZWdpc3Rl
cigpIGRyaXZlcjogMHg1NTZjMWI4MCBuYW1lOiBQcm92aXNpb25pbmc8L2Rpdj4KPGRpdj5vZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2R1bl9nd19ibHVlejUuYzpkdW5fZ3dfaW5p
dCgpoDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2hhbmRzZnJlZS1h
dWRpby5jOm9mb25vX2hhbmRzZnJlZV9jYXJkX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1
NTZjMWE1MDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6
b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxYTYwLCBuYW1lOiBo
ZnA8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2hlOTEwLmM6
aGU5MTBfaW5pdCgpoDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21v
ZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxOWUwLCBu
YW1lOiBoZTkxMDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9j
b25ubWFuLmM6Y29ubm1hbl9pbml0KCmgPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvc3JjL3ByaXZhdGUtbmV0d29yay5jOm9mb25vX3ByaXZhdGVfbmV0d29ya19kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzE5YjAsIG5hbWU6IENvbm5NYW4gUHJpdmF0ZSBOZXR3
b3JrPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9u
b19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzE5NjAsIG5hbWU6IHNpbTkw
MDwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25v
X21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTkxMCwgbmFtZTogc2Ftc3Vu
ZzwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9f
bW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxOGMwLCBuYW1lOiBzcGVlZHVw
Y2RtYTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9m
b25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTg3MCwgbmFtZTogc3Bl
ZWR1cDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zv
bm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxODIwLCBuYW1lOiBhbGNh
dGVsPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zv
bm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxN2MwLCBuYW1lOiBpY2Vy
YTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9f
bW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxNzcwLCBuYW1lOiBsaW5rdG9w
PC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9f
bW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxNzIwLCBuYW1lOiBub2tpYWNk
bWE8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25v
X21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTZkMCwgbmFtZTogbm9raWE8
L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19t
b2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzE2ODAsIG5hbWU6IHRjNjU8L2Rp
dj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVt
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTVmMCwgbmFtZTogc3RlPC9kaXY+PGRp
dj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxNTkwLCBuYW1lOiBpZng8L2Rpdj48ZGl2Pm9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTU0MCwgbmFtZTogcGFsbXByZTwvZGl2PjxkaXY+Cm9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTRmMCwgbmFtZTogbm92YXRlbDwvZGl2PjxkaXY+b2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxNGEwLCBuYW1lOiBzaWVycmE8L2Rpdj48ZGl2PgpvZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzE0MjAsIG5hbWU6IGh1YXdlaTwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDU1NmMxM2QwLCBuYW1lOiB6dGU8L2Rpdj48ZGl2PgpvZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4NTU2YzEzNzAsIG5hbWU6IGhzbzwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDU1NmMxMzIwLCBuYW1lOiBtYm08L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg1NTZjMTJkMCwgbmFtZTogY2FseXBzbzwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg1NTZjMTI4MCwgbmFtZTogd2F2ZWNvbTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAw
eDU1NmMxMjMwLCBuYW1lOiBnMTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3NyYy9jZG1hLXZvaWNlY2FsbC5jOm9mb25vX2NkbWFfdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3Rl
cigpIGRyaXZlcjogMHg1NTZjMTFhMCwgbmFtZTogY2RtYW1vZGVtPC9kaXY+PGRpdj5vZm9ub2Rb
MzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19kZXZpbmZvX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg1NTZjMTFjMCwgbmFtZTogY2RtYW1vZGVtPC9kaXY+CjxkaXY+b2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2NkbWEtY29ubm1hbi5jOm9mb25vX2NkbWFfY29u
bm1hbl9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzExZjAsIG5hbWU6IGNkbWFtb2Rl
bTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9f
bW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxMTFjLCBuYW1lOiBwaG9uZXNp
bTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25v
X21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTE1NCwgbmFtZTogbG9jYWxo
ZnA8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9f
Z3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTEwNCwgbmFtZTog
cGhvbmVzaW08L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvY3RtLmM6
b2Zvbm9fY3RtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTBmMCwgbmFtZTogcGhv
bmVzaW08L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvcGhvbmVz
aW0uYzpwYXJzZV9jb25maWcoKSBmaWxlbmFtZSAvZXRjL29mb25vL3Bob25lc2ltLmNvbmY8L2Rp
dj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy91c3NkLmM6b2Zvbm9fdXNzZF9k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzEwYjAsIG5hbWU6IHNwZWVkdXBtb2RlbTwv
ZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy92b2ljZWNhbGwuYzpvZm9u
b192b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwZjUwLCBuYW1lOiBo
ZnBtb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6
b2Zvbm9fZGV2aW5mb19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzEwMTAsIG5hbWU6
IGhmcG1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL25ldHdv
cmsuYzpvZm9ub19uZXRyZWdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwZmEwLCBu
YW1lOiBoZnBtb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2Nh
bGwtdm9sdW1lLmM6b2Zvbm9fY2FsbF92b2x1bWVfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAw
eDU1NmMwZmUwLCBuYW1lOiBoZnBtb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3NyYy9oYW5kc2ZyZWUuYzpvZm9ub19oYW5kc2ZyZWVfZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDU1NmMxMDMwLCBuYW1lOiBoZnBtb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQz
XTogL29mb25vLTEuMTQvc3JjL3NpcmkuYzpvZm9ub19zaXJpX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg1NTZjMTA2MCwgbmFtZTogaGZwbW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4NTU2YzBlYzAsIG5hbWU6IGR1bm1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDU1NmMwZWYwLCBuYW1lOiBkdW5tb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3NyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwZGYwLCBuYW1lOiBzdGVtb2RlbTwvZGl2PjxkaXY+b2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwZTcwLCBuYW1lOiBzdGVtb2RlbTwvZGl2Pgo8
ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25v
X3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMGU0MCwgbmFt
ZTogc3RlbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy92b2lj
ZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMw
Y2IwLCBuYW1lOiBpZnhtb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3NyYy9hdWRpby1zZXR0aW5ncy5jOm9mb25vX2F1ZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3Rl
cigpIGRyaXZlcjogMHg1NTZjMGQwMCwgbmFtZTogaWZ4bW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3NyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3NldHRp
bmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMGQyMCwgbmFtZTogaWZ4bW9kZW08
L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dw
cnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzBkNTAsIG5hbWU6IGlm
eG1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc3RrLmM6b2Zv
bm9fc3RrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMGQ4MCwgbmFtZTogaWZ4bW9k
ZW08L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvY3RtLmM6b2Zvbm9f
Y3RtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMGRiMCwgbmFtZTogaWZ4bW9kZW08
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9fZ3By
c19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMGM0MCwgbmFtZTogaHNv
bW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvcmFkaW8tc2V0
dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
NTU2YzBjNjAsIG5hbWU6IGhzb21vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4NTU2YzBiYjAsIG5hbWU6IG1ibW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvc3JjL3N0ay5jOm9mb25vX3N0a19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
IDB4NTU2YzBiZTAsIG5hbWU6IG1ibW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9zcmMvbG9jYXRpb24tcmVwb3J0aW5nLmM6b2Zvbm9fbG9jYXRpb25fcmVwb3J0aW5n
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMGMwMCwgbmFtZTogbWJtbW9kZW08L2Rp
dj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvdm9pY2VjYWxsLmM6b2Zvbm9f
dm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMGIyMCwgbmFtZTogY2Fs
eXBzb21vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc3RrLmM6
b2Zvbm9fc3RrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMGI3MCwgbmFtZTogY2Fs
eXBzb21vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3Vzc2Qu
YzpvZm9ub191c3NkX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMGEwMCwgbmFtZTog
aHVhd2VpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy92b2lj
ZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMw
YTIwLCBuYW1lOiBodWF3ZWltb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L3NyYy9hdWRpby1zZXR0aW5ncy5jOm9mb25vX2F1ZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg1NTZjMGE3MCwgbmFtZTogaHVhd2VpbW9kZW08L2Rpdj48ZGl2Pm9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlv
X3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMGFiMCwgbmFtZTogaHVh
d2VpbW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5j
Om9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzBhOTAs
IG5hbWU6IGh1YXdlaW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9z
cmMvY2RtYS1uZXRyZWcuYzpvZm9ub19jZG1hX25ldHJlZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4NTU2YzBhZTAsIG5hbWU6IGh1YXdlaW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQz
XTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDU1NmMwOTcwLCBuYW1lOiBpY2VyYW1vZGVtPC9kaXY+PGRpdj5vZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19z
ZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzA5YTAsIG5hbWU6IGljZXJh
bW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvcmFkaW8tc2V0
dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
NTU2YzA5MjAsIG5hbWU6IHp0ZW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4NTU2YzA4ZTAsIG5hbWU6IHN3bW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9zcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzA4OTAsIG5hbWU6IG53bW9kZW08L2Rpdj48ZGl2
Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNh
bGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwNmIwLCBuYW1lOiBhdG1vZGVtPC9k
aXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fZGV2
aW5mb19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzA3NjAsIG5hbWU6IGF0bW9kZW08
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9jYWxsLWJhcnJpbmcuYzpv
Zm9ub19jYWxsX2JhcnJpbmdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwNzEwLCBu
YW1lOiBhdG1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2Nh
bGwtZm9yd2FyZGluZy5jOm9mb25vX2NhbGxfZm9yd2FyZGluZ19kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6IDB4NTU2YzA0ODAsIG5hbWU6IGF0bW9kZW08L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3NyYy9jYWxsLW1ldGVyLmM6b2Zvbm9fY2FsbF9tZXRlcl9kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzA0YjAsIG5hbWU6IGF0bW9kZW08L2Rpdj4KPGRpdj5vZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvY2FsbC1zZXR0aW5ncy5jOm9mb25vX2NhbGxfc2V0
dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwMzkwLCBuYW1lOiBhdG1vZGVt
PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvcGhvbmVib29rLmM6b2Zv
bm9fcGhvbmVib29rX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDczMCwgbmFtZTog
YXRtb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy91c3NkLmM6
b2Zvbm9fdXNzZF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzA2ODAsIG5hbWU6IGF0
bW9kZW08L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zbXMuYzpvZm9u
b19zbXNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwNDAwLCBuYW1lOiBhdG1vZGVt
PC9kaXY+PGRpdj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3Np
bV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzA1NjAsIG5hbWU6IGF0bW9kZW08L2Rp
dj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwNWE4LCBuYW1lOiBhdG1vZGVtLW5vZWY8L2Rp
dj48ZGl2PgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc3RrLmM6b2Zvbm9fc3RrX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDY2MCwgbmFtZTogYXRtb2RlbTwvZGl2Pjxk
aXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwNTAwLCBuYW1lOiBhdG1vZGVtPC9kaXY+
PGRpdj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2Nicy5jOm9mb25vX2Nic19kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzA0NjAsIG5hbWU6IGF0bW9kZW08L2Rpdj48ZGl2
Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9jYWxsLXZvbHVtZS5jOm9mb25vX2NhbGxf
dm9sdW1lX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDc5MCwgbmFtZTogYXRtb2Rl
bTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9f
Z3Byc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzA3ZDAsIG5hbWU6IGF0bW9kZW08
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9fZ3By
c19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDgwMCwgbmFtZTogYXRt
b2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW0tYXV0aC5j
Om9mb25vX3NpbV9hdXRoX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDgyMCwgbmFt
ZTogYXRtb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2duc3Mu
YzpvZm9ub19nbnNzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDg0MCwgbmFtZTog
YXRtb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5j
Om9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDFiMCwgbmFtZTog
Z29iaTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zv
bm9fZGV2aW5mb19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YmZmODAsIG5hbWU6IHFt
aW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL25ldHdvcmsu
YzpvZm9ub19uZXRyZWdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmJmZmYwLCBuYW1l
OiBxbWltb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3ZvaWNl
Y2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YmZm
YTAsIG5hbWU6IHFtaW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
c3JjL3NpbS5jOm9mb25vX3NpbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzAwMjAs
IG5hbWU6IHFtaW1vZGVtLWxlZ2FjeTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvc3JjL3NpbS5jOm9mb25vX3NpbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzAw
NzAsIG5hbWU6IHFtaW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
c3JjL3Ntcy5jOm9mb25vX3Ntc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzAwYzAs
IG5hbWU6IHFtaW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMv
dXNzZC5jOm9mb25vX3Vzc2RfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwMGUwLCBu
YW1lOiBxbWltb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9n
cHJzLmM6b2Zvbm9fZ3Byc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzAxMDAsIG5h
bWU6IHFtaW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3By
cy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzAx
MjAsIG5hbWU6IHFtaW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
c3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDU1NmMwMTQwLCBuYW1lOiBxbWltb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvc3JjL2xvY2F0aW9uLXJlcG9ydGluZy5jOm9mb25vX2xvY2F0aW9u
X3JlcG9ydGluZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzAxNzAsIG5hbWU6IHFt
aW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6
b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmJmZjJjLCBuYW1lOiB1
ODUwMDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zv
bm9fZGV2aW5mb19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YmZmMTAsIG5hbWU6IHU4
NTAwPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zv
bm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmJmZWMwLCBuYW1lOiBuOTAw
PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19t
b2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YmZlNzAsIG5hbWU6IGlzaXVzYjwv
ZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX2Rl
dmluZm9fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmJmYjkwLCBuYW1lOiBpc2ltb2Rl
bTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3Bob25lYm9vay5jOm9m
b25vX3Bob25lYm9va19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YmZiODAsIG5hbWU6
IGlzaW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL25ldHdv
cmsuYzpvZm9ub19uZXRyZWdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmJmYmIwLCBu
YW1lOiBpc2ltb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3Zv
aWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2
YmZiZTAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvc3JjL3Ntcy5jOm9mb25vX3Ntc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YmZj
MzAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9z
cmMvY2JzLmM6b2Zvbm9fY2JzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZiZmM1MCwg
bmFtZTogaXNpbW9kZW08L2Rpdj48ZGl2PgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMv
c2ltLmM6b2Zvbm9fc2ltX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZiZmM3MCwgbmFt
ZTogaXNpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy91c3Nk
LmM6b2Zvbm9fdXNzZF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YmZjYzAsIG5hbWU6
IGlzaW1vZGVtPC9kaXY+PGRpdj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2NhbGwt
Zm9yd2FyZGluZy5jOm9mb25vX2NhbGxfZm9yd2FyZGluZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4NTU2YmZjZTAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9zcmMvY2FsbC1zZXR0aW5ncy5jOm9mb25vX2NhbGxfc2V0dGluZ3NfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmJmZDAwLCBuYW1lOiBpc2ltb2RlbTwvZGl2Pgo8ZGl2
Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9jYWxsLWJhcnJpbmcuYzpvZm9ub19jYWxs
X2JhcnJpbmdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmJmZDMwLCBuYW1lOiBpc2lt
b2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2NhbGwtbWV0ZXIu
YzpvZm9ub19jYWxsX21ldGVyX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZiZmQ1MCwg
bmFtZTogaXNpbW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMv
cmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6IDB4NTU2YmZkODAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDU1NmJmZGIwLCBuYW1lOiBpc2ltb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3Rl
cigpIGRyaXZlcjogMHg1NTZiZmRkMCwgbmFtZTogaXNpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3NyYy9hdWRpby1zZXR0aW5ncy5jOm9mb25vX2F1ZGlvX3NldHRp
bmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZiZmRmMCwgbmFtZTogaXNpbW9kZW08
L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltLmM6b2Zvbm9fc2lt
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZiZmUwMCwgbmFtZTogd2dtb2RlbTIuNTwv
ZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzp1ZGV2
X3N0YXJ0KCmgPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3Vk
ZXZuZy5jOmVudW1lcmF0ZV9kZXZpY2VzKCmgPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgaHViIFsobnVsbCk6
KG51bGwpXTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2
bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFswYmRhOjgxNzZdPC9kaXY+PGRpdj5vZm9ub2Rb
MzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBy
dGw4MTkyY3UgWyhudWxsKToobnVsbCldPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgcnRsODE5MmN1IFswYmRh
OjgxNzZdPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZu
Zy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBydGw4MTkyY3UgWzBiZGE6ODE3Nl08L2Rpdj48ZGl2Pm9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2Rldmlj
ZSgpIGh1YiBbKG51bGwpOihudWxsKV08L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSB1c2IgWzEyZDE6MTAwMV08
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hl
Y2tfdXNiX2RldmljZSgpIG9wdGlvbiBbKG51bGwpOihudWxsKV08L2Rpdj48ZGl2Pm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9w
dGlvbiBbMTJkMToxMDAxXTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3Bs
dWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gt
ZWhjaS1oY2QtMS91c2IyLzItMTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
cGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3Rhbmdv
eC1laGNpLWhjZC0xL3VzYjIvMi0xLzItMToxLjAvdHR5VVNCMC90dHkvdHR5VVNCMDwvZGl2Pgo8
ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6YWRkX2Rldmlj
ZSgpIC9kZXYvdHR5VVNCMCAoaHVhd2VpKSAyNTUvMjU1LzI1NSBbMDBdID09Jmd0OyAobnVsbCkg
KG51bGwpPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZu
Zy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBvcHRpb24gWyhudWxsKToobnVsbCldPC9kaXY+CjxkaXY+
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2
aWNlKCkgb3B0aW9uIFsxMmQxOjEwMDFdPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvc3lzL2RldmljZXMvcGxhdGZvcm0v
dGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTE8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3BsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wbGF0Zm9y
bS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMS8yLTE6MS4xL3R0eVVTQjEvdHR5L3R0eVVTQjE8
L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFk
ZF9kZXZpY2UoKSAvZGV2L3R0eVVTQjEgKGh1YXdlaSkgMjU1LzI1NS8yNTUgWzAxXSA9PSZndDsg
KG51bGwpIChudWxsKTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lu
cy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgb3B0aW9uIFsobnVsbCk6KG51bGwpXTwvZGl2
Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tf
dXNiX2RldmljZSgpIG9wdGlvbiBbMTJkMToxMDAxXTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3Bs
YXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvc3lzL2RldmljZXMv
cGxhdGZvcm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTEvMi0xOjEuMi90dHlVU0IyL3R0eS90
dHlVU0IyPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2
bmcuYzphZGRfZGV2aWNlKCkgL2Rldi90dHlVU0IyIChodWF3ZWkpIDI1NS8yNTUvMjU1IFswMl0g
PT0mZ3Q7IChudWxsKSAobnVsbCk8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3BsdWdpbnMvdWRldm5nLmM6Y3JlYXRlX21vZGVtKCkgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3Rh
bmdveC1laGNpLWhjZC0xL3VzYjIvMi0xPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjcmVhdGVfbW9kZW0oKSBkcml2ZXI9aHVhd2VpPC9kaXY+
PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9j
cmVhdGUoKSBuYW1lOiAobnVsbCksIHR5cGU6IGh1YXdlaTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQz
XTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSAvc3lzL2Rldmlj
ZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTE8L2Rpdj4KPGRpdj5vZm9ub2Rb
MzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOnNldHVwX2h1YXdlaSgpIC9kZXYv
dHR5VVNCMCAyNTUvMjU1LzI1NSAwMCAobnVsbCk8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9v
Zm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6c2V0dXBfaHVhd2VpKCkgL2Rldi90dHlVU0IxIDI1
NS8yNTUvMjU1IDAxIChudWxsKTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
cGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSAvZGV2L3R0eVVTQjIgMjU1LzI1NS8yNTUg
MDIgKG51bGwpPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91
ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSBtZG09L2Rldi90dHlVU0IwIHBjdWk9L2Rldi90dHlVU0Iy
IGRpYWc9KG51bGwpIHFtaT0obnVsbCkgbmV0PShudWxsKTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQz
XTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg1
NTZlYjM4MCBwcm9wZXJ0eSBEZXZpY2U8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9zcmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDU1NmViMzgwIHBy
b3BlcnR5IE1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9k
ZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDU1NmViMzgwIHByb3BlcnR5IFBjdWk8
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOnNldF9tb2Rl
bV9wcm9wZXJ0eSgpIG1vZGVtIDB4NTU2ZWIzODAgcHJvcGVydHkgRGlhZzwvZGl2Pgo8ZGl2Pm9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgp
IG1vZGVtIDB4NTU2ZWIzODAgcHJvcGVydHkgTmV0d29ya0ludGVyZmFjZTwvZGl2PjxkaXY+b2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fcmVnaXN0ZXIo
KSAweDU1NmViMzgwPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5z
L2h1YXdlaS5jOmh1YXdlaV9wcm9iZSgpIDB4NTU2ZWIzODA8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzplbWl0X21vZGVtX2FkZGVkKCkgMHg1NTZlYjM4
MDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6Y2FsbF9t
b2RlbXdhdGNoZXMoKSAweDU1NmViMzgwIGFkZGVkOjE8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3BsdWdpbnMvaGZwX2FnX2JsdWV6NS5jOm1vZGVtX3dhdGNoKCkgbW9kZW06
IDB4NTU2ZWIzODAsIGFkZGVkOiAxPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvcGx1Z2lucy9kdW5fZ3dfYmx1ZXo1LmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg1NTZlYjM4
MCwgYWRkZWQ6IDE8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMv
c21hcnQtbWVzc2FnaW5nLmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg1NTZlYjM4MCwgYWRkZWQ6
IDE8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvcHVzaC1ub3Rp
ZmljYXRpb24uYzptb2RlbV93YXRjaCgpIG1vZGVtOiAweDU1NmViMzgwLCBhZGRlZDogMTwvZGl2
Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6aHVhd2Vp
X2VuYWJsZSgpIDB4NTU2ZWIzODA8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3NyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4NTU2ZWIzODAgcHJvcGVy
dHkgTW9kZW08L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVh
d2VpLmM6b3Blbl9kZXZpY2UoKSBNb2RlbSAvZGV2L3R0eVVTQjA8L2Rpdj4KPGRpdj5vZm9ub2Rb
MzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBtb2Rl
bSAweDU1NmViMzgwIHByb3BlcnR5IFBjdWk8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6b3Blbl9kZXZpY2UoKSBQY3VpIC9kZXYvdHR5VVNCMjwv
ZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogTW9kZW06ICZndDsgQVRFMCArQ01FRT0xXHI8L2Rpdj4K
PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFURTAgK0NNRUU9MVxyPC9kaXY+PGRpdj5v
Zm9ub2RbMzA5NDNdOiBNb2RlbTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6
ICZndDsgQVRJXHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk1hbnVm
YWN0dXJlcjogaHVhd2VpXHJcbk1vZGVsOiBFMzAzXHJcblJldmlzaW9uOiAyMi4zMTguMDUuMDAu
MDBcclxuSU1FSTogODYyNTY2MDIwMDA1Njk3XHJcbitHQ0FQOiArQ0dTTSwrRFMsK0VTXHJcblxy
XG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXlJGU1dJVENI
PT9ccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuRVJST1JcclxuPC9k
aXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NGVU49MVxyPC9kaXY+PGRpdj5v
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eU0lNU1Q6MCwwXHJcbjwvZGl2PjxkaXY+b2Zv
bm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuT0tcclxuXHJcbl5TSU1TVDoxLDBcclxuPC9kaXY+
CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpjZnVuX2Vu
YWJsZSgpoDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3
ZWkuYzpzaW1zdF9ub3RpZnkoKSAyNTUgLSZndDsgMTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTog
UENVSTogJmd0OyBBVF5TWVNJTkZPXHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbitDUkVHOiAyXHJcblxyXG4rQ0dSRUc6IDJcclxuXHJcbl5TWVNJTkZPOjAsMywwLDAs
MSwwLDBcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3BsdWdpbnMvaHVhd2VpLmM6c3lzaW5mb19lbmFibGVfY2IoKSAxIC0mZ3Q7IDE8L2Rpdj48ZGl2
Pm9mb25vZFszMDk0M106IE1vZGVtOiAmZ3Q7IEFUJmFtcDtDMFxyPC9kaXY+PGRpdj5vZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUJmFtcDtDMFxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBN
b2RlbTogJmx0OyBcclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0
OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBNb2RlbTogJmd0OyBBVCtDU0NT
PSZxdW90O0dTTSZxdW90O1xyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFU
K0NTQ1M9JnF1b3Q7R1NNJnF1b3Q7XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IE1vZGVtOiAm
bHQ7IFxyXG5PS1xyXG48L2Rpdj48ZGl2PgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5P
S1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVReVTJESUFHP1xyPC9k
aXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eVTJESUFHOiAxMTlcclxuXHJc
bk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVF5HRVRQT1JUTU9E
RVxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eR0VUUE9SVE1PREU6
IFRZUEU6IFdDRE1BOiBodWF3ZWksXHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmZ3Q7IEFUXlVTU0RNT0RFPT9ccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTog
UENVSTogJmx0OyBcclxuXlVTU0RNT0RFOiAoMC0xKVxyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5v
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXkRJQUxNT0RFPT9ccjwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogUENVSTogJmx0OyBcclxuXkRJQUxNT0RFOiAoMC0yKSwoMC0yNTUpXHJcblxyXG5P
S1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXkNWT0lDRT0/XHI8
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbl5DVk9JQ0U6ICgwKVxyXG5c
clxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NGVU49NVxy
PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JFRzogMFxyXG5cclxu
K0NHUkVHOiAwXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9L
XHJcblxyXG5eTU9ERTogMCwwXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvcGx1Z2lucy9odWF3ZWkuYzpjZnVuX29mZmxpbmUoKaA8L2Rpdj48ZGl2Pm9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm1vZGVtX2NoYW5nZV9zdGF0ZSgpIG9sZCBzdGF0
ZTogMCwgbmV3IHN0YXRlOiAxPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
cGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfcHJlX3NpbSgpIDB4NTU2ZWIzODA8L2Rpdj48ZGl2Pm9m
b25vZFszMDk0M106IFBDVUk6ICZndDsgQVReVVNTRE1PREU/XHI8L2Rpdj48ZGl2Pm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3N0YXRlX3dhdGNoKCkg
MHg1NTZkYzY2MDwvZGl2PjxkaXY+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW0u
YzpvZm9ub19zaW1fYWRkX3N0YXRlX3dhdGNoKCkgMHg1NTZkYzY2MDwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3NpbV9hZGRfc3RhdGVfd2F0Y2go
KSAweDU1NmRjNjYwPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eVVNT
RE1PREU6IDFcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZn
dDsgQVReRElBTE1PREU/XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJc
bl5ESUFMTU9ERTozLDJcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENV
STogJmd0OyBBVF5DVk9JQ0U/XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsg
XHJcbl5DVk9JQ0U6IDEsIDgwMDAsIDE2LCAyMFxyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zv
bm9kWzMwOTQzXTogVm9pY2UgY2hhbm5lbDogODAwMCBIeiwgMTYgYml0cywgMjBtcyBwZXJpb2Q8
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrR0NBUFxyPC9kaXY+PGRpdj5v
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rR0NBUDogK0NHU00sK0RTLCtFU1xyXG5cclxu
T0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDEy
MjU4LDAsMCwyNTVccjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitD
UlNNOiAxNDQsMCwmcXVvdDs2MjFDODIwMjQxMjE4MzAyMkZFMkE1MDM4MDAxNzE4QTAxMDU4QjAz
MkYwNjAzODAwMjAwMEE4ODAxMTAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19j
YigpIGNyc21faW5mb19jYjogOTAsIDAwLCAzMDwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBD
VUk6ICZndDsgQVReRERTRVRFWD0/XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbl5ERFNFVEVYOiAoMilcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQz
XTogUENVSTogJmd0OyBBVCtDR01JXHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbmh1YXdlaVxyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENV
STogJmd0OyBBVCtDUlNNPTE3NiwxMjI1OCwwLDAsMTBccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQz
XTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90Ozk4NTMwMzA1MDEwNzA4NTMwNUY2
JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkw
LCAwMCwgMTA8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltZnMu
YzpzaW1fZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9mZjogMCwgZGF0YW9mZjogMCwgdG9jb3B5
OiAxMDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDR01NXHI8L2Rpdj48
ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbkUzMDNcclxuXHJcbk9LXHJcbjwvZGl2
PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODQyMSwwLDAsMjU1
XHI8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAs
JnF1b3Q7NjIxQzgyMDI0MTIxODMwMjZGMDVBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwNDgwMDIw
MDBBODgwMTEwJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9v
Zm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2luZm9fY2IoKSBjcnNtX2lu
Zm9fY2I6IDkwLCAwMCwgMzA8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFU
K0NHTVJccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuMjIuMzE4LjA1
LjAwLjAwXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsg
QVQrQ1JTTT0xNzYsMjg0MjEsMCwwLDEwXHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6
ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDs2NTZFRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xy
XG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVy
cy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAx
MDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbWZzLmM6c2ltX2Zz
X29wX3JlYWRfYmxvY2tfY2IoKSBidWZvZmY6IDAsIGRhdGFvZmY6IDAsIHRvY29weTogMTA8L2Rp
dj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0dTTlxyPC9kaXY+CjxkaXY+b2Zv
bm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuODYyNTY2MDIwMDA1Njk3XHJcblxyXG5PS1xyXG48
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMTIwMzcsMCww
LDI1NVxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0
LDAsJnF1b3Q7NjIxQzgyMDI0MTIxODMwMjJGMDVBNTAzODAwMTcxOEEwMTA1OEIwMzJGMDYwNDgw
MDIwMDBBODgwMTI4JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkgY3Jz
bV9pbmZvX2NiOiA5MCwgMDAsIDMwPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7
IEFUK0NSU009MTc2LDEyMDM3LDAsMCwxMFxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7NjU2RUZGRkZGRkZGRkZGRkZGRkYmcXVvdDtc
clxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZl
cnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwg
MTA8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW1mcy5jOnNpbV9m
c19vcF9yZWFkX2Jsb2NrX2NiKCkgYnVmb2ZmOiAwLCBkYXRhb2ZmOiAwLCB0b2NvcHk6IDEwPC9k
aXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NQSU4/XHI8L2Rpdj4KPGRpdj5v
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1BJTjogUkVBRFlcclxuXHJcbk9LXHJcbjwv
ZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5j
OmF0X2NwaW5fY2IoKSBjcnNtX3Bpbl9jYjogUkVBRFk8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9waW5fcmV0cmllc19xdWVyeSgp
oDwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVReQ1BJTj9ccjwvZGl2Pjxk
aXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuXkNQSU46IFJFQURZLCwxMCwzLDEwLDNc
clxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVy
cy9hdG1vZGVtL3NpbS5jOmh1YXdlaV9jcGluX2NiKCkgcmV0cnkgY291bnRlciBpZD05LCB2YWw9
MTA8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0v
c2ltLmM6aHVhd2VpX2NwaW5fY2IoKSByZXRyeSBjb3VudGVyIGlkPTEsIHZhbD0zPC9kaXY+PGRp
dj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6aHVhd2Vp
X2NwaW5fY2IoKSByZXRyeSBjb3VudGVyIGlkPTExLCB2YWw9MTA8L2Rpdj48ZGl2Pm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzpodWF3ZWlfY3Bpbl9jYigp
IHJldHJ5IGNvdW50ZXIgaWQ9NCwgdmFsPTM8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmZ3Q7IEFUK0NSU009MTkyLDI4NTkwLDAsMCwyNTVccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQz
XTogUENVSTogJmx0OyBcclxuK0NSU006IDEwNiwxMzAsJnF1b3Q7JnF1b3Q7XHJcblxyXG5PS1xy
XG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg1ODks
MCwwLDI1NVxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTog
MTQ0LDAsJnF1b3Q7NjIxQzgyMDI0MTIxODMwMjZGQURBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYw
NjgwMDIwMDA0ODgwMTE4JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkg
Y3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMwPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
Z3Q7IEFUK0NSU009MTc2LDI4NTg5LDAsMCw0XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBD
VUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMDAwMDAwMiZxdW90O1xyXG5cclxuT0tc
clxuPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCA0PC9kaXY+PGRp
dj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9i
bG9ja19jYigpIGJ1Zm9mZjogMCwgZGF0YW9mZjogMCwgdG9jb3B5OiA0PC9kaXY+PGRpdj5vZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NDM4LDAsMCwyNTVccjwvZGl2Pgo8
ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxMDYsMTMwLCZxdW90OyZx
dW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFU
K0NSU009MTkyLDI4NDcyLDAsMCwyNTVccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTog
Jmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzYyMUM4MjAyNDEyMTgzMDI2RjM4QTUwMzgwMDE3
MThBMDEwNThCMDM2RjA2MDI4MDAyMDAwQTg4MDEyMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+
CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0
X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAzMDwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3NiwyODQ3MiwwLDAsMTBccjwvZGl2PjxkaXY+
b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzdFRUUxMTFD
MjdGNjU5MDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3Jz
bV9yZWFkX2NiOiA5MCwgMDAsIDEwPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9zcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9mZjogMCwgZGF0YW9m
ZjogMCwgdG9jb3B5OiAxMDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtD
UlNNPTE5MiwyODUwMiwwLDAsMjU1XHI8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
bHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7NjIxQzgyMDI0MTIxODMwMjZGNTZBNTAzODAwMTcx
OEEwMTA1OEIwMzZGMDYwNzgwMDIwMDAxODgwMTI4JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48
ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9j
cnNtX2luZm9fY2IoKSBjcnNtX2luZm9fY2I6IDkwLCAwMCwgMzA8L2Rpdj4KPGRpdj5vZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc2LDI4NTAyLDAsMCwxXHI8L2Rpdj48ZGl2Pm9m
b25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMCZxdW90O1xy
XG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJz
L2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDE8
L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltZnMuYzpzaW1fZnNf
b3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9mZjogMCwgZGF0YW9mZjogMCwgdG9jb3B5OiAxPC9kaXY+
PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NJTUlccjwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogUENVSTogJmx0OyBcclxuMjcyMDUwMTAwNDEzNTgwXHJcblxyXG5PS1xyXG48L2Rp
dj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6
YXRfY2ltaV9jYigpIGNpbWlfY2I6IDI3MjA1MDEwMDQxMzU4MDwvZGl2PjxkaXY+b2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6bW9kZW1fY2hhbmdlX3N0YXRlKCkgb2xkIHN0
YXRlOiAxLCBuZXcgc3RhdGU6IDI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3BsdWdpbnMvaHVhd2VpLmM6aHVhd2VpX3Bvc3Rfc2ltKCkgMHg1NTZlYjM4MDwvZGl2Pgo8ZGl2
Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQu
YzphdF9ncHJzX2NvbnRleHRfcHJvYmUoKaA8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3NyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4NTU2ZWIzODAg
cHJvcGVydHkgQWx3YXlzT25saW5lPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7
IEFUK0NSQz0xXHI8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xy
XG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOmdldF9t
b2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4NTU2ZWIzODAgcHJvcGVydHkgQWx3YXlzT25saW5lPC9k
aXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmh1YXdl
aV9zZXRfb25saW5lKCkgbW9kZW0gMHg1NTZlYjM4MCBvbmxpbmU8L2Rpdj4KPGRpdj5vZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NMSVA9MVxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsg
QVQrQ09MUD0xXHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJc
bjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDQ1dBPTFccjwvZGl2Pgo8
ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9odWF3ZWltb2RlbS92b2ljZWNhbGwuYzpodWF3
ZWlfdm9pY2VjYWxsX2luaXRpYWxpemVkKCkgcmVnaXN0ZXJpbmcgdG8gbm90aWZpY2F0aW9uczwv
ZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3NpbV9h
ZGRfc3RhdGVfd2F0Y2goKSAweDU1NmRjNjYwPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvcGx1Z2lucy9ibHVlejUuYzpidF9yZWdpc3Rlcl9wcm9maWxlKCkgQmx1ZXRvb3Ro
OiBSZWdpc3RlcmluZyAwMDAwMTExZi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIgKGhmcF9h
ZykgcHJvZmlsZTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVF5DVk9JQ0U9
P1xyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eQ1ZPSUNFOiAoMClc
clxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1ND
Uz0/XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDU0NTOiAoJnF1
b3Q7SVJBJnF1b3Q7LCZxdW90O1VDUzImcXVvdDssJnF1b3Q7R1NNJnF1b3Q7KVxyXG5cclxuT0tc
clxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXlNZU0NGRz0/XHI8L2Rp
dj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbl5TWVNDRkc6ICgyLDEzLDE0LDE2
KSwoMC0zKSwoKDIwMDAwMDA0MDAzODAsJnF1b3Q7R1NNOTAwL0dTTTE4MDAvV0NETUE5MDAvV0NE
TUEyMTAwJnF1b3Q7KSwoMjgwMDAwLCZxdW90O0dTTTg1MC9HU00xOTAwJnF1b3Q7KSwoM2ZmZmZm
ZmYsJnF1b3Q7QWxsIGJhbmRzJnF1b3Q7KSksKDAtMiksKDAtNClcclxuXHJcbk9LXHJcbjwvZGl2
Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1NNUz0/XHI8L2Rpdj48ZGl2Pm9m
b25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDU01TOiAoMCwxKVxyXG5cclxuT0tcclxuPC9k
aXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc21zLmM6
YXRfY3Ntc19xdWVyeV9jYigpIENTTVMgcXVlcnkgcGFyc2VkIHN1Y2Nlc3NmdWxseTwvZGl2Pgo8
ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0dEQ09OVD0/XHI8L2Rpdj48ZGl2Pm9m
b25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDR0RDT05UOiAoMS0xMSksJnF1b3Q7SVAmcXVv
dDssLCwoMC0yKSwoMC0zKSwoMCwxKSwoMCwxKVxyXG4rQ0dEQ09OVDogKDEtMTEpLCZxdW90O1BQ
UCZxdW90OywsLCgwLTIpLCgwLTMpLCgwLDEpLCgwLDEpXHJcblxyXG5cclxuT0tcclxuPC9kaXY+
CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDRlVOPTFccjwvZGl2PjxkaXY+b2Zv
bm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuXlNJTVNUOjAsMFxyXG48L2Rpdj48ZGl2Pm9mb25v
ZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6c2ltc3Rfbm90aWZ5KCkgMSAt
Jmd0OyAwPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBSZWdpc3RlclByb2ZpbGUoKSByZXBsaWVk
IGFuIGVycm9yOiBvcmcuZnJlZWRlc2t0b3AuREJ1cy5FcnJvci5TcGF3bi5DaGlsZEV4aXRlZCwg
TGF1bmNoIGhlbHBlciBleGl0ZWQgd2l0aCB1bmtub3duIHJldHVybiBjb2RlIDE8L2Rpdj4KPGRp
dj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG5cclxuXlNJTVNUOjEsMFxyXG48
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6c2lt
c3Rfbm90aWZ5KCkgMCAtJmd0OyAxPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7
IEFUK0NSU009MTkyLDI4NDgwLDAsMCwyNTVccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENV
STogJmx0OyBcclxuK0NSRUc6IDJcclxuXHJcbitDR1JFRzogMlxyXG48L2Rpdj4KPGRpdj5vZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7NjIxRTgyMDU0MjIx
MDAyMjA2ODMwMjZGNDBBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwNTgwMDIwMENDODgwMCZxdW90
O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2
ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkgY3JzbV9pbmZvX2NiOiA5MCwgMDAs
IDMyPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUEJTPT9ccjwvZGl2
PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NQQlM6ICgmcXVvdDtTTSZxdW90
OywmcXVvdDtFTiZxdW90OywmcXVvdDtPTiZxdW90OywmcXVvdDtGRCZxdW90OylcclxuXHJcbk9L
XHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDU01TPTFccjwvZGl2
PjxkaXY+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDU01TOiAxLDEsMVxyXG5cclxu
T0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NHUkVHPT9ccjwv
ZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NHUkVHOiAoMC0yKVxyXG5c
clxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXlNZU0lORk9c
cjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbl5TWVNJTkZPOjAsMyww
LDAsMSwwLDBcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvcGx1Z2lucy9odWF3ZWkuYzpzeXNpbmZvX29ubGluZV9jYigpIDEgLSZndDsgMTwvZGl2Pjxk
aXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6bW9kZW1fY2hhbmdlX3N0
YXRlKCkgb2xkIHN0YXRlOiAyLCBuZXcgc3RhdGU6IDM8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9wb3N0X29ubGluZSgpIDB4NTU2
ZWIzODA8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg0
ODAsMSw0LDM0XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNN
OiAxNDQsMCwmcXVvdDs0RDc5MjA0RTc1NkQ2MjY1NzJGRkZGRkZGRkZGRkZGRkZGRkZGRkZGMDc5
MTUzODMxMzk3Nzg0OEZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21f
cmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQz
XTogUENVSTogJmd0OyBBVCtDU01TP1xyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
bHQ7IFxyXG4rQ1NNUzogMSwxLDEsMVxyXG5cclxuT0tcclxuPC9kaXY+PGRpdj4Kb2Zvbm9kWzMw
OTQzXTogUENVSTogJmd0OyBBVCtDR1JFRz0yXHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBD
VUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBB
VCtDR0FVVE89MFxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xy
XG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0dFUkVQPTIsMVxyPC9k
aXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuRVJST1JcclxuPC9kaXY+PGRp
dj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2JsdWV6NS5jOmJ0X3JlZ2lzdGVy
X3Byb2ZpbGUoKSBCbHVldG9vdGg6IFJlZ2lzdGVyaW5nIDAwMDAxMTAzLTAwMDAtMTAwMC04MDAw
LTAwODA1ZjliMzRmYiAoZHVuX2d3KSBwcm9maWxlPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmZ3Q7IEFUK0NSRUc9P1xyPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0
OyBcclxuK0NSRUc6ICgwLTIpXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVQrQ1NDQj0/XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbitDU0NCOigwLDEpXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVQrQ1VTRD0xXHI8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
bHQ7IFxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JT
TT0xNzgsMjg0ODAsMiw0LDM0XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsg
XHJcbitDUlNNOiAxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9k
aXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5j
OmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDwvZGl2PjxkaXY+b2Zv
bm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDTUdGPT9ccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQz
XTogUmVnaXN0ZXJQcm9maWxlKCkgcmVwbGllZCBhbiBlcnJvcjogb3JnLmZyZWVkZXNrdG9wLkRC
dXMuRXJyb3IuU3Bhd24uQ2hpbGRFeGl0ZWQsIExhdW5jaCBoZWxwZXIgZXhpdGVkIHdpdGggdW5r
bm93biByZXR1cm4gY29kZSAxPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBc
clxuK0NNR0Y6ICgwLDEpXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBD
VUk6ICZndDsgQVQrQ1JFRz0yXHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsg
XHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbS5j
Om9mb25vX3NpbV9hZGRfc3BuX3dhdGNoKCkgMHg1NTZkYzY2MDwvZGl2Pgo8ZGl2Pm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6X19vZm9ub19uZXRyZWdfYWRkX3N0YXR1
c193YXRjaCgpIDB4NTU2ZGNmMTg8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsg
QVQrQ1NDQj0wXHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJc
bjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2Nicy5jOmNic19nb3Rf
aW1zaSgpIEdvdCBJTVNJOiAyNzIwNTAxMDA0MTM1ODA8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOl9fb2Zvbm9fbmV0cmVnX2FkZF9zdGF0dXNfd2F0
Y2goKSAweDU1NmRjZjE4PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NQ
TVM9P1xyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1BNUzogKCZx
dW90O1NNJnF1b3Q7LCZxdW90O01FJnF1b3Q7KSwoJnF1b3Q7U00mcXVvdDssJnF1b3Q7TUUmcXVv
dDspLCgmcXVvdDtTTSZxdW90OywmcXVvdDtNRSZxdW90OylcclxuXHJcbk9LXHJcbjwvZGl2Pgo8
ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg0ODAsMyw0LDM0XHI8
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVv
dDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3Jz
bV9yZWFkX2NiOiA5MCwgMDAsIDM0PC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0
OyBBVCtDUkVHP1xyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JF
RzogMiwyXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0YXR1c19ub3RpZnkoKSAvaHVhd2VpXzAgc3Rh
dHVzIDIgdGVjaCAtMTwvZGl2PjxkaXY+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9u
ZXR3b3JrLmM6Y3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaygpIDB4NTU2ZGNmMTgsIChuaWwpPC9k
aXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvY2JzLmM6Y2JzX2xvY2F0aW9u
X2NoYW5nZWQoKSAyLCAtMSwgLTEsIC0xLCAobnVsbCkobnVsbCk8L2Rpdj48ZGl2Pm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6bmV0cmVnX3N0YXR1c19jaGFuZ2VkKCkgMjwv
ZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ01HRj0wXHI8L2Rpdj48ZGl2
Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMw
OTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODQ4MCw0LDQsMzRccjwvZGl2PjxkaXY+b2Zv
bm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90O0ZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5
MCwgMDAsIDM0PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NQTVM9JnF1
b3Q7TUUmcXVvdDssJnF1b3Q7TUUmcXVvdDssJnF1b3Q7TUUmcXVvdDtccjwvZGl2PjxkaXY+b2Zv
bm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuXk1PREU6IDUsNFxyXG48L2Rpdj4KPGRpdj5vZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1BNUzogMCwyMCwwLDIwLDAsMjBcclxuXHJcbk9L
XHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODQ4
MCw1LDQsMzRccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006
IDE0NCwwLCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5v
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9y
ZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNd
OiBQQ1VJOiAmZ3Q7IEFUK0NOTUk9P1xyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
bHQ7IFxyXG4rQ05NSTogKDAtMiksKDAtMyksKDAsMiksKDAtMiksKDAsMSlcclxuXHJcbk9LXHJc
bjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9z
bXMuYzpidWlsZF9jbm1pX3N0cmluZygpoDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTog
Jmd0OyBBVCtDUlNNPTE3OCwyODQ4MCw2LDQsMzRccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTog
UENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxy
XG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0
bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PC9k
aXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NOTUk9MSwxLDIsMSwwXHI8L2Rp
dj48ZGl2Pm9mb25vZFszMDk0M106IER1cGxpY2F0ZSBFRnNkbiBlbnRyaWVzIGZvciBgRW1lcmdl
bmN5IFNlcnZpY2VzJiMzOTs8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxy
XG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3Jr
LmM6X19vZm9ub19uZXRyZWdfYWRkX3N0YXR1c193YXRjaCgpIDB4NTU2ZGNmMTg8L2Rpdj48ZGl2
Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zbXMuYzpzbXNfcmVzdG9yZV90eF9xdWV1
ZSgpoDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9wdXNoLW5v
dGlmaWNhdGlvbi5jOnNtc193YXRjaCgpIHJlZ2lzdGVyZWQ8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3NtYXJ0LW1lc3NhZ2luZy5jOnNtc193YXRjaCgpIHJl
Z2lzdGVyZWQ8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIs
Mjg2MTgsMCwwLDI1NVxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4r
Q1JTTTogMTQ0LDAsJnF1b3Q7NjIxRTgyMDU0MjIxMDAwNjA1ODMwMjZGQ0FBNTAzODAwMTcxOEEw
MTA1OEIwMzZGMDYwNTgwMDIwMDFFODgwMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21f
aW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAzMjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQz
XTogUENVSTogJmd0OyBBVCtDTUdMPTRccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTog
Jmx0OyBcclxuXlJTU0k6IDEzXHJcblxyXG5eSENTUTomcXVvdDtXQ0RNQSZxdW90Oyw0MiwzNCw0
OVxyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48L2Rp
dj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zbXMuYzph
dF9jbWdsX2RvbmUoKaA8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0dT
TVM9M1xyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48L2Rp
dj48ZGl2PgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE4LDEsNCw2
XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwm
cXVvdDswMDAwMDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigp
IGNyc21fcmVhZF9jYjogOTAsIDAwLCA2PC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTog
Jmd0OyBBVCtDUlNNPTE3OCwyODYxOCwyLDQsNlxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDAwMDAwJnF1b3Q7XHJcblxy
XG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRt
b2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgNjwvZGl2
Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTgsMyw0LDZc
cjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZx
dW90OzAwMDAwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkg
Y3JzbV9yZWFkX2NiOiA5MCwgMDAsIDY8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
Z3Q7IEFUK0NSU009MTc4LDI4NjE4LDQsNCw2XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBD
VUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMDAwMDAwMDAwMDAmcXVvdDtcclxuXHJc
bk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1v
ZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCA2PC9kaXY+
CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxOCw1LDQsNlxy
PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1
b3Q7MDAwMDAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBj
cnNtX3JlYWRfY2I6IDkwLCAwMCwgNjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZn
dDsgQVQrQ1JTTT0xOTIsMjg2MTcsMCwwLDI1NVxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7NjIxRTgyMDU0MjIxMDAwNTA1ODMwMjZG
QzlBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwMjgwMDIwMDE5ODgwMCZxdW90O1xyXG5cclxuT0tc
clxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0v
c2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkgY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMyPC9kaXY+Cjxk
aXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNywxLDQsNVxyPC9k
aXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7
MDEwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9y
ZWFkX2NiOiA5MCwgMDAsIDU8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFU
K0NSU009MTc4LDI4NjE3LDIsNCw1XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMTAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0u
YzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgNTwvZGl2Pgo8ZGl2Pm9m
b25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTcsMyw0LDVccjwvZGl2Pjxk
aXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAxMDAw
MDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9j
YjogOTAsIDAwLCA1PC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNN
PTE3OCwyODYxNyw0LDQsNVxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxy
XG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDEwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+
PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRf
Y3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDU8L2Rpdj4KPGRpdj5vZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE3LDUsNCw1XHI8L2Rpdj48ZGl2Pm9m
b25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMTAwMDAwMDAw
JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkw
LCAwMCwgNTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIs
Mjg0MzMsMCwwLDI1NVxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4r
Q1JTTTogMTA2LDEzMCwmcXVvdDsmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21lc3NhZ2Utd2FpdGluZy5jOm13X2NwaHNfbXdpc19y
ZWFkX2NiKCkgTm8gQ1BIUyBNV0lTIG9uIFNJTTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBD
VUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg2MTksMCwwLDI1NVxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7NjIxRTgyMDU0MjIxMDAxMDA1
ODMwMjZGQ0JBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwNTgwMDIwMDUwODgwMCZxdW90O1xyXG5c
clxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0
bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkgY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMyPC9k
aXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxOSwxLDQs
MTZccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCww
LCZxdW90O0ZGMDBGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xy
XG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9z
aW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTY8L2Rpdj4KPGRp
dj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE5LDIsNCwxNlxyPC9k
aXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7
RkYwMEZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2
PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0
X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAxNjwvZGl2Pgo8ZGl2Pm9mb25v
ZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTksMyw0LDE2XHI8L2Rpdj48ZGl2
Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDtGRjAwRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5v
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9y
ZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDE2PC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQz
XTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxOSw0LDQsMTZccjwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90O0ZGMDBGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2Io
KSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTY8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE5LDUsNCwxNlxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNd
OiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7RkYwMEZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21f
cmVhZF9jYjogOTAsIDAwLCAxNjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3NyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrKCkgYnVmb2ZmOiAwLCBzZWVrb2ZmOiAz
OSwgdG9yZWFkOiAxNzwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3Np
bWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2soKSBidWZvZmY6IDAsIHNlZWtvZmY6IDM5LCB0b3Jl
YWQ6IDEwPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9k
ZW0vY2JzLmM6YXRfY2JzX3NldF90b3BpY3MoKaA8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmZ3Q7IEFUK0NTQ0I9MFxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7
IFxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1NDQj0w
LCZxdW90OzAsNTAsMjE0LDQzNTItNDM1NiZxdW90O1xyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNd
OiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
Z3Q7IEFUK0NSU009MTkyLDI4NDM3LDAsMCwyNTVccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTog
UENVSTogJmx0OyBcclxuK0NSU006IDEwNiwxMzAsJnF1b3Q7JnF1b3Q7XHJcblxyXG5PS1xyXG48
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg2MTUsMCww
LDI1NVxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eU1JWU1Q6IDJc
clxuXHJcbitDR1JFRzogMSwmcXVvdDswMDQwJnF1b3Q7LCZxdW90OzAyQzExNTVBJnF1b3Q7XHJc
bjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9f
Z3Byc19zdGF0dXNfbm90aWZ5KCkgL2h1YXdlaV8wIHN0YXR1cyAxPC9kaXY+PGRpdj5vZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7NjIxRTgyMDU0MjIxMDAy
MjA1ODMwMjZGQzdBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwMjgwMDIwMEFBODgwMCZxdW90O1xy
XG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVy
cy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAz
MjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNSwx
LDQsMzRccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0
NCwwLCZxdW90OzRENjE2OTZDRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYwNzkxNTM4
MzMzMzMxMzE3RkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFk
X2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE1LDIsNCwzNFxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtc
clxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZl
cnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwg
MzQ8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTUs
Myw0LDM0XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAx
NDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVh
ZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTog
UENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNSw0LDQsMzRccjwvZGl2PjxkaXY+b2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7
XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2
ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAs
IDM0PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0v
Z3Bycy1jb250ZXh0LmM6YXRfZ3Byc19hY3RpdmF0ZV9wcmltYXJ5KCkgY2lkIDE8L2Rpdj48ZGl2
Pm9mb25vZFszMDk0M106IE1vZGVtOiAmZ3Q7IEFUK0NHRENPTlQ9MSwmcXVvdDtJUCZxdW90Oywm
cXVvdDszSXJlbGFuZCZxdW90O1xyPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogTW9kZW06ICZs
dDsgXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVy
cy9hdG1vZGVtL2dwcnMtY29udGV4dC5jOmF0X2NnZGNvbnRfY2IoKSBvayAxPC9kaXY+PGRpdj5v
Zm9ub2RbMzA5NDNdOiBNb2RlbTogJmd0OyBBVEQqOTkqKioxI1xyPC9kaXY+PGRpdj5vZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE1LDUsNCwzNFxyPC9kaXY+CjxkaXY+
b2Zvbm9kWzMwOTQzXTogTW9kZW06ICZsdDsgXHJcbkNPTk5FQ1RcclxuPC9kaXY+PGRpdj5vZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmM6YXRf
Y2dkYXRhX2NiKCkgb2sgMTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJp
dmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5jOnNldHVwX3BwcCgpoDwvZGl2Pgo8ZGl2Pm9mb25v
ZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZx
dW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9k
cml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwg
MDAsIDM0PC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSRUc6IDEs
JnF1b3Q7MDA0MCZxdW90OywmcXVvdDswMkMxMTU1QSZxdW90O1xyXG48L2Rpdj48ZGl2Pm9mb25v
ZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0YXR1c19u
b3RpZnkoKSAvaHVhd2VpXzAgc3RhdHVzIDEgdGVjaCAyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9zcmMvY2JzLmM6Y2JzX2xvY2F0aW9uX2NoYW5nZWQoKSAxLCAtMSwgLTEs
IDIsIChudWxsKShudWxsKTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3Ny
Yy9ncHJzLmM6bmV0cmVnX3N0YXR1c19jaGFuZ2VkKCkgMTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQz
XTogUENVSTogJmd0OyBBVCtDT1BTPTMsMlxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQr
Q09QUz9ccjwvZGl2PjxkaXY+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDT1BTOiAw
LDIsJnF1b3Q7MjcyMDUmcXVvdDssMlxyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vbmV0d29yay1yZWdpc3RyYXRpb24uYzpj
b3BzX251bWVyaWNfY2IoKSBDb3BzIG51bWVyaWMgZ290IG1jYzogMjcyLCBtbmM6IDA1PC9kaXY+
PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NTUVxyPC9kaXY+CjxkaXY+b2Zvbm9k
WzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NTUTogMTMsOTlcclxuXHJcbk9LXHJcbjwvZGl2Pjxk
aXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL25ldHdvcmstcmVn
aXN0cmF0aW9uLmM6Y3NxX2NiKCkgY3NxX2NiOiAxMzwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfc3RyZW5ndGhfbm90aWZ5KCkg
c3RyZW5ndGggNDE8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NPUFM9
MywwXHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2
PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDT1BTP1xyPC9kaXY+PGRpdj5vZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ09QUzogMCwwLCZxdW90OzMgSVJMJnF1b3Q7LDJc
clxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZl
cnMvYXRtb2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5jOmNvcHNfY2IoKSBjb3BzX2NiOiAzIElS
TCwgMjcyIDA1IDI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9uZXR3
b3JrLmM6Y3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaygpIDB4NTU2ZGNmMTgsIChuaWwpPC9kaXY+
PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvY2JzLmM6Y2JzX2xvY2F0aW9uX2No
YW5nZWQoKSAxLCAtMSwgLTEsIDIsIDI3MjA1PC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvc3JjL2Nicy5jOmNic19sb2NhdGlvbl9jaGFuZ2VkKCkgMSwgMCwgMDwvZGl2Pjxk
aXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpuZXRyZWdfc3RhdHVzX2No
YW5nZWQoKSAxPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eUlNTSTog
MTBcclxuXHJcbl5IQ1NROiZxdW90O1dDRE1BJnF1b3Q7LDM3LDI4LDQ3XHJcbjwvZGl2Pgo8ZGl2
Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0
cmVuZ3RoX25vdGlmeSgpIHN0cmVuZ3RoIDMyPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Ib21hbTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPgo8L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pgo8YnI+PC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eUlNTSTogMTJcclxuXHJcbl5IQ1NR
OiZxdW90O1dDRE1BJnF1b3Q7LDQyLDMzLDQ3XHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfc3RyZW5ndGhfbm90aWZ5KCkg
c3RyZW5ndGggMzg8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eTU9E
RTogNSw3XHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9h
dG1vZGVtL2dwcnMtY29udGV4dC5jOnBwcF9jb25uZWN0KCmgPC9kaXY+PGRpdj5vZm9ub2RbMzA5
NDNdOiBJUDogMTAuMjA1LjIwNi4yNDM8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IEROUzogMTcy
LjMwLjIyNC42NSwgMTcyLjMwLjIyNC42NTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3NyYy9ncHJzLmM6cHJpX2FjdGl2YXRlX2NhbGxiYWNrKCkgMHg1NTZlNjVhODwvZGl2
PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVu
dCgpIHN1YnN5c3RlbSBuZXQgYWRkPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9wbHVnaW5zL3VkZXYuYzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIG5ldCBmaW5pc2hlZDwvZGl2
Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMv
dWRldm5nLmM6Y2hlY2tfbW9kZW1fbGlzdCgpoDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2Pgo8
ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBD
VUk6ICZsdDsgXHJcbl5EU0ZMT1dSUFQ6MDAwMDAwMDIsMDAwMDAxRUQsMDAwMDAyOUUsMDAwMDAw
MDAwMDAwMDNBNiwwMDAwMDAwMDAwMDAwNEQ0LDAwMDAwMDAwLDAwMDAwMDAwXHJcbjwvZGl2Pgo8
ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj4KPGRp
dj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eRFNGTE9X
UlBUOjAwMDAwMDA0LDAwMDAwMDAwLDAwMDAwMDAwLDAwMDAwMDAwMDAwMDAzQTYsMDAwMDAwMDAw
MDAwMDRENCwwMDAwMDAwMCwwMDAwMDAwMFxyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9v
Zm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6cmVtb3ZlX2RldmljZSgpIC9zeXMvZGV2aWNlcy9w
bGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMS8yLTE6MS4wL3R0eVVTQjAvdHR5L3R0
eVVTQjA8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZu
Zy5jOmRlc3Ryb3lfbW9kZW0oKSAvc3lzL2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNk
LTEvdXNiMi8yLTE8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2Rl
bS5jOm9mb25vX21vZGVtX3JlbW92ZSgpIDB4NTU2ZWIzODA8L2Rpdj48ZGl2Pm9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm1vZGVtX3VucmVnaXN0ZXIoKSAweDU1NmViMzgw
PC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6bW9kZW1f
Y2hhbmdlX3N0YXRlKCkgb2xkIHN0YXRlOiAzLCBuZXcgc3RhdGU6IDA8L2Rpdj48ZGl2Pm9mb25v
ZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOmZsdXNoX2F0b21zKCmgPC9kaXY+PGRp
dj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbWVzc2FnZS13YWl0aW5nLmM6bXdfcmVt
b3ZlKCkgYXRvbTogMHg1NTZlNTk1MDwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L3NyYy9jYWxsLWJhcnJpbmcuYzpjYWxsX2JhcnJpbmdfcmVtb3ZlKCkgYXRvbTogMHg1NTZl
NTZiODwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2NhbGwtc2V0dGlu
Z3MuYzpjYWxsX3NldHRpbmdzX3JlbW92ZSgpIGF0b206IDB4NTU2ZTU1ZDA8L2Rpdj48ZGl2Pm9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9jYWxsLWZvcndhcmRpbmcuYzpjYWxsX2Zvcndh
cmRpbmdfcmVtb3ZlKCkgYXRvbTogMHg1NTZlNTRmODwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3NyYy91c3NkLmM6dXNzZF9yZW1vdmUoKSBhdG9tOiAweDU1NmU1NDM4PC9k
aXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOl9fb2Zvbm9f
bmV0cmVnX3JlbW92ZV9zdGF0dXNfd2F0Y2goKSAweDU1NmRjZjE4PC9kaXY+PGRpdj5vZm9ub2Rb
MzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvY2JzLmM6Y2JzX3JlbW92ZSgpIGF0b206IDB4NTU2ZTUy
Yzg8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0v
Z3Bycy1jb250ZXh0LmM6YXRfZ3Byc19kZXRhY2hfc2h1dGRvd24oKSBjaWQgMTwvZGl2PjxkaXY+
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3NpbV9yZW1vdmVfc3Bu
X3dhdGNoKCkgMHg1NTZkYzY2MDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
c3JjL25ldHdvcmsuYzpuZXRyZWdfcmVtb3ZlKCkgYXRvbTogMHg1NTZkZGI4ODwvZGl2Pgo8ZGl2
Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6Z3Byc19jb250ZXh0X3VucmVn
aXN0ZXIoKSAweDU1NmU0NmE4LCAweDU1NmRkODQwPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOmdwcnNfY29udGV4dF9yZW1vdmUoKSBhdG9tOiAweDU1NmU0
NmM4PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0v
Z3Bycy1jb250ZXh0LmM6YXRfZ3Byc19jb250ZXh0X3JlbW92ZSgpoDwvZGl2Pgo8ZGl2Pm9mb25v
ZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvYmx1ZXo1LmM6YnRfdW5yZWdpc3Rlcl9wcm9m
aWxlKCkgQmx1ZXRvb3RoOiBVbnJlZ2lzdGVyaW5nIHByb2ZpbGUgL2JsdWV0b290aC9wcm9maWxl
L2R1bl9ndzwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpn
cHJzX3VucmVnaXN0ZXIoKSAweDU1NmRkODQwPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9zcmMvZ3Bycy5jOmdwcnNfcmVtb3ZlKCkgYXRvbTogMHg1NTZkZDhhODwvZGl2Pgo8
ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvcHVzaC1ub3RpZmljYXRpb24u
YzpwdXNoX25vdGlmaWNhdGlvbl9jbGVhbnVwKCkgMHg1NTZkZjE5MDwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9zbWFydC1tZXNzYWdpbmcuYzpzbWFydF9tZXNz
YWdpbmdfY2xlYW51cCgpIDB4NTU2ZGYxNjA8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3NyYy9zbXMuYzpzbXNfcmVtb3ZlKCkgYXRvbTogMHg1NTZkZDc4MDwvZGl2Pgo8ZGl2
Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9yYWRpby1zZXR0aW5ncy5jOnJhZGlvX3Nl
dHRpbmdzX3JlbW92ZSgpIGF0b206IDB4NTU2ZGRiZjg8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3NyYy9waG9uZWJvb2suYzpwaG9uZWJvb2tfcmVtb3ZlKCkgYXRvbTogMHg1
NTZkZGIwODwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2F1ZGlvLXNl
dHRpbmdzLmM6YXVkaW9fc2V0dGluZ3NfcmVtb3ZlKCkgYXRvbTogMHg1NTZkZGEyODwvZGl2Pgo8
ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy92b2ljZWNhbGwuYzp2b2ljZWNhbGxf
cmVtb3ZlKCkgYXRvbTogMHg1NTZkNjhjODwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvcGx1Z2lucy9ibHVlejUuYzpidF91bnJlZ2lzdGVyX3Byb2ZpbGUoKSBCbHVldG9vdGg6
IFVucmVnaXN0ZXJpbmcgcHJvZmlsZSAvYmx1ZXRvb3RoL3Byb2ZpbGUvaGZwX2FnPC9kaXY+Cjxk
aXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOnNpbV9yZW1vdmUoKSBhdG9t
OiAweDU1NmRjNzg4PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9k
ZW0uYzpkZXZpbmZvX3JlbW92ZSgpIGF0b206IDB4NTU2ZGQwNzA8L2Rpdj48ZGl2Pm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6aHVhd2VpX2Rpc2FibGUoKSAweDU1
NmViMzgwPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3
ZWkuYzpodWF3ZWlfcmVtb3ZlKCkgMHg1NTZlYjM4MDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvc3JjL21vZGVtLmM6dW5yZWdpc3Rlcl9wcm9wZXJ0eSgpIHByb3BlcnR5IDB4
NTU2ZWIxMjg8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5j
OnVucmVnaXN0ZXJfcHJvcGVydHkoKSBwcm9wZXJ0eSAweDU1NmViMmIwPC9kaXY+CjxkaXY+b2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6dW5yZWdpc3Rlcl9wcm9wZXJ0eSgp
IHByb3BlcnR5IDB4NTU2ZWIxMDg8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3NyYy9tb2RlbS5jOnVucmVnaXN0ZXJfcHJvcGVydHkoKSBwcm9wZXJ0eSAweDU1NmViNDQwPC9k
aXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzp1bnJlZ2lzdGVy
X3Byb3BlcnR5KCkgcHJvcGVydHkgMHg1NTZlYjBkMDwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOmVtaXRfbW9kZW1fcmVtb3ZlZCgpIDB4NTU2ZWIzODA8
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOmNhbGxfbW9k
ZW13YXRjaGVzKCkgMHg1NTZlYjM4MCBhZGRlZDowPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9wbHVnaW5zL2hmcF9hZ19ibHVlejUuYzptb2RlbV93YXRjaCgpIG1vZGVtOiAw
eDU1NmViMzgwLCBhZGRlZDogMDwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3BsdWdpbnMvZHVuX2d3X2JsdWV6NS5jOm1vZGVtX3dhdGNoKCkgbW9kZW06IDB4NTU2ZWIzODAs
IGFkZGVkOiAwPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3Nt
YXJ0LW1lc3NhZ2luZy5jOm1vZGVtX3dhdGNoKCkgbW9kZW06IDB4NTU2ZWIzODAsIGFkZGVkOiAw
PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3B1c2gtbm90aWZp
Y2F0aW9uLmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg1NTZlYjM4MCwgYWRkZWQ6IDA8L2Rpdj4K
PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmRlc3Ryb3lf
bW9kZW0oKSAvZGV2L3R0eVVTQjA8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3BsdWdpbnMvdWRldm5nLmM6ZGVzdHJveV9tb2RlbSgpIC9kZXYvdHR5VVNCMTwvZGl2PjxkaXY+
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpkZXN0cm95X21vZGVt
KCkgL2Rldi90dHlVU0IyPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1
Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSB0dHkgcmVtb3ZlPC9kaXY+PGRpdj5v
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXYuYzpyZW1vdmVfbW9kZW0oKSAv
ZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMS8yLTE6MS4wL3R0eVVT
QjAvdHR5L3R0eVVTQjA8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVn
aW5zL3VkZXYuYzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSBmaW5pc2hlZDwvZGl2PjxkaXY+
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpyZW1vdmVfZGV2aWNl
KCkgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xLzItMTox
LjA8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldi5jOnVk
ZXZfZXZlbnQoKSBzdWJzeXN0ZW0gdHR5IHJlbW92ZTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldi5jOnJlbW92ZV9tb2RlbSgpIC9kZXZpY2VzL3BsYXRm
b3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xLzItMToxLjEvdHR5VVNCMS90dHkvdHR5VVNC
MTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2LmM6dWRl
dl9ldmVudCgpIHN1YnN5c3RlbSB0dHkgZmluaXNoZWQ8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOnJlbW92ZV9kZXZpY2UoKSAvc3lzL2Rldmlj
ZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTEvMi0xOjEuMS90dHlVU0IxL3R0
eS90dHlVU0IxPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3Vk
ZXYuYzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSByZW1vdmU8L2Rpdj4KPGRpdj5vZm9ub2Rb
MzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXYuYzpyZW1vdmVfbW9kZW0oKSAvZGV2aWNl
cy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMS8yLTE6MS4yL3R0eVVTQjIvdHR5
L3R0eVVTQjI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRl
di5jOnVkZXZfZXZlbnQoKSBzdWJzeXN0ZW0gdHR5IGZpbmlzaGVkPC9kaXY+CjxkaXY+b2Zvbm9k
WzMwOTQzXTogVW5yZWdpc3RlclByb2ZpbGUoKSByZXBsaWVkIGFuIGVycm9yOiBvcmcuZnJlZWRl
c2t0b3AuREJ1cy5FcnJvci5TcGF3bi5DaGlsZEV4aXRlZCwgTGF1bmNoIGhlbHBlciBleGl0ZWQg
d2l0aCB1bmtub3duIHJldHVybiBjb2RlIDE8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3BsdWdpbnMvdWRldm5nLmM6cmVtb3ZlX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wbGF0
Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMS8yLTE6MS4xPC9kaXY+CjxkaXY+b2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3Rl
bSBuZXQgcmVtb3ZlPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5z
L3VkZXYuYzpyZW1vdmVfbW9kZW0oKSAvZGV2aWNlcy92aXJ0dWFsL25ldC9wcHAwPC9kaXY+PGRp
dj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXYuYzp1ZGV2X2V2ZW50KCkg
c3Vic3lzdGVtIG5ldCBmaW5pc2hlZDwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L3BsdWdpbnMvdWRldm5nLmM6cmVtb3ZlX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wbGF0Zm9y
bS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMS8yLTE6MS4yL3R0eVVTQjIvdHR5L3R0eVVTQjI8
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6cmVt
b3ZlX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2Iy
LzItMS8yLTE6MS4yPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lu
cy91ZGV2bmcuYzpyZW1vdmVfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1l
aGNpLWhjZC0xL3VzYjIvMi0xPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9w
bHVnaW5zL3VkZXZuZy5jOnJlbW92ZV9kZXZpY2UoKSAvc3lzL2RldmljZXMvdmlydHVhbC9uZXQv
cHBwMDwvZGl2PjxkaXY+Cm9mb25vZFszMDk0M106IFVucmVnaXN0ZXJQcm9maWxlKCkgcmVwbGll
ZCBhbiBlcnJvcjogb3JnLmZyZWVkZXNrdG9wLkRCdXMuRXJyb3IuU3Bhd24uQ2hpbGRFeGl0ZWQs
IExhdW5jaCBoZWxwZXIgZXhpdGVkIHdpdGggdW5rbm93biByZXR1cm4gY29kZSAxPC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj48YnI+CjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNi
X2RldmljZSgpIHVzYiBbMTJkMToxZjAxXTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFsobnVsbCk6KG51
bGwpXTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcu
YzpyZW1vdmVfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0x
L3VzYjIvMi0xLzItMToxLjA8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9w
bHVnaW5zL3VkZXZuZy5jOnJlbW92ZV9kZXZpY2UoKSAvc3lzL2RldmljZXMvcGxhdGZvcm0vdGFu
Z294LWVoY2ktaGNkLTEvdXNiMi8yLTE8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfbW9kZW1fbGlzdCgpoDwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkg
dXNiIFsxMmQxOjEwMDFdPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1
Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgb3B0aW9uIFsobnVsbCk6KG51bGwpXTwv
ZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVj
a191c2JfZGV2aWNlKCkgb3B0aW9uIFsobnVsbCk6KG51bGwpXTwvZGl2PjxkaXY+b2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgb3B0
aW9uIFsobnVsbCk6KG51bGwpXTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3BsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBzdWJzeXN0ZW0gdHR5IGFkZDwvZGl2PjxkaXY+
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1
YnN5c3RlbSB0dHkgZmluaXNoZWQ8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbiBbMTJkMToxMDAxXTwv
ZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6YWRk
X2RldmljZSgpIC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzIt
MTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzph
ZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIv
Mi0xLzItMToxLjEvdHR5VVNCMS90dHkvdHR5VVNCMTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9kZXYvdHR5VVNCMSAo
aHVhd2VpKSAyNTUvMjU1LzI1NSBbMDFdID09Jmd0OyAobnVsbCkgKG51bGwpPC9kaXY+PGRpdj5v
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZp
Y2UoKSBvcHRpb24gWzEyZDE6MTAwMV08L2Rpdj48ZGl2PgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvc3lzL2RldmljZXMvcGxhdGZvcm0v
dGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTE8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3BsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wbGF0Zm9y
bS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMS8yLTE6MS4wL3R0eVVTQjAvdHR5L3R0eVVTQjA8
L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFk
ZF9kZXZpY2UoKSAvZGV2L3R0eVVTQjAgKGh1YXdlaSkgMjU1LzI1NS8yNTUgWzAwXSA9PSZndDsg
KG51bGwpIChudWxsKTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lu
cy91ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSB0dHkgYWRkPC9kaXY+PGRpdj5vZm9ub2Rb
MzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXYuYzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVt
IHR0eSBmaW5pc2hlZDwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdp
bnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbiBbMTJkMToxMDAxXTwvZGl2Pjxk
aXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNl
KCkgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xPC9kaXY+
PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZp
Y2UoKSAvc3lzL2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTEvMi0x
OjEuMi90dHlVU0IyL3R0eS90dHlVU0IyPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL2Rldi90dHlVU0IyIChodWF3ZWkp
IDI1NS8yNTUvMjU1IFswMl0gPT0mZ3Q7IChudWxsKSAobnVsbCk8L2Rpdj48ZGl2Pm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBzdWJzeXN0ZW0g
dHR5IGFkZDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2
LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSB0dHkgZmluaXNoZWQ8L2Rpdj4KPGRpdj5vZm9ub2Rb
MzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX21vZGVtX2xpc3QoKaA8
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y3Jl
YXRlX21vZGVtKCkgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIv
Mi0xPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5j
OmNyZWF0ZV9tb2RlbSgpIGRyaXZlcj1odWF3ZWk8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9jcmVhdGUoKSBuYW1lOiAobnVsbCks
IHR5cGU6IGh1YXdlaTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lu
cy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSAvc3lzL2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVo
Y2ktaGNkLTEvdXNiMi8yLTE8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3Bs
dWdpbnMvdWRldm5nLmM6c2V0dXBfaHVhd2VpKCkgL2Rldi90dHlVU0IwIDI1NS8yNTUvMjU1IDAw
IChudWxsKTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRl
dm5nLmM6c2V0dXBfaHVhd2VpKCkgL2Rldi90dHlVU0IxIDI1NS8yNTUvMjU1IDAxIChudWxsKTwv
ZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpzZXR1
cF9odWF3ZWkoKSAvZGV2L3R0eVVTQjIgMjU1LzI1NS8yNTUgMDIgKG51bGwpPC9kaXY+PGRpdj5v
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOnNldHVwX2h1YXdlaSgp
IG1kbT0vZGV2L3R0eVVTQjAgcGN1aT0vZGV2L3R0eVVTQjIgZGlhZz0obnVsbCkgcW1pPShudWxs
KSBuZXQ9KG51bGwpPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21v
ZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg1NTZkZDI4MCBwcm9wZXJ0eSBEZXZp
Y2U8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOnNldF9t
b2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4NTU2ZGQyODAgcHJvcGVydHkgTW9kZW08L2Rpdj48ZGl2
Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0
eSgpIG1vZGVtIDB4NTU2ZGQyODAgcHJvcGVydHkgUGN1aTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4
NTU2ZGQyODAgcHJvcGVydHkgRGlhZzwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg1NTZkZDI4MCBwcm9w
ZXJ0eSBOZXR3b3JrSW50ZXJmYWNlPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9yZWdpc3RlcigpIDB4NTU2ZGQyODA8L2Rpdj4KPGRp
dj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9wcm9i
ZSgpIDB4NTU2ZGQyODA8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9t
b2RlbS5jOmVtaXRfbW9kZW1fYWRkZWQoKSAweDU1NmRkMjgwPC9kaXY+PGRpdj5vZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpjYWxsX21vZGVtd2F0Y2hlcygpIDB4NTU2ZGQy
ODAgYWRkZWQ6MTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMv
aGZwX2FnX2JsdWV6NS5jOm1vZGVtX3dhdGNoKCkgbW9kZW06IDB4NTU2ZGQyODAsIGFkZGVkOiAx
PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2R1bl9nd19ibHVl
ejUuYzptb2RlbV93YXRjaCgpIG1vZGVtOiAweDU1NmRkMjgwLCBhZGRlZDogMTwvZGl2PjxkaXY+
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9zbWFydC1tZXNzYWdpbmcuYzptb2Rl
bV93YXRjaCgpIG1vZGVtOiAweDU1NmRkMjgwLCBhZGRlZDogMTwvZGl2Pgo8ZGl2Pm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvcHVzaC1ub3RpZmljYXRpb24uYzptb2RlbV93YXRj
aCgpIG1vZGVtOiAweDU1NmRkMjgwLCBhZGRlZDogMTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfZW5hYmxlKCkgMHg1NTZkZDI4MDwv
ZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6Z2V0X21vZGVt
X3Byb3BlcnR5KCkgbW9kZW0gMHg1NTZkZDI4MCBwcm9wZXJ0eSBNb2RlbTwvZGl2Pgo8ZGl2Pm9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6b3Blbl9kZXZpY2UoKSBN
b2RlbSAvZGV2L3R0eVVTQjA8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3Ny
Yy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4NTU2ZGQyODAgcHJvcGVydHkg
UGN1aTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWku
YzpvcGVuX2RldmljZSgpIFBjdWkgL2Rldi90dHlVU0IyPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQz
XTogUENVSTogJmd0OyBBVEUwICtDTUVFPTFccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENV
STogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFU
SVxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5NYW51ZmFjdHVyZXI6
IGh1YXdlaVxyXG5Nb2RlbDogRTMwM1xyXG5SZXZpc2lvbjogMjIuMzE4LjA1LjAwLjAwXHJcbklN
RUk6IDg2MjU2NjAyMDAwNTY5N1xyXG4rR0NBUDogK0NHU00sK0RTLCtFU1xyXG5cclxuT0tcclxu
PC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVF5SRlNXSVRDSD0/XHI8L2Rp
dj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbkVSUk9SXHJcbjwvZGl2PjxkaXY+
b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDRlVOPTFccjwvZGl2PjxkaXY+b2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmNmdW5fZW5hYmxlKCmgPC9kaXY+CjxkaXY+b2Zvbm9k
WzMwOTQzXTogUENVSTogJmd0OyBBVF5TWVNJTkZPXHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106
IFBDVUk6ICZsdDsgXHJcbl5TWVNJTkZPOjIsMywwLDUsMSwwLDRcclxuXHJcbk9LXHJcbjwvZGl2
PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpzeXNpbmZv
X2VuYWJsZV9jYigpIDI1NSAtJmd0OyAxPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
Z3Q7IEFUJmFtcDtDMFxyPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxu
T0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NTQ1M9JnF1b3Q7
R1NNJnF1b3Q7XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJc
bjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVF5VMkRJQUc/XHI8L2Rpdj48
ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbl5VMkRJQUc6IDExOVxyXG5cclxuT0tc
clxuPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVF5HRVRQT1JUTU9ERVxy
PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eR0VUUE9SVE1PREU6IFRZ
UEU6IFdDRE1BOiBodWF3ZWksXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVReVVNTRE1PREU9P1xyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmbHQ7IFxyXG5eVVNTRE1PREU6ICgwLTEpXHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXkRJQUxNT0RFPT9ccjwvZGl2PjxkaXY+b2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuXkRJQUxNT0RFOiAoMC0yKSwoMC0yNTUpXHJcblxyXG5PS1xy
XG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVReQ1ZPSUNFPT9ccjwvZGl2
PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuXkNWT0lDRTogKDApXHJcblxyXG5P
S1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NGVU49NVxyPC9k
aXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG5cclxuXlNSVlNUOiAw
XHJcblxyXG5eTU9ERTogMCwwXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvcGx1Z2lucy9odWF3ZWkuYzpjZnVuX29mZmxpbmUoKaA8L2Rpdj48ZGl2Pm9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm1vZGVtX2NoYW5nZV9zdGF0ZSgpIG9sZCBzdGF0
ZTogMCwgbmV3IHN0YXRlOiAxPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
cGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfcHJlX3NpbSgpIDB4NTU2ZGQyODA8L2Rpdj48ZGl2Pm9m
b25vZFszMDk0M106IFBDVUk6ICZndDsgQVReVVNTRE1PREU/XHI8L2Rpdj48ZGl2Pm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3N0YXRlX3dhdGNoKCkg
MHg1NTZlNzYyODwvZGl2PjxkaXY+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW0u
YzpvZm9ub19zaW1fYWRkX3N0YXRlX3dhdGNoKCkgMHg1NTZlNzYyODwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3NpbV9hZGRfc3RhdGVfd2F0Y2go
KSAweDU1NmU3NjI4PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eVVNT
RE1PREU6IDFcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZn
dDsgQVReRElBTE1PREU/XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJc
bl5ESUFMTU9ERTozLDJcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENV
STogJmd0OyBBVF5DVk9JQ0U/XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsg
XHJcbl5DVk9JQ0U6IDEsIDgwMDAsIDE2LCAyMFxyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zv
bm9kWzMwOTQzXTogVm9pY2UgY2hhbm5lbDogODAwMCBIeiwgMTYgYml0cywgMjBtcyBwZXJpb2Q8
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrR0NBUFxyPC9kaXY+PGRpdj5v
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rR0NBUDogK0NHU00sK0RTLCtFU1xyXG5cclxu
T0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDEy
MjU4LDAsMCwyNTVccjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitD
UlNNOiAxNDQsMCwmcXVvdDs2MjFDODIwMjQxMjE4MzAyMkZFMkE1MDM4MDAxNzE4QTAxMDU4QjAz
MkYwNjAzODAwMjAwMEE4ODAxMTAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19j
YigpIGNyc21faW5mb19jYjogOTAsIDAwLCAzMDwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBD
VUk6ICZndDsgQVReRERTRVRFWD0/XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbl5ERFNFVEVYOiAoMilcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQz
XTogUENVSTogJmd0OyBBVCtDR01JXHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbmh1YXdlaVxyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENV
STogJmd0OyBBVCtDUlNNPTE3NiwxMjI1OCwwLDAsMTBccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQz
XTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90Ozk4NTMwMzA1MDEwNzA4NTMwNUY2
JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkw
LCAwMCwgMTA8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltZnMu
YzpzaW1fZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9mZjogMCwgZGF0YW9mZjogMCwgdG9jb3B5
OiAxMDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDR01NXHI8L2Rpdj48
ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbkUzMDNcclxuXHJcbk9LXHJcbjwvZGl2
PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODQyMSwwLDAsMjU1
XHI8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAs
JnF1b3Q7NjIxQzgyMDI0MTIxODMwMjZGMDVBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwNDgwMDIw
MDBBODgwMTEwJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9v
Zm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2luZm9fY2IoKSBjcnNtX2lu
Zm9fY2I6IDkwLCAwMCwgMzA8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFU
K0NHTVJccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuMjIuMzE4LjA1
LjAwLjAwXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsg
QVQrQ1JTTT0xNzYsMjg0MjEsMCwwLDEwXHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6
ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDs2NTZFRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xy
XG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVy
cy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAx
MDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbWZzLmM6c2ltX2Zz
X29wX3JlYWRfYmxvY2tfY2IoKSBidWZvZmY6IDAsIGRhdGFvZmY6IDAsIHRvY29weTogMTA8L2Rp
dj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0dTTlxyPC9kaXY+CjxkaXY+b2Zv
bm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuODYyNTY2MDIwMDA1Njk3XHJcblxyXG5PS1xyXG48
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMTIwMzcsMCww
LDI1NVxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0
LDAsJnF1b3Q7NjIxQzgyMDI0MTIxODMwMjJGMDVBNTAzODAwMTcxOEEwMTA1OEIwMzJGMDYwNDgw
MDIwMDBBODgwMTI4JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkgY3Jz
bV9pbmZvX2NiOiA5MCwgMDAsIDMwPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7
IEFUK0NSU009MTc2LDEyMDM3LDAsMCwxMFxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7NjU2RUZGRkZGRkZGRkZGRkZGRkYmcXVvdDtc
clxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZl
cnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwg
MTA8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW1mcy5jOnNpbV9m
c19vcF9yZWFkX2Jsb2NrX2NiKCkgYnVmb2ZmOiAwLCBkYXRhb2ZmOiAwLCB0b2NvcHk6IDEwPC9k
aXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NQSU4/XHI8L2Rpdj4KPGRpdj5v
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1BJTjogUkVBRFlcclxuXHJcbk9LXHJcbjwv
ZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5j
OmF0X2NwaW5fY2IoKSBjcnNtX3Bpbl9jYjogUkVBRFk8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9waW5fcmV0cmllc19xdWVyeSgp
oDwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVReQ1BJTj9ccjwvZGl2Pjxk
aXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuXkNQSU46IFJFQURZLCwxMCwzLDEwLDNc
clxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVy
cy9hdG1vZGVtL3NpbS5jOmh1YXdlaV9jcGluX2NiKCkgcmV0cnkgY291bnRlciBpZD05LCB2YWw9
MTA8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0v
c2ltLmM6aHVhd2VpX2NwaW5fY2IoKSByZXRyeSBjb3VudGVyIGlkPTEsIHZhbD0zPC9kaXY+PGRp
dj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6aHVhd2Vp
X2NwaW5fY2IoKSByZXRyeSBjb3VudGVyIGlkPTExLCB2YWw9MTA8L2Rpdj48ZGl2Pm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzpodWF3ZWlfY3Bpbl9jYigp
IHJldHJ5IGNvdW50ZXIgaWQ9NCwgdmFsPTM8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmZ3Q7IEFUK0NSU009MTkyLDI4NTkwLDAsMCwyNTVccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQz
XTogUENVSTogJmx0OyBcclxuK0NSU006IDEwNiwxMzAsJnF1b3Q7JnF1b3Q7XHJcblxyXG5PS1xy
XG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg1ODks
MCwwLDI1NVxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTog
MTQ0LDAsJnF1b3Q7NjIxQzgyMDI0MTIxODMwMjZGQURBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYw
NjgwMDIwMDA0ODgwMTE4JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkg
Y3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMwPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
Z3Q7IEFUK0NSU009MTc2LDI4NTg5LDAsMCw0XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBD
VUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMDAwMDAwMiZxdW90O1xyXG5cclxuT0tc
clxuPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCA0PC9kaXY+PGRp
dj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9i
bG9ja19jYigpIGJ1Zm9mZjogMCwgZGF0YW9mZjogMCwgdG9jb3B5OiA0PC9kaXY+PGRpdj5vZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NDM4LDAsMCwyNTVccjwvZGl2Pgo8
ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxMDYsMTMwLCZxdW90OyZx
dW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFU
K0NSU009MTkyLDI4NDcyLDAsMCwyNTVccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTog
Jmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzYyMUM4MjAyNDEyMTgzMDI2RjM4QTUwMzgwMDE3
MThBMDEwNThCMDM2RjA2MDI4MDAyMDAwQTg4MDEyMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+
CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0
X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAzMDwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3NiwyODQ3MiwwLDAsMTBccjwvZGl2PjxkaXY+
b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzdFRUUxMTFD
MjdGNjU5MDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3Jz
bV9yZWFkX2NiOiA5MCwgMDAsIDEwPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9zcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9mZjogMCwgZGF0YW9m
ZjogMCwgdG9jb3B5OiAxMDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtD
UlNNPTE5MiwyODUwMiwwLDAsMjU1XHI8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
bHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7NjIxQzgyMDI0MTIxODMwMjZGNTZBNTAzODAwMTcx
OEEwMTA1OEIwMzZGMDYwNzgwMDIwMDAxODgwMTI4JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48
ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9j
cnNtX2luZm9fY2IoKSBjcnNtX2luZm9fY2I6IDkwLCAwMCwgMzA8L2Rpdj4KPGRpdj5vZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc2LDI4NTAyLDAsMCwxXHI8L2Rpdj48ZGl2Pm9m
b25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMCZxdW90O1xy
XG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJz
L2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDE8
L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltZnMuYzpzaW1fZnNf
b3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9mZjogMCwgZGF0YW9mZjogMCwgdG9jb3B5OiAxPC9kaXY+
PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NJTUlccjwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogUENVSTogJmx0OyBcclxuMjcyMDUwMTAwNDEzNTgwXHJcblxyXG5PS1xyXG48L2Rp
dj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6
YXRfY2ltaV9jYigpIGNpbWlfY2I6IDI3MjA1MDEwMDQxMzU4MDwvZGl2PjxkaXY+b2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6bW9kZW1fY2hhbmdlX3N0YXRlKCkgb2xkIHN0
YXRlOiAxLCBuZXcgc3RhdGU6IDI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3BsdWdpbnMvaHVhd2VpLmM6aHVhd2VpX3Bvc3Rfc2ltKCkgMHg1NTZkZDI4MDwvZGl2Pgo8ZGl2
Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQu
YzphdF9ncHJzX2NvbnRleHRfcHJvYmUoKaA8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3NyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4NTU2ZGQyODAg
cHJvcGVydHkgQWx3YXlzT25saW5lPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7
IEFUK0NSQz0xXHI8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xy
XG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0xJUD0xXHI8L2Rpdj48
ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogUENVSTogJmd0OyBBVCtDT0xQPTFccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg1NTZk
ZDI4MCBwcm9wZXJ0eSBBbHdheXNPbmxpbmU8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9zZXRfb25saW5lKCkgbW9kZW0gMHg1NTZk
ZDI4MCBvbmxpbmU8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJc
bjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDQ1dBPTFccjwvZGl2Pjxk
aXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9odWF3ZWltb2RlbS92b2ljZWNhbGwuYzpodWF3
ZWlfdm9pY2VjYWxsX2luaXRpYWxpemVkKCkgcmVnaXN0ZXJpbmcgdG8gbm90aWZpY2F0aW9uczwv
ZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3NpbV9h
ZGRfc3RhdGVfd2F0Y2goKSAweDU1NmU3NjI4PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9wbHVnaW5zL2JsdWV6NS5jOmJ0X3JlZ2lzdGVyX3Byb2ZpbGUoKSBCbHVldG9vdGg6
IFJlZ2lzdGVyaW5nIDAwMDAxMTFmLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYiAoaGZwX2Fn
KSBwcm9maWxlPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVF5DVk9JQ0U9
P1xyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eQ1ZPSUNFOiAoMClc
clxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDU0NT
PT9ccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NTQ1M6ICgmcXVv
dDtJUkEmcXVvdDssJnF1b3Q7VUNTMiZxdW90OywmcXVvdDtHU00mcXVvdDspXHJcblxyXG5PS1xy
XG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXlNZU0NGRz0/XHI8L2Rp
dj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbl5TWVNDRkc6ICgyLDEzLDE0LDE2
KSwoMC0zKSwoKDIwMDAwMDA0MDAzODAsJnF1b3Q7R1NNOTAwL0dTTTE4MDAvV0NETUE5MDAvV0NE
TUEyMTAwJnF1b3Q7KSwoMjgwMDAwLCZxdW90O0dTTTg1MC9HU00xOTAwJnF1b3Q7KSwoM2ZmZmZm
ZmYsJnF1b3Q7QWxsIGJhbmRzJnF1b3Q7KSksKDAtMiksKDAtNClcclxuXHJcbk9LXHJcbjwvZGl2
Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1NNUz0/XHI8L2Rpdj48ZGl2Pm9m
b25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDU01TOiAoMCwxKVxyXG5cclxuT0tcclxuPC9k
aXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc21zLmM6
YXRfY3Ntc19xdWVyeV9jYigpIENTTVMgcXVlcnkgcGFyc2VkIHN1Y2Nlc3NmdWxseTwvZGl2Pgo8
ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0dEQ09OVD0/XHI8L2Rpdj48ZGl2Pm9m
b25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDR0RDT05UOiAoMS0xMSksJnF1b3Q7SVAmcXVv
dDssLCwoMC0yKSwoMC0zKSwoMCwxKSwoMCwxKVxyXG4rQ0dEQ09OVDogKDEtMTEpLCZxdW90O1BQ
UCZxdW90OywsLCgwLTIpLCgwLTMpLCgwLDEpLCgwLDEpXHJcblxyXG5cclxuT0tcclxuPC9kaXY+
CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODQ4MCwwLDAsMjU1
XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwm
cXVvdDs2MjFFODIwNTQyMjEwMDIyMDY4MzAyNkY0MEE1MDM4MDAxNzE4QTAxMDU4QjAzNkYwNjA1
ODAwMjAwQ0M4ODAwJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2luZm9fY2IoKSBjcnNt
X2luZm9fY2I6IDkwLCAwMCwgMzI8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7
IEFUK0NGVU49MVxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBSZWdpc3RlclByb2ZpbGUoKSBy
ZXBsaWVkIGFuIGVycm9yOiBvcmcuZnJlZWRlc2t0b3AuREJ1cy5FcnJvci5TcGF3bi5DaGlsZEV4
aXRlZCwgTGF1bmNoIGhlbHBlciBleGl0ZWQgd2l0aCB1bmtub3duIHJldHVybiBjb2RlIDE8L2Rp
dj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbl5TSU1TVDowLDBcclxuPC9kaXY+
CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpzaW1zdF9u
b3RpZnkoKSAxIC0mZ3Q7IDA8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJc
bk9LXHJcblxyXG5eU0lNU1Q6MSwwXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpzaW1zdF9ub3RpZnkoKSAwIC0mZ3Q7IDE8L2Rpdj4KPGRp
dj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NQQlM9P1xyPC9kaXY+PGRpdj5vZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1BCUzogKCZxdW90O1NNJnF1b3Q7LCZxdW90O0VOJnF1
b3Q7LCZxdW90O09OJnF1b3Q7LCZxdW90O0ZEJnF1b3Q7KVxyXG5cclxuT0tcclxuPC9kaXY+PGRp
dj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NTTVM9MVxyPC9kaXY+PGRpdj4Kb2Zvbm9k
WzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NTTVM6IDEsMSwxXHJcblxyXG5PS1xyXG48L2Rpdj48
ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0dSRUc9P1xyPC9kaXY+PGRpdj5vZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ0dSRUc6ICgwLTIpXHJcblxyXG5PS1xyXG48L2Rp
dj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg0ODAsMSw0LDM0
XHI8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAs
JnF1b3Q7NEQ3OTIwNEU3NTZENjI2NTcyRkZGRkZGRkZGRkZGRkZGRkZGRkZGRjA3OTE1MzgzMTM5
Nzc4NDhGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigp
IGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6
ICZndDsgQVReU1lTSU5GT1xyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxy
XG5eU1lTSU5GTzowLDMsMCwwLDEsMCwwXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6c3lzaW5mb19vbmxpbmVfY2IoKSAx
IC0mZ3Q7IDE8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5j
Om1vZGVtX2NoYW5nZV9zdGF0ZSgpIG9sZCBzdGF0ZTogMiwgbmV3IHN0YXRlOiAzPC9kaXY+Cjxk
aXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfcG9z
dF9vbmxpbmUoKSAweDU1NmRkMjgwPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7
IEFUK0NTTVM/XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDU01T
OiAxLDEsMSwxXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZn
dDsgQVQrQ0dSRUc9MlxyPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxu
T0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NHQVVUTz0wXHI8
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2PjxkaXY+
b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDR0VSRVA9MiwxXHI8L2Rpdj48ZGl2Pm9mb25v
ZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbkVSUk9SXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3BsdWdpbnMvYmx1ZXo1LmM6YnRfcmVnaXN0ZXJfcHJvZmlsZSgpIEJs
dWV0b290aDogUmVnaXN0ZXJpbmcgMDAwMDExMDMtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZi
IChkdW5fZ3cpIHByb2ZpbGU8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQr
Q1JTTT0xNzgsMjg0ODAsMiw0LDM0XHI8L2Rpdj48ZGl2PgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
bHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJc
bjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3Np
bS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDwvZGl2Pgo8ZGl2
Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JFRz0/XHI8L2Rpdj48ZGl2Pm9mb25vZFsz
MDk0M106IFBDVUk6ICZsdDsgXHJcbitDUkVHOiAoMC0yKVxyXG5cclxuT0tcclxuPC9kaXY+PGRp
dj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NTQ0I9P1xyPC9kaXY+PGRpdj5vZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1NDQjooMCwxKVxyXG5cclxuT0tcclxuPC9kaXY+Cjxk
aXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDVVNEPTFccjwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBS
ZWdpc3RlclByb2ZpbGUoKSByZXBsaWVkIGFuIGVycm9yOiBvcmcuZnJlZWRlc2t0b3AuREJ1cy5F
cnJvci5TcGF3bi5DaGlsZEV4aXRlZCwgTGF1bmNoIGhlbHBlciBleGl0ZWQgd2l0aCB1bmtub3du
IHJldHVybiBjb2RlIDE8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NN
R0Y9P1xyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ01HRjogKDAs
MSlcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtD
UlNNPTE3OCwyODQ4MCwzLDQsMzRccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0
OyBcclxuK0NSU006IDE0NCwwLCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48
L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2lt
LmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PC9kaXY+PGRpdj5v
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSRUc9MlxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3Nwbl93YXRjaCgpIDB4NTU2ZTc2Mjg8L2Rp
dj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOl9fb2Zvbm9f
bmV0cmVnX2FkZF9zdGF0dXNfd2F0Y2goKSAweDU1NmU3MGQ4PC9kaXY+PGRpdj5vZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NTQ0I9MFxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmbHQ7IFxyXG5eTU9ERTogNSw0XHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTog
Jmx0OyBcclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3Jj
L2Nicy5jOmNic19nb3RfaW1zaSgpIEdvdCBJTVNJOiAyNzIwNTAxMDA0MTM1ODA8L2Rpdj48ZGl2
Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6X19vZm9ub19uZXRyZWdf
YWRkX3N0YXR1c193YXRjaCgpIDB4NTU2ZTcwZDg8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBD
VUk6ICZndDsgQVQrQ1BNUz0/XHI8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7
IFxyXG4rQ1BNUzogKCZxdW90O1NNJnF1b3Q7LCZxdW90O01FJnF1b3Q7KSwoJnF1b3Q7U00mcXVv
dDssJnF1b3Q7TUUmcXVvdDspLCgmcXVvdDtTTSZxdW90OywmcXVvdDtNRSZxdW90OylcclxuXHJc
bk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwy
ODQ4MCw0LDQsMzRccjwvZGl2PjxkaXY+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitD
UlNNOiAxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRp
dj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3Jz
bV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PC9kaXY+CjxkaXY+b2Zvbm9kWzMw
OTQzXTogUENVSTogJmd0OyBBVCtDUkVHP1xyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1JFRzogMiwyXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0YXR1c19ub3RpZnko
KSAvaHVhd2VpXzEgc3RhdHVzIDIgdGVjaCAtMTwvZGl2PjxkaXY+Cm9mb25vZFszMDk0M106IC9v
Zm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6Y3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaygpIDB4NTU2
ZTcwZDgsIChuaWwpPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvY2Jz
LmM6Y2JzX2xvY2F0aW9uX2NoYW5nZWQoKSAyLCAtMSwgLTEsIC0xLCAobnVsbCkobnVsbCk8L2Rp
dj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6bmV0cmVnX3N0YXR1
c19jaGFuZ2VkKCkgMjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ01H
Rj0wXHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2
PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODQ4MCw1LDQsMzRc
cjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZx
dW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkg
Y3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
Z3Q7IEFUK0NQTVM9JnF1b3Q7TUUmcXVvdDssJnF1b3Q7TUUmcXVvdDssJnF1b3Q7TUUmcXVvdDtc
cjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NQTVM6IDAsMjAsMCwy
MCwwLDIwXHJcblxyXG5PS1xyXG5cclxuXlJTU0k6IDEzXHJcblxyXG5eSENTUTomcXVvdDtXQ0RN
QSZxdW90Oyw0MCwzNCw1M1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7
IEFUK0NSU009MTc4LDI4NDgwLDYsNCwzNFxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9L
XHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDwvZGl2Pgo8
ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ05NST0/XHI8L2Rpdj48ZGl2Pm9mb25v
ZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDTk1JOiAoMC0yKSwoMC0zKSwoMCwyKSwoMC0yKSwo
MCwxKVxyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9k
cml2ZXJzL2F0bW9kZW0vc21zLmM6YnVpbGRfY25taV9zdHJpbmcoKaA8L2Rpdj48ZGl2PgpvZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NOTUk9MSwxLDIsMSwwXHI8L2Rpdj48ZGl2Pm9mb25v
ZFszMDk0M106IER1cGxpY2F0ZSBFRnNkbiBlbnRyaWVzIGZvciBgRW1lcmdlbmN5IFNlcnZpY2Vz
JiMzOTs8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2
PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpfX29mb25vX25l
dHJlZ19hZGRfc3RhdHVzX3dhdGNoKCkgMHg1NTZlNzBkODwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3NyYy9zbXMuYzpzbXNfcmVzdG9yZV90eF9xdWV1ZSgpoDwvZGl2Pjxk
aXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9wdXNoLW5vdGlmaWNhdGlvbi5j
OnNtc193YXRjaCgpIHJlZ2lzdGVyZWQ8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L3BsdWdpbnMvc21hcnQtbWVzc2FnaW5nLmM6c21zX3dhdGNoKCkgcmVnaXN0ZXJlZDwvZGl2
Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg2MTgsMCwwLDI1
NVxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAs
JnF1b3Q7NjIxRTgyMDU0MjIxMDAwNjA1ODMwMjZGQ0FBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYw
NTgwMDIwMDFFODgwMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkgY3Jz
bV9pbmZvX2NiOiA5MCwgMDAsIDMyPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0
OyBBVCtDTUdMPTRccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuT0tc
clxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0v
c21zLmM6YXRfY21nbF9kb25lKCmgPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7
IEFUK0NHU01TPTNccjwvZGl2PjxkaXY+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9L
XHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYx
OCwxLDQsNlxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTog
MTQ0LDAsJnF1b3Q7MDAwMDAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3Jl
YWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgNjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTgsMiw0LDZccjwvZGl2PjxkaXY+b2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAwMDAwMDAwMDAwMCZxdW90
O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2
ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAs
IDY8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE4
LDMsNCw2XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAx
NDQsMCwmcXVvdDswMDAwMDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVh
ZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCA2PC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTog
UENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxOCw0LDQsNlxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDAwMDAwJnF1b3Q7
XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZl
cnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwg
NjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTgs
NSw0LDZccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0
NCwwLCZxdW90OzAwMDAwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFk
X2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDY8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NjE3LDAsMCwyNTVccjwvZGl2PjxkaXY+b2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzYyMUU4MjA1NDIyMTAwMDUw
NTgzMDI2RkM5QTUwMzgwMDE3MThBMDEwNThCMDM2RjA2MDI4MDAyMDAxOTg4MDAmcXVvdDtcclxu
XHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9h
dG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAzMjwv
ZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTcsMSw0
LDVccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCww
LCZxdW90OzAxMDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigp
IGNyc21fcmVhZF9jYjogOTAsIDAwLCA1PC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTog
Jmd0OyBBVCtDUlNNPTE3OCwyODYxNywyLDQsNVxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDEwMDAwMDAwMCZxdW90O1xyXG5cclxu
T0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9k
ZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDU8L2Rpdj4K
PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE3LDMsNCw1XHI8
L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVv
dDswMTAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNt
X3JlYWRfY2I6IDkwLCAwMCwgNTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsg
QVQrQ1JTTT0xNzgsMjg2MTcsNCw0LDVccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTog
Jmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAxMDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJc
bjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3Np
bS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCA1PC9kaXY+CjxkaXY+
b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNyw1LDQsNVxyPC9kaXY+
PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDEw
MDAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFk
X2NiOiA5MCwgMDAsIDU8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NS
U009MTkyLDI4NDMzLDAsMCwyNTVccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0
OyBcclxuK0NSU006IDEwNiwxMzAsJnF1b3Q7JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2
Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tZXNzYWdlLXdhaXRpbmcuYzptd19jcGhz
X213aXNfcmVhZF9jYigpIE5vIENQSFMgTVdJUyBvbiBTSU08L2Rpdj4KPGRpdj5vZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NjE5LDAsMCwyNTVccjwvZGl2PjxkaXY+b2Zv
bm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzYyMUU4MjA1NDIy
MTAwMTAwNTgzMDI2RkNCQTUwMzgwMDE3MThBMDEwNThCMDM2RjA2MDU4MDAyMDA1MDg4MDAmcXVv
dDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJp
dmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAw
LCAzMjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2
MTksMSw0LDE2XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNN
OiAxNDQsMCwmcXVvdDtGRjAwRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5c
clxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0
bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDE2PC9k
aXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxOSwyLDQs
MTZccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCww
LCZxdW90O0ZGMDBGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xy
XG48L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9z
aW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTY8L2Rpdj4KPGRp
dj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE5LDMsNCwxNlxyPC9k
aXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7
RkYwMEZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2
PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0
X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAxNjwvZGl2Pgo8ZGl2Pm9mb25v
ZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTksNCw0LDE2XHI8L2Rpdj48ZGl2
Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDtGRjAwRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5v
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9y
ZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDE2PC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQz
XTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxOSw1LDQsMTZccjwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90O0ZGMDBGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2Io
KSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTY8L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9zcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9jaygpIGJ1Zm9mZjogMCwgc2Vl
a29mZjogMzksIHRvcmVhZDogMTc8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3NyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrKCkgYnVmb2ZmOiAwLCBzZWVrb2ZmOiAz
OSwgdG9yZWFkOiAxMDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVy
cy9hdG1vZGVtL2Nicy5jOmF0X2Nic19zZXRfdG9waWNzKCmgPC9kaXY+CjxkaXY+b2Zvbm9kWzMw
OTQzXTogUENVSTogJmd0OyBBVCtDU0NCPTBccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENV
STogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFU
K0NTQ0I9MCwmcXVvdDswLDUwLDIxNCw0MzUyLTQzNTYmcXVvdDtccjwvZGl2PjxkaXY+b2Zvbm9k
WzMwOTQzXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTog
UENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODQzNywwLDAsMjU1XHI8L2Rpdj48ZGl2Pm9mb25vZFsz
MDk0M106IFBDVUk6ICZsdDsgXHJcbl5TUlZTVDogMlxyXG5cclxuK0NHUkVHOiAxLCZxdW90OzAw
NDAmcXVvdDssJnF1b3Q7MDJDMTAxNzgmcXVvdDtcclxuXHJcbitDUlNNOiAxMDYsMTMwLCZxdW90
OyZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX3N0YXR1c19ub3RpZnkoKSAvaHVhd2VpXzEgc3RhdHVz
IDE8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg2MTUs
MCwwLDI1NVxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTog
MTQ0LDAsJnF1b3Q7NjIxRTgyMDU0MjIxMDAyMjA1ODMwMjZGQzdBNTAzODAwMTcxOEEwMTA1OEIw
MzZGMDYwMjgwMDIwMEFBODgwMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19j
YigpIGNyc21faW5mb19jYjogOTAsIDAwLCAzMjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENV
STogJmd0OyBBVCtDUlNNPTE3OCwyODYxNSwxLDQsMzRccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQz
XTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzRENjE2OTZDRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkYwNzkxNTM4MzMzMzMxMzE3RkZGRkZGRkZGRkZGJnF1b3Q7XHJc
blxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJz
L2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0
PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE1LDIs
NCwzNFxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0
LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25v
ZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRf
Y2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBD
VUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTUsMyw0LDM0XHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0
M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xy
XG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVy
cy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAz
NDwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNSw0
LDQsMzRccjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0
NCwwLCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFk
X2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE1LDUsNCwzNFxyPC9kaXY+PGRpdj5vZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtc
clxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZl
cnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwg
MzQ8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUkVHOiAxLCZxdW90
OzAwNDAmcXVvdDssJnF1b3Q7MDJDMTAxNzgmcXVvdDtcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19zdGF0dXNfbm90aWZ5
KCkgL2h1YXdlaV8xIHN0YXR1cyAxIHRlY2ggMjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9v
Zm9uby0xLjE0L3NyYy9jYnMuYzpjYnNfbG9jYXRpb25fY2hhbmdlZCgpIDEsIC0xLCAtMSwgMiwg
KG51bGwpKG51bGwpPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3By
cy5jOm5ldHJlZ19zdGF0dXNfY2hhbmdlZCgpIDE8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IFBD
VUk6ICZndDsgQVQrQ09QUz0zLDJccjwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDT1BT
P1xyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ09QUzogMCwyLCZx
dW90OzI3MjA1JnF1b3Q7LDJcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmM6Y29wc19u
dW1lcmljX2NiKCkgQ29wcyBudW1lcmljIGdvdCBtY2M6IDI3MiwgbW5jOiAwNTwvZGl2Pgo8ZGl2
Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1NRXHI8L2Rpdj48ZGl2Pm9mb25vZFszMDk0
M106IFBDVUk6ICZsdDsgXHJcbitDU1E6IDEzLDk5XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9uZXR3b3JrLXJlZ2lzdHJh
dGlvbi5jOmNzcV9jYigpIGNzcV9jYjogMTM8L2Rpdj48ZGl2Pm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0cmVuZ3RoX25vdGlmeSgpIHN0cmVu
Z3RoIDQxPC9kaXY+CjxkaXY+b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDT1BTPTMsMFxy
PC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj48ZGl2
Pm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ09QUz9ccjwvZGl2PjxkaXY+b2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuK0NPUFM6IDAsMCwmcXVvdDszIElSTCZxdW90OywyXHJcblxy
XG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0
bW9kZW0vbmV0d29yay1yZWdpc3RyYXRpb24uYzpjb3BzX2NiKCkgY29wc19jYjogMyBJUkwsIDI3
MiAwNSAyPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5j
OmN1cnJlbnRfb3BlcmF0b3JfY2FsbGJhY2soKSAweDU1NmU3MGQ4LCAobmlsKTwvZGl2PjxkaXY+
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2Nicy5jOmNic19sb2NhdGlvbl9jaGFuZ2Vk
KCkgMSwgLTEsIC0xLCAyLCAyNzIwNTwvZGl2Pgo8ZGl2Pm9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L3NyYy9jYnMuYzpjYnNfbG9jYXRpb25fY2hhbmdlZCgpIDEsIDAsIDA8L2Rpdj48ZGl2Pm9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6bmV0cmVnX3N0YXR1c19jaGFuZ2Vk
KCkgMTwvZGl2PjxkaXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVt
L2dwcnMtY29udGV4dC5jOmF0X2dwcnNfYWN0aXZhdGVfcHJpbWFyeSgpIGNpZCAxPC9kaXY+Cjxk
aXY+b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpwcmlfYWN0aXZhdGVfY2Fs
bGJhY2soKSAweDU1NmViMDcwPC9kaXY+PGRpdj5vZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9z
cmMvZ3Bycy5jOnByaV9hY3RpdmF0ZV9jYWxsYmFjaygpIEFjdGl2YXRpbmcgY29udGV4dCBmYWls
ZWQgd2l0aCBlcnJvcjogVW5rbm93biBlcnJvciB0eXBlPC9kaXY+PC9kaXY+PGRpdj4KPGJyPjwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxzcGFuPjwv
c3Bhbj48c3Bhbj48L3NwYW4+PGJyPjxkaXY+PGJyPjwvZGl2PjwvZGl2Pgo8L2Rpdj4K

--===============2479271357265424958==--

