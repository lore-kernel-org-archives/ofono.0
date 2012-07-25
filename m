Content-Type: multipart/mixed; boundary="===============5368885901876749815=="
MIME-Version: 1.0
From: Andrea Galbusera <gizero@gmail.com>
Subject: Testing Telit GT864-3G compatibility with ofono
Date: Wed, 25 Jul 2012 14:50:38 +0200
Message-ID: <CAC+thW2AnS0U5CGst4CiBfpbY5LZq=RX0-wKBmnmjbxwOkQWNQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5368885901876749815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm doing some tests with Telit GT864-3G terminal connected to USB with
ofono 1.9. This modem uses UC864-E core. Since ofono provides a driver for
UC864-G core, I hope managing it with ofono should be quite
straightforward. One difference between the two cores is that UC864-G does
expose 4 serial devices: after a quick fix I got "modem" and "aux" channel
correctly assigned. The problem I see here when I run enable-modem is ofono
getting stuck after trying to check PIN authentication state: note that the
sim I use is pin-unlocked and I tried with sims by two different italian
providers.
Looking closer at the logs, attached below, it seems the problem relates
with calls to +CRSM always returning error. I suspect one of those commands
or maybe the timing they are executed with, is messing up the modem, since
+CPIN? returns with success before the sequence of +CRSM and
sistematiccally fails after that (modem reboot required to recover).

Is anybody having similar behaviour with Telit modems? Any suggestion how
to workaround or closer debug this issue?

Regards,
Andrea

Here is the log:

$ sudo OFONO_AT_DEBUG=3Dy /home/gizero/local/sbin/ofonod -n -d

ofonod[5812]: oFono version 1.9
ofonod[5812]: src/plugin.c:__ofono_plugin_init()
ofonod[5812]: plugins/push-notification.c:push_notification_init()
ofonod[5812]: plugins/smart-messaging.c:smart_messaging_init()
ofonod[5812]: examples/emulator.c:example_emulator_init()
ofonod[5812]: src/gprs-provision.c:ofono_gprs_provision_driver_register()
driver: 0x818fa80 name: Example GPRS context provisioning
ofonod[5812]: src/nettime.c:ofono_nettime_driver_register() driver:
0x818fa40 name: Example Network Time
ofonod[5812]: src/history.c:ofono_history_driver_register() driver:
0x818fa00 name: Example Call History
ofonod[5812]: src/cdma-provision.c:ofono_cdma_provision_driver_register()
driver: 0x818f9c0 name: CDMA provisioning
ofonod[5812]: src/gprs-provision.c:ofono_gprs_provision_driver_register()
driver: 0x818f980 name: Provisioning
ofonod[5812]: plugins/connman.c:connman_init()
ofonod[5812]: src/private-network.c:ofono_private_network_driver_register()
driver: 0x818f940, name: ConnMan Private Network
ofonod[5812]: plugins/dun_gw.c:dun_gw_init()
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f880,
name: hfp
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f820,
name: sap
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f7a0,
name: telit
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f700,
name: sim900
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f6a0,
name: samsung
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f640,
name: speedupcdma
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f5e0,
name: speedup
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f580,
name: alcatel
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f520,
name: icera
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f4c0,
name: linktop
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f460,
name: nokiacdma
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f400,
name: nokia
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f3a0,
name: tc65
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f300,
name: ste
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f2a0,
name: ifx
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f240,
name: palmpre
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f1e0,
name: novatel
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f180,
name: sierra
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f100,
name: huawei
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f0a0,
name: zte
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f040,
name: hso
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818efe0,
name: mbm
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818ef80,
name: calypso
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818ef20,
name: wavecom
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818eec0,
name: g1
ofonod[5812]: src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register()
driver: 0x818ee40, name: cdmamodem
ofonod[5812]: src/modem.c:ofono_devinfo_driver_register() driver:
0x818ee60, name: cdmamodem
ofonod[5812]: src/cdma-connman.c:ofono_cdma_connman_driver_register()
driver: 0x818ee84, name: cdmamodem
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818eda0,
name: phonesim
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818ede0,
name: localhfp
ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x818ed74, name: phonesim
ofonod[5812]: src/ctm.c:ofono_ctm_driver_register() driver: 0x818ed60,
name: phonesim
ofonod[5812]: plugins/phonesim.c:parse_config() filename
/home/gizero/local/etc/ofono/phonesim.conf
ofonod[5812]: src/ussd.c:ofono_ussd_driver_register() driver: 0x818ed20,
name: speedupmodem
ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x818ec00, name: hfpmodem
ofonod[5812]: src/modem.c:ofono_devinfo_driver_register() driver:
0x818ecbc, name: hfpmodem
ofonod[5812]: src/network.c:ofono_netreg_driver_register() driver:
0x818ec60, name: hfpmodem
ofonod[5812]: src/call-volume.c:ofono_call_volume_driver_register() driver:
0x818ec94, name: hfpmodem
ofonod[5812]: src/handsfree.c:ofono_handsfree_driver_register() driver:
0x818ecd8, name: hfpmodem
ofonod[5812]: src/network.c:ofono_netreg_driver_register() driver:
0x818eb80, name: dunmodem
ofonod[5812]: src/gprs.c:ofono_gprs_driver_register() driver: 0x818ebac,
name: dunmodem
ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x818eaa0, name: stemodem
ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x818eb2c, name: stemodem
ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x818eb00, name: stemodem
ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x818e960, name: ifxmodem
ofonod[5812]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x818e9b0, name: ifxmodem
ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x818e9e0, name: ifxmodem
ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x818ea0c, name: ifxmodem
ofonod[5812]: src/stk.c:ofono_stk_driver_register() driver: 0x818ea34,
name: ifxmodem
ofonod[5812]: src/ctm.c:ofono_ctm_driver_register() driver: 0x818ea5c,
name: ifxmodem
ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x818e8e0, name: hsomodem
ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x818e900, name: hsomodem
ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x818e840, name: mbmmodem
ofonod[5812]: src/stk.c:ofono_stk_driver_register() driver: 0x818e868,
name: mbmmodem
ofonod[5812]:
src/location-reporting.c:ofono_location_reporting_driver_register() driver:
0x818e888, name: mbmmodem
ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x818e7a0, name: calypsomodem
ofonod[5812]: src/stk.c:ofono_stk_driver_register() driver: 0x818e7e8,
name: calypsomodem
ofonod[5812]: src/ussd.c:ofono_ussd_driver_register() driver: 0x818e680,
name: huaweimodem
ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x818e6a0, name: huaweimodem
ofonod[5812]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x818e6e8, name: huaweimodem
ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x818e720, name: huaweimodem
ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x818e6fc, name: huaweimodem
ofonod[5812]: src/cdma-netreg.c:ofono_cdma_netreg_driver_register() driver:
0x818e74c, name: huaweimodem
ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x818e5e0, name: iceramodem
ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x818e620, name: iceramodem
ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x818e580, name: ztemodem
ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x818e540, name: swmodem
ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x818e4e0, name: nwmodem
ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x818e340, name: atmodem
ofonod[5812]: src/modem.c:ofono_devinfo_driver_register() driver:
0x818e3e0, name: atmodem
ofonod[5812]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x818e398, name: atmodem
ofonod[5812]: src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x818e0e0, name: atmodem
ofonod[5812]: src/call-meter.c:ofono_call_meter_driver_register() driver:
0x818e120, name: atmodem
ofonod[5812]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x818dfe0, name: atmodem
ofonod[5812]: src/phonebook.c:ofono_phonebook_driver_register() driver:
0x818e3b8, name: atmodem
ofonod[5812]: src/ussd.c:ofono_ussd_driver_register() driver: 0x818e304,
name: atmodem
ofonod[5812]: src/sms.c:ofono_sms_driver_register() driver: 0x818e060,
name: atmodem
ofonod[5812]: src/sim.c:ofono_sim_driver_register() driver: 0x818e1e0,
name: atmodem
ofonod[5812]: src/sim.c:ofono_sim_driver_register() driver: 0x818e240,
name: atmodem-noef
ofonod[5812]: src/stk.c:ofono_stk_driver_register() driver: 0x818e2e4,
name: atmodem
ofonod[5812]: src/network.c:ofono_netreg_driver_register() driver:
0x818e180, name: atmodem
ofonod[5812]: src/cbs.c:ofono_cbs_driver_register() driver: 0x818e0c0,
name: atmodem
ofonod[5812]: src/call-volume.c:ofono_call_volume_driver_register() driver:
0x818e404, name: atmodem
ofonod[5812]: src/gprs.c:ofono_gprs_driver_register() driver: 0x818e434,
name: atmodem
ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x818e458, name: atmodem
ofonod[5812]: src/sim-auth.c:ofono_sim_auth_driver_register() driver:
0x818e470, name: atmodem
ofonod[5812]: src/gnss.c:ofono_gnss_driver_register() driver: 0x818e488,
name: atmodem
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818ddc0,
name: gobi
ofonod[5812]: src/modem.c:ofono_devinfo_driver_register() driver:
0x818dbe0, name: qmimodem
ofonod[5812]: src/network.c:ofono_netreg_driver_register() driver:
0x818dc60, name: qmimodem
ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x818dc00, name: qmimodem
ofonod[5812]: src/sim.c:ofono_sim_driver_register() driver: 0x818dca0,
name: qmimodem-legacy
ofonod[5812]: src/sms.c:ofono_sms_driver_register() driver: 0x818dd00,
name: qmimodem
ofonod[5812]: src/ussd.c:ofono_ussd_driver_register() driver: 0x818dd20,
name: qmimodem
ofonod[5812]: src/gprs.c:ofono_gprs_driver_register() driver: 0x818dd34,
name: qmimodem
ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x818dd48, name: qmimodem
ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x818dd60, name: qmimodem
ofonod[5812]:
src/location-reporting.c:ofono_location_reporting_driver_register() driver:
0x818dd84, name: qmimodem
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818db80,
name: u8500
ofonod[5812]: src/modem.c:ofono_devinfo_driver_register() driver:
0x818db60, name: u8500
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818db00,
name: n900
ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818daa0,
name: isiusb
ofonod[5812]: src/modem.c:ofono_devinfo_driver_register() driver:
0x818d790, name: isimodem
ofonod[5812]: src/phonebook.c:ofono_phonebook_driver_register() driver:
0x818d780, name: isimodem
ofonod[5812]: src/network.c:ofono_netreg_driver_register() driver:
0x818d7c0, name: isimodem
ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x818d800, name: isimodem
ofonod[5812]: src/sms.c:ofono_sms_driver_register() driver: 0x818d860,
name: isimodem
ofonod[5812]: src/cbs.c:ofono_cbs_driver_register() driver: 0x818d880,
name: isimodem
ofonod[5812]: src/sim.c:ofono_sim_driver_register() driver: 0x818d8a0,
name: isimodem
ofonod[5812]: src/ussd.c:ofono_ussd_driver_register() driver: 0x818d8e8,
name: isimodem
ofonod[5812]: src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x818d900, name: isimodem
ofonod[5812]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x818d920, name: isimodem
ofonod[5812]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x818d950, name: isimodem
ofonod[5812]: src/call-meter.c:ofono_call_meter_driver_register() driver:
0x818d980, name: isimodem
ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x818d9c0, name: isimodem
ofonod[5812]: src/gprs.c:ofono_gprs_driver_register() driver: 0x818d9e4,
name: isimodem
ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x818d9f8, name: isimodem
ofonod[5812]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x818da10, name: isimodem
ofonod[5812]: src/sim.c:ofono_sim_driver_register() driver: 0x818da20,
name: wgmodem2.5
ofonod[5812]: plugins/udevng.c:udev_start()
ofonod[5812]: plugins/udevng.c:enumerate_devices()
ofonod[5812]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[5812]: plugins/udevng.c:check_usb_device() usb [8087:0024]
ofonod[5812]: plugins/udevng.c:check_usb_device() usb [067b:2303]
ofonod[5812]: plugins/udevng.c:check_usb_device() pl2303 [(null):(null)]
ofonod[5812]: plugins/udevng.c:check_usb_device() pl2303 [067b:2303]
ofonod[5812]: plugins/udevng.c:check_usb_device() usb [046d:c310]
ofonod[5812]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
ofonod[5812]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
ofonod[5812]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
ofonod[5812]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[5812]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[5812]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[5812]: plugins/udevng.c:check_usb_device() usb [174c:5106]
ofonod[5812]: plugins/udevng.c:check_usb_device() usb-storage
[(null):(null)]
ofonod[5812]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[5812]: plugins/udevng.c:check_usb_device() usb [8087:0024]
ofonod[5812]: plugins/udevng.c:check_usb_device() usb [067b:2303]
ofonod[5812]: plugins/udevng.c:check_usb_device() pl2303 [(null):(null)]
ofonod[5812]: plugins/udevng.c:check_usb_device() pl2303 [067b:2303]
ofonod[5812]: plugins/udevng.c:check_usb_device() usb [046d:c016]
ofonod[5812]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
ofonod[5812]: plugins/udevng.c:check_usb_device() usb [058f:6362]
ofonod[5812]: plugins/udevng.c:check_usb_device() usb-storage
[(null):(null)]
ofonod[5812]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[5812]: src/private-network.c:ofono_private_network_driver_register()
driver: 0x818fae0, name: Example Private Network Driver
ofonod[5812]: plugins/bluetooth.c:manager_properties_cb()
ofonod[5812]: plugins/bluetooth.c:parse_adapters()

> here I connect the modem to the USB

ofonod[5812]: plugins/udevng.c:check_usb_device() usb [1bc7:1003]
ofonod[5812]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[5812]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[5812]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[5812]: plugins/udevng.c:check_usb_device() option [1bc7:1003]
ofonod[5812]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4
ofonod[5812]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.1/ttyUSB3/tty/t=
tyUSB3
ofonod[5812]: plugins/udevng.c:add_device() /dev/ttyUSB3 (telit)
255/255/255 [01] =3D=3D> (null) (null)
ofonod[5812]: plugins/udev.c:udev_event() subsystem tty add
ofonod[5812]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[5812]: plugins/udevng.c:check_usb_device() option [1bc7:1003]
ofonod[5812]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4
ofonod[5812]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.2/ttyUSB4/tty/t=
tyUSB4
ofonod[5812]: plugins/udevng.c:add_device() /dev/ttyUSB4 (telit)
255/255/255 [02] =3D=3D> (null) (null)
ofonod[5812]: plugins/udev.c:udev_event() subsystem tty add
ofonod[5812]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[5812]: plugins/udevng.c:check_usb_device() option [1bc7:1003]
ofonod[5812]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4
ofonod[5812]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.0/ttyUSB2/tty/t=
tyUSB2
ofonod[5812]: plugins/udevng.c:add_device() /dev/ttyUSB2 (telit)
255/255/255 [00] =3D=3D> (null) (null)
ofonod[5812]: plugins/udev.c:udev_event() subsystem tty add
ofonod[5812]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[5812]: plugins/udevng.c:check_modem_list()
ofonod[5812]: plugins/udevng.c:create_modem()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4
ofonod[5812]: plugins/udevng.c:create_modem() driver=3Dtelit
ofonod[5812]: src/modem.c:ofono_modem_create() name: (null), type: telit
ofonod[5812]: plugins/udevng.c:setup_telit()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4
ofonod[5812]: plugins/udevng.c:setup_telit() /dev/ttyUSB2 255/255/255 00
(null)
ofonod[5812]: plugins/udevng.c:setup_telit() /dev/ttyUSB3 255/255/255 01
(null)
ofonod[5812]: plugins/udevng.c:setup_telit() /dev/ttyUSB4 255/255/255 02
(null)
ofonod[5812]: plugins/udevng.c:setup_telit() modem=3D/dev/ttyUSB2
aux=3D/dev/ttyUSB4 gps=3D(null) diag=3D/dev/ttyUSB3
ofonod[5812]: src/modem.c:set_modem_property() modem 0x8e0f140 property
Modem
ofonod[5812]: src/modem.c:set_modem_property() modem 0x8e0f140 property Data
ofonod[5812]: src/modem.c:set_modem_property() modem 0x8e0f140 property GPS
ofonod[5812]: src/modem.c:ofono_modem_register() 0x8e0f140
ofonod[5812]: plugins/telit.c:telit_probe() 0x8e0f140
ofonod[5812]: src/modem.c:emit_modem_added() 0x8e0f140
ofonod[5812]: src/modem.c:call_modemwatches() 0x8e0f140 added:1
ofonod[5812]: plugins/hfp_ag.c:modem_watch() modem: 0x8e0f140, added: 1
ofonod[5812]: plugins/dun_gw.c:modem_watch() modem: 0x8e0f140, added: 1
ofonod[5812]: examples/emulator.c:modem_watch() modem: 0x8e0f140, added: 1
ofonod[5812]: plugins/smart-messaging.c:modem_watch() modem: 0x8e0f140,
added: 1
ofonod[5812]: plugins/push-notification.c:modem_watch() modem: 0x8e0f140,
added: 1

$ enable-modem /telit_0

ofonod[5812]: plugins/telit.c:telit_enable() 0x8e0f140
ofonod[5812]: src/modem.c:get_modem_property() modem 0x8e0f140 property
Modem
ofonod[5812]: plugins/telit.c:open_device() Modem /dev/ttyUSB2
ofonod[5812]: Modem: > ATE0 +CMEE=3D1\r
ofonod[5812]: Modem: < \r\nOK\r\n
ofonod[5812]: Modem: > AT+CFUN=3D4\r
ofonod[5812]: Modem: < \r\nOK\r\n
ofonod[5812]: plugins/telit.c:cfun_enable_cb() 0x8e0f140
ofonod[5812]: examples/emulator.c:powered_watch() Adding modem 0x8e0f140 to
the list
ofonod[5812]: examples/emulator.c:create_tcp() Created server_watch: 38
ofonod[5812]: examples/emulator.c:create_tcp() Created server_watch: 39
ofonod[5812]: src/modem.c:modem_change_state() old state: 0, new state: 1
ofonod[5812]: plugins/telit.c:telit_pre_sim() 0x8e0f140
ofonod[5812]: drivers/atmodem/sim.c:at_sim_probe() GIZERO at_sim_probe:
vendor 15
ofonod[5812]: Modem: > AT+GCAP\r
ofonod[5812]: src/sim.c:ofono_sim_add_state_watch() 0x8e06a90
ofonod[5812]: src/sim.c:ofono_sim_add_state_watch() 0x8e06a90
ofonod[5812]: src/sim.c:ofono_sim_add_state_watch() 0x8e06a90
ofonod[5812]: Modem: < \r\n+GCAP: +CGSM,+DS,+FCLASS,+MS,+ES\r\n\r\nOK\r\n
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
ofonod[5812]: drivers/atmodem/voicecall.c:at_voicecall_initialized()
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

--===============5368885901876749815==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGksPGJyPjxicj5JJiMzOTttIGRvaW5nIHNvbWUgdGVzdHMgd2l0aCBUZWxpdCBHVDg2NC0zRyB0
ZXJtaW5hbCBjb25uZWN0ZWQgdG8gVVNCIHdpdGggb2Zvbm8gMS45LiBUaGlzIG1vZGVtIHVzZXMg
VUM4NjQtRSBjb3JlLiBTaW5jZSBvZm9ubyBwcm92aWRlcyBhIGRyaXZlciBmb3IgVUM4NjQtRyBj
b3JlLCBJIGhvcGUgbWFuYWdpbmcgaXQgd2l0aCBvZm9ubyBzaG91bGQgYmUgcXVpdGUgc3RyYWln
aHRmb3J3YXJkLiBPbmUgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZSB0d28gY29yZXMgaXMgdGhhdCBV
Qzg2NC1HIGRvZXMgZXhwb3NlIDQgc2VyaWFsIGRldmljZXM6IGFmdGVyIGEgcXVpY2sgZml4IEkg
Z290ICZxdW90O21vZGVtJnF1b3Q7IGFuZCAmcXVvdDthdXgmcXVvdDsgY2hhbm5lbCBjb3JyZWN0
bHkgYXNzaWduZWQuIFRoZSBwcm9ibGVtIEkgc2VlIGhlcmUgd2hlbiBJIHJ1biBlbmFibGUtbW9k
ZW0gaXMgIG9mb25vIGdldHRpbmcgc3R1Y2sgYWZ0ZXIgdHJ5aW5nIHRvIGNoZWNrIFBJTiBhdXRo
ZW50aWNhdGlvbiBzdGF0ZTogbm90ZSB0aGF0IHRoZSBzaW0gSSB1c2UgaXMgcGluLXVubG9ja2Vk
IGFuZCBJIHRyaWVkIHdpdGggc2ltcyBieSB0d28gZGlmZmVyZW50IGl0YWxpYW4gcHJvdmlkZXJz
LiA8YnI+Ckxvb2tpbmcgY2xvc2VyIGF0IHRoZSBsb2dzLCBhdHRhY2hlZCBiZWxvdywgaXQgc2Vl
bXMgdGhlIHByb2JsZW0gcmVsYXRlcyB3aXRoIGNhbGxzIHRvICtDUlNNIGFsd2F5cyByZXR1cm5p
bmcgZXJyb3IuIEkgc3VzcGVjdCBvbmUgb2YgdGhvc2UgY29tbWFuZHMgb3IgbWF5YmUgdGhlIHRp
bWluZyB0aGV5IGFyZSBleGVjdXRlZCB3aXRoLCBpcyBtZXNzaW5nIHVwIHRoZSBtb2RlbSwgc2lu
Y2UgK0NQSU4/IHJldHVybnMgd2l0aCBzdWNjZXNzIGJlZm9yZSB0aGUgc2VxdWVuY2Ugb2YgK0NS
U00gYW5kIHNpc3RlbWF0aWNjYWxseSBmYWlscyBhZnRlciB0aGF0IChtb2RlbSByZWJvb3QgcmVx
dWlyZWQgdG8gcmVjb3ZlcikuPGJyPgo8YnI+SXMgYW55Ym9keSBoYXZpbmcgc2ltaWxhciBiZWhh
dmlvdXIgd2l0aCBUZWxpdCBtb2RlbXM/IEFueSBzdWdnZXN0aW9uIGhvdyB0byB3b3JrYXJvdW5k
IG9yIGNsb3NlciBkZWJ1ZyB0aGlzIGlzc3VlPzxicj48YnI+UmVnYXJkcyw8YnI+QW5kcmVhPGJy
Pjxicj5IZXJlIGlzIHRoZSBsb2c6PGJyPjxicj4kIHN1ZG8gT0ZPTk9fQVRfREVCVUc9eSAvaG9t
ZS9naXplcm8vbG9jYWwvc2Jpbi9vZm9ub2QgLW4gLWQ8YnI+Cjxicj5vZm9ub2RbNTgxMl06IG9G
b25vIHZlcnNpb24gMS45PGJyPm9mb25vZFs1ODEyXTogc3JjL3BsdWdpbi5jOl9fb2Zvbm9fcGx1
Z2luX2luaXQoKSA8YnI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3B1c2gtbm90aWZpY2F0aW9uLmM6
cHVzaF9ub3RpZmljYXRpb25faW5pdCgpIDxicj5vZm9ub2RbNTgxMl06IHBsdWdpbnMvc21hcnQt
bWVzc2FnaW5nLmM6c21hcnRfbWVzc2FnaW5nX2luaXQoKSA8YnI+Cm9mb25vZFs1ODEyXTogZXhh
bXBsZXMvZW11bGF0b3IuYzpleGFtcGxlX2VtdWxhdG9yX2luaXQoKSA8YnI+b2Zvbm9kWzU4MTJd
OiBzcmMvZ3Bycy1wcm92aXNpb24uYzpvZm9ub19ncHJzX3Byb3Zpc2lvbl9kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4ODE4ZmE4MCBuYW1lOiBFeGFtcGxlIEdQUlMgY29udGV4dCBwcm92aXNp
b25pbmc8YnI+b2Zvbm9kWzU4MTJdOiBzcmMvbmV0dGltZS5jOm9mb25vX25ldHRpbWVfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGZhNDAgbmFtZTogRXhhbXBsZSBOZXR3b3JrIFRpbWU8
YnI+Cm9mb25vZFs1ODEyXTogc3JjL2hpc3RvcnkuYzpvZm9ub19oaXN0b3J5X2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg4MThmYTAwIG5hbWU6IEV4YW1wbGUgQ2FsbCBIaXN0b3J5PGJyPm9m
b25vZFs1ODEyXTogc3JjL2NkbWEtcHJvdmlzaW9uLmM6b2Zvbm9fY2RtYV9wcm92aXNpb25fZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGY5YzAgbmFtZTogQ0RNQSBwcm92aXNpb25pbmc8
YnI+Cm9mb25vZFs1ODEyXTogc3JjL2dwcnMtcHJvdmlzaW9uLmM6b2Zvbm9fZ3Byc19wcm92aXNp
b25fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGY5ODAgbmFtZTogUHJvdmlzaW9uaW5n
PGJyPm9mb25vZFs1ODEyXTogcGx1Z2lucy9jb25ubWFuLmM6Y29ubm1hbl9pbml0KCkgPGJyPm9m
b25vZFs1ODEyXTogc3JjL3ByaXZhdGUtbmV0d29yay5jOm9mb25vX3ByaXZhdGVfbmV0d29ya19k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4Zjk0MCwgbmFtZTogQ29ubk1hbiBQcml2YXRl
IE5ldHdvcms8YnI+Cm9mb25vZFs1ODEyXTogcGx1Z2lucy9kdW5fZ3cuYzpkdW5fZ3dfaW5pdCgp
IDxicj5vZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3Rl
cigpIGRyaXZlcjogMHg4MThmODgwLCBuYW1lOiBoZnA8YnI+b2Zvbm9kWzU4MTJdOiBzcmMvbW9k
ZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZjgyMCwgbmFt
ZTogc2FwPGJyPgpvZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg4MThmN2EwLCBuYW1lOiB0ZWxpdDxicj5vZm9ub2RbNTgxMl06
IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThm
NzAwLCBuYW1lOiBzaW05MDA8YnI+b2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2Rl
bV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZjZhMCwgbmFtZTogc2Ftc3VuZzxicj4K
b2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6IDB4ODE4ZjY0MCwgbmFtZTogc3BlZWR1cGNkbWE8YnI+b2Zvbm9kWzU4MTJdOiBzcmMv
bW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZjVlMCwg
bmFtZTogc3BlZWR1cDxicj5vZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThmNTgwLCBuYW1lOiBhbGNhdGVsPGJyPgpvZm9u
b2RbNTgxMl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg4MThmNTIwLCBuYW1lOiBpY2VyYTxicj5vZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm9m
b25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThmNGMwLCBuYW1lOiBsaW5r
dG9wPGJyPm9mb25vZFs1ODEyXTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDgxOGY0NjAsIG5hbWU6IG5va2lhY2RtYTxicj4Kb2Zvbm9kWzU4MTJd
OiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4
ZjQwMCwgbmFtZTogbm9raWE8YnI+b2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2Rl
bV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZjNhMCwgbmFtZTogdGM2NTxicj5vZm9u
b2RbNTgxMl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg4MThmMzAwLCBuYW1lOiBzdGU8YnI+Cm9mb25vZFs1ODEyXTogc3JjL21vZGVtLmM6b2Zv
bm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGYyYTAsIG5hbWU6IGlmeDxi
cj5vZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg4MThmMjQwLCBuYW1lOiBwYWxtcHJlPGJyPm9mb25vZFs1ODEyXTogc3JjL21v
ZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGYxZTAsIG5h
bWU6IG5vdmF0ZWw8YnI+Cm9mb25vZFs1ODEyXTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGYxODAsIG5hbWU6IHNpZXJyYTxicj5vZm9ub2Rb
NTgxMl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg4MThmMTAwLCBuYW1lOiBodWF3ZWk8YnI+b2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpvZm9u
b19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZjBhMCwgbmFtZTogenRlPGJy
PgpvZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg4MThmMDQwLCBuYW1lOiBoc288YnI+b2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0u
YzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZWZlMCwgbmFtZTog
bWJtPGJyPm9mb25vZFs1ODEyXTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDgxOGVmODAsIG5hbWU6IGNhbHlwc288YnI+Cm9mb25vZFs1ODEyXTog
c3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGVm
MjAsIG5hbWU6IHdhdmVjb208YnI+b2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2Rl
bV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZWVjMCwgbmFtZTogZzE8YnI+b2Zvbm9k
WzU4MTJdOiBzcmMvY2RtYS12b2ljZWNhbGwuYzpvZm9ub19jZG1hX3ZvaWNlY2FsbF9kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZWU0MCwgbmFtZTogY2RtYW1vZGVtPGJyPgpvZm9ub2Rb
NTgxMl06IHNyYy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
OiAweDgxOGVlNjAsIG5hbWU6IGNkbWFtb2RlbTxicj5vZm9ub2RbNTgxMl06IHNyYy9jZG1hLWNv
bm5tYW4uYzpvZm9ub19jZG1hX2Nvbm5tYW5fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgx
OGVlODQsIG5hbWU6IGNkbWFtb2RlbTxicj5vZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm9mb25v
X21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlZGEwLCBuYW1lOiBwaG9uZXNp
bTxicj4Kb2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4ODE4ZWRlMCwgbmFtZTogbG9jYWxoZnA8YnI+b2Zvbm9kWzU4MTJdOiBz
cmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
ODE4ZWQ3NCwgbmFtZTogcGhvbmVzaW08YnI+b2Zvbm9kWzU4MTJdOiBzcmMvY3RtLmM6b2Zvbm9f
Y3RtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlZDYwLCBuYW1lOiBwaG9uZXNpbTxi
cj4Kb2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3Bob25lc2ltLmM6cGFyc2VfY29uZmlnKCkgZmlsZW5h
bWUgL2hvbWUvZ2l6ZXJvL2xvY2FsL2V0Yy9vZm9uby9waG9uZXNpbS5jb25mPGJyPm9mb25vZFs1
ODEyXTogc3JjL3Vzc2QuYzpvZm9ub191c3NkX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4
MThlZDIwLCBuYW1lOiBzcGVlZHVwbW9kZW08YnI+b2Zvbm9kWzU4MTJdOiBzcmMvdm9pY2VjYWxs
LmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlYzAwLCBu
YW1lOiBoZnBtb2RlbTxicj4Kb2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19kZXZpbmZv
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlY2JjLCBuYW1lOiBoZnBtb2RlbTxicj5v
Zm9ub2RbNTgxMl06IHNyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg4MThlYzYwLCBuYW1lOiBoZnBtb2RlbTxicj5vZm9ub2RbNTgxMl06IHNyYy9j
YWxsLXZvbHVtZS5jOm9mb25vX2NhbGxfdm9sdW1lX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg4MThlYzk0LCBuYW1lOiBoZnBtb2RlbTxicj4Kb2Zvbm9kWzU4MTJdOiBzcmMvaGFuZHNmcmVl
LmM6b2Zvbm9faGFuZHNmcmVlX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlY2Q4LCBu
YW1lOiBoZnBtb2RlbTxicj5vZm9ub2RbNTgxMl06IHNyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVn
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlYjgwLCBuYW1lOiBkdW5tb2RlbTxicj5v
Zm9ub2RbNTgxMl06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4ODE4ZWJhYywgbmFtZTogZHVubW9kZW08YnI+Cm9mb25vZFs1ODEyXTogc3JjL3ZvaWNl
Y2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZWFh
MCwgbmFtZTogc3RlbW9kZW08YnI+b2Zvbm9kWzU4MTJdOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNf
Y29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZWIyYywgbmFtZTogc3RlbW9k
ZW08YnI+b2Zvbm9kWzU4MTJdOiBzcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0
aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZWIwMCwgbmFtZTogc3RlbW9kZW08
YnI+Cm9mb25vZFs1ODEyXTogc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZTk2MCwgbmFtZTogaWZ4bW9kZW08YnI+b2Zvbm9kWzU4
MTJdOiBzcmMvYXVkaW8tc2V0dGluZ3MuYzpvZm9ub19hdWRpb19zZXR0aW5nc19kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZTliMCwgbmFtZTogaWZ4bW9kZW08YnI+b2Zvbm9kWzU4MTJd
OiBzcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4ODE4ZTllMCwgbmFtZTogaWZ4bW9kZW08YnI+Cm9mb25vZFs1ODEyXTog
c3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAw
eDgxOGVhMGMsIG5hbWU6IGlmeG1vZGVtPGJyPm9mb25vZFs1ODEyXTogc3JjL3N0ay5jOm9mb25v
X3N0a19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZWEzNCwgbmFtZTogaWZ4bW9kZW08
YnI+b2Zvbm9kWzU4MTJdOiBzcmMvY3RtLmM6b2Zvbm9fY3RtX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg4MThlYTVjLCBuYW1lOiBpZnhtb2RlbTxicj4Kb2Zvbm9kWzU4MTJdOiBzcmMvZ3By
cy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZThl
MCwgbmFtZTogaHNvbW9kZW08YnI+b2Zvbm9kWzU4MTJdOiBzcmMvcmFkaW8tc2V0dGluZ3MuYzpv
Zm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZTkwMCwg
bmFtZTogaHNvbW9kZW08YnI+b2Zvbm9kWzU4MTJdOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29u
dGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZTg0MCwgbmFtZTogbWJtbW9kZW08
YnI+Cm9mb25vZFs1ODEyXTogc3JjL3N0ay5jOm9mb25vX3N0a19kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6IDB4ODE4ZTg2OCwgbmFtZTogbWJtbW9kZW08YnI+b2Zvbm9kWzU4MTJdOiBzcmMvbG9j
YXRpb24tcmVwb3J0aW5nLmM6b2Zvbm9fbG9jYXRpb25fcmVwb3J0aW5nX2RyaXZlcl9yZWdpc3Rl
cigpIGRyaXZlcjogMHg4MThlODg4LCBuYW1lOiBtYm1tb2RlbTxicj5vZm9ub2RbNTgxMl06IHNy
Yy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAw
eDgxOGU3YTAsIG5hbWU6IGNhbHlwc29tb2RlbTxicj4Kb2Zvbm9kWzU4MTJdOiBzcmMvc3RrLmM6
b2Zvbm9fc3RrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlN2U4LCBuYW1lOiBjYWx5
cHNvbW9kZW08YnI+b2Zvbm9kWzU4MTJdOiBzcmMvdXNzZC5jOm9mb25vX3Vzc2RfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDgxOGU2ODAsIG5hbWU6IGh1YXdlaW1vZGVtPGJyPm9mb25vZFs1
ODEyXTogc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6IDB4ODE4ZTZhMCwgbmFtZTogaHVhd2VpbW9kZW08YnI+Cm9mb25vZFs1ODEyXTogc3Jj
L2F1ZGlvLXNldHRpbmdzLmM6b2Zvbm9fYXVkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxOGU2ZTgsIG5hbWU6IGh1YXdlaW1vZGVtPGJyPm9mb25vZFs1ODEyXTogc3Jj
L3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxOGU3MjAsIG5hbWU6IGh1YXdlaW1vZGVtPGJyPgpvZm9ub2RbNTgxMl06IHNy
Yy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4
MThlNmZjLCBuYW1lOiBodWF3ZWltb2RlbTxicj5vZm9ub2RbNTgxMl06IHNyYy9jZG1hLW5ldHJl
Zy5jOm9mb25vX2NkbWFfbmV0cmVnX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlNzRj
LCBuYW1lOiBodWF3ZWltb2RlbTxicj5vZm9ub2RbNTgxMl06IHNyYy9ncHJzLmM6b2Zvbm9fZ3By
c19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlNWUwLCBuYW1lOiBpY2Vy
YW1vZGVtPGJyPgpvZm9ub2RbNTgxMl06IHNyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlv
X3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlNjIwLCBuYW1lOiBpY2Vy
YW1vZGVtPGJyPm9mb25vZFs1ODEyXTogc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9f
c2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGU1ODAsIG5hbWU6IHp0ZW1v
ZGVtPGJyPgpvZm9ub2RbNTgxMl06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlNTQwLCBuYW1lOiBzd21vZGVtPGJyPm9mb25vZFs1
ODEyXTogc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDgxOGU0ZTAsIG5hbWU6IG53bW9kZW08YnI+b2Zvbm9kWzU4MTJd
OiBzcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg4MThlMzQwLCBuYW1lOiBhdG1vZGVtPGJyPgpvZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5j
Om9mb25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGUzZTAsIG5hbWU6
IGF0bW9kZW08YnI+b2Zvbm9kWzU4MTJdOiBzcmMvY2FsbC1iYXJyaW5nLmM6b2Zvbm9fY2FsbF9i
YXJyaW5nX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlMzk4LCBuYW1lOiBhdG1vZGVt
PGJyPm9mb25vZFs1ODEyXTogc3JjL2NhbGwtZm9yd2FyZGluZy5jOm9mb25vX2NhbGxfZm9yd2Fy
ZGluZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZTBlMCwgbmFtZTogYXRtb2RlbTxi
cj4Kb2Zvbm9kWzU4MTJdOiBzcmMvY2FsbC1tZXRlci5jOm9mb25vX2NhbGxfbWV0ZXJfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGUxMjAsIG5hbWU6IGF0bW9kZW08YnI+b2Zvbm9kWzU4
MTJdOiBzcmMvY2FsbC1zZXR0aW5ncy5jOm9mb25vX2NhbGxfc2V0dGluZ3NfZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDgxOGRmZTAsIG5hbWU6IGF0bW9kZW08YnI+b2Zvbm9kWzU4MTJdOiBz
cmMvcGhvbmVib29rLmM6b2Zvbm9fcGhvbmVib29rX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg4MThlM2I4LCBuYW1lOiBhdG1vZGVtPGJyPgpvZm9ub2RbNTgxMl06IHNyYy91c3NkLmM6b2Zv
bm9fdXNzZF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZTMwNCwgbmFtZTogYXRtb2Rl
bTxicj5vZm9ub2RbNTgxMl06IHNyYy9zbXMuYzpvZm9ub19zbXNfZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxOGUwNjAsIG5hbWU6IGF0bW9kZW08YnI+b2Zvbm9kWzU4MTJdOiBzcmMvc2lt
LmM6b2Zvbm9fc2ltX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThlMWUwLCBuYW1lOiBh
dG1vZGVtPGJyPgpvZm9ub2RbNTgxMl06IHNyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDgxOGUyNDAsIG5hbWU6IGF0bW9kZW0tbm9lZjxicj5vZm9ub2RbNTgx
Ml06IHNyYy9zdGsuYzpvZm9ub19zdGtfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGUy
ZTQsIG5hbWU6IGF0bW9kZW08YnI+b2Zvbm9kWzU4MTJdOiBzcmMvbmV0d29yay5jOm9mb25vX25l
dHJlZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZTE4MCwgbmFtZTogYXRtb2RlbTxi
cj4Kb2Zvbm9kWzU4MTJdOiBzcmMvY2JzLmM6b2Zvbm9fY2JzX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg4MThlMGMwLCBuYW1lOiBhdG1vZGVtPGJyPm9mb25vZFs1ODEyXTogc3JjL2NhbGwt
dm9sdW1lLmM6b2Zvbm9fY2FsbF92b2x1bWVfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgx
OGU0MDQsIG5hbWU6IGF0bW9kZW08YnI+b2Zvbm9kWzU4MTJdOiBzcmMvZ3Bycy5jOm9mb25vX2dw
cnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGU0MzQsIG5hbWU6IGF0bW9kZW08YnI+
Cm9mb25vZFs1ODEyXTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDgxOGU0NTgsIG5hbWU6IGF0bW9kZW08YnI+b2Zvbm9kWzU4MTJdOiBz
cmMvc2ltLWF1dGguYzpvZm9ub19zaW1fYXV0aF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
ODE4ZTQ3MCwgbmFtZTogYXRtb2RlbTxicj5vZm9ub2RbNTgxMl06IHNyYy9nbnNzLmM6b2Zvbm9f
Z25zc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZTQ4OCwgbmFtZTogYXRtb2RlbTxi
cj4Kb2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4ODE4ZGRjMCwgbmFtZTogZ29iaTxicj5vZm9ub2RbNTgxMl06IHNyYy9tb2Rl
bS5jOm9mb25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGRiZTAsIG5h
bWU6IHFtaW1vZGVtPGJyPm9mb25vZFs1ODEyXTogc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGRjNjAsIG5hbWU6IHFtaW1vZGVtPGJyPgpv
Zm9ub2RbNTgxMl06IHNyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDgxOGRjMDAsIG5hbWU6IHFtaW1vZGVtPGJyPm9mb25vZFs1ODEyXTog
c3JjL3NpbS5jOm9mb25vX3NpbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZGNhMCwg
bmFtZTogcW1pbW9kZW0tbGVnYWN5PGJyPm9mb25vZFs1ODEyXTogc3JjL3Ntcy5jOm9mb25vX3Nt
c19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZGQwMCwgbmFtZTogcW1pbW9kZW08YnI+
Cm9mb25vZFs1ODEyXTogc3JjL3Vzc2QuYzpvZm9ub191c3NkX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg4MThkZDIwLCBuYW1lOiBxbWltb2RlbTxicj5vZm9ub2RbNTgxMl06IHNyYy9ncHJz
LmM6b2Zvbm9fZ3Byc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZGQzNCwgbmFtZTog
cW1pbW9kZW08YnI+b2Zvbm9kWzU4MTJdOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZGQ0OCwgbmFtZTogcW1pbW9kZW08YnI+Cm9m
b25vZFs1ODEyXTogc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGRkNjAsIG5hbWU6IHFtaW1vZGVtPGJyPm9mb25v
ZFs1ODEyXTogc3JjL2xvY2F0aW9uLXJlcG9ydGluZy5jOm9mb25vX2xvY2F0aW9uX3JlcG9ydGlu
Z19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZGQ4NCwgbmFtZTogcW1pbW9kZW08YnI+
Cm9mb25vZFs1ODEyXTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxOGRiODAsIG5hbWU6IHU4NTAwPGJyPm9mb25vZFs1ODEyXTogc3JjL21vZGVt
LmM6b2Zvbm9fZGV2aW5mb19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZGI2MCwgbmFt
ZTogdTg1MDA8YnI+b2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZGIwMCwgbmFtZTogbjkwMDxicj4Kb2Zvbm9kWzU4MTJd
OiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4
ZGFhMCwgbmFtZTogaXNpdXNiPGJyPm9mb25vZFs1ODEyXTogc3JjL21vZGVtLmM6b2Zvbm9fZGV2
aW5mb19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZDc5MCwgbmFtZTogaXNpbW9kZW08
YnI+b2Zvbm9kWzU4MTJdOiBzcmMvcGhvbmVib29rLmM6b2Zvbm9fcGhvbmVib29rX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg4MThkNzgwLCBuYW1lOiBpc2ltb2RlbTxicj4Kb2Zvbm9kWzU4
MTJdOiBzcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
IDB4ODE4ZDdjMCwgbmFtZTogaXNpbW9kZW08YnI+b2Zvbm9kWzU4MTJdOiBzcmMvdm9pY2VjYWxs
LmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThkODAwLCBu
YW1lOiBpc2ltb2RlbTxicj5vZm9ub2RbNTgxMl06IHNyYy9zbXMuYzpvZm9ub19zbXNfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOGQ4NjAsIG5hbWU6IGlzaW1vZGVtPGJyPgpvZm9ub2Rb
NTgxMl06IHNyYy9jYnMuYzpvZm9ub19jYnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgx
OGQ4ODAsIG5hbWU6IGlzaW1vZGVtPGJyPm9mb25vZFs1ODEyXTogc3JjL3NpbS5jOm9mb25vX3Np
bV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZDhhMCwgbmFtZTogaXNpbW9kZW08YnI+
b2Zvbm9kWzU4MTJdOiBzcmMvdXNzZC5jOm9mb25vX3Vzc2RfZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDgxOGQ4ZTgsIG5hbWU6IGlzaW1vZGVtPGJyPgpvZm9ub2RbNTgxMl06IHNyYy9jYWxs
LWZvcndhcmRpbmcuYzpvZm9ub19jYWxsX2ZvcndhcmRpbmdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDgxOGQ5MDAsIG5hbWU6IGlzaW1vZGVtPGJyPm9mb25vZFs1ODEyXTogc3JjL2NhbGwt
c2V0dGluZ3MuYzpvZm9ub19jYWxsX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg4MThkOTIwLCBuYW1lOiBpc2ltb2RlbTxicj4Kb2Zvbm9kWzU4MTJdOiBzcmMvY2FsbC1iYXJy
aW5nLmM6b2Zvbm9fY2FsbF9iYXJyaW5nX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThk
OTUwLCBuYW1lOiBpc2ltb2RlbTxicj5vZm9ub2RbNTgxMl06IHNyYy9jYWxsLW1ldGVyLmM6b2Zv
bm9fY2FsbF9tZXRlcl9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZDk4MCwgbmFtZTog
aXNpbW9kZW08YnI+b2Zvbm9kWzU4MTJdOiBzcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRp
b19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE4ZDljMCwgbmFtZTogaXNp
bW9kZW08YnI+Cm9mb25vZFs1ODEyXTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg4MThkOWU0LCBuYW1lOiBpc2ltb2RlbTxicj5vZm9ub2RbNTgxMl06
IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg4MThkOWY4LCBuYW1lOiBpc2ltb2RlbTxicj5vZm9ub2RbNTgxMl06IHNyYy9hdWRpby1zZXR0
aW5ncy5jOm9mb25vX2F1ZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4
MThkYTEwLCBuYW1lOiBpc2ltb2RlbTxicj4Kb2Zvbm9kWzU4MTJdOiBzcmMvc2ltLmM6b2Zvbm9f
c2ltX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MThkYTIwLCBuYW1lOiB3Z21vZGVtMi41
PGJyPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzp1ZGV2X3N0YXJ0KCkgPGJyPm9mb25v
ZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzplbnVtZXJhdGVfZGV2aWNlcygpIDxicj5vZm9ub2Rb
NTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIGh1YiBbKG51bGwpOihu
dWxsKV08YnI+Cm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNl
KCkgdXNiIFs4MDg3OjAwMjRdPGJyPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVj
a191c2JfZGV2aWNlKCkgdXNiIFswNjdiOjIzMDNdPGJyPm9mb25vZFs1ODEyXTogcGx1Z2lucy91
ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgcGwyMzAzIFsobnVsbCk6KG51bGwpXTxicj5vZm9u
b2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHBsMjMwMyBbMDY3
YjoyMzAzXTxicj4Kb2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZp
Y2UoKSB1c2IgWzA0NmQ6YzMxMF08YnI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOmNo
ZWNrX3VzYl9kZXZpY2UoKSB1c2JoaWQgWyhudWxsKToobnVsbCldPGJyPm9mb25vZFs1ODEyXTog
cGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiaGlkIFsobnVsbCk6KG51bGwp
XTxicj4Kb2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSB1
c2JoaWQgWyhudWxsKToobnVsbCldPGJyPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzpj
aGVja191c2JfZGV2aWNlKCkgaHViIFsobnVsbCk6KG51bGwpXTxicj5vZm9ub2RbNTgxMl06IHBs
dWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIGh1YiBbKG51bGwpOihudWxsKV08YnI+
Cm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgaHViIFso
bnVsbCk6KG51bGwpXTxicj5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNi
X2RldmljZSgpIHVzYiBbMTc0Yzo1MTA2XTxicj5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5n
LmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYi1zdG9yYWdlIFsobnVsbCk6KG51bGwpXTxicj4Kb2Zv
bm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBodWIgWyhudWxs
KToobnVsbCldPGJyPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2
aWNlKCkgdXNiIFs4MDg3OjAwMjRdPGJyPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzpj
aGVja191c2JfZGV2aWNlKCkgdXNiIFswNjdiOjIzMDNdPGJyPm9mb25vZFs1ODEyXTogcGx1Z2lu
cy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgcGwyMzAzIFsobnVsbCk6KG51bGwpXTxicj4K
b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBwbDIzMDMg
WzA2N2I6MjMwM108YnI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9k
ZXZpY2UoKSB1c2IgWzA0NmQ6YzAxNl08YnI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5j
OmNoZWNrX3VzYl9kZXZpY2UoKSB1c2JoaWQgWyhudWxsKToobnVsbCldPGJyPm9mb25vZFs1ODEy
XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFswNThmOjYzNjJdPGJy
PgpvZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYi1z
dG9yYWdlIFsobnVsbCk6KG51bGwpXTxicj5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6
Y2hlY2tfdXNiX2RldmljZSgpIGh1YiBbKG51bGwpOihudWxsKV08YnI+b2Zvbm9kWzU4MTJdOiBz
cmMvcHJpdmF0ZS1uZXR3b3JrLmM6b2Zvbm9fcHJpdmF0ZV9uZXR3b3JrX2RyaXZlcl9yZWdpc3Rl
cigpIGRyaXZlcjogMHg4MThmYWUwLCBuYW1lOiBFeGFtcGxlIFByaXZhdGUgTmV0d29yayBEcml2
ZXI8YnI+Cm9mb25vZFs1ODEyXTogcGx1Z2lucy9ibHVldG9vdGguYzptYW5hZ2VyX3Byb3BlcnRp
ZXNfY2IoKSA8YnI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL2JsdWV0b290aC5jOnBhcnNlX2FkYXB0
ZXJzKCkgPGJyPjxicj4mZ3Q7IGhlcmUgSSBjb25uZWN0IHRoZSBtb2RlbSB0byB0aGUgVVNCPGJy
Pjxicj5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVz
YiBbMWJjNzoxMDAzXTxicj4Kb2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3Vz
Yl9kZXZpY2UoKSBvcHRpb24gWyhudWxsKToobnVsbCldPGJyPm9mb25vZFs1ODEyXTogcGx1Z2lu
cy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgb3B0aW9uIFsobnVsbCk6KG51bGwpXTxicj5v
Zm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbiBb
KG51bGwpOihudWxsKV08YnI+Cm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191
c2JfZGV2aWNlKCkgb3B0aW9uIFsxYmM3OjEwMDNdPGJyPm9mb25vZFs1ODEyXTogcGx1Z2lucy91
ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxYS4w
L3VzYjEvMS0xLzEtMS40PGJyPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2
aWNlKCkgL3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxYS4wL3VzYjEvMS0xLzEtMS40
LzEtMS40OjEuMS90dHlVU0IzL3R0eS90dHlVU0IzPGJyPgpvZm9ub2RbNTgxMl06IHBsdWdpbnMv
dWRldm5nLmM6YWRkX2RldmljZSgpIC9kZXYvdHR5VVNCMyAodGVsaXQpIDI1NS8yNTUvMjU1IFsw
MV0gPT0mZ3Q7IChudWxsKSAobnVsbCk8YnI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXYuYzp1
ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSBhZGQ8YnI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3Vk
ZXYuYzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSBmaW5pc2hlZDxicj4Kb2Zvbm9kWzU4MTJd
OiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBvcHRpb24gWzFiYzc6MTAwM108
YnI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvc3lzL2Rldmlj
ZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFhLjAvdXNiMS8xLTEvMS0xLjQ8YnI+b2Zvbm9kWzU4MTJd
OiBwbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvc3lzL2RldmljZXMvcGNpMDAwMDowMC8w
MDAwOjAwOjFhLjAvdXNiMS8xLTEvMS0xLjQvMS0xLjQ6MS4yL3R0eVVTQjQvdHR5L3R0eVVTQjQ8
YnI+Cm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL2Rldi90dHlV
U0I0ICh0ZWxpdCkgMjU1LzI1NS8yNTUgWzAyXSA9PSZndDsgKG51bGwpIChudWxsKTxicj5vZm9u
b2RbNTgxMl06IHBsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBzdWJzeXN0ZW0gdHR5IGFkZDxi
cj5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBzdWJzeXN0ZW0gdHR5
IGZpbmlzaGVkPGJyPgpvZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2Rl
dmljZSgpIG9wdGlvbiBbMWJjNzoxMDAzXTxicj5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5n
LmM6YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWEuMC91c2Ix
LzEtMS8xLTEuNDxicj5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgp
IC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWEuMC91c2IxLzEtMS8xLTEuNC8xLTEu
NDoxLjAvdHR5VVNCMi90dHkvdHR5VVNCMjxicj4Kb2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZu
Zy5jOmFkZF9kZXZpY2UoKSAvZGV2L3R0eVVTQjIgKHRlbGl0KSAyNTUvMjU1LzI1NSBbMDBdID09
Jmd0OyAobnVsbCkgKG51bGwpPGJyPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2LmM6dWRldl9l
dmVudCgpIHN1YnN5c3RlbSB0dHkgYWRkPGJyPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2LmM6
dWRldl9ldmVudCgpIHN1YnN5c3RlbSB0dHkgZmluaXNoZWQ8YnI+Cm9mb25vZFs1ODEyXTogcGx1
Z2lucy91ZGV2bmcuYzpjaGVja19tb2RlbV9saXN0KCkgPGJyPm9mb25vZFs1ODEyXTogcGx1Z2lu
cy91ZGV2bmcuYzpjcmVhdGVfbW9kZW0oKSAvc3lzL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAw
OjFhLjAvdXNiMS8xLTEvMS0xLjQ8YnI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOmNy
ZWF0ZV9tb2RlbSgpIGRyaXZlcj10ZWxpdDxicj5vZm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOm9m
b25vX21vZGVtX2NyZWF0ZSgpIG5hbWU6IChudWxsKSwgdHlwZTogdGVsaXQ8YnI+Cm9mb25vZFs1
ODEyXTogcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF90ZWxpdCgpIC9zeXMvZGV2aWNlcy9wY2kwMDAw
OjAwLzAwMDA6MDA6MWEuMC91c2IxLzEtMS8xLTEuNDxicj5vZm9ub2RbNTgxMl06IHBsdWdpbnMv
dWRldm5nLmM6c2V0dXBfdGVsaXQoKSAvZGV2L3R0eVVTQjIgMjU1LzI1NS8yNTUgMDAgKG51bGwp
PGJyPm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF90ZWxpdCgpIC9kZXYvdHR5
VVNCMyAyNTUvMjU1LzI1NSAwMSAobnVsbCk8YnI+Cm9mb25vZFs1ODEyXTogcGx1Z2lucy91ZGV2
bmcuYzpzZXR1cF90ZWxpdCgpIC9kZXYvdHR5VVNCNCAyNTUvMjU1LzI1NSAwMiAobnVsbCk8YnI+
b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3VkZXZuZy5jOnNldHVwX3RlbGl0KCkgbW9kZW09L2Rldi90
dHlVU0IyIGF1eD0vZGV2L3R0eVVTQjQgZ3BzPShudWxsKSBkaWFnPS9kZXYvdHR5VVNCMzxicj5v
Zm9ub2RbNTgxMl06IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OGUw
ZjE0MCBwcm9wZXJ0eSBNb2RlbTxicj4Kb2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpzZXRfbW9k
ZW1fcHJvcGVydHkoKSBtb2RlbSAweDhlMGYxNDAgcHJvcGVydHkgRGF0YTxicj5vZm9ub2RbNTgx
Ml06IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OGUwZjE0MCBwcm9w
ZXJ0eSBHUFM8YnI+b2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9yZWdpc3Rl
cigpIDB4OGUwZjE0MDxicj4Kb2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3RlbGl0LmM6dGVsaXRfcHJv
YmUoKSAweDhlMGYxNDA8YnI+b2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzplbWl0X21vZGVtX2Fk
ZGVkKCkgMHg4ZTBmMTQwPGJyPm9mb25vZFs1ODEyXTogc3JjL21vZGVtLmM6Y2FsbF9tb2RlbXdh
dGNoZXMoKSAweDhlMGYxNDAgYWRkZWQ6MTxicj5vZm9ub2RbNTgxMl06IHBsdWdpbnMvaGZwX2Fn
LmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg4ZTBmMTQwLCBhZGRlZDogMTxicj4Kb2Zvbm9kWzU4
MTJdOiBwbHVnaW5zL2R1bl9ndy5jOm1vZGVtX3dhdGNoKCkgbW9kZW06IDB4OGUwZjE0MCwgYWRk
ZWQ6IDE8YnI+b2Zvbm9kWzU4MTJdOiBleGFtcGxlcy9lbXVsYXRvci5jOm1vZGVtX3dhdGNoKCkg
bW9kZW06IDB4OGUwZjE0MCwgYWRkZWQ6IDE8YnI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3NtYXJ0
LW1lc3NhZ2luZy5jOm1vZGVtX3dhdGNoKCkgbW9kZW06IDB4OGUwZjE0MCwgYWRkZWQ6IDE8YnI+
Cm9mb25vZFs1ODEyXTogcGx1Z2lucy9wdXNoLW5vdGlmaWNhdGlvbi5jOm1vZGVtX3dhdGNoKCkg
bW9kZW06IDB4OGUwZjE0MCwgYWRkZWQ6IDE8YnI+PGJyPiQgZW5hYmxlLW1vZGVtIC90ZWxpdF8w
PGJyPjxicj5vZm9ub2RbNTgxMl06IHBsdWdpbnMvdGVsaXQuYzp0ZWxpdF9lbmFibGUoKSAweDhl
MGYxNDA8YnI+b2Zvbm9kWzU4MTJdOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBt
b2RlbSAweDhlMGYxNDAgcHJvcGVydHkgTW9kZW08YnI+Cm9mb25vZFs1ODEyXTogcGx1Z2lucy90
ZWxpdC5jOm9wZW5fZGV2aWNlKCkgTW9kZW0gL2Rldi90dHlVU0IyPGJyPm9mb25vZFs1ODEyXTog
TW9kZW06ICZndDsgQVRFMCArQ01FRT0xXHI8YnI+b2Zvbm9kWzU4MTJdOiBNb2RlbTogJmx0OyBc
clxuT0tcclxuPGJyPm9mb25vZFs1ODEyXTogTW9kZW06ICZndDsgQVQrQ0ZVTj00XHI8YnI+b2Zv
bm9kWzU4MTJdOiBNb2RlbTogJmx0OyBcclxuT0tcclxuPGJyPgpvZm9ub2RbNTgxMl06IHBsdWdp
bnMvdGVsaXQuYzpjZnVuX2VuYWJsZV9jYigpIDB4OGUwZjE0MDxicj5vZm9ub2RbNTgxMl06IGV4
YW1wbGVzL2VtdWxhdG9yLmM6cG93ZXJlZF93YXRjaCgpIEFkZGluZyBtb2RlbSAweDhlMGYxNDAg
dG8gdGhlIGxpc3Q8YnI+b2Zvbm9kWzU4MTJdOiBleGFtcGxlcy9lbXVsYXRvci5jOmNyZWF0ZV90
Y3AoKSBDcmVhdGVkIHNlcnZlcl93YXRjaDogMzg8YnI+Cm9mb25vZFs1ODEyXTogZXhhbXBsZXMv
ZW11bGF0b3IuYzpjcmVhdGVfdGNwKCkgQ3JlYXRlZCBzZXJ2ZXJfd2F0Y2g6IDM5PGJyPm9mb25v
ZFs1ODEyXTogc3JjL21vZGVtLmM6bW9kZW1fY2hhbmdlX3N0YXRlKCkgb2xkIHN0YXRlOiAwLCBu
ZXcgc3RhdGU6IDE8YnI+b2Zvbm9kWzU4MTJdOiBwbHVnaW5zL3RlbGl0LmM6dGVsaXRfcHJlX3Np
bSgpIDB4OGUwZjE0MDxicj5vZm9ub2RbNTgxMl06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9z
aW1fcHJvYmUoKSBHSVpFUk8gYXRfc2ltX3Byb2JlOiB2ZW5kb3IgMTU8YnI+Cm9mb25vZFs1ODEy
XTogTW9kZW06ICZndDsgQVQrR0NBUFxyPGJyPm9mb25vZFs1ODEyXTogc3JjL3NpbS5jOm9mb25v
X3NpbV9hZGRfc3RhdGVfd2F0Y2goKSAweDhlMDZhOTA8YnI+b2Zvbm9kWzU4MTJdOiBzcmMvc2lt
LmM6b2Zvbm9fc2ltX2FkZF9zdGF0ZV93YXRjaCgpIDB4OGUwNmE5MDxicj5vZm9ub2RbNTgxMl06
IHNyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3N0YXRlX3dhdGNoKCkgMHg4ZTA2YTkwPGJyPgpvZm9u
b2RbNTgxMl06IE1vZGVtOiAmbHQ7IFxyXG4rR0NBUDogK0NHU00sK0RTLCtGQ0xBU1MsK01TLCtF
U1xyXG5cclxuT0tcclxuPGJyPm9mb25vZFs1ODEyXTogTW9kZW06ICZndDsgQVQrQ1JDPTFccjxi
cj5vZm9ub2RbNTgxMl06IE1vZGVtOiAmbHQ7IFxyXG5PS1xyXG48YnI+b2Zvbm9kWzU4MTJdOiBN
b2RlbTogJmd0OyBBVCtDTElQPTFccjxicj5vZm9ub2RbNTgxMl06IE1vZGVtOiAmbHQ7IFxyXG5P
S1xyXG48YnI+Cm9mb25vZFs1ODEyXTogTW9kZW06ICZndDsgQVQrQ0RJUD0xXHI8YnI+b2Zvbm9k
WzU4MTJdOiBNb2RlbTogJmx0OyBcclxuRVJST1JcclxuPGJyPm9mb25vZFs1ODEyXTogTW9kZW06
ICZndDsgQVQrQ05BUD0xXHI8YnI+b2Zvbm9kWzU4MTJdOiBNb2RlbTogJmx0OyBcclxuRVJST1Jc
clxuPGJyPm9mb25vZFs1ODEyXTogTW9kZW06ICZndDsgQVQrQ09MUD0xXHI8YnI+b2Zvbm9kWzU4
MTJdOiBNb2RlbTogJmx0OyBcclxuK0NNRSBFUlJPUjogMTBcclxuPGJyPgpvZm9ub2RbNTgxMl06
IE1vZGVtOiAmZ3Q7IEFUK0NTU049MSwxXHI8YnI+b2Zvbm9kWzU4MTJdOiBNb2RlbTogJmx0OyBc
clxuK0NNRSBFUlJPUjogMTBcclxuPGJyPm9mb25vZFs1ODEyXTogTW9kZW06ICZndDsgQVQrVlRE
P1xyPGJyPm9mb25vZFs1ODEyXTogTW9kZW06ICZsdDsgXHJcbitDTUUgRVJST1I6IDEwXHJcbjxi
cj5vZm9ub2RbNTgxMl06IE1vZGVtOiAmZ3Q7IEFUK0NDV0E9MVxyPGJyPgpvZm9ub2RbNTgxMl06
IE1vZGVtOiAmbHQ7IFxyXG4rQ01FIEVSUk9SOiAxMFxyXG48YnI+b2Zvbm9kWzU4MTJdOiBkcml2
ZXJzL2F0bW9kZW0vdm9pY2VjYWxsLmM6YXRfdm9pY2VjYWxsX2luaXRpYWxpemVkKCkgdm9pY2Vj
YWxsX2luaXQ6IHJlZ2lzdGVyaW5nIHRvIG5vdGlmaWNhdGlvbnM8YnI+b2Zvbm9kWzU4MTJdOiBz
cmMvc2ltLmM6b2Zvbm9fc2ltX2FkZF9zdGF0ZV93YXRjaCgpIDB4OGUwNmE5MDxicj4Kb2Zvbm9k
WzU4MTJdOiBNb2RlbTogJmd0OyBBVCNRU1M9MVxyPGJyPm9mb25vZFs1ODEyXTogTW9kZW06ICZs
dDsgXHJcbk9LXHJcbjxicj5vZm9ub2RbNTgxMl06IE1vZGVtOiAmZ3Q7IEFUI1FTUz9ccjxicj5v
Zm9ub2RbNTgxMl06IE1vZGVtOiAmbHQ7IFxyXG4jUVNTOiAxLDFcclxuXHJcbk9LXHJcbjxicj5v
Zm9ub2RbNTgxMl06IHBsdWdpbnMvdGVsaXQuYzp0ZWxpdF9xc3NfY2IoKSAweDhlMGYxNDA8YnI+
Cm9mb25vZFs1ODEyXTogcGx1Z2lucy90ZWxpdC5jOnN3aXRjaF9zaW1fc3RhdGVfc3RhdHVzKCkg
MHg4ZTBmMTQwPGJyPm9mb25vZFs1ODEyXTogcGx1Z2lucy90ZWxpdC5jOnN3aXRjaF9zaW1fc3Rh
dGVfc3RhdHVzKCkgU0lNIGluc2VydGVkPGJyPm9mb25vZFs1ODEyXTogTW9kZW06ICZndDsgQVQr
Q0dNSVxyPGJyPm9mb25vZFs1ODEyXTogTW9kZW06ICZsdDsgXHJcblRlbGl0XHJcblxyXG5PS1xy
XG48YnI+Cm9mb25vZFs1ODEyXTogTW9kZW06ICZndDsgQVQrQ0xDQ1xyPGJyPm9mb25vZFs1ODEy
XTogTW9kZW06ICZsdDsgXHJcbitDTUUgRVJST1I6IDEwXHJcbjxicj5vZm9ub2RbNTgxMl06IE1v
ZGVtOiAmZ3Q7IEFUK0NHTU1ccjxicj5vZm9ub2RbNTgxMl06IE1vZGVtOiAmbHQ7IFxyXG5VQzg2
NC1FXHJcblxyXG5PS1xyXG48YnI+b2Zvbm9kWzU4MTJdOiBNb2RlbTogJmd0OyBBVCtDR01SXHI8
YnI+Cm9mb25vZFs1ODEyXTogTW9kZW06ICZsdDsgXHJcbjA4LjAxLjAwNVxyXG5cclxuT0tcclxu
PGJyPm9mb25vZFs1ODEyXTogTW9kZW06ICZndDsgQVQrQ0dTTlxyPGJyPm9mb25vZFs1ODEyXTog
TW9kZW06ICZsdDsgXHJcbjM1MjYzNjAyMDQxMjc2OFxyXG5cclxuT0tcclxuPGJyPm9mb25vZFs1
ODEyXTogcGx1Z2lucy90ZWxpdC5jOnNpbV9pbnNlcnRlZF90aW1lb3V0X2NiKCkgMHg4ZTBmMTQw
PGJyPgpvZm9ub2RbNTgxMl06IE1vZGVtOiAmZ3Q7IEFUK0NSU009MTkyLDI4NTk5XHI8YnI+b2Zv
bm9kWzU4MTJdOiBNb2RlbTogJmx0OyBcclxuK0NNRSBFUlJPUjogMTAwXHJcbjxicj5vZm9ub2Rb
NTgxMl06IHNyYy92b2ljZWNhbGwuYzplY2NfZzJfcmVhZF9jYigpIDA8YnI+b2Zvbm9kWzU4MTJd
OiBNb2RlbTogJmd0OyBBVCtDUlNNPTE5MiwyODU5OVxyPGJyPm9mb25vZFs1ODEyXTogTW9kZW06
ICZsdDsgXHJcbitDTUUgRVJST1I6IDEwMFxyXG48YnI+Cm9mb25vZFs1ODEyXTogc3JjL3ZvaWNl
Y2FsbC5jOmVjY19nM19yZWFkX2NiKCkgMDxicj5vZm9ub2RbNTgxMl06IE1vZGVtOiAmZ3Q7IEFU
K0NSU009MTkyLDEyMjU4XHI8YnI+b2Zvbm9kWzU4MTJdOiBNb2RlbTogJmx0OyBcclxuK0NNRSBF
UlJPUjogMTAwXHJcbjxicj5vZm9ub2RbNTgxMl06IE1vZGVtOiAmZ3Q7IEFUK0NSU009MTkyLDI4
NDIxXHI8YnI+b2Zvbm9kWzU4MTJdOiBNb2RlbTogJmx0OyBcclxuK0NNRSBFUlJPUjogMTAwXHJc
bjxicj4Kb2Zvbm9kWzU4MTJdOiBNb2RlbTogJmd0OyBBVCtDUlNNPTE5MiwxMjAzN1xyPGJyPm9m
b25vZFs1ODEyXTogTW9kZW06ICZsdDsgXHJcbitDTUUgRVJST1I6IDEwMFxyXG48YnI+b2Zvbm9k
WzU4MTJdOiBNb2RlbTogJmd0OyBBVCtDUElOP1xyPGJyPm9mb25vZFs1ODEyXTogTW9kZW06ICZs
dDsgXHJcbitDTUUgRVJST1I6IDEwXHJcbjxicj5vZm9ub2RbNTgxMl06IFF1ZXJ5aW5nIFBJTiBh
dXRoZW50aWNhdGlvbiBzdGF0ZSBmYWlsZWQ8YnI+Cjxicj48YnI+Cg==

--===============5368885901876749815==--

