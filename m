Content-Type: multipart/mixed; boundary="===============5968892134672453616=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Re: [PATCH] Simcom support
Date: Tue, 29 Jan 2013 09:30:04 +0100
Message-ID: <5107888C.1070006@syscom-instruments.com>
In-Reply-To: <CAGNC_aN0RQaPUMNY0q7Up=z+8V8MpymeQXMjTRiBQ68NZj-odw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5968892134672453616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 28. 01. 13 14:43, Renat Zaripov wrote:
> Hi!

Hi Renat,

>
> I'll get started to test patch that sended by Anthony in previous email.
> Patch have some errors, but I'm fix it.
>
> renat(a)zaripov:~/work/ofono$ patch -p 1 < ../simcom.patch
> patching file Makefile.am
> Hunk #1 succeeded at 407 (offset 36 lines).
> patching file drivers/atmodem/sms.c
> patching file drivers/atmodem/sim.c
> Hunk #1 FAILED at 1023.
> 1 out of 1 hunk FAILED -- saving rejects to file drivers/atmodem/sim.c.rej
> patching file drivers/atmodem/network-registration.c
> Hunk #1 succeeded at 1740 (offset 329 lines).
> Hunk #2 succeeded at 1893 (offset 351 lines).
> patching file plugins/simcom.c
>
> Build done successfully, and udev pick simcom plugin for sim900:
>
> root(a)zaripov:/home/renat/work/ofono/src# export OFONO_AT_DEBUG=3D1 &&
> ./ofonod -nd "*"
> ofonod[17539]: oFono version 1.12
> ofonod[17539]: src/plugin.c:__ofono_plugin_init()
> ofonod[17539]: plugins/push-notification.c:push_notification_init()
> ofonod[17539]: plugins/smart-messaging.c:smart_messaging_init()
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8194e40, name: stktest
> ofonod[17539]: src/modem.c:ofono_modem_create() name: stktest, type: stkt=
est
> ofonod[17539]: src/modem.c:ofono_modem_register() 0x9c99f40
> ofonod[17539]: plugins/stktest.c:stktest_probe() 0x9c99f40
> ofonod[17539]: src/modem.c:emit_modem_added() 0x9c99f40
> ofonod[17539]: src/modem.c:call_modemwatches() 0x9c99f40 added:1
> ofonod[17539]: plugins/smart-messaging.c:modem_watch() modem: 0x9c99f40,
> added: 1
> ofonod[17539]: plugins/push-notification.c:modem_watch() modem:
> 0x9c99f40, added: 1
> ofonod[17539]: examples/emulator.c:example_emulator_init()
> ofonod[17539]: examples/emulator.c:modem_watch() modem: 0x9c99f40, added:=
 1
> ofonod[17539]:
> src/gprs-provision.c:ofono_gprs_provision_driver_register() driver:
> 0x8194da0 name: Example GPRS context provisioning
> ofonod[17539]: src/nettime.c:ofono_nettime_driver_register() driver:
> 0x8194d60 name: Example Network Time
> ofonod[17539]: src/history.c:ofono_history_driver_register() driver:
> 0x8194d20 name: Example Call History
> ofonod[17539]:
> src/cdma-provision.c:ofono_cdma_provision_driver_register() driver:
> 0x8194ce0 name: CDMA provisioning
> ofonod[17539]:
> src/gprs-provision.c:ofono_gprs_provision_driver_register() driver:
> 0x8194ca0 name: Provisioning
> ofonod[17539]: plugins/connman.c:connman_init()
> ofonod[17539]:
> src/private-network.c:ofono_private_network_driver_register() driver:
> 0x8194c60, name: ConnMan Private Network
> ofonod[17539]: plugins/dun_gw.c:dun_gw_init()
> ofonod[17539]: plugins/dun_gw.c:modem_watch() modem: 0x9c99f40, added: 1
> ofonod[17539]: plugins/hfp_ag.c:modem_watch() modem: 0x9c99f40, added: 1
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8194ba0, name: hfp
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8194b40, name: sap
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8194ac0, name: telit
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x81949c0, name: sim900
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8194960, name: samsung
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8194900, name: speedupcdma
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x81948a0, name: speedup
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8194840, name: alcatel
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x81947e0, name: icera
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8194780, name: linktop
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8194720, name: nokiacdma
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x81946c0, name: nokia
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8194660, name: tc65
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x81945c0, name: ste
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8194560, name: ifx
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8194500, name: palmpre
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x81944a0, name: novatel
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8194440, name: sierra
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x81943c0, name: huawei
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8194360, name: zte
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8194300, name: hso
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x81942a0, name: mbm
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8194240, name: calypso
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x81941e0, name: wavecom
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8194180, name: g1
> ofonod[17539]:
> src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register() driver:
> 0x8194100, name: cdmamodem
> ofonod[17539]: src/modem.c:ofono_devinfo_driver_register() driver:
> 0x8194120, name: cdmamodem
> ofonod[17539]: src/cdma-connman.c:ofono_cdma_connman_driver_register()
> driver: 0x8194144, name: cdmamodem
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8194060, name: phonesim
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x81940a0, name: localhfp
> ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
> 0x8194034, name: phonesim
> ofonod[17539]: src/ctm.c:ofono_ctm_driver_register() driver: 0x8194020,
> name: phonesim
> ofonod[17539]: plugins/phonesim.c:parse_config() filename
> /etc/ofono/phonesim.conf
> ofonod[17539]: Reading of /etc/ofono/phonesim.conf failed: No such file
> or directory
> ofonod[17539]: src/ussd.c:ofono_ussd_driver_register() driver:
> 0x8193fe0, name: speedupmodem
> ofonod[17539]: src/voicecall.c:ofono_voicecall_driver_register() driver:
> 0x8193ec0, name: hfpmodem
> ofonod[17539]: src/modem.c:ofono_devinfo_driver_register() driver:
> 0x8193f7c, name: hfpmodem
> ofonod[17539]: src/network.c:ofono_netreg_driver_register() driver:
> 0x8193f20, name: hfpmodem
> ofonod[17539]: src/call-volume.c:ofono_call_volume_driver_register()
> driver: 0x8193f54, name: hfpmodem
> ofonod[17539]: src/handsfree.c:ofono_handsfree_driver_register() driver:
> 0x8193f98, name: hfpmodem
> ofonod[17539]: src/network.c:ofono_netreg_driver_register() driver:
> 0x8193e40, name: dunmodem
> ofonod[17539]: src/gprs.c:ofono_gprs_driver_register() driver:
> 0x8193e6c, name: dunmodem
> ofonod[17539]: src/voicecall.c:ofono_voicecall_driver_register() driver:
> 0x8193d60, name: stemodem
> ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
> 0x8193dec, name: stemodem
> ofonod[17539]:
> src/radio-settings.c:ofono_radio_settings_driver_register() driver:
> 0x8193dc0, name: stemodem
> ofonod[17539]: src/voicecall.c:ofono_voicecall_driver_register() driver:
> 0x8193c20, name: ifxmodem
> ofonod[17539]:
> src/audio-settings.c:ofono_audio_settings_driver_register() driver:
> 0x8193c70, name: ifxmodem
> ofonod[17539]:
> src/radio-settings.c:ofono_radio_settings_driver_register() driver:
> 0x8193ca0, name: ifxmodem
> ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
> 0x8193ccc, name: ifxmodem
> ofonod[17539]: src/stk.c:ofono_stk_driver_register() driver: 0x8193cf4,
> name: ifxmodem
> ofonod[17539]: src/ctm.c:ofono_ctm_driver_register() driver: 0x8193d1c,
> name: ifxmodem
> ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
> 0x8193ba0, name: hsomodem
> ofonod[17539]:
> src/radio-settings.c:ofono_radio_settings_driver_register() driver:
> 0x8193bc0, name: hsomodem
> ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
> 0x8193b00, name: mbmmodem
> ofonod[17539]: src/stk.c:ofono_stk_driver_register() driver: 0x8193b28,
> name: mbmmodem
> ofonod[17539]:
> src/location-reporting.c:ofono_location_reporting_driver_register()
> driver: 0x8193b48, name: mbmmodem
> ofonod[17539]: src/voicecall.c:ofono_voicecall_driver_register() driver:
> 0x8193a60, name: calypsomodem
> ofonod[17539]: src/stk.c:ofono_stk_driver_register() driver: 0x8193aa8,
> name: calypsomodem
> ofonod[17539]: src/ussd.c:ofono_ussd_driver_register() driver:
> 0x8193940, name: huaweimodem
> ofonod[17539]: src/voicecall.c:ofono_voicecall_driver_register() driver:
> 0x8193960, name: huaweimodem
> ofonod[17539]:
> src/audio-settings.c:ofono_audio_settings_driver_register() driver:
> 0x81939a8, name: huaweimodem
> ofonod[17539]:
> src/radio-settings.c:ofono_radio_settings_driver_register() driver:
> 0x81939e0, name: huaweimodem
> ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
> 0x81939bc, name: huaweimodem
> ofonod[17539]: src/cdma-netreg.c:ofono_cdma_netreg_driver_register()
> driver: 0x8193a0c, name: huaweimodem
> ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
> 0x81938a0, name: iceramodem
> ofonod[17539]:
> src/radio-settings.c:ofono_radio_settings_driver_register() driver:
> 0x81938e0, name: iceramodem
> ofonod[17539]:
> src/radio-settings.c:ofono_radio_settings_driver_register() driver:
> 0x8193840, name: ztemodem
> ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
> 0x8193800, name: swmodem
> ofonod[17539]:
> src/radio-settings.c:ofono_radio_settings_driver_register() driver:
> 0x81937a0, name: nwmodem
> ofonod[17539]: src/voicecall.c:ofono_voicecall_driver_register() driver:
> 0x8193600, name: atmodem
> ofonod[17539]: src/modem.c:ofono_devinfo_driver_register() driver:
> 0x81936a0, name: atmodem
> ofonod[17539]: src/call-barring.c:ofono_call_barring_driver_register()
> driver: 0x8193658, name: atmodem
> ofonod[17539]:
> src/call-forwarding.c:ofono_call_forwarding_driver_register() driver:
> 0x81933a0, name: atmodem
> ofonod[17539]: src/call-meter.c:ofono_call_meter_driver_register()
> driver: 0x81933e0, name: atmodem
> ofonod[17539]: src/call-settings.c:ofono_call_settings_driver_register()
> driver: 0x81932a0, name: atmodem
> ofonod[17539]: src/phonebook.c:ofono_phonebook_driver_register() driver:
> 0x8193678, name: atmodem
> ofonod[17539]: src/ussd.c:ofono_ussd_driver_register() driver:
> 0x81935d4, name: atmodem
> ofonod[17539]: src/sms.c:ofono_sms_driver_register() driver: 0x8193320,
> name: atmodem
> ofonod[17539]: src/sim.c:ofono_sim_driver_register() driver: 0x81934a0,
> name: atmodem
> ofonod[17539]: src/sim.c:ofono_sim_driver_register() driver: 0x8193500,
> name: atmodem-noef
> ofonod[17539]: src/stk.c:ofono_stk_driver_register() driver: 0x81935b4,
> name: atmodem
> ofonod[17539]: src/network.c:ofono_netreg_driver_register() driver:
> 0x8193440, name: atmodem
> ofonod[17539]: src/cbs.c:ofono_cbs_driver_register() driver: 0x8193380,
> name: atmodem
> ofonod[17539]: src/call-volume.c:ofono_call_volume_driver_register()
> driver: 0x81936c4, name: atmodem
> ofonod[17539]: src/gprs.c:ofono_gprs_driver_register() driver:
> 0x81936f4, name: atmodem
> ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
> 0x8193718, name: atmodem
> ofonod[17539]: src/sim-auth.c:ofono_sim_auth_driver_register() driver:
> 0x8193730, name: atmodem
> ofonod[17539]: src/gnss.c:ofono_gnss_driver_register() driver:
> 0x8193748, name: atmodem
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8193080, name: gobi
> ofonod[17539]: src/modem.c:ofono_devinfo_driver_register() driver:
> 0x8192e40, name: qmimodem
> ofonod[17539]: src/network.c:ofono_netreg_driver_register() driver:
> 0x8192ec0, name: qmimodem
> ofonod[17539]: src/voicecall.c:ofono_voicecall_driver_register() driver:
> 0x8192e60, name: qmimodem
> ofonod[17539]: src/sim.c:ofono_sim_driver_register() driver: 0x8192f00,
> name: qmimodem-legacy
> ofonod[17539]: src/sim.c:ofono_sim_driver_register() driver: 0x8192f60,
> name: qmimodem
> ofonod[17539]: src/sms.c:ofono_sms_driver_register() driver: 0x8192fc0,
> name: qmimodem
> ofonod[17539]: src/ussd.c:ofono_ussd_driver_register() driver:
> 0x8192fe0, name: qmimodem
> ofonod[17539]: src/gprs.c:ofono_gprs_driver_register() driver:
> 0x8192ff4, name: qmimodem
> ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
> 0x8193008, name: qmimodem
> ofonod[17539]:
> src/radio-settings.c:ofono_radio_settings_driver_register() driver:
> 0x8193020, name: qmimodem
> ofonod[17539]:
> src/location-reporting.c:ofono_location_reporting_driver_register()
> driver: 0x8193044, name: qmimodem
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8192de0, name: u8500
> ofonod[17539]: src/modem.c:ofono_devinfo_driver_register() driver:
> 0x8192dc0, name: u8500
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8192d60, name: n900
> ofonod[17539]: src/modem.c:ofono_modem_driver_register() driver:
> 0x8192d00, name: isiusb
> ofonod[17539]: src/modem.c:ofono_devinfo_driver_register() driver:
> 0x81929f0, name: isimodem
> ofonod[17539]: src/phonebook.c:ofono_phonebook_driver_register() driver:
> 0x81929e0, name: isimodem
> ofonod[17539]: src/network.c:ofono_netreg_driver_register() driver:
> 0x8192a20, name: isimodem
> ofonod[17539]: src/voicecall.c:ofono_voicecall_driver_register() driver:
> 0x8192a60, name: isimodem
> ofonod[17539]: src/sms.c:ofono_sms_driver_register() driver: 0x8192ac0,
> name: isimodem
> ofonod[17539]: src/cbs.c:ofono_cbs_driver_register() driver: 0x8192ae0,
> name: isimodem
> ofonod[17539]: src/sim.c:ofono_sim_driver_register() driver: 0x8192b00,
> name: isimodem
> ofonod[17539]: src/ussd.c:ofono_ussd_driver_register() driver:
> 0x8192b48, name: isimodem
> ofonod[17539]:
> src/call-forwarding.c:ofono_call_forwarding_driver_register() driver:
> 0x8192b60, name: isimodem
> ofonod[17539]: src/call-settings.c:ofono_call_settings_driver_register()
> driver: 0x8192b80, name: isimodem
> ofonod[17539]: src/call-barring.c:ofono_call_barring_driver_register()
> driver: 0x8192bb0, name: isimodem
> ofonod[17539]: src/call-meter.c:ofono_call_meter_driver_register()
> driver: 0x8192be0, name: isimodem
> ofonod[17539]:
> src/radio-settings.c:ofono_radio_settings_driver_register() driver:
> 0x8192c20, name: isimodem
> ofonod[17539]: src/gprs.c:ofono_gprs_driver_register() driver:
> 0x8192c44, name: isimodem
> ofonod[17539]: src/gprs.c:ofono_gprs_context_driver_register() driver:
> 0x8192c58, name: isimodem
> ofonod[17539]:
> src/audio-settings.c:ofono_audio_settings_driver_register() driver:
> 0x8192c70, name: isimodem
> ofonod[17539]: src/sim.c:ofono_sim_driver_register() driver: 0x8192c80,
> name: wgmodem2.5
> ofonod[17539]: plugins/udevng.c:udev_start()
> ofonod[17539]: plugins/udevng.c:enumerate_devices()
> ofonod[17539]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
> ofonod[17539]: plugins/udevng.c:check_usb_device() usb [8087:0020]
> ofonod[17539]: plugins/udevng.c:check_usb_device() usb [1a40:0101]
> ofonod[17539]: plugins/udevng.c:check_usb_device() usb [067b:2303]
> ofonod[17539]: plugins/udevng.c:check_usb_device() pl2303 [(null):(null)]
> ofonod[17539]: plugins/udevng.c:check_usb_device() pl2303 [067b:2303]
> ofonod[17539]: plugins/udevng.c:check_usb_device() usb [067b:2303]
> ofonod[17539]: plugins/udevng.c:check_usb_device() pl2303 [(null):(null)]
> ofonod[17539]: plugins/udevng.c:check_usb_device() pl2303 [067b:2303]
> ofonod[17539]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
> ofonod[17539]: plugins/udevng.c:check_usb_device() usb [0409:005a]
> ofonod[17539]: plugins/udevng.c:check_usb_device() usb [058f:6254]
> ofonod[17539]: plugins/udevng.c:check_usb_device() usb [058f:6366]
> ofonod[17539]: plugins/udevng.c:check_usb_device() usb-storage
> [(null):(null)]
> ofonod[17539]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
> ofonod[17539]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
> ofonod[17539]: plugins/udevng.c:check_usb_device() usb [046d:c05a]
> ofonod[17539]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
> ofonod[17539]: plugins/udevng.c:check_usb_device() usb [045e:00db]
> ofonod[17539]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
> ofonod[17539]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
> ofonod[17539]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
> ofonod[17539]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
> ofonod[17539]: plugins/udevng.c:check_usb_device() usb [8087:0020]
> ofonod[17539]: plugins/udevng.c:check_usb_device() usb [0403:6010]
> ofonod[17539]: plugins/udevng.c:check_usb_device() ftdi_sio [(null):(null=
)]
> ofonod[17539]: plugins/udevng.c:check_usb_device() ftdi_sio [0403:6010]
> ofonod[17539]: plugins/udevng.c:check_usb_device() ftdi_sio [(null):(null=
)]
> ofonod[17539]: plugins/udevng.c:check_usb_device() ftdi_sio [0403:6010]
> ofonod[17539]: plugins/udevng.c:check_usb_device() hub [(null):(null)]

I don't see the simcom device. I have got theses messages in my console :

Jan  7 13:12:18 mr3000 ofonod[19624]: plugins/udevng.c:udev_start()
Jan  7 13:12:18 mr3000 ofonod[19624]: plugins/udevng.c:enumerate_devices()
Jan  7 13:12:22 mr3000 ofonod[19624]: =

plugins/udevng.c:check_usb_device() option [05c6:9000]
Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udevng.c:add_device() =

/sys/devices/platform/ohci.0/usb2/2-1/2-1:1.0/ttyUSB0/tty/ttyUSB0
Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udevng.c:add_device() =

/dev/ttyUSB0 (simcom) 255/255/255 [00] =3D=3D> (null) (null)
Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udev.c:udev_event() =

subsystem tty add
Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udev.c:udev_event() =

subsystem tty finished
Jan  7 13:12:22 mr3000 ofonod[19624]: =

plugins/udevng.c:check_usb_device() option [05c6:9000]
Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udevng.c:add_device() =

/sys/devices/platform/ohci.0/usb2/2-1/2-1:1.1/ttyUSB1/tty/ttyUSB1
Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udevng.c:add_device() =

/dev/ttyUSB1 (simcom) 255/255/255 [01] =3D=3D> (null) (null)
Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udev.c:udev_event() =

subsystem tty add
Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udev.c:udev_event() =

subsystem tty finished
Jan  7 13:12:22 mr3000 ofonod[19624]: =

plugins/udevng.c:check_usb_device() option [05c6:9000]
Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udevng.c:add_device() =

/sys/devices/platform/ohci.0/usb2/2-1/2-1:1.2/ttyUSB2/tty/ttyUSB2
Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udevng.c:add_device() =

/dev/ttyUSB2 (simcom) 255/255/255 [02] =3D=3D> (null) (null)
Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udev.c:udev_event() =

subsystem tty add
Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udev.c:udev_event() =

subsystem tty finished
Jan  7 13:12:23 mr3000 ofonod[19624]: =

plugins/udevng.c:check_usb_device() option [05c6:9000]
Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udevng.c:add_device() =

/sys/devices/platform/ohci.0/usb2/2-1/2-1:1.3/ttyUSB3/tty/ttyUSB3
Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udevng.c:add_device() =

/dev/ttyUSB3 (simcom) 255/255/255 [03] =3D=3D> (null) (null)
Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udev.c:udev_event() =

subsystem tty add
Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udev.c:udev_event() =

subsystem tty finished
Jan  7 13:12:23 mr3000 ofonod[19624]: =

plugins/udevng.c:check_usb_device() option [05c6:9000]
Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udevng.c:add_device() =

/sys/devices/platform/ohci.0/usb2/2-1/2-1:1.4/ttyUSB4/tty/ttyUSB4
Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udevng.c:add_device() =

/dev/ttyUSB4 (simcom) 255/255/255 [04] =3D=3D> (null) (null)
Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udev.c:udev_event() =

subsystem tty add
Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udev.c:udev_event() =

subsystem tty finished
Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udevng.c:check_modem_list()
Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udevng.c:create_modem() =

/sys/devices/platform/ohci.0/usb2/2-1
Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udevng.c:create_modem() =

driver=3Dsimcom

-----------------------------------------------

udevng do the creation.

> ofonod[17539]: src/modem.c:ofono_modem_create() name: (null), type: simcom
> ofonod[17539]: src/modem.c:set_modem_property() modem 0x9ca15b8 property
> Path
> ofonod[17539]: plugins/udev.c:add_modem()
> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6:1.1/ttyUSB3/tty/tty=
USB3
> (simcom)
> ofonod[17539]:
> src/private-network.c:ofono_private_network_driver_register() driver:
> 0x8194e00, name: Example Private Network Driver
> ofonod[17539]: plugins/bluetooth.c:manager_properties_cb()
> ofonod[17539]: plugins/bluetooth.c:parse_adapters()

On the other side, it appears its udev which create the modem... I =

wouldn't be the case...

So, try to disable detection in udev. And check you have this device =

line in lsusb :

# lsusb
[...]
Bus 002 Device 041: ID 05c6:9000

Maybe your device has got a different ID ?

Best regards,
avd.


--===============5968892134672453616==--

