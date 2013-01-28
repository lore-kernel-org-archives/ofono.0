Content-Type: multipart/mixed; boundary="===============6879529400184536115=="
MIME-Version: 1.0
From: Renat Zaripov <r.r.zaripov@gmail.com>
Subject: Re: [PATCH] Simcom support
Date: Mon, 28 Jan 2013 17:43:45 +0400
Message-ID: <CAGNC_aN0RQaPUMNY0q7Up=z+8V8MpymeQXMjTRiBQ68NZj-odw@mail.gmail.com>
In-Reply-To: <1359045900-17358-1-git-send-email-viallard@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6879529400184536115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

I'll get started to test patch that sended by Anthony in previous email.
Patch have some errors, but I'm fix it.

renat(a)zaripov:~/work/ofono$ patch -p 1 < ../simcom.patch
patching file Makefile.am
Hunk #1 succeeded at 407 (offset 36 lines).
patching file drivers/atmodem/sms.c
patching file drivers/atmodem/sim.c
Hunk #1 FAILED at 1023.
1 out of 1 hunk FAILED -- saving rejects to file drivers/atmodem/sim.c.rej
patching file drivers/atmodem/network-registration.c
Hunk #1 succeeded at 1740 (offset 329 lines).
Hunk #2 succeeded@1893 (offset 351 lines).
patching file plugins/simcom.c

Build done successfully, and udev pick simcom plugin for sim900:

root(a)zaripov:/home/renat/work/ofono/src# export OFONO_AT_DEBUG=3D1 &&
./ofonod -nd "*"
ofonod[17539]: oFono version 1.12
ofonod[17539]: src/plugin.c:__ofono_plugin_init()
ofonod[17539]: plugins/push-notification.c:push_notification_init()
ofonod[17539]: plugins/smart-messaging.c:smart_messaging_init()
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8194e40,
name: stktest
ofonod[17539]: src/modem.c:ofono_modem_create() name: stktest, type: stktest
ofonod[17539]: src/modem.c:ofono_modem_register() 0x9c99f40
ofonod[17539]: plugins/stktest.c:stktest_probe() 0x9c99f40
ofonod[17539]: src/modem.c:emit_modem_added() 0x9c99f40
ofonod[17539]: src/modem.c:call_modemwatches() 0x9c99f40 added:1
ofonod[17539]: plugins/smart-messaging.c:modem_watch() modem: 0x9c99f40,
added: 1
ofonod[17539]: plugins/push-notification.c:modem_watch() modem: 0x9c99f40,
added: 1
ofonod[17539]: examples/emulator.c:example_emulator_init()
ofonod[17539]: examples/emulator.c:modem_watch() modem: 0x9c99f40, added: 1
ofonod[17539]: src/gprs-provision.c:ofono_gprs_provision_driver_register()
driver: 0x8194da0 name: Example GPRS context provisioning
ofonod[17539]: src/nettime.c:ofono_nettime_driver_register() driver:
0x8194d60 name: Example Network Time
ofonod[17539]: src/history.c:ofono_history_driver_register() driver:
0x8194d20 name: Example Call History
ofonod[17539]: src/cdma-provision.c:ofono_cdma_provision_driver_register()
driver: 0x8194ce0 name: CDMA provisioning
ofonod[17539]: src/gprs-provision.c:ofono_gprs_provision_driver_register()
driver: 0x8194ca0 name: Provisioning
ofonod[17539]: plugins/connman.c:connman_init()
ofonod[17539]:
src/private-network.c:ofono_private_network_driver_register() driver:
0x8194c60, name: ConnMan Private Network
ofonod[17539]: plugins/dun_gw.c:dun_gw_init()
ofonod[17539]: plugins/dun_gw.c:modem_watch() modem: 0x9c99f40, added: 1
ofonod[17539]: plugins/hfp_ag.c:modem_watch() modem: 0x9c99f40, added: 1
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8194ba0,
name: hfp
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8194b40,
name: sap
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8194ac0,
name: telit
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x81949c0,
name: sim900
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8194960,
name: samsung
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8194900,
name: speedupcdma
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x81948a0,
name: speedup
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8194840,
name: alcatel
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x81947e0,
name: icera
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8194780,
name: linktop
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8194720,
name: nokiacdma
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x81946c0,
name: nokia
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8194660,
name: tc65
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x81945c0,
name: ste
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8194560,
name: ifx
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8194500,
name: palmpre
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x81944a0,
name: novatel
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8194440,
name: sierra
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x81943c0,
name: huawei
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8194360,
name: zte
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8194300,
name: hso
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x81942a0,
name: mbm
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8194240,
name: calypso
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x81941e0,
name: wavecom
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8194180,
name: g1
ofonod[17539]: src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register()
driver: 0x8194100, name: cdmamodem
ofonod[17539]: src/modem.c:ofono_devinfo_driver_register() driver:
0x8194120, name: cdmamodem
ofonod[17539]: src/cdma-connman.c:ofono_cdma_connman_driver_register()
driver: 0x8194144, name: cdmamodem
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8194060,
name: phonesim
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x81940a0,
name: localhfp
ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8194034, name: phonesim
ofonod[17539]: src/ctm.c:ofono_ctm_driver_register() driver: 0x8194020,
name: phonesim
ofonod[17539]: plugins/phonesim.c:parse_config() filename
/etc/ofono/phonesim.conf
ofonod[17539]: Reading of /etc/ofono/phonesim.conf failed: No such file or
directory
ofonod[17539]: src/ussd.c:ofono_ussd_driver_register() driver: 0x8193fe0,
name: speedupmodem
ofonod[17539]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8193ec0, name: hfpmodem
ofonod[17539]: src/modem.c:ofono_devinfo_driver_register() driver:
0x8193f7c, name: hfpmodem
ofonod[17539]: src/network.c:ofono_netreg_driver_register() driver:
0x8193f20, name: hfpmodem
ofonod[17539]: src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x8193f54, name: hfpmodem
ofonod[17539]: src/handsfree.c:ofono_handsfree_driver_register() driver:
0x8193f98, name: hfpmodem
ofonod[17539]: src/network.c:ofono_netreg_driver_register() driver:
0x8193e40, name: dunmodem
ofonod[17539]: src/gprs.c:ofono_gprs_driver_register() driver: 0x8193e6c,
name: dunmodem
ofonod[17539]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8193d60, name: stemodem
ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8193dec, name: stemodem
ofonod[17539]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8193dc0, name: stemodem
ofonod[17539]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8193c20, name: ifxmodem
ofonod[17539]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x8193c70, name: ifxmodem
ofonod[17539]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8193ca0, name: ifxmodem
ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8193ccc, name: ifxmodem
ofonod[17539]: src/stk.c:ofono_stk_driver_register() driver: 0x8193cf4,
name: ifxmodem
ofonod[17539]: src/ctm.c:ofono_ctm_driver_register() driver: 0x8193d1c,
name: ifxmodem
ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8193ba0, name: hsomodem
ofonod[17539]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8193bc0, name: hsomodem
ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8193b00, name: mbmmodem
ofonod[17539]: src/stk.c:ofono_stk_driver_register() driver: 0x8193b28,
name: mbmmodem
ofonod[17539]:
src/location-reporting.c:ofono_location_reporting_driver_register() driver:
0x8193b48, name: mbmmodem
ofonod[17539]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8193a60, name: calypsomodem
ofonod[17539]: src/stk.c:ofono_stk_driver_register() driver: 0x8193aa8,
name: calypsomodem
ofonod[17539]: src/ussd.c:ofono_ussd_driver_register() driver: 0x8193940,
name: huaweimodem
ofonod[17539]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8193960, name: huaweimodem
ofonod[17539]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x81939a8, name: huaweimodem
ofonod[17539]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x81939e0, name: huaweimodem
ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x81939bc, name: huaweimodem
ofonod[17539]: src/cdma-netreg.c:ofono_cdma_netreg_driver_register()
driver: 0x8193a0c, name: huaweimodem
ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x81938a0, name: iceramodem
ofonod[17539]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x81938e0, name: iceramodem
ofonod[17539]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8193840, name: ztemodem
ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8193800, name: swmodem
ofonod[17539]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x81937a0, name: nwmodem
ofonod[17539]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8193600, name: atmodem
ofonod[17539]: src/modem.c:ofono_devinfo_driver_register() driver:
0x81936a0, name: atmodem
ofonod[17539]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x8193658, name: atmodem
ofonod[17539]:
src/call-forwarding.c:ofono_call_forwarding_driver_register() driver:
0x81933a0, name: atmodem
ofonod[17539]: src/call-meter.c:ofono_call_meter_driver_register() driver:
0x81933e0, name: atmodem
ofonod[17539]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x81932a0, name: atmodem
ofonod[17539]: src/phonebook.c:ofono_phonebook_driver_register() driver:
0x8193678, name: atmodem
ofonod[17539]: src/ussd.c:ofono_ussd_driver_register() driver: 0x81935d4,
name: atmodem
ofonod[17539]: src/sms.c:ofono_sms_driver_register() driver: 0x8193320,
name: atmodem
ofonod[17539]: src/sim.c:ofono_sim_driver_register() driver: 0x81934a0,
name: atmodem
ofonod[17539]: src/sim.c:ofono_sim_driver_register() driver: 0x8193500,
name: atmodem-noef
ofonod[17539]: src/stk.c:ofono_stk_driver_register() driver: 0x81935b4,
name: atmodem
ofonod[17539]: src/network.c:ofono_netreg_driver_register() driver:
0x8193440, name: atmodem
ofonod[17539]: src/cbs.c:ofono_cbs_driver_register() driver: 0x8193380,
name: atmodem
ofonod[17539]: src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x81936c4, name: atmodem
ofonod[17539]: src/gprs.c:ofono_gprs_driver_register() driver: 0x81936f4,
name: atmodem
ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8193718, name: atmodem
ofonod[17539]: src/sim-auth.c:ofono_sim_auth_driver_register() driver:
0x8193730, name: atmodem
ofonod[17539]: src/gnss.c:ofono_gnss_driver_register() driver: 0x8193748,
name: atmodem
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8193080,
name: gobi
ofonod[17539]: src/modem.c:ofono_devinfo_driver_register() driver:
0x8192e40, name: qmimodem
ofonod[17539]: src/network.c:ofono_netreg_driver_register() driver:
0x8192ec0, name: qmimodem
ofonod[17539]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8192e60, name: qmimodem
ofonod[17539]: src/sim.c:ofono_sim_driver_register() driver: 0x8192f00,
name: qmimodem-legacy
ofonod[17539]: src/sim.c:ofono_sim_driver_register() driver: 0x8192f60,
name: qmimodem
ofonod[17539]: src/sms.c:ofono_sms_driver_register() driver: 0x8192fc0,
name: qmimodem
ofonod[17539]: src/ussd.c:ofono_ussd_driver_register() driver: 0x8192fe0,
name: qmimodem
ofonod[17539]: src/gprs.c:ofono_gprs_driver_register() driver: 0x8192ff4,
name: qmimodem
ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8193008, name: qmimodem
ofonod[17539]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8193020, name: qmimodem
ofonod[17539]:
src/location-reporting.c:ofono_location_reporting_driver_register() driver:
0x8193044, name: qmimodem
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8192de0,
name: u8500
ofonod[17539]: src/modem.c:ofono_devinfo_driver_register() driver:
0x8192dc0, name: u8500
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8192d60,
name: n900
ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver: 0x8192d00,
name: isiusb
ofonod[17539]: src/modem.c:ofono_devinfo_driver_register() driver:
0x81929f0, name: isimodem
ofonod[17539]: src/phonebook.c:ofono_phonebook_driver_register() driver:
0x81929e0, name: isimodem
ofonod[17539]: src/network.c:ofono_netreg_driver_register() driver:
0x8192a20, name: isimodem
ofonod[17539]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8192a60, name: isimodem
ofonod[17539]: src/sms.c:ofono_sms_driver_register() driver: 0x8192ac0,
name: isimodem
ofonod[17539]: src/cbs.c:ofono_cbs_driver_register() driver: 0x8192ae0,
name: isimodem
ofonod[17539]: src/sim.c:ofono_sim_driver_register() driver: 0x8192b00,
name: isimodem
ofonod[17539]: src/ussd.c:ofono_ussd_driver_register() driver: 0x8192b48,
name: isimodem
ofonod[17539]:
src/call-forwarding.c:ofono_call_forwarding_driver_register() driver:
0x8192b60, name: isimodem
ofonod[17539]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x8192b80, name: isimodem
ofonod[17539]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x8192bb0, name: isimodem
ofonod[17539]: src/call-meter.c:ofono_call_meter_driver_register() driver:
0x8192be0, name: isimodem
ofonod[17539]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8192c20, name: isimodem
ofonod[17539]: src/gprs.c:ofono_gprs_driver_register() driver: 0x8192c44,
name: isimodem
ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8192c58, name: isimodem
ofonod[17539]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x8192c70, name: isimodem
ofonod[17539]: src/sim.c:ofono_sim_driver_register() driver: 0x8192c80,
name: wgmodem2.5
ofonod[17539]: plugins/udevng.c:udev_start()
ofonod[17539]: plugins/udevng.c:enumerate_devices()
ofonod[17539]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17539]: plugins/udevng.c:check_usb_device() usb [8087:0020]
ofonod[17539]: plugins/udevng.c:check_usb_device() usb [1a40:0101]
ofonod[17539]: plugins/udevng.c:check_usb_device() usb [067b:2303]
ofonod[17539]: plugins/udevng.c:check_usb_device() pl2303 [(null):(null)]
ofonod[17539]: plugins/udevng.c:check_usb_device() pl2303 [067b:2303]
ofonod[17539]: plugins/udevng.c:check_usb_device() usb [067b:2303]
ofonod[17539]: plugins/udevng.c:check_usb_device() pl2303 [(null):(null)]
ofonod[17539]: plugins/udevng.c:check_usb_device() pl2303 [067b:2303]
ofonod[17539]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17539]: plugins/udevng.c:check_usb_device() usb [0409:005a]
ofonod[17539]: plugins/udevng.c:check_usb_device() usb [058f:6254]
ofonod[17539]: plugins/udevng.c:check_usb_device() usb [058f:6366]
ofonod[17539]: plugins/udevng.c:check_usb_device() usb-storage
[(null):(null)]
ofonod[17539]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17539]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17539]: plugins/udevng.c:check_usb_device() usb [046d:c05a]
ofonod[17539]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
ofonod[17539]: plugins/udevng.c:check_usb_device() usb [045e:00db]
ofonod[17539]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
ofonod[17539]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
ofonod[17539]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17539]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17539]: plugins/udevng.c:check_usb_device() usb [8087:0020]
ofonod[17539]: plugins/udevng.c:check_usb_device() usb [0403:6010]
ofonod[17539]: plugins/udevng.c:check_usb_device() ftdi_sio [(null):(null)]
ofonod[17539]: plugins/udevng.c:check_usb_device() ftdi_sio [0403:6010]
ofonod[17539]: plugins/udevng.c:check_usb_device() ftdi_sio [(null):(null)]
ofonod[17539]: plugins/udevng.c:check_usb_device() ftdi_sio [0403:6010]
ofonod[17539]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17539]: src/modem.c:ofono_modem_create() name: (null), type: simcom
ofonod[17539]: src/modem.c:set_modem_property() modem 0x9ca15b8 property
Path
ofonod[17539]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6:1.1/ttyUSB3/tty/ttyUS=
B3
(simcom)
ofonod[17539]:
src/private-network.c:ofono_private_network_driver_register() driver:
0x8194e00, name: Example Private Network Driver
ofonod[17539]: plugins/bluetooth.c:manager_properties_cb()
ofonod[17539]: plugins/bluetooth.c:parse_adapters()

But any simcom device is not available via list-modems:

renat(a)zaripov:~/work/ofono$ test/list-modems
[ /stktest ]
    Features =3D
    Emergency =3D 0
    Powered =3D 0
    Lockdown =3D 0
    Interfaces =3D
    Online =3D 0
    Type =3D test

Any ideas why that happened?

Best regards,
Renat Zaripov


2013/1/24 Anthony Viallard <viallard@syscom-instruments.com>

> Add SIMCOM support.
>
> I developped this with the SIM5216E chipset.
>
> SMS and GPRS work. I don't add voice part because i don't use it so
> can't test it.
>
> Signed-off-by: Anthony Viallard <homer242@gmail.com>
> --- ofono-1.6.orig/Makefile.am  2012-04-20 21:06:29.000000000 +0200
> +++ ofono-1.6/Makefile.am       2013-01-21 17:17:48.089627277 +0100
> @@ -371,6 +371,9 @@ builtin_sources +=3D plugins/samsung.c
>  builtin_modules +=3D sim900
>  builtin_sources +=3D plugins/sim900.c
>
> +builtin_modules +=3D simcom
> +builtin_sources +=3D plugins/simcom.c
> +
>  if BLUETOOTH
>  builtin_modules +=3D bluetooth
>  builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
> --- ofono-1.6.orig/drivers/atmodem/sms.c        2012-04-20
> 21:06:29.000000000 +0200
> +++ ofono-1.6/drivers/atmodem/sms.c     2013-01-21 16:48:44.460627485 +01=
00
> @@ -805,6 +807,7 @@ static gboolean build_cnmi_string(char *
>         case OFONO_VENDOR_NOVATEL:
>         case OFONO_VENDOR_HUAWEI:
>         case OFONO_VENDOR_ZTE:
> +       case OFONO_VENDOR_SIMCOM:
>                 /* MSM devices advertise support for mode 2, but return an
>                  * error if we attempt to actually use it. */
>                 mode =3D "1";
> diff -pruN ofono-1.6.orig/drivers/atmodem/sim.c
> ofono-1.6/drivers/atmodem/sim.c
> --- ofono-1.6.orig/drivers/atmodem/sim.c        2013-01-23
> 11:38:22.959609087 +0100
> +++ ofono-1.6/drivers/atmodem/sim.c     2013-01-23 11:57:52.602608948 +01=
00
> @@ -1023,10 +1023,16 @@ static void at_pin_send_cb(gboolean ok,
>                                                         FALSE, cbd,
> g_free);
>                 return;
>         case OFONO_VENDOR_ZTE:
> +       case OFONO_VENDOR_SIMCOM:
>                 /*
>                  * On ZTE modems, after pin is entered, SIM state is
> checked
>                  * by polling CPIN as their modem doesn't provide
> unsolicited
>                  * notification of SIM readiness.
> +                *
> +                * On SIMCOM modems, SIM is busy after pin is entered
> (we've
> +                * got an "+CME ERROR: 14" at "AT+CPIN?" request) and ofo=
no
> +                * don't catch the "+CPIN: READY" message sent by the mod=
em
> +                * when SIM is ready. So, use extra CPIN to check the
> state.
>                  */
>                 sd->sim_state_query =3D at_util_sim_state_query_new(sd->c=
hat,
>                                                 2, 20, sim_state_cb, cbd,
> diff -purN ofono-1.6/drivers/atmodem/network-registration.c
> ofono-patched/drivers/atmodem/network-registration.c
> --- ofono-1.6/drivers/atmodem/network-registration.c    2013-01-18
> 15:04:03.598659165 +0100
> +++ ofono-patched/drivers/atmodem/network-registration.c        2013-01-18
> 14:54:03.256659236 +0100
> @@ -1411,6 +1411,14 @@ static void at_creg_set_cb(gboolean ok,
>         }
>
>         switch (nd->vendor) {
> +       case OFONO_VENDOR_SIMCOM:
> +               /* Register for CSQ changes */
> +               g_at_chat_send(nd->chat, "AT+AUTOCSQ=3D1,1", none_prefix,
> +                               NULL, NULL, NULL);
> +
> +               g_at_chat_register(nd->chat, "+CSQ:",
> +                                  csq_notify, FALSE, netreg, NULL);
> +               break;
>         case OFONO_VENDOR_PHONESIM:
>                 g_at_chat_register(nd->chat, "+CSQ:",
>                                         csq_notify, FALSE, netreg, NULL);
> @@ -1534,7 +1537,6 @@ static void at_creg_set_cb(gboolean ok,
>                 break;
>         case OFONO_VENDOR_NOKIA:
>         case OFONO_VENDOR_SAMSUNG:
> -       case OFONO_VENDOR_SIMCOM:
>                 /* Signal strength reporting via CIND is not supported */
>                 break;
>         default:
> --- /dev/null   2013-01-16 10:54:41.551089567 +0100
> +++ ofono-1.6/plugins/simcom.c  2013-01-23 10:43:05.631609483 +0100
> @@ -0,0 +1,308 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
>  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <errno.h>
> +#include <stdlib.h>
> +
> +#include <glib.h>
> +#include <gatchat.h>
> +#include <gattty.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/plugin.h>
> +#include <ofono/modem.h>
> +#include <ofono/devinfo.h>
> +#include <ofono/netreg.h>
> +#include <ofono/sim.h>
> +#include <ofono/cbs.h>
> +#include <ofono/sms.h>
> +#include <ofono/ussd.h>
> +#include <ofono/gprs.h>
> +#include <ofono/gprs-context.h>
> +#include <ofono/radio-settings.h>
> +#include <ofono/phonebook.h>
> +#include <ofono/log.h>
> +
> +#include <drivers/atmodem/atutil.h>
> +#include <drivers/atmodem/vendor.h>
> +
> +static const char *none_prefix[] =3D { NULL };
> +
> +struct simcom_data {
> +       GAtChat *modem;
> +       GAtChat *data;
> +};
> +
> +/* Callback and helpers functions */
> +static void simcom_debug(const char *str, void *user_data)
> +{
> +       const char *prefix =3D user_data;
> +
> +       ofono_info("%s%s", prefix, str);
> +}
> +
> +static void cfun_enable(gboolean ok, GAtResult *result, gpointer
> user_data)
> +{
> +       struct ofono_modem *modem =3D user_data;
> +       struct simcom_data *data =3D ofono_modem_get_data(modem);
> +
> +       DBG("");
> +
> +       if (!ok) {
> +               g_at_chat_unref(data->modem);
> +               data->modem =3D NULL;
> +
> +               g_at_chat_unref(data->data);
> +               data->data =3D NULL;
> +
> +               ofono_modem_set_powered(modem, FALSE);
> +               return;
> +       }
> +
> +       ofono_modem_set_powered(modem, TRUE);
> +}
> +
> +static void cfun_disable(gboolean ok, GAtResult *result, gpointer
> user_data)
> +{
> +       struct ofono_modem *modem =3D user_data;
> +       struct simcom_data *data =3D ofono_modem_get_data(modem);
> +
> +       DBG("");
> +
> +       g_at_chat_unref(data->data);
> +       data->data =3D NULL;
> +
> +       if (ok)
> +               ofono_modem_set_powered(modem, FALSE);
> +}
> +
> +static GAtChat *open_device(struct ofono_modem *modem,
> +                           const char *key,
> +                           char *debug)
> +{
> +       const char *device;
> +       GIOChannel *channel;
> +       GAtSyntax *syntax;
> +       GAtChat *chat;
> +       /* GHashTable *options; */
> +
> +       device =3D ofono_modem_get_string(modem, key);
> +       if (device =3D=3D NULL)
> +               return NULL;
> +
> +       DBG("%s %s", key, device);
> +
> +       /* options =3D g_hash_table_new(g_str_hash, g_str_equal); */
> +       /* if (options =3D=3D NULL) */
> +       /*      return NULL; */
> +
> +       /* g_hash_table_insert(options, "Baud", "115200"); */
> +       /* g_hash_table_insert(options, "Parity", "none"); */
> +       /* g_hash_table_insert(options, "StopBits", "1"); */
> +       /* g_hash_table_insert(options, "DataBits", "8"); */
> +       /* g_hash_table_insert(options, "XonXoff", "off"); */
> +       /* g_hash_table_insert(options, "RtsCts", "on"); */
> +       /* g_hash_table_insert(options, "Local", "on"); */
> +       /* g_hash_table_insert(options, "Read", "on"); */
> +
> +       channel =3D g_at_tty_open(device, NULL);
> +
> +       /* g_hash_table_destroy(options); */
> +
> +       if (channel =3D=3D NULL)
> +               return NULL;
> +
> +       syntax =3D g_at_syntax_new_gsm_permissive();
> +       chat =3D g_at_chat_new(channel, syntax);
> +       g_at_syntax_unref(syntax);
> +
> +       g_io_channel_unref(channel);
> +
> +       if (chat =3D=3D NULL)
> +               return NULL;
> +
> +       if (getenv("OFONO_AT_DEBUG"))
> +               g_at_chat_set_debug(chat, simcom_debug, debug);
> +
> +       return chat;
> +}
> +
> +/* Modem interface function */
> +static int simcom_probe(struct ofono_modem *modem)
> +{
> +       struct simcom_data *data;
> +
> +       DBG("%p", modem);
> +
> +       data =3D g_try_new0(struct simcom_data, 1);
> +       if (data =3D=3D NULL)
> +               return -ENOMEM;
> +
> +       ofono_modem_set_data(modem, data);
> +
> +       return 0;
> +}
> +
> +static void simcom_remove(struct ofono_modem *modem)
> +{
> +       struct simcom_data *data =3D ofono_modem_get_data(modem);
> +
> +       DBG("%p", modem);
> +
> +       ofono_modem_set_data(modem, NULL);
> +
> +       /* Cleanup after hot-unplug */
> +       g_at_chat_unref(data->data);
> +
> +       g_free(data);
> +}
> +
> +static int simcom_enable(struct ofono_modem *modem)
> +{
> +       struct simcom_data *data =3D ofono_modem_get_data(modem);
> +
> +       DBG("%p", modem);
> +
> +       data->modem =3D open_device(modem, "Modem", "Modem: ");
> +       if (data->modem =3D=3D NULL)
> +               return -EINVAL;
> +
> +       data->data =3D open_device(modem, "Data", "Data: ");
> +       if (data->data =3D=3D NULL) {
> +               g_at_chat_unref(data->modem);
> +               data->modem =3D NULL;
> +               return -EIO;
> +       }
> +
> +       g_at_chat_set_slave(data->modem, data->data);
> +
> +       g_at_chat_blacklist_terminator(data->data,
> +                                       G_AT_CHAT_TERMINATOR_NO_CARRIER);
> +
> +       /* init modem */
> +       g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", NULL, NULL, NULL,
> NULL);
> +       g_at_chat_send(data->data, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NU=
LL);
> +
> +       g_at_chat_send(data->data, "AT+CFUN=3D1", none_prefix,
> +                      cfun_enable, modem, NULL);
> +
> +       return -EINPROGRESS;
> +}
> +
> +static int simcom_disable(struct ofono_modem *modem)
> +{
> +       struct simcom_data *data =3D ofono_modem_get_data(modem);
> +
> +       DBG("%p", modem);
> +
> +       g_at_chat_cancel_all(data->modem);
> +       g_at_chat_unregister_all(data->modem);
> +
> +       g_at_chat_unref(data->modem);
> +       data->modem =3D NULL;
> +
> +       g_at_chat_cancel_all(data->data);
> +       g_at_chat_unregister_all(data->data);
> +
> +       g_at_chat_send(data->data, "AT+CFUN=3D4", none_prefix,
> +                      cfun_disable, modem, NULL);
> +
> +       return -EINPROGRESS;
> +}
> +
> +static void simcom_pre_sim(struct ofono_modem *modem)
> +{
> +       struct simcom_data *data =3D ofono_modem_get_data(modem);
> +       struct ofono_sim *sim;
> +
> +       DBG("%p", modem);
> +
> +       ofono_devinfo_create(modem, 0, "atmodem", data->data);
> +       sim =3D ofono_sim_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> +                               data->data);
> +
> +       if (sim)
> +               ofono_sim_inserted_notify(sim, TRUE);
> +}
> +
> +static void simcom_post_sim(struct ofono_modem *modem)
> +{
> +       struct simcom_data *data =3D ofono_modem_get_data(modem);
> +       struct ofono_message_waiting *mw;
> +       struct ofono_gprs *gprs;
> +       struct ofono_gprs_context *gc;
> +
> +       DBG("%p", modem);
> +
> +       ofono_phonebook_create(modem, 0, "atmodem", data->data);
> +
> +       ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> +                               data->data);
> +
> +       /* gprs things */
> +       gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->data);
> +       gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem=
);
> +
> +       if(gprs && gc)
> +       {
> +               ofono_gprs_add_context(gprs, gc);
> +       }
> +}
> +
> +static void simcom_post_online(struct ofono_modem *modem)
> +{
> +       struct simcom_data *data =3D ofono_modem_get_data(modem);
> +
> +       DBG("%p", modem);
> +
> +       ofono_netreg_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> data->data);
> +       ofono_cbs_create(modem, 0, "atmodem", data->data);
> +       ofono_ussd_create(modem, 0, "atmodem", data->data);
> +}
> +
> +static struct ofono_modem_driver simcom_driver =3D {
> +       .name           =3D "simcom",
> +       .probe          =3D simcom_probe,
> +       .remove         =3D simcom_remove,
> +       .enable         =3D simcom_enable,
> +       .disable        =3D simcom_disable,
> +       .pre_sim        =3D simcom_pre_sim,
> +       .post_sim       =3D simcom_post_sim,
> +       .post_online    =3D simcom_post_online,
> +};
> +
> +static int simcom_init(void)
> +{
> +       return ofono_modem_driver_register(&simcom_driver);
> +}
> +
> +static void simcom_exit(void)
> +{
> +       ofono_modem_driver_unregister(&simcom_driver);
> +}
> +
> +OFONO_PLUGIN_DEFINE(simcom, "SIMCOM modem driver", VERSION,
> +                   OFONO_PLUGIN_PRIORITY_DEFAULT,
> +                   simcom_init, simcom_exit)
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============6879529400184536115==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkhoDxkaXY+PGJyPjwvZGl2PjxkaXYgc3R5bGU+PGRpdj5JJiMzOTts
bCBnZXQgc3RhcnRlZCB0byB0ZXN0IHBhdGNoIHRoYXQgc2VuZGVkIGJ5IEFudGhvbnkgaW4gcHJl
dmlvdXMgZW1haWwuoDwvZGl2PjxkaXY+UGF0Y2ggaGF2ZSBzb21lIGVycm9ycywgYnV0IEkmIzM5
O20gZml4IGl0LjwvZGl2PjwvZGl2PjxkaXYgc3R5bGU+PGRpdj48YnI+cmVuYXRAemFyaXBvdjp+
L3dvcmsvb2Zvbm8kIHBhdGNoIC1wIDEgJmx0OyAuLi9zaW1jb20ucGF0Y2igPC9kaXY+Cgo8ZGl2
PnBhdGNoaW5nIGZpbGUgTWFrZWZpbGUuYW08L2Rpdj48ZGl2Pkh1bmsgIzEgc3VjY2VlZGVkIGF0
IDQwNyAob2Zmc2V0IDM2IGxpbmVzKS48L2Rpdj48ZGl2PnBhdGNoaW5nIGZpbGUgZHJpdmVycy9h
dG1vZGVtL3Ntcy5jPC9kaXY+PGRpdj5wYXRjaGluZyBmaWxlIGRyaXZlcnMvYXRtb2RlbS9zaW0u
YzwvZGl2PjxkaXY+SHVuayAjMSBGQUlMRUQgYXQgMTAyMy48L2Rpdj48ZGl2PgoKMSBvdXQgb2Yg
MSBodW5rIEZBSUxFRCAtLSBzYXZpbmcgcmVqZWN0cyB0byBmaWxlIGRyaXZlcnMvYXRtb2RlbS9z
aW0uYy5yZWo8L2Rpdj48ZGl2PnBhdGNoaW5nIGZpbGUgZHJpdmVycy9hdG1vZGVtL25ldHdvcmst
cmVnaXN0cmF0aW9uLmM8L2Rpdj48ZGl2Pkh1bmsgIzEgc3VjY2VlZGVkIGF0IDE3NDAgKG9mZnNl
dCAzMjkgbGluZXMpLjwvZGl2PjxkaXY+SHVuayAjMiBzdWNjZWVkZWQgYXQgMTg5MyAob2Zmc2V0
IDM1MSBsaW5lcykuPC9kaXY+Cgo8ZGl2PnBhdGNoaW5nIGZpbGUgcGx1Z2lucy9zaW1jb20uYzxi
cj48YnI+QnVpbGQgZG9uZSBzdWNjZXNzZnVsbHksIGFuZCB1ZGV2IHBpY2sgc2ltY29tIHBsdWdp
biBmb3Igc2ltOTAwOjxicj48YnI+PGRpdj5yb290QHphcmlwb3Y6L2hvbWUvcmVuYXQvd29yay9v
Zm9uby9zcmMjIGV4cG9ydCBPRk9OT19BVF9ERUJVRz0xICZhbXA7JmFtcDsgLi9vZm9ub2QgLW5k
ICZxdW90OyomcXVvdDs8L2Rpdj4KCjxkaXY+b2Zvbm9kWzE3NTM5XTogb0Zvbm8gdmVyc2lvbiAx
LjEyPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvcGx1Z2luLmM6X19vZm9ub19wbHVnaW5f
aW5pdCgpoDwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTogcGx1Z2lucy9wdXNoLW5vdGlmaWNhdGlv
bi5jOnB1c2hfbm90aWZpY2F0aW9uX2luaXQoKaA8L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHBs
dWdpbnMvc21hcnQtbWVzc2FnaW5nLmM6c21hcnRfbWVzc2FnaW5nX2luaXQoKaA8L2Rpdj4KCjxk
aXY+b2Zvbm9kWzE3NTM5XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDgxOTRlNDAsIG5hbWU6IHN0a3Rlc3Q8L2Rpdj48ZGl2Pm9mb25vZFsxNzUz
OV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2NyZWF0ZSgpIG5hbWU6IHN0a3Rlc3QsIHR5cGU6
IHN0a3Rlc3Q8L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVt
X3JlZ2lzdGVyKCkgMHg5Yzk5ZjQwPC9kaXY+Cgo8ZGl2Pm9mb25vZFsxNzUzOV06IHBsdWdpbnMv
c3RrdGVzdC5jOnN0a3Rlc3RfcHJvYmUoKSAweDljOTlmNDA8L2Rpdj48ZGl2Pm9mb25vZFsxNzUz
OV06IHNyYy9tb2RlbS5jOmVtaXRfbW9kZW1fYWRkZWQoKSAweDljOTlmNDA8L2Rpdj48ZGl2Pm9m
b25vZFsxNzUzOV06IHNyYy9tb2RlbS5jOmNhbGxfbW9kZW13YXRjaGVzKCkgMHg5Yzk5ZjQwIGFk
ZGVkOjE8L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHBsdWdpbnMvc21hcnQtbWVzc2FnaW5nLmM6
bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg5Yzk5ZjQwLCBhZGRlZDogMTwvZGl2PgoKPGRpdj5vZm9u
b2RbMTc1MzldOiBwbHVnaW5zL3B1c2gtbm90aWZpY2F0aW9uLmM6bW9kZW1fd2F0Y2goKSBtb2Rl
bTogMHg5Yzk5ZjQwLCBhZGRlZDogMTwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTogZXhhbXBsZXMv
ZW11bGF0b3IuYzpleGFtcGxlX2VtdWxhdG9yX2luaXQoKaA8L2Rpdj48ZGl2Pm9mb25vZFsxNzUz
OV06IGV4YW1wbGVzL2VtdWxhdG9yLmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg5Yzk5ZjQwLCBh
ZGRlZDogMTwvZGl2PgoKPGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvZ3Bycy1wcm92aXNpb24uYzpv
Zm9ub19ncHJzX3Byb3Zpc2lvbl9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5NGRhMCBu
YW1lOiBFeGFtcGxlIEdQUlMgY29udGV4dCBwcm92aXNpb25pbmc8L2Rpdj48ZGl2Pm9mb25vZFsx
NzUzOV06IHNyYy9uZXR0aW1lLmM6b2Zvbm9fbmV0dGltZV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4ODE5NGQ2MCBuYW1lOiBFeGFtcGxlIE5ldHdvcmsgVGltZTwvZGl2PgoKPGRpdj5vZm9u
b2RbMTc1MzldOiBzcmMvaGlzdG9yeS5jOm9mb25vX2hpc3RvcnlfZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxOTRkMjAgbmFtZTogRXhhbXBsZSBDYWxsIEhpc3Rvcnk8L2Rpdj48ZGl2Pm9m
b25vZFsxNzUzOV06IHNyYy9jZG1hLXByb3Zpc2lvbi5jOm9mb25vX2NkbWFfcHJvdmlzaW9uX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk0Y2UwIG5hbWU6IENETUEgcHJvdmlzaW9uaW5n
PC9kaXY+Cgo8ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9ncHJzLXByb3Zpc2lvbi5jOm9mb25vX2dw
cnNfcHJvdmlzaW9uX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk0Y2EwIG5hbWU6IFBy
b3Zpc2lvbmluZzwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTogcGx1Z2lucy9jb25ubWFuLmM6Y29u
bm1hbl9pbml0KCmgPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvcHJpdmF0ZS1uZXR3b3Jr
LmM6b2Zvbm9fcHJpdmF0ZV9uZXR3b3JrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk0
YzYwLCBuYW1lOiBDb25uTWFuIFByaXZhdGUgTmV0d29yazwvZGl2PgoKPGRpdj5vZm9ub2RbMTc1
MzldOiBwbHVnaW5zL2R1bl9ndy5jOmR1bl9nd19pbml0KCmgPC9kaXY+PGRpdj5vZm9ub2RbMTc1
MzldOiBwbHVnaW5zL2R1bl9ndy5jOm1vZGVtX3dhdGNoKCkgbW9kZW06IDB4OWM5OWY0MCwgYWRk
ZWQ6IDE8L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHBsdWdpbnMvaGZwX2FnLmM6bW9kZW1fd2F0
Y2goKSBtb2RlbTogMHg5Yzk5ZjQwLCBhZGRlZDogMTwvZGl2PgoKPGRpdj5vZm9ub2RbMTc1Mzld
OiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5
NGJhMCwgbmFtZTogaGZwPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpvZm9u
b19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5NGI0MCwgbmFtZTogc2FwPC9k
aXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4ODE5NGFjMCwgbmFtZTogdGVsaXQ8L2Rpdj4KCjxkaXY+b2Zvbm9k
WzE3NTM5XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
OiAweDgxOTQ5YzAsIG5hbWU6IHNpbTkwMDwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTogc3JjL21v
ZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTQ5NjAsIG5h
bWU6IHNhbXN1bmc8L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9tb2RlbS5jOm9mb25vX21v
ZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk0OTAwLCBuYW1lOiBzcGVlZHVwY2Rt
YTwvZGl2PgoKPGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5NDhhMCwgbmFtZTogc3BlZWR1cDwvZGl2PjxkaXY+
b2Zvbm9kWzE3NTM5XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxOTQ4NDAsIG5hbWU6IGFsY2F0ZWw8L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06
IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk0
N2UwLCBuYW1lOiBpY2VyYTwvZGl2PgoKPGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpv
Zm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5NDc4MCwgbmFtZTogbGlu
a3RvcDwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTQ3MjAsIG5hbWU6IG5va2lhY2RtYTwvZGl2Pjxk
aXY+b2Zvbm9kWzE3NTM5XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDgxOTQ2YzAsIG5hbWU6IG5va2lhPC9kaXY+Cgo8ZGl2Pm9mb25vZFsxNzUz
OV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4
MTk0NjYwLCBuYW1lOiB0YzY1PC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpv
Zm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5NDVjMCwgbmFtZTogc3Rl
PC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5NDU2MCwgbmFtZTogaWZ4PC9kaXY+Cgo8ZGl2Pm9mb25v
ZFsxNzUzOV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg4MTk0NTAwLCBuYW1lOiBwYWxtcHJlPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMv
bW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5NDRhMCwg
bmFtZTogbm92YXRlbDwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTogc3JjL21vZGVtLmM6b2Zvbm9f
bW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTQ0NDAsIG5hbWU6IHNpZXJyYTwv
ZGl2PgoKPGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5NDNjMCwgbmFtZTogaHVhd2VpPC9kaXY+PGRpdj5vZm9u
b2RbMTc1MzldOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4ODE5NDM2MCwgbmFtZTogenRlPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvbW9k
ZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5NDMwMCwgbmFt
ZTogaHNvPC9kaXY+Cgo8ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVt
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk0MmEwLCBuYW1lOiBtYm08L2Rpdj48ZGl2
Pm9mb25vZFsxNzUzOV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg4MTk0MjQwLCBuYW1lOiBjYWx5cHNvPC9kaXY+PGRpdj5vZm9ub2RbMTc1Mzld
OiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5
NDFlMCwgbmFtZTogd2F2ZWNvbTwvZGl2PgoKPGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0u
YzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5NDE4MCwgbmFtZTog
ZzE8L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9jZG1hLXZvaWNlY2FsbC5jOm9mb25vX2Nk
bWFfdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk0MTAwLCBuYW1lOiBj
ZG1hbW9kZW08L2Rpdj48ZGl2PgpvZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpvZm9ub19kZXZp
bmZvX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk0MTIwLCBuYW1lOiBjZG1hbW9kZW08
L2Rpdj4KPGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvY2RtYS1jb25ubWFuLmM6b2Zvbm9fY2RtYV9j
b25ubWFuX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk0MTQ0LCBuYW1lOiBjZG1hbW9k
ZW08L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk0MDYwLCBuYW1lOiBwaG9uZXNpbTwvZGl2PjxkaXY+
CgpvZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4ODE5NDBhMCwgbmFtZTogbG9jYWxoZnA8L2Rpdj48ZGl2Pm9mb25vZFsxNzUz
OV06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg4MTk0MDM0LCBuYW1lOiBwaG9uZXNpbTwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTogc3Jj
L2N0bS5jOm9mb25vX2N0bV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5NDAyMCwgbmFt
ZTogcGhvbmVzaW08L2Rpdj4KCjxkaXY+b2Zvbm9kWzE3NTM5XTogcGx1Z2lucy9waG9uZXNpbS5j
OnBhcnNlX2NvbmZpZygpIGZpbGVuYW1lIC9ldGMvb2Zvbm8vcGhvbmVzaW0uY29uZjwvZGl2Pjxk
aXY+b2Zvbm9kWzE3NTM5XTogUmVhZGluZyBvZiAvZXRjL29mb25vL3Bob25lc2ltLmNvbmYgZmFp
bGVkOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5PC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBz
cmMvdXNzZC5jOm9mb25vX3Vzc2RfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTNmZTAs
IG5hbWU6IHNwZWVkdXBtb2RlbTwvZGl2PgoKPGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvdm9pY2Vj
YWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTkzZWMw
LCBuYW1lOiBoZnBtb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTogc3JjL21vZGVtLmM6b2Zv
bm9fZGV2aW5mb19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5M2Y3YywgbmFtZTogaGZw
bW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVn
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTkzZjIwLCBuYW1lOiBoZnBtb2RlbTwvZGl2
PgoKPGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvY2FsbC12b2x1bWUuYzpvZm9ub19jYWxsX3ZvbHVt
ZV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5M2Y1NCwgbmFtZTogaGZwbW9kZW08L2Rp
dj48ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9oYW5kc2ZyZWUuYzpvZm9ub19oYW5kc2ZyZWVfZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTNmOTgsIG5hbWU6IGhmcG1vZGVtPC9kaXY+Cgo8
ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg4MTkzZTQwLCBuYW1lOiBkdW5tb2RlbTwvZGl2PjxkaXY+b2Zvbm9k
WzE3NTM5XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg4MTkzZTZjLCBuYW1lOiBkdW5tb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTogc3JjL3Zv
aWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5
M2Q2MCwgbmFtZTogc3RlbW9kZW08L2Rpdj4KCjxkaXY+b2Zvbm9kWzE3NTM5XTogc3JjL2dwcnMu
YzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTNkZWMs
IG5hbWU6IHN0ZW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvcmFkaW8tc2V0dGlu
Z3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5
M2RjMCwgbmFtZTogc3RlbW9kZW08L2Rpdj4KCjxkaXY+b2Zvbm9kWzE3NTM5XTogc3JjL3ZvaWNl
Y2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5M2My
MCwgbmFtZTogaWZ4bW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9hdWRpby1zZXR0
aW5ncy5jOm9mb25vX2F1ZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4
MTkzYzcwLCBuYW1lOiBpZnhtb2RlbTwvZGl2PgoKPGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvcmFk
aW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4ODE5M2NhMCwgbmFtZTogaWZ4bW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHNy
Yy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4
MTkzY2NjLCBuYW1lOiBpZnhtb2RlbTwvZGl2PgoKPGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvc3Rr
LmM6b2Zvbm9fc3RrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTkzY2Y0LCBuYW1lOiBp
Znhtb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTogc3JjL2N0bS5jOm9mb25vX2N0bV9kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5M2QxYywgbmFtZTogaWZ4bW9kZW08L2Rpdj48ZGl2
Pm9mb25vZFsxNzUzOV06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg4MTkzYmEwLCBuYW1lOiBoc29tb2RlbTwvZGl2PgoKPGRpdj5vZm9u
b2RbMTc1MzldOiBzcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5M2JjMCwgbmFtZTogaHNvbW9kZW08L2Rpdj48ZGl2
Pm9mb25vZFsxNzUzOV06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg4MTkzYjAwLCBuYW1lOiBtYm1tb2RlbTwvZGl2PgoKPGRpdj5vZm9u
b2RbMTc1MzldOiBzcmMvc3RrLmM6b2Zvbm9fc3RrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg4MTkzYjI4LCBuYW1lOiBtYm1tb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTogc3JjL2xv
Y2F0aW9uLXJlcG9ydGluZy5jOm9mb25vX2xvY2F0aW9uX3JlcG9ydGluZ19kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4ODE5M2I0OCwgbmFtZTogbWJtbW9kZW08L2Rpdj4KCjxkaXY+b2Zvbm9k
WzE3NTM5XTogc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4ODE5M2E2MCwgbmFtZTogY2FseXBzb21vZGVtPC9kaXY+PGRpdj5vZm9ub2Rb
MTc1MzldOiBzcmMvc3RrLmM6b2Zvbm9fc3RrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4
MTkzYWE4LCBuYW1lOiBjYWx5cHNvbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy91
c3NkLmM6b2Zvbm9fdXNzZF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5Mzk0MCwgbmFt
ZTogaHVhd2VpbW9kZW08L2Rpdj4KCjxkaXY+b2Zvbm9kWzE3NTM5XTogc3JjL3ZvaWNlY2FsbC5j
Om9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5Mzk2MCwgbmFt
ZTogaHVhd2VpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9hdWRpby1zZXR0aW5n
cy5jOm9mb25vX2F1ZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTkz
OWE4LCBuYW1lOiBodWF3ZWltb2RlbTwvZGl2PgoKPGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvcmFk
aW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4ODE5MzllMCwgbmFtZTogaHVhd2VpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06
IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg4MTkzOWJjLCBuYW1lOiBodWF3ZWltb2RlbTwvZGl2PgoKPGRpdj5vZm9ub2RbMTc1MzldOiBz
cmMvY2RtYS1uZXRyZWcuYzpvZm9ub19jZG1hX25ldHJlZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4ODE5M2EwYywgbmFtZTogaHVhd2VpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06
IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg4MTkzOGEwLCBuYW1lOiBpY2VyYW1vZGVtPC9kaXY+Cgo8ZGl2Pm9mb25vZFsxNzUzOV06IHNy
Yy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg4MTkzOGUwLCBuYW1lOiBpY2VyYW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTc1
MzldOiBzcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4ODE5Mzg0MCwgbmFtZTogenRlbW9kZW08L2Rpdj4KCjxkaXY+b2Zv
bm9kWzE3NTM5XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDgxOTM4MDAsIG5hbWU6IHN3bW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNzUz
OV06IHNyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg4MTkzN2EwLCBuYW1lOiBud21vZGVtPC9kaXY+Cgo8ZGl2Pm9mb25v
ZFsxNzUzOV06IHNyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDgxOTM2MDAsIG5hbWU6IGF0bW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNzUz
OV06IHNyYy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAw
eDgxOTM2YTAsIG5hbWU6IGF0bW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9jYWxs
LWJhcnJpbmcuYzpvZm9ub19jYWxsX2JhcnJpbmdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAw
eDgxOTM2NTgsIG5hbWU6IGF0bW9kZW08L2Rpdj4KCjxkaXY+b2Zvbm9kWzE3NTM5XTogc3JjL2Nh
bGwtZm9yd2FyZGluZy5jOm9mb25vX2NhbGxfZm9yd2FyZGluZ19kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6IDB4ODE5MzNhMCwgbmFtZTogYXRtb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTog
c3JjL2NhbGwtbWV0ZXIuYzpvZm9ub19jYWxsX21ldGVyX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg4MTkzM2UwLCBuYW1lOiBhdG1vZGVtPC9kaXY+Cgo8ZGl2Pm9mb25vZFsxNzUzOV06IHNy
Yy9jYWxsLXNldHRpbmdzLmM6b2Zvbm9fY2FsbF9zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6IDB4ODE5MzJhMCwgbmFtZTogYXRtb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTog
c3JjL3Bob25lYm9vay5jOm9mb25vX3Bob25lYm9va19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
IDB4ODE5MzY3OCwgbmFtZTogYXRtb2RlbTwvZGl2PgoKPGRpdj5vZm9ub2RbMTc1MzldOiBzcmMv
dXNzZC5jOm9mb25vX3Vzc2RfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTM1ZDQsIG5h
bWU6IGF0bW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9zbXMuYzpvZm9ub19zbXNf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTMzMjAsIG5hbWU6IGF0bW9kZW08L2Rpdj48
ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxOTM0YTAsIG5hbWU6IGF0bW9kZW08L2Rpdj4KCjxkaXY+b2Zvbm9kWzE3NTM5
XTogc3JjL3NpbS5jOm9mb25vX3NpbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5MzUw
MCwgbmFtZTogYXRtb2RlbS1ub2VmPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvc3RrLmM6
b2Zvbm9fc3RrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTkzNWI0LCBuYW1lOiBhdG1v
ZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5MzQ0MCwgbmFtZTogYXRtb2RlbTwvZGl2PgoK
PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvY2JzLmM6b2Zvbm9fY2JzX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg4MTkzMzgwLCBuYW1lOiBhdG1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTc1Mzld
OiBzcmMvY2FsbC12b2x1bWUuYzpvZm9ub19jYWxsX3ZvbHVtZV9kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6IDB4ODE5MzZjNCwgbmFtZTogYXRtb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTog
c3JjL2dwcnMuYzpvZm9ub19ncHJzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTkzNmY0
LCBuYW1lOiBhdG1vZGVtPC9kaXY+Cgo8ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9ncHJzLmM6b2Zv
bm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTkzNzE4LCBuYW1l
OiBhdG1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvc2ltLWF1dGguYzpvZm9ub19z
aW1fYXV0aF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5MzczMCwgbmFtZTogYXRtb2Rl
bTwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTogc3JjL2duc3MuYzpvZm9ub19nbnNzX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg4MTkzNzQ4LCBuYW1lOiBhdG1vZGVtPC9kaXY+Cgo8ZGl2Pm9m
b25vZFsxNzUzOV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg4MTkzMDgwLCBuYW1lOiBnb2JpPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMv
bW9kZW0uYzpvZm9ub19kZXZpbmZvX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTkyZTQw
LCBuYW1lOiBxbWltb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTogc3JjL25ldHdvcmsuYzpv
Zm9ub19uZXRyZWdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTJlYzAsIG5hbWU6IHFt
aW1vZGVtPC9kaXY+Cgo8ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy92b2ljZWNhbGwuYzpvZm9ub192
b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTJlNjAsIG5hbWU6IHFtaW1v
ZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvc2ltLmM6b2Zvbm9fc2ltX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg4MTkyZjAwLCBuYW1lOiBxbWltb2RlbS1sZWdhY3k8L2Rpdj48
ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxOTJmNjAsIG5hbWU6IHFtaW1vZGVtPC9kaXY+Cgo8ZGl2Pm9mb25vZFsxNzUz
OV06IHNyYy9zbXMuYzpvZm9ub19zbXNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTJm
YzAsIG5hbWU6IHFtaW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvdXNzZC5jOm9m
b25vX3Vzc2RfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTJmZTAsIG5hbWU6IHFtaW1v
ZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTJmZjQsIG5hbWU6IHFtaW1vZGVtPC9kaXY+Cgo8ZGl2
Pm9mb25vZFsxNzUzOV06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg4MTkzMDA4LCBuYW1lOiBxbWltb2RlbTwvZGl2PjxkaXY+b2Zvbm9k
WzE3NTM5XTogc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTMwMjAsIG5hbWU6IHFtaW1vZGVtPC9kaXY+Cgo8ZGl2
Pm9mb25vZFsxNzUzOV06IHNyYy9sb2NhdGlvbi1yZXBvcnRpbmcuYzpvZm9ub19sb2NhdGlvbl9y
ZXBvcnRpbmdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTMwNDQsIG5hbWU6IHFtaW1v
ZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5MmRlMCwgbmFtZTogdTg1MDA8L2Rpdj4KCjxkaXY+
b2Zvbm9kWzE3NTM5XTogc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5mb19kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4ODE5MmRjMCwgbmFtZTogdTg1MDA8L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06
IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTky
ZDYwLCBuYW1lOiBuOTAwPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpvZm9u
b19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5MmQwMCwgbmFtZTogaXNpdXNi
PC9kaXY+Cgo8ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTI5ZjAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+PGRp
dj5vZm9ub2RbMTc1MzldOiBzcmMvcGhvbmVib29rLmM6b2Zvbm9fcGhvbmVib29rX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg4MTkyOWUwLCBuYW1lOiBpc2ltb2RlbTwvZGl2PjxkaXY+b2Zv
bm9kWzE3NTM5XTogc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxOTJhMjAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+Cgo8ZGl2Pm9mb25vZFsxNzUz
OV06IHNyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDgxOTJhNjAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBz
cmMvc21zLmM6b2Zvbm9fc21zX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTkyYWMwLCBu
YW1lOiBpc2ltb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTogc3JjL2Nicy5jOm9mb25vX2Ni
c19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5MmFlMCwgbmFtZTogaXNpbW9kZW08L2Rp
dj4KCjxkaXY+b2Zvbm9kWzE3NTM5XTogc3JjL3NpbS5jOm9mb25vX3NpbV9kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4ODE5MmIwMCwgbmFtZTogaXNpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsx
NzUzOV06IHNyYy91c3NkLmM6b2Zvbm9fdXNzZF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
ODE5MmI0OCwgbmFtZTogaXNpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9jYWxs
LWZvcndhcmRpbmcuYzpvZm9ub19jYWxsX2ZvcndhcmRpbmdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDgxOTJiNjAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+Cgo8ZGl2Pm9mb25vZFsxNzUzOV06
IHNyYy9jYWxsLXNldHRpbmdzLmM6b2Zvbm9fY2FsbF9zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4ODE5MmI4MCwgbmFtZTogaXNpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNzUz
OV06IHNyYy9jYWxsLWJhcnJpbmcuYzpvZm9ub19jYWxsX2JhcnJpbmdfZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDgxOTJiYjAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+Cgo8ZGl2Pm9mb25vZFsx
NzUzOV06IHNyYy9jYWxsLW1ldGVyLmM6b2Zvbm9fY2FsbF9tZXRlcl9kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4ODE5MmJlMCwgbmFtZTogaXNpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNzUz
OV06IHNyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg4MTkyYzIwLCBuYW1lOiBpc2ltb2RlbTwvZGl2PgoKPGRpdj5vZm9u
b2RbMTc1MzldOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
OiAweDgxOTJjNDQsIG5hbWU6IGlzaW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBzcmMv
Z3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5
MmM1OCwgbmFtZTogaXNpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHNyYy9hdWRpby1z
ZXR0aW5ncy5jOm9mb25vX2F1ZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg4MTkyYzcwLCBuYW1lOiBpc2ltb2RlbTwvZGl2PgoKPGRpdj5vZm9ub2RbMTc1MzldOiBzcmMv
c2ltLmM6b2Zvbm9fc2ltX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTkyYzgwLCBuYW1l
OiB3Z21vZGVtMi41PC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBwbHVnaW5zL3VkZXZuZy5jOnVk
ZXZfc3RhcnQoKaA8L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHBsdWdpbnMvdWRldm5nLmM6ZW51
bWVyYXRlX2RldmljZXMoKaA8L2Rpdj48ZGl2PgoKb2Zvbm9kWzE3NTM5XTogcGx1Z2lucy91ZGV2
bmcuYzpjaGVja191c2JfZGV2aWNlKCkgaHViIFsobnVsbCk6KG51bGwpXTwvZGl2PjxkaXY+b2Zv
bm9kWzE3NTM5XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFs4MDg3
OjAwMjBdPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3Vz
Yl9kZXZpY2UoKSB1c2IgWzFhNDA6MDEwMV08L2Rpdj4KCjxkaXY+b2Zvbm9kWzE3NTM5XTogcGx1
Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFswNjdiOjIzMDNdPC9kaXY+PGRp
dj5vZm9ub2RbMTc1MzldOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBwbDIz
MDMgWyhudWxsKToobnVsbCldPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBwbHVnaW5zL3VkZXZu
Zy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBwbDIzMDMgWzA2N2I6MjMwM108L2Rpdj4KCjxkaXY+b2Zv
bm9kWzE3NTM5XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFswNjdi
OjIzMDNdPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3Vz
Yl9kZXZpY2UoKSBwbDIzMDMgWyhudWxsKToobnVsbCldPC9kaXY+PGRpdj5vZm9ub2RbMTc1Mzld
OiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBwbDIzMDMgWzA2N2I6MjMwM108
L2Rpdj4KCjxkaXY+b2Zvbm9kWzE3NTM5XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2
aWNlKCkgaHViIFsobnVsbCk6KG51bGwpXTwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTogcGx1Z2lu
cy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFswNDA5OjAwNWFdPC9kaXY+PGRpdj5v
Zm9ub2RbMTc1MzldOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSB1c2IgWzA1
OGY6NjI1NF08L2Rpdj4KCjxkaXY+b2Zvbm9kWzE3NTM5XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVj
a191c2JfZGV2aWNlKCkgdXNiIFswNThmOjYzNjZdPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBw
bHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSB1c2Itc3RvcmFnZSBbKG51bGwpOihu
dWxsKV08L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNi
X2RldmljZSgpIGh1YiBbKG51bGwpOihudWxsKV08L2Rpdj4KCjxkaXY+b2Zvbm9kWzE3NTM5XTog
cGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgaHViIFsobnVsbCk6KG51bGwpXTwv
ZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNl
KCkgdXNiIFswNDZkOmMwNWFdPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBwbHVnaW5zL3VkZXZu
Zy5jOmNoZWNrX3VzYl9kZXZpY2UoKSB1c2JoaWQgWyhudWxsKToobnVsbCldPC9kaXY+Cgo8ZGl2
Pm9mb25vZFsxNzUzOV06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBb
MDQ1ZTowMGRiXTwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVj
a191c2JfZGV2aWNlKCkgdXNiaGlkIFsobnVsbCk6KG51bGwpXTwvZGl2PjxkaXY+b2Zvbm9kWzE3
NTM5XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiaGlkIFsobnVsbCk6
KG51bGwpXTwvZGl2PgoKPGRpdj5vZm9ub2RbMTc1MzldOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNr
X3VzYl9kZXZpY2UoKSBodWIgWyhudWxsKToobnVsbCldPC9kaXY+PGRpdj5vZm9ub2RbMTc1Mzld
OiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBodWIgWyhudWxsKToobnVsbCld
PC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZp
Y2UoKSB1c2IgWzgwODc6MDAyMF08L2Rpdj4KCjxkaXY+b2Zvbm9kWzE3NTM5XTogcGx1Z2lucy91
ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFswNDAzOjYwMTBdPC9kaXY+PGRpdj5vZm9u
b2RbMTc1MzldOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBmdGRpX3NpbyBb
KG51bGwpOihudWxsKV08L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHBsdWdpbnMvdWRldm5nLmM6
Y2hlY2tfdXNiX2RldmljZSgpIGZ0ZGlfc2lvIFswNDAzOjYwMTBdPC9kaXY+Cgo8ZGl2Pm9mb25v
ZFsxNzUzOV06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIGZ0ZGlfc2lvIFso
bnVsbCk6KG51bGwpXTwvZGl2PjxkaXY+b2Zvbm9kWzE3NTM5XTogcGx1Z2lucy91ZGV2bmcuYzpj
aGVja191c2JfZGV2aWNlKCkgZnRkaV9zaW8gWzA0MDM6NjAxMF08L2Rpdj48ZGl2Pm9mb25vZFsx
NzUzOV06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIGh1YiBbKG51bGwpOihu
dWxsKV08L2Rpdj4KCjxkaXY+b2Zvbm9kWzE3NTM5XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1f
Y3JlYXRlKCkgbmFtZTogKG51bGwpLCB0eXBlOiBzaW1jb208L2Rpdj48ZGl2Pm9mb25vZFsxNzUz
OV06IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OWNhMTViOCBwcm9w
ZXJ0eSBQYXRoPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBwbHVnaW5zL3VkZXYuYzphZGRfbW9k
ZW0oKSAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWQuMC91c2IyLzItMS8yLTEuNi8yLTEu
NjoxLjEvdHR5VVNCMy90dHkvdHR5VVNCMyAoc2ltY29tKTwvZGl2PgoKPGRpdj5vZm9ub2RbMTc1
MzldOiBzcmMvcHJpdmF0ZS1uZXR3b3JrLmM6b2Zvbm9fcHJpdmF0ZV9uZXR3b3JrX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg4MTk0ZTAwLCBuYW1lOiBFeGFtcGxlIFByaXZhdGUgTmV0d29y
ayBEcml2ZXI8L2Rpdj48ZGl2Pm9mb25vZFsxNzUzOV06IHBsdWdpbnMvYmx1ZXRvb3RoLmM6bWFu
YWdlcl9wcm9wZXJ0aWVzX2NiKCmgPC9kaXY+PGRpdj5vZm9ub2RbMTc1MzldOiBwbHVnaW5zL2Js
dWV0b290aC5jOnBhcnNlX2FkYXB0ZXJzKCmgPC9kaXY+Cgo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2IHN0eWxlPkJ1dCBhbnkgc2ltY29tIGRldmljZSBpcyBub3QgYXZhaWxhYmxlIHZpYSBsaXN0
LW1vZGVtczo8YnI+PGJyPjxkaXY+cmVuYXRAemFyaXBvdjp+L3dvcmsvb2Zvbm8kIHRlc3QvbGlz
dC1tb2RlbXOgPC9kaXY+PGRpdj5bIC9zdGt0ZXN0IF08L2Rpdj48ZGl2PqAgoCBGZWF0dXJlcyA9
oDwvZGl2PjxkaXY+oCCgIEVtZXJnZW5jeSA9IDA8L2Rpdj4KCjxkaXY+oCCgIFBvd2VyZWQgPSAw
PC9kaXY+PGRpdj6gIKAgTG9ja2Rvd24gPSAwPC9kaXY+PGRpdj6gIKAgSW50ZXJmYWNlcyA9oDwv
ZGl2PjxkaXY+oCCgIE9ubGluZSA9IDA8L2Rpdj48ZGl2PqAgoCBUeXBlID0gdGVzdDwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXYgc3R5bGU+QW55IGlkZWFzIHdoeSB0aGF0IGhhcHBlbmVkPzwvZGl2
PjxkaXYgc3R5bGU+PGJyPjwvZGl2PjxkaXYgc3R5bGU+CgpCZXN0IHJlZ2FyZHMsPGJyPlJlbmF0
IFphcmlwb3Y8L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+
PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxMy8xLzI0IEFudGhvbnkgVmlhbGxh
cmQgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86dmlhbGxhcmRAc3lzY29tLWlu
c3RydW1lbnRzLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnZpYWxsYXJkQHN5c2NvbS1pbnN0cnVtZW50
cy5jb208L2E+Jmd0Ozwvc3Bhbj48YnI+Cgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUi
IHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRk
aW5nLWxlZnQ6MWV4Ij5BZGQgU0lNQ09NIHN1cHBvcnQuPGJyPgo8YnI+CkkgZGV2ZWxvcHBlZCB0
aGlzIHdpdGggdGhlIFNJTTUyMTZFIGNoaXBzZXQuPGJyPgo8YnI+ClNNUyBhbmQgR1BSUyB3b3Jr
LiBJIGRvbiYjMzk7dCBhZGQgdm9pY2UgcGFydCBiZWNhdXNlIGkgZG9uJiMzOTt0IHVzZSBpdCBz
bzxicj4KY2FuJiMzOTt0IHRlc3QgaXQuPGJyPgo8YnI+ClNpZ25lZC1vZmYtYnk6IEFudGhvbnkg
VmlhbGxhcmQgJmx0O2hvbWVyMjQyIGF0IDxhIGhyZWY9Imh0dHA6Ly9nbWFpbC5jb20iIHRhcmdl
dD0iX2JsYW5rIj5nbWFpbC5jb208L2E+Jmd0Ozxicj4KLS0tIG9mb25vLTEuNi5vcmlnL01ha2Vm
aWxlLmFtIKAyMDEyLTA0LTIwIDIxOjA2OjI5LjAwMDAwMDAwMCArMDIwMDxicj4KKysrIG9mb25v
LTEuNi9NYWtlZmlsZS5hbSCgIKAgoCAyMDEzLTAxLTIxIDE3OjE3OjQ4LjA4OTYyNzI3NyArMDEw
MDxicj4KQEAgLTM3MSw2ICszNzEsOSBAQCBidWlsdGluX3NvdXJjZXMgKz0gcGx1Z2lucy9zYW1z
dW5nLmM8YnI+CqBidWlsdGluX21vZHVsZXMgKz0gc2ltOTAwPGJyPgqgYnVpbHRpbl9zb3VyY2Vz
ICs9IHBsdWdpbnMvc2ltOTAwLmM8YnI+Cjxicj4KK2J1aWx0aW5fbW9kdWxlcyArPSBzaW1jb208
YnI+CitidWlsdGluX3NvdXJjZXMgKz0gcGx1Z2lucy9zaW1jb20uYzxicj4KKzxicj4KoGlmIEJM
VUVUT09USDxicj4KoGJ1aWx0aW5fbW9kdWxlcyArPSBibHVldG9vdGg8YnI+CqBidWlsdGluX3Nv
dXJjZXMgKz0gcGx1Z2lucy9ibHVldG9vdGguYyBwbHVnaW5zL2JsdWV0b290aC5oPGJyPgotLS0g
b2Zvbm8tMS42Lm9yaWcvZHJpdmVycy9hdG1vZGVtL3Ntcy5jIKAgoCCgIKAyMDEyLTA0LTIwIDIx
OjA2OjI5LjAwMDAwMDAwMCArMDIwMDxicj4KKysrIG9mb25vLTEuNi9kcml2ZXJzL2F0bW9kZW0v
c21zLmMgoCCgIDIwMTMtMDEtMjEgMTY6NDg6NDQuNDYwNjI3NDg1ICswMTAwPGJyPgpAQCAtODA1
LDYgKzgwNyw3IEBAIHN0YXRpYyBnYm9vbGVhbiBidWlsZF9jbm1pX3N0cmluZyhjaGFyICo8YnI+
CqAgoCCgIKAgY2FzZSBPRk9OT19WRU5ET1JfTk9WQVRFTDo8YnI+CqAgoCCgIKAgY2FzZSBPRk9O
T19WRU5ET1JfSFVBV0VJOjxicj4KoCCgIKAgoCBjYXNlIE9GT05PX1ZFTkRPUl9aVEU6PGJyPgor
IKAgoCCgIGNhc2UgT0ZPTk9fVkVORE9SX1NJTUNPTTo8YnI+CqAgoCCgIKAgoCCgIKAgoCAvKiBN
U00gZGV2aWNlcyBhZHZlcnRpc2Ugc3VwcG9ydCBmb3IgbW9kZSAyLCBidXQgcmV0dXJuIGFuPGJy
PgqgIKAgoCCgIKAgoCCgIKAgoCogZXJyb3IgaWYgd2UgYXR0ZW1wdCB0byBhY3R1YWxseSB1c2Ug
aXQuICovPGJyPgqgIKAgoCCgIKAgoCCgIKAgbW9kZSA9ICZxdW90OzEmcXVvdDs7PGJyPgpkaWZm
IC1wcnVOIG9mb25vLTEuNi5vcmlnL2RyaXZlcnMvYXRtb2RlbS9zaW0uYyBvZm9uby0xLjYvZHJp
dmVycy9hdG1vZGVtL3NpbS5jPGJyPgotLS0gb2Zvbm8tMS42Lm9yaWcvZHJpdmVycy9hdG1vZGVt
L3NpbS5jIKAgoCCgIKAyMDEzLTAxLTIzIDExOjM4OjIyLjk1OTYwOTA4NyArMDEwMDxicj4KKysr
IG9mb25vLTEuNi9kcml2ZXJzL2F0bW9kZW0vc2ltLmMgoCCgIDIwMTMtMDEtMjMgMTE6NTc6NTIu
NjAyNjA4OTQ4ICswMTAwPGJyPgpAQCAtMTAyMywxMCArMTAyMywxNiBAQCBzdGF0aWMgdm9pZCBh
dF9waW5fc2VuZF9jYihnYm9vbGVhbiBvayw8YnI+CqAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgRkFMU0UsIGNiZCwgZ19mcmVlKTs8YnI+CqAg
oCCgIKAgoCCgIKAgoCByZXR1cm47PGJyPgqgIKAgoCCgIGNhc2UgT0ZPTk9fVkVORE9SX1pURTo8
YnI+CisgoCCgIKAgY2FzZSBPRk9OT19WRU5ET1JfU0lNQ09NOjxicj4KoCCgIKAgoCCgIKAgoCCg
IC8qPGJyPgqgIKAgoCCgIKAgoCCgIKAgoCogT24gWlRFIG1vZGVtcywgYWZ0ZXIgcGluIGlzIGVu
dGVyZWQsIFNJTSBzdGF0ZSBpcyBjaGVja2VkPGJyPgqgIKAgoCCgIKAgoCCgIKAgoCogYnkgcG9s
bGluZyBDUElOIGFzIHRoZWlyIG1vZGVtIGRvZXNuJiMzOTt0IHByb3ZpZGUgdW5zb2xpY2l0ZWQ8
YnI+CqAgoCCgIKAgoCCgIKAgoCCgKiBub3RpZmljYXRpb24gb2YgU0lNIHJlYWRpbmVzcy48YnI+
CisgoCCgIKAgoCCgIKAgoCCgKjxicj4KKyCgIKAgoCCgIKAgoCCgIKAqIE9uIFNJTUNPTSBtb2Rl
bXMsIFNJTSBpcyBidXN5IGFmdGVyIHBpbiBpcyBlbnRlcmVkICh3ZSYjMzk7dmU8YnI+CisgoCCg
IKAgoCCgIKAgoCCgKiBnb3QgYW4gJnF1b3Q7K0NNRSBFUlJPUjogMTQmcXVvdDsgYXQgJnF1b3Q7
QVQrQ1BJTj8mcXVvdDsgcmVxdWVzdCkgYW5kIG9mb25vPGJyPgorIKAgoCCgIKAgoCCgIKAgoCog
ZG9uJiMzOTt0IGNhdGNoIHRoZSAmcXVvdDsrQ1BJTjogUkVBRFkmcXVvdDsgbWVzc2FnZSBzZW50
IGJ5IHRoZSBtb2RlbTxicj4KKyCgIKAgoCCgIKAgoCCgIKAqIHdoZW4gU0lNIGlzIHJlYWR5LiBT
bywgdXNlIGV4dHJhIENQSU4gdG8gY2hlY2sgdGhlIHN0YXRlLjxicj4KoCCgIKAgoCCgIKAgoCCg
IKAqLzxicj4KoCCgIKAgoCCgIKAgoCCgIHNkLSZndDtzaW1fc3RhdGVfcXVlcnkgPSBhdF91dGls
X3NpbV9zdGF0ZV9xdWVyeV9uZXcoc2QtJmd0O2NoYXQsPGJyPgqgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCAyLCAyMCwgc2ltX3N0YXRlX2NiLCBjYmQsPGJy
PgpkaWZmIC1wdXJOIG9mb25vLTEuNi9kcml2ZXJzL2F0bW9kZW0vbmV0d29yay1yZWdpc3RyYXRp
b24uYyBvZm9uby1wYXRjaGVkL2RyaXZlcnMvYXRtb2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5j
PGJyPgotLS0gb2Zvbm8tMS42L2RyaXZlcnMvYXRtb2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5j
IKAgoDIwMTMtMDEtMTggMTU6MDQ6MDMuNTk4NjU5MTY1ICswMTAwPGJyPgorKysgb2Zvbm8tcGF0
Y2hlZC9kcml2ZXJzL2F0bW9kZW0vbmV0d29yay1yZWdpc3RyYXRpb24uYyCgIKAgoCCgMjAxMy0w
MS0xOCAxNDo1NDowMy4yNTY2NTkyMzYgKzAxMDA8YnI+CkBAIC0xNDExLDYgKzE0MTEsMTQgQEAg
c3RhdGljIHZvaWQgYXRfY3JlZ19zZXRfY2IoZ2Jvb2xlYW4gb2ssPGJyPgqgIKAgoCCgIH08YnI+
Cjxicj4KoCCgIKAgoCBzd2l0Y2ggKG5kLSZndDt2ZW5kb3IpIHs8YnI+CisgoCCgIKAgY2FzZSBP
Rk9OT19WRU5ET1JfU0lNQ09NOjxicj4KKyCgIKAgoCCgIKAgoCCgIC8qIFJlZ2lzdGVyIGZvciBD
U1EgY2hhbmdlcyAqLzxicj4KKyCgIKAgoCCgIKAgoCCgIGdfYXRfY2hhdF9zZW5kKG5kLSZndDtj
aGF0LCAmcXVvdDtBVCtBVVRPQ1NRPTEsMSZxdW90Oywgbm9uZV9wcmVmaXgsPGJyPgorIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIE5VTEwsIE5VTEwsIE5VTEwpOzxicj4KKzxicj4KKyCg
IKAgoCCgIKAgoCCgIGdfYXRfY2hhdF9yZWdpc3RlcihuZC0mZ3Q7Y2hhdCwgJnF1b3Q7K0NTUTom
cXVvdDssPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoGNzcV9ub3RpZnks
IEZBTFNFLCBuZXRyZWcsIE5VTEwpOzxicj4KKyCgIKAgoCCgIKAgoCCgIGJyZWFrOzxicj4KoCCg
IKAgoCBjYXNlIE9GT05PX1ZFTkRPUl9QSE9ORVNJTTo8YnI+CqAgoCCgIKAgoCCgIKAgoCBnX2F0
X2NoYXRfcmVnaXN0ZXIobmQtJmd0O2NoYXQsICZxdW90OytDU1E6JnF1b3Q7LDxicj4KoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIGNzcV9ub3RpZnksIEZBTFNFLCBuZXRy
ZWcsIE5VTEwpOzxicj4KQEAgLTE1MzQsNyArMTUzNyw2IEBAIHN0YXRpYyB2b2lkIGF0X2NyZWdf
c2V0X2NiKGdib29sZWFuIG9rLDxicj4KoCCgIKAgoCCgIKAgoCCgIGJyZWFrOzxicj4KoCCgIKAg
oCBjYXNlIE9GT05PX1ZFTkRPUl9OT0tJQTo8YnI+CqAgoCCgIKAgY2FzZSBPRk9OT19WRU5ET1Jf
U0FNU1VORzo8YnI+Ci0goCCgIKAgY2FzZSBPRk9OT19WRU5ET1JfU0lNQ09NOjxicj4KoCCgIKAg
oCCgIKAgoCCgIC8qIFNpZ25hbCBzdHJlbmd0aCByZXBvcnRpbmcgdmlhIENJTkQgaXMgbm90IHN1
cHBvcnRlZCAqLzxicj4KoCCgIKAgoCCgIKAgoCCgIGJyZWFrOzxicj4KoCCgIKAgoCBkZWZhdWx0
Ojxicj4KLS0tIC9kZXYvbnVsbCCgIDIwMTMtMDEtMTYgMTA6NTQ6NDEuNTUxMDg5NTY3ICswMTAw
PGJyPgorKysgb2Zvbm8tMS42L3BsdWdpbnMvc2ltY29tLmMgoDIwMTMtMDEtMjMgMTA6NDM6MDUu
NjMxNjA5NDgzICswMTAwPGJyPgpAQCAtMCwwICsxLDMwOCBAQDxicj4KKy8qPGJyPgorICo8YnI+
CisgKiCgb0Zvbm8gLSBPcGVuIFNvdXJjZSBUZWxlcGhvbnk8YnI+CisgKjxicj4KKyAqIKBDb3B5
cmlnaHQgKEMpIDIwMDgtMjAxMSCgSW50ZWwgQ29ycG9yYXRpb24uIEFsbCByaWdodHMgcmVzZXJ2
ZWQuPGJyPgorICo8YnI+CisgKiCgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBj
YW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnk8YnI+CisgKiCgaXQgdW5kZXIgdGhlIHRl
cm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXM8YnI+Cisg
KiCgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uPGJyPgorICo8YnI+
CisgKiCgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2ls
bCBiZSB1c2VmdWwsPGJyPgorICogoGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBl
dmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mPGJyPgorICogoE1FUkNIQU5UQUJJTElUWSBvciBG
SVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4goFNlZSB0aGU8YnI+CisgKiCgR05VIEdl
bmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy48YnI+CisgKjxicj4KKyAqIKBZ
b3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZTxicj4KKyAqIKBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0
byB0aGUgRnJlZSBTb2Z0d2FyZTxicj4KKyAqIKBGb3VuZGF0aW9uLCBJbmMuLCA1MSBGcmFua2xp
biBTdCwgRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEgoDAyMTEwLTEzMDEgoFVTQTxicj4KKyAqPGJy
PgorICovPGJyPgorPGJyPgorI2lmZGVmIEhBVkVfQ09ORklHX0g8YnI+CisjaW5jbHVkZSAmbHQ7
Y29uZmlnLmgmZ3Q7PGJyPgorI2VuZGlmPGJyPgorPGJyPgorI2luY2x1ZGUgJmx0O2Vycm5vLmgm
Z3Q7PGJyPgorI2luY2x1ZGUgJmx0O3N0ZGxpYi5oJmd0Ozxicj4KKzxicj4KKyNpbmNsdWRlICZs
dDtnbGliLmgmZ3Q7PGJyPgorI2luY2x1ZGUgJmx0O2dhdGNoYXQuaCZndDs8YnI+CisjaW5jbHVk
ZSAmbHQ7Z2F0dHR5LmgmZ3Q7PGJyPgorPGJyPgorI2RlZmluZSBPRk9OT19BUElfU1VCSkVDVF9U
T19DSEFOR0U8YnI+CisjaW5jbHVkZSAmbHQ7b2Zvbm8vcGx1Z2luLmgmZ3Q7PGJyPgorI2luY2x1
ZGUgJmx0O29mb25vL21vZGVtLmgmZ3Q7PGJyPgorI2luY2x1ZGUgJmx0O29mb25vL2RldmluZm8u
aCZndDs8YnI+CisjaW5jbHVkZSAmbHQ7b2Zvbm8vbmV0cmVnLmgmZ3Q7PGJyPgorI2luY2x1ZGUg
Jmx0O29mb25vL3NpbS5oJmd0Ozxicj4KKyNpbmNsdWRlICZsdDtvZm9uby9jYnMuaCZndDs8YnI+
CisjaW5jbHVkZSAmbHQ7b2Zvbm8vc21zLmgmZ3Q7PGJyPgorI2luY2x1ZGUgJmx0O29mb25vL3Vz
c2QuaCZndDs8YnI+CisjaW5jbHVkZSAmbHQ7b2Zvbm8vZ3Bycy5oJmd0Ozxicj4KKyNpbmNsdWRl
ICZsdDtvZm9uby9ncHJzLWNvbnRleHQuaCZndDs8YnI+CisjaW5jbHVkZSAmbHQ7b2Zvbm8vcmFk
aW8tc2V0dGluZ3MuaCZndDs8YnI+CisjaW5jbHVkZSAmbHQ7b2Zvbm8vcGhvbmVib29rLmgmZ3Q7
PGJyPgorI2luY2x1ZGUgJmx0O29mb25vL2xvZy5oJmd0Ozxicj4KKzxicj4KKyNpbmNsdWRlICZs
dDtkcml2ZXJzL2F0bW9kZW0vYXR1dGlsLmgmZ3Q7PGJyPgorI2luY2x1ZGUgJmx0O2RyaXZlcnMv
YXRtb2RlbS92ZW5kb3IuaCZndDs8YnI+Cis8YnI+CitzdGF0aWMgY29uc3QgY2hhciAqbm9uZV9w
cmVmaXhbXSA9IHsgTlVMTCB9Ozxicj4KKzxicj4KK3N0cnVjdCBzaW1jb21fZGF0YSB7PGJyPgor
IKAgoCCgIEdBdENoYXQgKm1vZGVtOzxicj4KKyCgIKAgoCBHQXRDaGF0ICpkYXRhOzxicj4KK307
PGJyPgorPGJyPgorLyogQ2FsbGJhY2sgYW5kIGhlbHBlcnMgZnVuY3Rpb25zICovPGJyPgorc3Rh
dGljIHZvaWQgc2ltY29tX2RlYnVnKGNvbnN0IGNoYXIgKnN0ciwgdm9pZCAqdXNlcl9kYXRhKTxi
cj4KK3s8YnI+CisgoCCgIKAgY29uc3QgY2hhciAqcHJlZml4ID0gdXNlcl9kYXRhOzxicj4KKzxi
cj4KKyCgIKAgoCBvZm9ub19pbmZvKCZxdW90OyVzJXMmcXVvdDssIHByZWZpeCwgc3RyKTs8YnI+
Cit9PGJyPgorPGJyPgorc3RhdGljIHZvaWQgY2Z1bl9lbmFibGUoZ2Jvb2xlYW4gb2ssIEdBdFJl
c3VsdCAqcmVzdWx0LCBncG9pbnRlciB1c2VyX2RhdGEpPGJyPgorezxicj4KKyCgIKAgoCBzdHJ1
Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtID0gdXNlcl9kYXRhOzxicj4KKyCgIKAgoCBzdHJ1Y3Qgc2lt
Y29tX2RhdGEgKmRhdGEgPSBvZm9ub19tb2RlbV9nZXRfZGF0YShtb2RlbSk7PGJyPgorPGJyPgor
IKAgoCCgIERCRygmcXVvdDsmcXVvdDspOzxicj4KKzxicj4KKyCgIKAgoCBpZiAoIW9rKSB7PGJy
PgorIKAgoCCgIKAgoCCgIKAgZ19hdF9jaGF0X3VucmVmKGRhdGEtJmd0O21vZGVtKTs8YnI+Cisg
oCCgIKAgoCCgIKAgoCBkYXRhLSZndDttb2RlbSA9IE5VTEw7PGJyPgorPGJyPgorIKAgoCCgIKAg
oCCgIKAgZ19hdF9jaGF0X3VucmVmKGRhdGEtJmd0O2RhdGEpOzxicj4KKyCgIKAgoCCgIKAgoCCg
IGRhdGEtJmd0O2RhdGEgPSBOVUxMOzxicj4KKzxicj4KKyCgIKAgoCCgIKAgoCCgIG9mb25vX21v
ZGVtX3NldF9wb3dlcmVkKG1vZGVtLCBGQUxTRSk7PGJyPgorIKAgoCCgIKAgoCCgIKAgcmV0dXJu
Ozxicj4KKyCgIKAgoCB9PGJyPgorPGJyPgorIKAgoCCgIG9mb25vX21vZGVtX3NldF9wb3dlcmVk
KG1vZGVtLCBUUlVFKTs8YnI+Cit9PGJyPgorPGJyPgorc3RhdGljIHZvaWQgY2Z1bl9kaXNhYmxl
KGdib29sZWFuIG9rLCBHQXRSZXN1bHQgKnJlc3VsdCwgZ3BvaW50ZXIgdXNlcl9kYXRhKTxicj4K
K3s8YnI+CisgoCCgIKAgc3RydWN0IG9mb25vX21vZGVtICptb2RlbSA9IHVzZXJfZGF0YTs8YnI+
CisgoCCgIKAgc3RydWN0IHNpbWNvbV9kYXRhICpkYXRhID0gb2Zvbm9fbW9kZW1fZ2V0X2RhdGEo
bW9kZW0pOzxicj4KKzxicj4KKyCgIKAgoCBEQkcoJnF1b3Q7JnF1b3Q7KTs8YnI+Cis8YnI+Cisg
oCCgIKAgZ19hdF9jaGF0X3VucmVmKGRhdGEtJmd0O2RhdGEpOzxicj4KKyCgIKAgoCBkYXRhLSZn
dDtkYXRhID0gTlVMTDs8YnI+Cis8YnI+CisgoCCgIKAgaWYgKG9rKTxicj4KKyCgIKAgoCCgIKAg
oCCgIG9mb25vX21vZGVtX3NldF9wb3dlcmVkKG1vZGVtLCBGQUxTRSk7PGJyPgorfTxicj4KKzxi
cj4KK3N0YXRpYyBHQXRDaGF0ICpvcGVuX2RldmljZShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVt
LDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIGNvbnN0IGNoYXIgKmtleSw8YnI+Cisg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBjaGFyICpkZWJ1Zyk8YnI+Cit7PGJyPgorIKAgoCCg
IGNvbnN0IGNoYXIgKmRldmljZTs8YnI+CisgoCCgIKAgR0lPQ2hhbm5lbCAqY2hhbm5lbDs8YnI+
CisgoCCgIKAgR0F0U3ludGF4ICpzeW50YXg7PGJyPgorIKAgoCCgIEdBdENoYXQgKmNoYXQ7PGJy
PgorIKAgoCCgIC8qIEdIYXNoVGFibGUgKm9wdGlvbnM7ICovPGJyPgorPGJyPgorIKAgoCCgIGRl
dmljZSA9IG9mb25vX21vZGVtX2dldF9zdHJpbmcobW9kZW0sIGtleSk7PGJyPgorIKAgoCCgIGlm
IChkZXZpY2UgPT0gTlVMTCk8YnI+CisgoCCgIKAgoCCgIKAgoCByZXR1cm4gTlVMTDs8YnI+Cis8
YnI+CisgoCCgIKAgREJHKCZxdW90OyVzICVzJnF1b3Q7LCBrZXksIGRldmljZSk7PGJyPgorPGJy
PgorIKAgoCCgIC8qIG9wdGlvbnMgPSBnX2hhc2hfdGFibGVfbmV3KGdfc3RyX2hhc2gsIGdfc3Ry
X2VxdWFsKTsgKi88YnI+CisgoCCgIKAgLyogaWYgKG9wdGlvbnMgPT0gTlVMTCkgKi88YnI+Cisg
oCCgIKAgLyogoCCgIKByZXR1cm4gTlVMTDsgKi88YnI+Cis8YnI+CisgoCCgIKAgLyogZ19oYXNo
X3RhYmxlX2luc2VydChvcHRpb25zLCAmcXVvdDtCYXVkJnF1b3Q7LCAmcXVvdDsxMTUyMDAmcXVv
dDspOyAqLzxicj4KKyCgIKAgoCAvKiBnX2hhc2hfdGFibGVfaW5zZXJ0KG9wdGlvbnMsICZxdW90
O1Bhcml0eSZxdW90OywgJnF1b3Q7bm9uZSZxdW90Oyk7ICovPGJyPgorIKAgoCCgIC8qIGdfaGFz
aF90YWJsZV9pbnNlcnQob3B0aW9ucywgJnF1b3Q7U3RvcEJpdHMmcXVvdDssICZxdW90OzEmcXVv
dDspOyAqLzxicj4KKyCgIKAgoCAvKiBnX2hhc2hfdGFibGVfaW5zZXJ0KG9wdGlvbnMsICZxdW90
O0RhdGFCaXRzJnF1b3Q7LCAmcXVvdDs4JnF1b3Q7KTsgKi88YnI+CisgoCCgIKAgLyogZ19oYXNo
X3RhYmxlX2luc2VydChvcHRpb25zLCAmcXVvdDtYb25Yb2ZmJnF1b3Q7LCAmcXVvdDtvZmYmcXVv
dDspOyAqLzxicj4KKyCgIKAgoCAvKiBnX2hhc2hfdGFibGVfaW5zZXJ0KG9wdGlvbnMsICZxdW90
O1J0c0N0cyZxdW90OywgJnF1b3Q7b24mcXVvdDspOyAqLzxicj4KKyCgIKAgoCAvKiBnX2hhc2hf
dGFibGVfaW5zZXJ0KG9wdGlvbnMsICZxdW90O0xvY2FsJnF1b3Q7LCAmcXVvdDtvbiZxdW90Oyk7
ICovPGJyPgorIKAgoCCgIC8qIGdfaGFzaF90YWJsZV9pbnNlcnQob3B0aW9ucywgJnF1b3Q7UmVh
ZCZxdW90OywgJnF1b3Q7b24mcXVvdDspOyAqLzxicj4KKzxicj4KKyCgIKAgoCBjaGFubmVsID0g
Z19hdF90dHlfb3BlbihkZXZpY2UsIE5VTEwpOzxicj4KKzxicj4KKyCgIKAgoCAvKiBnX2hhc2hf
dGFibGVfZGVzdHJveShvcHRpb25zKTsgKi88YnI+Cis8YnI+CisgoCCgIKAgaWYgKGNoYW5uZWwg
PT0gTlVMTCk8YnI+CisgoCCgIKAgoCCgIKAgoCByZXR1cm4gTlVMTDs8YnI+Cis8YnI+CisgoCCg
IKAgc3ludGF4ID0gZ19hdF9zeW50YXhfbmV3X2dzbV9wZXJtaXNzaXZlKCk7PGJyPgorIKAgoCCg
IGNoYXQgPSBnX2F0X2NoYXRfbmV3KGNoYW5uZWwsIHN5bnRheCk7PGJyPgorIKAgoCCgIGdfYXRf
c3ludGF4X3VucmVmKHN5bnRheCk7PGJyPgorPGJyPgorIKAgoCCgIGdfaW9fY2hhbm5lbF91bnJl
ZihjaGFubmVsKTs8YnI+Cis8YnI+CisgoCCgIKAgaWYgKGNoYXQgPT0gTlVMTCk8YnI+CisgoCCg
IKAgoCCgIKAgoCByZXR1cm4gTlVMTDs8YnI+Cis8YnI+CisgoCCgIKAgaWYgKGdldGVudigmcXVv
dDtPRk9OT19BVF9ERUJVRyZxdW90OykpPGJyPgorIKAgoCCgIKAgoCCgIKAgZ19hdF9jaGF0X3Nl
dF9kZWJ1ZyhjaGF0LCBzaW1jb21fZGVidWcsIGRlYnVnKTs8YnI+Cis8YnI+CisgoCCgIKAgcmV0
dXJuIGNoYXQ7PGJyPgorfTxicj4KKzxicj4KKy8qIE1vZGVtIGludGVyZmFjZSBmdW5jdGlvbiAq
Lzxicj4KK3N0YXRpYyBpbnQgc2ltY29tX3Byb2JlKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0p
PGJyPgorezxicj4KKyCgIKAgoCBzdHJ1Y3Qgc2ltY29tX2RhdGEgKmRhdGE7PGJyPgorPGJyPgor
IKAgoCCgIERCRygmcXVvdDslcCZxdW90OywgbW9kZW0pOzxicj4KKzxicj4KKyCgIKAgoCBkYXRh
ID0gZ190cnlfbmV3MChzdHJ1Y3Qgc2ltY29tX2RhdGEsIDEpOzxicj4KKyCgIKAgoCBpZiAoZGF0
YSA9PSBOVUxMKTxicj4KKyCgIKAgoCCgIKAgoCCgIHJldHVybiAtRU5PTUVNOzxicj4KKzxicj4K
KyCgIKAgoCBvZm9ub19tb2RlbV9zZXRfZGF0YShtb2RlbSwgZGF0YSk7PGJyPgorPGJyPgorIKAg
oCCgIHJldHVybiAwOzxicj4KK308YnI+Cis8YnI+CitzdGF0aWMgdm9pZCBzaW1jb21fcmVtb3Zl
KHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0pPGJyPgorezxicj4KKyCgIKAgoCBzdHJ1Y3Qgc2lt
Y29tX2RhdGEgKmRhdGEgPSBvZm9ub19tb2RlbV9nZXRfZGF0YShtb2RlbSk7PGJyPgorPGJyPgor
IKAgoCCgIERCRygmcXVvdDslcCZxdW90OywgbW9kZW0pOzxicj4KKzxicj4KKyCgIKAgoCBvZm9u
b19tb2RlbV9zZXRfZGF0YShtb2RlbSwgTlVMTCk7PGJyPgorPGJyPgorIKAgoCCgIC8qIENsZWFu
dXAgYWZ0ZXIgaG90LXVucGx1ZyAqLzxicj4KKyCgIKAgoCBnX2F0X2NoYXRfdW5yZWYoZGF0YS0m
Z3Q7ZGF0YSk7PGJyPgorPGJyPgorIKAgoCCgIGdfZnJlZShkYXRhKTs8YnI+Cit9PGJyPgorPGJy
Pgorc3RhdGljIGludCBzaW1jb21fZW5hYmxlKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0pPGJy
Pgorezxicj4KKyCgIKAgoCBzdHJ1Y3Qgc2ltY29tX2RhdGEgKmRhdGEgPSBvZm9ub19tb2RlbV9n
ZXRfZGF0YShtb2RlbSk7PGJyPgorPGJyPgorIKAgoCCgIERCRygmcXVvdDslcCZxdW90OywgbW9k
ZW0pOzxicj4KKzxicj4KKyCgIKAgoCBkYXRhLSZndDttb2RlbSA9IG9wZW5fZGV2aWNlKG1vZGVt
LCAmcXVvdDtNb2RlbSZxdW90OywgJnF1b3Q7TW9kZW06ICZxdW90Oyk7PGJyPgorIKAgoCCgIGlm
IChkYXRhLSZndDttb2RlbSA9PSBOVUxMKTxicj4KKyCgIKAgoCCgIKAgoCCgIHJldHVybiAtRUlO
VkFMOzxicj4KKzxicj4KKyCgIKAgoCBkYXRhLSZndDtkYXRhID0gb3Blbl9kZXZpY2UobW9kZW0s
ICZxdW90O0RhdGEmcXVvdDssICZxdW90O0RhdGE6ICZxdW90Oyk7PGJyPgorIKAgoCCgIGlmIChk
YXRhLSZndDtkYXRhID09IE5VTEwpIHs8YnI+CisgoCCgIKAgoCCgIKAgoCBnX2F0X2NoYXRfdW5y
ZWYoZGF0YS0mZ3Q7bW9kZW0pOzxicj4KKyCgIKAgoCCgIKAgoCCgIGRhdGEtJmd0O21vZGVtID0g
TlVMTDs8YnI+CisgoCCgIKAgoCCgIKAgoCByZXR1cm4gLUVJTzs8YnI+CisgoCCgIKAgfTxicj4K
Kzxicj4KKyCgIKAgoCBnX2F0X2NoYXRfc2V0X3NsYXZlKGRhdGEtJmd0O21vZGVtLCBkYXRhLSZn
dDtkYXRhKTs8YnI+Cis8YnI+CisgoCCgIKAgZ19hdF9jaGF0X2JsYWNrbGlzdF90ZXJtaW5hdG9y
KGRhdGEtJmd0O2RhdGEsPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgR19BVF9DSEFUX1RFUk1JTkFUT1JfTk9fQ0FSUklFUik7PGJyPgorPGJyPgorIKAgoCCgIC8q
IGluaXQgbW9kZW0gKi88YnI+CisgoCCgIKAgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7bW9kZW0s
ICZxdW90O0FURTAgK0NNRUU9MSZxdW90OywgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCk7PGJyPgor
IKAgoCCgIGdfYXRfY2hhdF9zZW5kKGRhdGEtJmd0O2RhdGEsICZxdW90O0FURTAgK0NNRUU9MSZx
dW90OywgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCk7PGJyPgorPGJyPgorIKAgoCCgIGdfYXRfY2hh
dF9zZW5kKGRhdGEtJmd0O2RhdGEsICZxdW90O0FUK0NGVU49MSZxdW90Oywgbm9uZV9wcmVmaXgs
PGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoGNmdW5fZW5hYmxlLCBtb2RlbSwgTlVMTCk7PGJy
PgorPGJyPgorIKAgoCCgIHJldHVybiAtRUlOUFJPR1JFU1M7PGJyPgorfTxicj4KKzxicj4KK3N0
YXRpYyBpbnQgc2ltY29tX2Rpc2FibGUoc3RydWN0IG9mb25vX21vZGVtICptb2RlbSk8YnI+Cit7
PGJyPgorIKAgoCCgIHN0cnVjdCBzaW1jb21fZGF0YSAqZGF0YSA9IG9mb25vX21vZGVtX2dldF9k
YXRhKG1vZGVtKTs8YnI+Cis8YnI+CisgoCCgIKAgREJHKCZxdW90OyVwJnF1b3Q7LCBtb2RlbSk7
PGJyPgorPGJyPgorIKAgoCCgIGdfYXRfY2hhdF9jYW5jZWxfYWxsKGRhdGEtJmd0O21vZGVtKTs8
YnI+CisgoCCgIKAgZ19hdF9jaGF0X3VucmVnaXN0ZXJfYWxsKGRhdGEtJmd0O21vZGVtKTs8YnI+
Cis8YnI+CisgoCCgIKAgZ19hdF9jaGF0X3VucmVmKGRhdGEtJmd0O21vZGVtKTs8YnI+CisgoCCg
IKAgZGF0YS0mZ3Q7bW9kZW0gPSBOVUxMOzxicj4KKzxicj4KKyCgIKAgoCBnX2F0X2NoYXRfY2Fu
Y2VsX2FsbChkYXRhLSZndDtkYXRhKTs8YnI+CisgoCCgIKAgZ19hdF9jaGF0X3VucmVnaXN0ZXJf
YWxsKGRhdGEtJmd0O2RhdGEpOzxicj4KKzxicj4KKyCgIKAgoCBnX2F0X2NoYXRfc2VuZChkYXRh
LSZndDtkYXRhLCAmcXVvdDtBVCtDRlVOPTQmcXVvdDssIG5vbmVfcHJlZml4LDxicj4KKyCgIKAg
oCCgIKAgoCCgIKAgoCCgIKBjZnVuX2Rpc2FibGUsIG1vZGVtLCBOVUxMKTs8YnI+Cis8YnI+Cisg
oCCgIKAgcmV0dXJuIC1FSU5QUk9HUkVTUzs8YnI+Cit9PGJyPgorPGJyPgorc3RhdGljIHZvaWQg
c2ltY29tX3ByZV9zaW0oc3RydWN0IG9mb25vX21vZGVtICptb2RlbSk8YnI+Cit7PGJyPgorIKAg
oCCgIHN0cnVjdCBzaW1jb21fZGF0YSAqZGF0YSA9IG9mb25vX21vZGVtX2dldF9kYXRhKG1vZGVt
KTs8YnI+CisgoCCgIKAgc3RydWN0IG9mb25vX3NpbSAqc2ltOzxicj4KKzxicj4KKyCgIKAgoCBE
QkcoJnF1b3Q7JXAmcXVvdDssIG1vZGVtKTs8YnI+Cis8YnI+CisgoCCgIKAgb2Zvbm9fZGV2aW5m
b19jcmVhdGUobW9kZW0sIDAsICZxdW90O2F0bW9kZW0mcXVvdDssIGRhdGEtJmd0O2RhdGEpOzxi
cj4KKyCgIKAgoCBzaW0gPSBvZm9ub19zaW1fY3JlYXRlKG1vZGVtLCBPRk9OT19WRU5ET1JfU0lN
Q09NLCAmcXVvdDthdG1vZGVtJnF1b3Q7LDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCBkYXRhLSZndDtkYXRhKTs8YnI+Cis8YnI+CisgoCCgIKAgaWYgKHNpbSk8YnI+CisgoCCg
IKAgoCCgIKAgoCBvZm9ub19zaW1faW5zZXJ0ZWRfbm90aWZ5KHNpbSwgVFJVRSk7PGJyPgorfTxi
cj4KKzxicj4KK3N0YXRpYyB2b2lkIHNpbWNvbV9wb3N0X3NpbShzdHJ1Y3Qgb2Zvbm9fbW9kZW0g
Km1vZGVtKTxicj4KK3s8YnI+CisgoCCgIKAgc3RydWN0IHNpbWNvbV9kYXRhICpkYXRhID0gb2Zv
bm9fbW9kZW1fZ2V0X2RhdGEobW9kZW0pOzxicj4KKyCgIKAgoCBzdHJ1Y3Qgb2Zvbm9fbWVzc2Fn
ZV93YWl0aW5nICptdzs8YnI+CisgoCCgIKAgc3RydWN0IG9mb25vX2dwcnMgKmdwcnM7PGJyPgor
IKAgoCCgIHN0cnVjdCBvZm9ub19ncHJzX2NvbnRleHQgKmdjOzxicj4KKzxicj4KKyCgIKAgoCBE
QkcoJnF1b3Q7JXAmcXVvdDssIG1vZGVtKTs8YnI+Cis8YnI+CisgoCCgIKAgb2Zvbm9fcGhvbmVi
b29rX2NyZWF0ZShtb2RlbSwgMCwgJnF1b3Q7YXRtb2RlbSZxdW90OywgZGF0YS0mZ3Q7ZGF0YSk7
PGJyPgorPGJyPgorIKAgoCCgIG9mb25vX3Ntc19jcmVhdGUobW9kZW0sIE9GT05PX1ZFTkRPUl9T
SU1DT00sICZxdW90O2F0bW9kZW0mcXVvdDssPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIGRhdGEtJmd0O2RhdGEpOzxicj4KKzxicj4KKyCgIKAgoCAvKiBncHJzIHRoaW5ncyAq
Lzxicj4KKyCgIKAgoCBncHJzID0gb2Zvbm9fZ3Byc19jcmVhdGUobW9kZW0sIDAsICZxdW90O2F0
bW9kZW0mcXVvdDssIGRhdGEtJmd0O2RhdGEpOzxicj4KKyCgIKAgoCBnYyA9IG9mb25vX2dwcnNf
Y29udGV4dF9jcmVhdGUobW9kZW0sIDAsICZxdW90O2F0bW9kZW0mcXVvdDssIGRhdGEtJmd0O21v
ZGVtKTs8YnI+Cis8YnI+CisgoCCgIKAgaWYoZ3BycyAmYW1wOyZhbXA7IGdjKTxicj4KKyCgIKAg
oCB7PGJyPgorIKAgoCCgIKAgoCCgIKAgb2Zvbm9fZ3Byc19hZGRfY29udGV4dChncHJzLCBnYyk7
PGJyPgorIKAgoCCgIH08YnI+Cit9PGJyPgorPGJyPgorc3RhdGljIHZvaWQgc2ltY29tX3Bvc3Rf
b25saW5lKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0pPGJyPgorezxicj4KKyCgIKAgoCBzdHJ1
Y3Qgc2ltY29tX2RhdGEgKmRhdGEgPSBvZm9ub19tb2RlbV9nZXRfZGF0YShtb2RlbSk7PGJyPgor
PGJyPgorIKAgoCCgIERCRygmcXVvdDslcCZxdW90OywgbW9kZW0pOzxicj4KKzxicj4KKyCgIKAg
oCBvZm9ub19uZXRyZWdfY3JlYXRlKG1vZGVtLCBPRk9OT19WRU5ET1JfU0lNQ09NLCAmcXVvdDth
dG1vZGVtJnF1b3Q7LCBkYXRhLSZndDtkYXRhKTs8YnI+CisgoCCgIKAgb2Zvbm9fY2JzX2NyZWF0
ZShtb2RlbSwgMCwgJnF1b3Q7YXRtb2RlbSZxdW90OywgZGF0YS0mZ3Q7ZGF0YSk7PGJyPgorIKAg
oCCgIG9mb25vX3Vzc2RfY3JlYXRlKG1vZGVtLCAwLCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBkYXRh
LSZndDtkYXRhKTs8YnI+Cit9PGJyPgorPGJyPgorc3RhdGljIHN0cnVjdCBvZm9ub19tb2RlbV9k
cml2ZXIgc2ltY29tX2RyaXZlciA9IHs8YnI+CisgoCCgIKAgLm5hbWUgoCCgIKAgoCCgID0gJnF1
b3Q7c2ltY29tJnF1b3Q7LDxicj4KKyCgIKAgoCAucHJvYmUgoCCgIKAgoCCgPSBzaW1jb21fcHJv
YmUsPGJyPgorIKAgoCCgIC5yZW1vdmUgoCCgIKAgoCA9IHNpbWNvbV9yZW1vdmUsPGJyPgorIKAg
oCCgIC5lbmFibGUgoCCgIKAgoCA9IHNpbWNvbV9lbmFibGUsPGJyPgorIKAgoCCgIC5kaXNhYmxl
IKAgoCCgIKA9IHNpbWNvbV9kaXNhYmxlLDxicj4KKyCgIKAgoCAucHJlX3NpbSCgIKAgoCCgPSBz
aW1jb21fcHJlX3NpbSw8YnI+CisgoCCgIKAgLnBvc3Rfc2ltIKAgoCCgID0gc2ltY29tX3Bvc3Rf
c2ltLDxicj4KKyCgIKAgoCAucG9zdF9vbmxpbmUgoCCgPSBzaW1jb21fcG9zdF9vbmxpbmUsPGJy
PgorfTs8YnI+Cis8YnI+CitzdGF0aWMgaW50IHNpbWNvbV9pbml0KHZvaWQpPGJyPgorezxicj4K
KyCgIKAgoCByZXR1cm4gb2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCZhbXA7c2ltY29tX2Ry
aXZlcik7PGJyPgorfTxicj4KKzxicj4KK3N0YXRpYyB2b2lkIHNpbWNvbV9leGl0KHZvaWQpPGJy
Pgorezxicj4KKyCgIKAgoCBvZm9ub19tb2RlbV9kcml2ZXJfdW5yZWdpc3RlcigmYW1wO3NpbWNv
bV9kcml2ZXIpOzxicj4KK308YnI+Cis8YnI+CitPRk9OT19QTFVHSU5fREVGSU5FKHNpbWNvbSwg
JnF1b3Q7U0lNQ09NIG1vZGVtIGRyaXZlciZxdW90OywgVkVSU0lPTiw8YnI+CisgoCCgIKAgoCCg
IKAgoCCgIKAgT0ZPTk9fUExVR0lOX1BSSU9SSVRZX0RFRkFVTFQsPGJyPgorIKAgoCCgIKAgoCCg
IKAgoCCgIHNpbWNvbV9pbml0LCBzaW1jb21fZXhpdCk8YnI+Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+Cjxh
IGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciPm9mb25vQG9mb25vLm9yZzwvYT48YnI+Cjxh
IGhyZWY9Imh0dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm8iIHRhcmdldD0iX2Js
YW5rIj5odHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vPC9hPjxicj4KPC9ibG9j
a3F1b3RlPjwvZGl2Pjxicj48L2Rpdj4K

--===============6879529400184536115==--

