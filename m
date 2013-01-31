Content-Type: multipart/mixed; boundary="===============1394090113699264746=="
MIME-Version: 1.0
From: Renat Zaripov <r.r.zaripov@gmail.com>
Subject: Re: [PATCH] Simcom support
Date: Thu, 31 Jan 2013 18:21:16 +0400
Message-ID: <CAGNC_aOV0U5OLqFL95bKw33QBW1VuyOXkG=iUSZp_Cj0KRYtmg@mail.gmail.com>
In-Reply-To: <5107888C.1070006@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1394090113699264746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

2013/1/29 Viallard Anthony <viallard@syscom-instruments.com>

> On 28. 01. 13 14:43, Renat Zaripov wrote:
>
>> Hi!
>>
>
> Hi Renat,
>
>
>> I'll get started to test patch that sended by Anthony in previous email.
>> Patch have some errors, but I'm fix it.
>>
>> renat(a)zaripov:~/work/ofono$ patch -p 1 < ../simcom.patch
>> patching file Makefile.am
>> Hunk #1 succeeded at 407 (offset 36 lines).
>> patching file drivers/atmodem/sms.c
>> patching file drivers/atmodem/sim.c
>> Hunk #1 FAILED at 1023.
>> 1 out of 1 hunk FAILED -- saving rejects to file drivers/atmodem/sim.c.r=
ej
>> patching file drivers/atmodem/network-**registration.c
>> Hunk #1 succeeded at 1740 (offset 329 lines).
>> Hunk #2 succeeded at 1893 (offset 351 lines).
>> patching file plugins/simcom.c
>>
>> Build done successfully, and udev pick simcom plugin for sim900:
>>
>> root(a)zaripov:/home/renat/work/**ofono/src# export OFONO_AT_DEBUG=3D1 &&
>> ./ofonod -nd "*"
>> ofonod[17539]: oFono version 1.12
>> ofonod[17539]: src/plugin.c:__ofono_plugin_**init()
>> ofonod[17539]: plugins/push-notification.c:**push_notification_init()
>> ofonod[17539]: plugins/smart-messaging.c:**smart_messaging_init()
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8194e40, name: stktest
>> ofonod[17539]: src/modem.c:ofono_modem_**create() name: stktest, type:
>> stktest
>> ofonod[17539]: src/modem.c:ofono_modem_**register() 0x9c99f40
>> ofonod[17539]: plugins/stktest.c:stktest_**probe() 0x9c99f40
>> ofonod[17539]: src/modem.c:emit_modem_added() 0x9c99f40
>> ofonod[17539]: src/modem.c:call_modemwatches(**) 0x9c99f40 added:1
>> ofonod[17539]: plugins/smart-messaging.c:**modem_watch() modem:
>> 0x9c99f40,
>> added: 1
>> ofonod[17539]: plugins/push-notification.c:**modem_watch() modem:
>> 0x9c99f40, added: 1
>> ofonod[17539]: examples/emulator.c:example_**emulator_init()
>> ofonod[17539]: examples/emulator.c:modem_**watch() modem: 0x9c99f40,
>> added: 1
>> ofonod[17539]:
>> src/gprs-provision.c:ofono_**gprs_provision_driver_**register() driver:
>> 0x8194da0 name: Example GPRS context provisioning
>> ofonod[17539]: src/nettime.c:ofono_nettime_**driver_register() driver:
>> 0x8194d60 name: Example Network Time
>> ofonod[17539]: src/history.c:ofono_history_**driver_register() driver:
>> 0x8194d20 name: Example Call History
>> ofonod[17539]:
>> src/cdma-provision.c:ofono_**cdma_provision_driver_**register() driver:
>> 0x8194ce0 name: CDMA provisioning
>> ofonod[17539]:
>> src/gprs-provision.c:ofono_**gprs_provision_driver_**register() driver:
>> 0x8194ca0 name: Provisioning
>> ofonod[17539]: plugins/connman.c:connman_**init()
>> ofonod[17539]:
>> src/private-network.c:ofono_**private_network_driver_**register() driver:
>> 0x8194c60, name: ConnMan Private Network
>> ofonod[17539]: plugins/dun_gw.c:dun_gw_init()
>> ofonod[17539]: plugins/dun_gw.c:modem_watch() modem: 0x9c99f40, added: 1
>> ofonod[17539]: plugins/hfp_ag.c:modem_watch() modem: 0x9c99f40, added: 1
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8194ba0, name: hfp
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8194b40, name: sap
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8194ac0, name: telit
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x81949c0, name: sim900
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8194960, name: samsung
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8194900, name: speedupcdma
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x81948a0, name: speedup
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8194840, name: alcatel
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x81947e0, name: icera
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8194780, name: linktop
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8194720, name: nokiacdma
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x81946c0, name: nokia
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8194660, name: tc65
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x81945c0, name: ste
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8194560, name: ifx
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8194500, name: palmpre
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x81944a0, name: novatel
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8194440, name: sierra
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x81943c0, name: huawei
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8194360, name: zte
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8194300, name: hso
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x81942a0, name: mbm
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8194240, name: calypso
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x81941e0, name: wavecom
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8194180, name: g1
>> ofonod[17539]:
>> src/cdma-voicecall.c:ofono_**cdma_voicecall_driver_**register() driver:
>> 0x8194100, name: cdmamodem
>> ofonod[17539]: src/modem.c:ofono_devinfo_**driver_register() driver:
>> 0x8194120, name: cdmamodem
>> ofonod[17539]: src/cdma-connman.c:ofono_cdma_**connman_driver_register()
>> driver: 0x8194144, name: cdmamodem
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8194060, name: phonesim
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x81940a0, name: localhfp
>> ofonod[17539]: src/gprs.c:ofono_gprs_context_**driver_register() driver:
>> 0x8194034, name: phonesim
>> ofonod[17539]: src/ctm.c:ofono_ctm_driver_**register() driver: 0x8194020,
>> name: phonesim
>> ofonod[17539]: plugins/phonesim.c:parse_**config() filename
>> /etc/ofono/phonesim.conf
>> ofonod[17539]: Reading of /etc/ofono/phonesim.conf failed: No such file
>> or directory
>> ofonod[17539]: src/ussd.c:ofono_ussd_driver_**register() driver:
>> 0x8193fe0, name: speedupmodem
>> ofonod[17539]: src/voicecall.c:ofono_**voicecall_driver_register()
>> driver:
>> 0x8193ec0, name: hfpmodem
>> ofonod[17539]: src/modem.c:ofono_devinfo_**driver_register() driver:
>> 0x8193f7c, name: hfpmodem
>> ofonod[17539]: src/network.c:ofono_netreg_**driver_register() driver:
>> 0x8193f20, name: hfpmodem
>> ofonod[17539]: src/call-volume.c:ofono_call_**volume_driver_register()
>> driver: 0x8193f54, name: hfpmodem
>> ofonod[17539]: src/handsfree.c:ofono_**handsfree_driver_register()
>> driver:
>> 0x8193f98, name: hfpmodem
>> ofonod[17539]: src/network.c:ofono_netreg_**driver_register() driver:
>> 0x8193e40, name: dunmodem
>> ofonod[17539]: src/gprs.c:ofono_gprs_driver_**register() driver:
>> 0x8193e6c, name: dunmodem
>> ofonod[17539]: src/voicecall.c:ofono_**voicecall_driver_register()
>> driver:
>> 0x8193d60, name: stemodem
>> ofonod[17539]: src/gprs.c:ofono_gprs_context_**driver_register() driver:
>> 0x8193dec, name: stemodem
>> ofonod[17539]:
>> src/radio-settings.c:ofono_**radio_settings_driver_**register() driver:
>> 0x8193dc0, name: stemodem
>> ofonod[17539]: src/voicecall.c:ofono_**voicecall_driver_register()
>> driver:
>> 0x8193c20, name: ifxmodem
>> ofonod[17539]:
>> src/audio-settings.c:ofono_**audio_settings_driver_**register() driver:
>> 0x8193c70, name: ifxmodem
>> ofonod[17539]:
>> src/radio-settings.c:ofono_**radio_settings_driver_**register() driver:
>> 0x8193ca0, name: ifxmodem
>> ofonod[17539]: src/gprs.c:ofono_gprs_context_**driver_register() driver:
>> 0x8193ccc, name: ifxmodem
>> ofonod[17539]: src/stk.c:ofono_stk_driver_**register() driver: 0x8193cf4,
>> name: ifxmodem
>> ofonod[17539]: src/ctm.c:ofono_ctm_driver_**register() driver: 0x8193d1c,
>> name: ifxmodem
>> ofonod[17539]: src/gprs.c:ofono_gprs_context_**driver_register() driver:
>> 0x8193ba0, name: hsomodem
>> ofonod[17539]:
>> src/radio-settings.c:ofono_**radio_settings_driver_**register() driver:
>> 0x8193bc0, name: hsomodem
>> ofonod[17539]: src/gprs.c:ofono_gprs_context_**driver_register() driver:
>> 0x8193b00, name: mbmmodem
>> ofonod[17539]: src/stk.c:ofono_stk_driver_**register() driver: 0x8193b28,
>> name: mbmmodem
>> ofonod[17539]:
>> src/location-reporting.c:**ofono_location_reporting_**driver_register()
>> driver: 0x8193b48, name: mbmmodem
>> ofonod[17539]: src/voicecall.c:ofono_**voicecall_driver_register()
>> driver:
>> 0x8193a60, name: calypsomodem
>> ofonod[17539]: src/stk.c:ofono_stk_driver_**register() driver: 0x8193aa8,
>> name: calypsomodem
>> ofonod[17539]: src/ussd.c:ofono_ussd_driver_**register() driver:
>> 0x8193940, name: huaweimodem
>> ofonod[17539]: src/voicecall.c:ofono_**voicecall_driver_register()
>> driver:
>> 0x8193960, name: huaweimodem
>> ofonod[17539]:
>> src/audio-settings.c:ofono_**audio_settings_driver_**register() driver:
>> 0x81939a8, name: huaweimodem
>> ofonod[17539]:
>> src/radio-settings.c:ofono_**radio_settings_driver_**register() driver:
>> 0x81939e0, name: huaweimodem
>> ofonod[17539]: src/gprs.c:ofono_gprs_context_**driver_register() driver:
>> 0x81939bc, name: huaweimodem
>> ofonod[17539]: src/cdma-netreg.c:ofono_cdma_**netreg_driver_register()
>> driver: 0x8193a0c, name: huaweimodem
>> ofonod[17539]: src/gprs.c:ofono_gprs_context_**driver_register() driver:
>> 0x81938a0, name: iceramodem
>> ofonod[17539]:
>> src/radio-settings.c:ofono_**radio_settings_driver_**register() driver:
>> 0x81938e0, name: iceramodem
>> ofonod[17539]:
>> src/radio-settings.c:ofono_**radio_settings_driver_**register() driver:
>> 0x8193840, name: ztemodem
>> ofonod[17539]: src/gprs.c:ofono_gprs_context_**driver_register() driver:
>> 0x8193800, name: swmodem
>> ofonod[17539]:
>> src/radio-settings.c:ofono_**radio_settings_driver_**register() driver:
>> 0x81937a0, name: nwmodem
>> ofonod[17539]: src/voicecall.c:ofono_**voicecall_driver_register()
>> driver:
>> 0x8193600, name: atmodem
>> ofonod[17539]: src/modem.c:ofono_devinfo_**driver_register() driver:
>> 0x81936a0, name: atmodem
>> ofonod[17539]: src/call-barring.c:ofono_call_**barring_driver_register()
>> driver: 0x8193658, name: atmodem
>> ofonod[17539]:
>> src/call-forwarding.c:ofono_**call_forwarding_driver_**register() driver:
>> 0x81933a0, name: atmodem
>> ofonod[17539]: src/call-meter.c:ofono_call_**meter_driver_register()
>> driver: 0x81933e0, name: atmodem
>> ofonod[17539]: src/call-settings.c:ofono_**call_settings_driver_register(
>> **)
>> driver: 0x81932a0, name: atmodem
>> ofonod[17539]: src/phonebook.c:ofono_**phonebook_driver_register()
>> driver:
>> 0x8193678, name: atmodem
>> ofonod[17539]: src/ussd.c:ofono_ussd_driver_**register() driver:
>> 0x81935d4, name: atmodem
>> ofonod[17539]: src/sms.c:ofono_sms_driver_**register() driver: 0x8193320,
>> name: atmodem
>> ofonod[17539]: src/sim.c:ofono_sim_driver_**register() driver: 0x81934a0,
>> name: atmodem
>> ofonod[17539]: src/sim.c:ofono_sim_driver_**register() driver: 0x8193500,
>> name: atmodem-noef
>> ofonod[17539]: src/stk.c:ofono_stk_driver_**register() driver: 0x81935b4,
>> name: atmodem
>> ofonod[17539]: src/network.c:ofono_netreg_**driver_register() driver:
>> 0x8193440, name: atmodem
>> ofonod[17539]: src/cbs.c:ofono_cbs_driver_**register() driver: 0x8193380,
>> name: atmodem
>> ofonod[17539]: src/call-volume.c:ofono_call_**volume_driver_register()
>> driver: 0x81936c4, name: atmodem
>> ofonod[17539]: src/gprs.c:ofono_gprs_driver_**register() driver:
>> 0x81936f4, name: atmodem
>> ofonod[17539]: src/gprs.c:ofono_gprs_context_**driver_register() driver:
>> 0x8193718, name: atmodem
>> ofonod[17539]: src/sim-auth.c:ofono_sim_auth_**driver_register() driver:
>> 0x8193730, name: atmodem
>> ofonod[17539]: src/gnss.c:ofono_gnss_driver_**register() driver:
>> 0x8193748, name: atmodem
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8193080, name: gobi
>> ofonod[17539]: src/modem.c:ofono_devinfo_**driver_register() driver:
>> 0x8192e40, name: qmimodem
>> ofonod[17539]: src/network.c:ofono_netreg_**driver_register() driver:
>> 0x8192ec0, name: qmimodem
>> ofonod[17539]: src/voicecall.c:ofono_**voicecall_driver_register()
>> driver:
>> 0x8192e60, name: qmimodem
>> ofonod[17539]: src/sim.c:ofono_sim_driver_**register() driver: 0x8192f00,
>> name: qmimodem-legacy
>> ofonod[17539]: src/sim.c:ofono_sim_driver_**register() driver: 0x8192f60,
>> name: qmimodem
>> ofonod[17539]: src/sms.c:ofono_sms_driver_**register() driver: 0x8192fc0,
>> name: qmimodem
>> ofonod[17539]: src/ussd.c:ofono_ussd_driver_**register() driver:
>> 0x8192fe0, name: qmimodem
>> ofonod[17539]: src/gprs.c:ofono_gprs_driver_**register() driver:
>> 0x8192ff4, name: qmimodem
>> ofonod[17539]: src/gprs.c:ofono_gprs_context_**driver_register() driver:
>> 0x8193008, name: qmimodem
>> ofonod[17539]:
>> src/radio-settings.c:ofono_**radio_settings_driver_**register() driver:
>> 0x8193020, name: qmimodem
>> ofonod[17539]:
>> src/location-reporting.c:**ofono_location_reporting_**driver_register()
>> driver: 0x8193044, name: qmimodem
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8192de0, name: u8500
>> ofonod[17539]: src/modem.c:ofono_devinfo_**driver_register() driver:
>> 0x8192dc0, name: u8500
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8192d60, name: n900
>> ofonod[17539]: src/modem.c:ofono_modem_**driver_register() driver:
>> 0x8192d00, name: isiusb
>> ofonod[17539]: src/modem.c:ofono_devinfo_**driver_register() driver:
>> 0x81929f0, name: isimodem
>> ofonod[17539]: src/phonebook.c:ofono_**phonebook_driver_register()
>> driver:
>> 0x81929e0, name: isimodem
>> ofonod[17539]: src/network.c:ofono_netreg_**driver_register() driver:
>> 0x8192a20, name: isimodem
>> ofonod[17539]: src/voicecall.c:ofono_**voicecall_driver_register()
>> driver:
>> 0x8192a60, name: isimodem
>> ofonod[17539]: src/sms.c:ofono_sms_driver_**register() driver: 0x8192ac0,
>> name: isimodem
>> ofonod[17539]: src/cbs.c:ofono_cbs_driver_**register() driver: 0x8192ae0,
>> name: isimodem
>> ofonod[17539]: src/sim.c:ofono_sim_driver_**register() driver: 0x8192b00,
>> name: isimodem
>> ofonod[17539]: src/ussd.c:ofono_ussd_driver_**register() driver:
>> 0x8192b48, name: isimodem
>> ofonod[17539]:
>> src/call-forwarding.c:ofono_**call_forwarding_driver_**register() driver:
>> 0x8192b60, name: isimodem
>> ofonod[17539]: src/call-settings.c:ofono_**call_settings_driver_register(
>> **)
>> driver: 0x8192b80, name: isimodem
>> ofonod[17539]: src/call-barring.c:ofono_call_**barring_driver_register()
>> driver: 0x8192bb0, name: isimodem
>> ofonod[17539]: src/call-meter.c:ofono_call_**meter_driver_register()
>> driver: 0x8192be0, name: isimodem
>> ofonod[17539]:
>> src/radio-settings.c:ofono_**radio_settings_driver_**register() driver:
>> 0x8192c20, name: isimodem
>> ofonod[17539]: src/gprs.c:ofono_gprs_driver_**register() driver:
>> 0x8192c44, name: isimodem
>> ofonod[17539]: src/gprs.c:ofono_gprs_context_**driver_register() driver:
>> 0x8192c58, name: isimodem
>> ofonod[17539]:
>> src/audio-settings.c:ofono_**audio_settings_driver_**register() driver:
>> 0x8192c70, name: isimodem
>> ofonod[17539]: src/sim.c:ofono_sim_driver_**register() driver: 0x8192c80,
>> name: wgmodem2.5
>> ofonod[17539]: plugins/udevng.c:udev_start()
>> ofonod[17539]: plugins/udevng.c:enumerate_**devices()
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() hub [(null):(null)]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() usb [8087:0020]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() usb [1a40:0101]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() usb [067b:2303]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() pl2303
>> [(null):(null)]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() pl2303 [067b:2303]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() usb [067b:2303]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() pl2303
>> [(null):(null)]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() pl2303 [067b:2303]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() hub [(null):(null)]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() usb [0409:005a]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() usb [058f:6254]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() usb [058f:6366]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() usb-storage
>> [(null):(null)]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() hub [(null):(null)]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() hub [(null):(null)]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() usb [046d:c05a]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() usbhid
>> [(null):(null)]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() usb [045e:00db]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() usbhid
>> [(null):(null)]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() usbhid
>> [(null):(null)]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() hub [(null):(null)]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() hub [(null):(null)]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() usb [8087:0020]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() usb [0403:6010]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() ftdi_sio
>> [(null):(null)]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() ftdi_sio [0403:6010]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() ftdi_sio
>> [(null):(null)]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() ftdi_sio [0403:6010]
>> ofonod[17539]: plugins/udevng.c:check_usb_**device() hub [(null):(null)]
>>
>
> I don't see the simcom device. I have got theses messages in my console :
>
> Jan  7 13:12:18 mr3000 ofonod[19624]: plugins/udevng.c:udev_start()
> Jan  7 13:12:18 mr3000 ofonod[19624]: plugins/udevng.c:enumerate_**
> devices()
> Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udevng.c:check_usb_**device=
()
> option [05c6:9000]
> Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udevng.c:add_device()
> /sys/devices/platform/ohci.0/**usb2/2-1/2-1:1.0/ttyUSB0/tty/**ttyUSB0
> Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udevng.c:add_device()
> /dev/ttyUSB0 (simcom) 255/255/255 [00] =3D=3D> (null) (null)
> Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udev.c:udev_event()
> subsystem tty add
> Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udev.c:udev_event()
> subsystem tty finished
> Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udevng.c:check_usb_**device=
()
> option [05c6:9000]
> Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udevng.c:add_device()
> /sys/devices/platform/ohci.0/**usb2/2-1/2-1:1.1/ttyUSB1/tty/**ttyUSB1
> Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udevng.c:add_device()
> /dev/ttyUSB1 (simcom) 255/255/255 [01] =3D=3D> (null) (null)
> Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udev.c:udev_event()
> subsystem tty add
> Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udev.c:udev_event()
> subsystem tty finished
> Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udevng.c:check_usb_**device=
()
> option [05c6:9000]
> Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udevng.c:add_device()
> /sys/devices/platform/ohci.0/**usb2/2-1/2-1:1.2/ttyUSB2/tty/**ttyUSB2
> Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udevng.c:add_device()
> /dev/ttyUSB2 (simcom) 255/255/255 [02] =3D=3D> (null) (null)
> Jan  7 13:12:22 mr3000 ofonod[19624]: plugins/udev.c:udev_event()
> subsystem tty add
> Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udev.c:udev_event()
> subsystem tty finished
> Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udevng.c:check_usb_**device=
()
> option [05c6:9000]
> Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udevng.c:add_device()
> /sys/devices/platform/ohci.0/**usb2/2-1/2-1:1.3/ttyUSB3/tty/**ttyUSB3
> Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udevng.c:add_device()
> /dev/ttyUSB3 (simcom) 255/255/255 [03] =3D=3D> (null) (null)
> Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udev.c:udev_event()
> subsystem tty add
> Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udev.c:udev_event()
> subsystem tty finished
> Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udevng.c:check_usb_**device=
()
> option [05c6:9000]
> Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udevng.c:add_device()
> /sys/devices/platform/ohci.0/**usb2/2-1/2-1:1.4/ttyUSB4/tty/**ttyUSB4
> Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udevng.c:add_device()
> /dev/ttyUSB4 (simcom) 255/255/255 [04] =3D=3D> (null) (null)
> Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udev.c:udev_event()
> subsystem tty add
> Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udev.c:udev_event()
> subsystem tty finished
> Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udevng.c:check_modem_**
> list()
> Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udevng.c:create_modem(**)
> /sys/devices/platform/ohci.0/**usb2/2-1
> Jan  7 13:12:23 mr3000 ofonod[19624]: plugins/udevng.c:create_modem(**)
> driver=3Dsimcom
>
------------------------------**-----------------
>
> udevng do the creation.
>
>  ofonod[17539]: src/modem.c:ofono_modem_**create() name: (null), type:
>> simcom
>> ofonod[17539]: src/modem.c:set_modem_**property() modem 0x9ca15b8
>> property
>> Path
>> ofonod[17539]: plugins/udev.c:add_modem()
>> /devices/pci0000:00/0000:00:**1d.0/usb2/2-1/2-1.6/2-1.6:1.1/**
>> ttyUSB3/tty/ttyUSB3
>> (simcom)
>> ofonod[17539]:
>> src/private-network.c:ofono_**private_network_driver_**register() driver:
>> 0x8194e00, name: Example Private Network Driver
>> ofonod[17539]: plugins/bluetooth.c:manager_**properties_cb()
>> ofonod[17539]: plugins/bluetooth.c:parse_**adapters()
>>
>
> On the other side, it appears its udev which create the modem... I
> wouldn't be the case...
>
> So, try to disable detection in udev. And check you have this device line
> in lsusb :
>
> # lsusb
> [...]
> Bus 002 Device 041: ID 05c6:9000
>
> Maybe your device has got a different ID ?
>
>
SIM900 is presented in system as serial device, so we have no ID. We use
udev rules for detecting modem.
All what I achieved - simcom plugin added to plugins list and loaded with
SIM900 (need patching udev.c in my case). But modem-eneble not work, and I
can't understand why.

ofonod[9046]: src/modem.c:ofono_modem_create() name: (null), type: simcom
ofonod[9046]: src/modem.c:set_modem_property() modem 0x95035d8 property Path
ofonod[9046]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6:1.1/ttyUSB3/tty/ttyUS=
B3
(simcom)
ofonod[9046]: plugins/udev.c:add_simcom() modem 0x95035d8
ofonod[9046]: src/modem.c:set_modem_property() modem 0x95035d8 property
Device
ofonod[9046]: src/modem.c:ofono_modem_register() 0x95035d8
ofonod[9046]: plugins/simcom.c:simcom_probe() 0x95035d8
ofonod[9046]: src/modem.c:emit_modem_added() 0x95035d8
ofonod[9046]: src/modem.c:call_modemwatches() 0x95035d8 added:1
ofonod[9046]: plugins/hfp_ag.c:modem_watch() modem: 0x95035d8, added: 1
ofonod[9046]: plugins/dun_gw.c:modem_watch() modem: 0x95035d8, added: 1
ofonod[9046]: examples/emulator.c:modem_watch() modem: 0x95035d8, added: 1
ofonod[9046]: plugins/smart-messaging.c:modem_watch() modem: 0x95035d8,
added: 1
ofonod[9046]: plugins/push-notification.c:modem_watch() modem: 0x95035d8,
added: 1
ofonod[9046]: src/private-network.c:ofono_private_network_driver_register()
driver: 0x8195e00, name: Example Private Network Driver
ofonod[9046]: plugins/bluetooth.c:manager_properties_cb()
ofonod[9046]: plugins/bluetooth.c:parse_adapters()
ofonod[9046]: plugins/simcom.c:simcom_enable() 0x95035d8
ofonod[9046]: src/modem.c:get_modem_property() modem 0x95035d8 property
Modem

But I think, that this may be solved, if this is problem in device setup.
Now I'm busy, but maybe debug this issue in near time.

Best regards,
Renat Zaripov

--===============1394090113699264746==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgQW50aG9ueSw8ZGl2Pjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9leHRyYSI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjIwMTMvMS8yOSBWaWFsbGFyZCBBbnRo
b255IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOnZpYWxsYXJkQHN5c2NvbS1p
bnN0cnVtZW50cy5jb20iIHRhcmdldD0iX2JsYW5rIj52aWFsbGFyZEBzeXNjb20taW5zdHJ1bWVu
dHMuY29tPC9hPiZndDs8L3NwYW4+PGJyPgoKCgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQtd2lkdGg6MXB4
O2JvcmRlci1sZWZ0LWNvbG9yOnJnYigyMDQsMjA0LDIwNCk7Ym9yZGVyLWxlZnQtc3R5bGU6c29s
aWQ7cGFkZGluZy1sZWZ0OjFleCI+T24gMjguIDAxLiAxMyAxNDo0MywgUmVuYXQgWmFyaXBvdiB3
cm90ZTo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
cHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdC13aWR0aDoxcHg7Ym9yZGVyLWxlZnQtY29sb3I6
cmdiKDIwNCwyMDQsMjA0KTtib3JkZXItbGVmdC1zdHlsZTpzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4
Ij4KSGkhPGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj4KSGkgUmVuYXQsPGJyPgo8YnI+CjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDti
b3JkZXItbGVmdC13aWR0aDoxcHg7Ym9yZGVyLWxlZnQtY29sb3I6cmdiKDIwNCwyMDQsMjA0KTti
b3JkZXItbGVmdC1zdHlsZTpzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgpJJiMzOTtsbCBn
ZXQgc3RhcnRlZCB0byB0ZXN0IHBhdGNoIHRoYXQgc2VuZGVkIGJ5IEFudGhvbnkgaW4gcHJldmlv
dXMgZW1haWwuPGJyPgpQYXRjaCBoYXZlIHNvbWUgZXJyb3JzLCBidXQgSSYjMzk7bSBmaXggaXQu
PGJyPgo8YnI+CnJlbmF0QHphcmlwb3Y6fi93b3JrL29mb25vJCBwYXRjaCAtcCAxICZsdDsgLi4v
c2ltY29tLnBhdGNoPGJyPgpwYXRjaGluZyBmaWxlIE1ha2VmaWxlLmFtPGJyPgpIdW5rICMxIHN1
Y2NlZWRlZCBhdCA0MDcgKG9mZnNldCAzNiBsaW5lcykuPGJyPgpwYXRjaGluZyBmaWxlIGRyaXZl
cnMvYXRtb2RlbS9zbXMuYzxicj4KcGF0Y2hpbmcgZmlsZSBkcml2ZXJzL2F0bW9kZW0vc2ltLmM8
YnI+Ckh1bmsgIzEgRkFJTEVEIGF0IDEwMjMuPGJyPgoxIG91dCBvZiAxIGh1bmsgRkFJTEVEIC0t
IHNhdmluZyByZWplY3RzIHRvIGZpbGUgZHJpdmVycy9hdG1vZGVtL3NpbS5jLnJlajxicj4KcGF0
Y2hpbmcgZmlsZSBkcml2ZXJzL2F0bW9kZW0vbmV0d29yay08dT48L3U+cmVnaXN0cmF0aW9uLmM8
YnI+Ckh1bmsgIzEgc3VjY2VlZGVkIGF0IDE3NDAgKG9mZnNldCAzMjkgbGluZXMpLjxicj4KSHVu
ayAjMiBzdWNjZWVkZWQgYXQgMTg5MyAob2Zmc2V0IDM1MSBsaW5lcykuPGJyPgpwYXRjaGluZyBm
aWxlIHBsdWdpbnMvc2ltY29tLmM8YnI+Cjxicj4KQnVpbGQgZG9uZSBzdWNjZXNzZnVsbHksIGFu
ZCB1ZGV2IHBpY2sgc2ltY29tIHBsdWdpbiBmb3Igc2ltOTAwOjxicj4KPGJyPgpyb290QHphcmlw
b3Y6L2hvbWUvcmVuYXQvd29yay88dT48L3U+b2Zvbm8vc3JjIyBleHBvcnQgT0ZPTk9fQVRfREVC
VUc9MSAmYW1wOyZhbXA7PGJyPgouL29mb25vZCAtbmQgJnF1b3Q7KiZxdW90Ozxicj4Kb2Zvbm9k
WzE3NTM5XTogb0Zvbm8gdmVyc2lvbiAxLjEyPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvcGx1Z2lu
LmM6X19vZm9ub19wbHVnaW5fPHU+PC91PmluaXQoKTxicj4Kb2Zvbm9kWzE3NTM5XTogcGx1Z2lu
cy9wdXNoLW5vdGlmaWNhdGlvbi5jOjx1PjwvdT5wdXNoX25vdGlmaWNhdGlvbl9pbml0KCk8YnI+
Cm9mb25vZFsxNzUzOV06IHBsdWdpbnMvc21hcnQtbWVzc2FnaW5nLmM6PHU+PC91PnNtYXJ0X21l
c3NhZ2luZ19pbml0KCk8YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVt
Xzx1PjwvdT5kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDgxOTRlNDAsIG5hbWU6IHN0
a3Rlc3Q8YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtXzx1PjwvdT5j
cmVhdGUoKSBuYW1lOiBzdGt0ZXN0LCB0eXBlOiBzdGt0ZXN0PGJyPgpvZm9ub2RbMTc1MzldOiBz
cmMvbW9kZW0uYzpvZm9ub19tb2RlbV88dT48L3U+cmVnaXN0ZXIoKSAweDljOTlmNDA8YnI+Cm9m
b25vZFsxNzUzOV06IHBsdWdpbnMvc3RrdGVzdC5jOnN0a3Rlc3RfPHU+PC91PnByb2JlKCkgMHg5
Yzk5ZjQwPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzplbWl0X21vZGVtX2FkZGVkKCkg
MHg5Yzk5ZjQwPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpjYWxsX21vZGVtd2F0Y2hl
cyg8dT48L3U+KSAweDljOTlmNDAgYWRkZWQ6MTxicj4Kb2Zvbm9kWzE3NTM5XTogcGx1Z2lucy9z
bWFydC1tZXNzYWdpbmcuYzo8dT48L3U+bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg5Yzk5ZjQwLDxi
cj4KYWRkZWQ6IDE8YnI+Cm9mb25vZFsxNzUzOV06IHBsdWdpbnMvcHVzaC1ub3RpZmljYXRpb24u
Yzo8dT48L3U+bW9kZW1fd2F0Y2goKSBtb2RlbTo8YnI+CjB4OWM5OWY0MCwgYWRkZWQ6IDE8YnI+
Cm9mb25vZFsxNzUzOV06IGV4YW1wbGVzL2VtdWxhdG9yLmM6ZXhhbXBsZV88dT48L3U+ZW11bGF0
b3JfaW5pdCgpPGJyPgpvZm9ub2RbMTc1MzldOiBleGFtcGxlcy9lbXVsYXRvci5jOm1vZGVtXzx1
PjwvdT53YXRjaCgpIG1vZGVtOiAweDljOTlmNDAsIGFkZGVkOiAxPGJyPgpvZm9ub2RbMTc1Mzld
Ojxicj4Kc3JjL2dwcnMtcHJvdmlzaW9uLmM6b2Zvbm9fPHU+PC91PmdwcnNfcHJvdmlzaW9uX2Ry
aXZlcl88dT48L3U+cmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDgxOTRkYTAgbmFtZTogRXhhbXBs
ZSBHUFJTIGNvbnRleHQgcHJvdmlzaW9uaW5nPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvbmV0dGlt
ZS5jOm9mb25vX25ldHRpbWVfPHU+PC91PmRyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4
ODE5NGQ2MCBuYW1lOiBFeGFtcGxlIE5ldHdvcmsgVGltZTxicj4Kb2Zvbm9kWzE3NTM5XTogc3Jj
L2hpc3RvcnkuYzpvZm9ub19oaXN0b3J5Xzx1PjwvdT5kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
PGJyPgoweDgxOTRkMjAgbmFtZTogRXhhbXBsZSBDYWxsIEhpc3Rvcnk8YnI+Cm9mb25vZFsxNzUz
OV06PGJyPgpzcmMvY2RtYS1wcm92aXNpb24uYzpvZm9ub188dT48L3U+Y2RtYV9wcm92aXNpb25f
ZHJpdmVyXzx1PjwvdT5yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5NGNlMCBuYW1lOiBDRE1B
IHByb3Zpc2lvbmluZzxicj4Kb2Zvbm9kWzE3NTM5XTo8YnI+CnNyYy9ncHJzLXByb3Zpc2lvbi5j
Om9mb25vXzx1PjwvdT5ncHJzX3Byb3Zpc2lvbl9kcml2ZXJfPHU+PC91PnJlZ2lzdGVyKCkgZHJp
dmVyOjxicj4KMHg4MTk0Y2EwIG5hbWU6IFByb3Zpc2lvbmluZzxicj4Kb2Zvbm9kWzE3NTM5XTog
cGx1Z2lucy9jb25ubWFuLmM6Y29ubm1hbl88dT48L3U+aW5pdCgpPGJyPgpvZm9ub2RbMTc1Mzld
Ojxicj4Kc3JjL3ByaXZhdGUtbmV0d29yay5jOm9mb25vXzx1PjwvdT5wcml2YXRlX25ldHdvcmtf
ZHJpdmVyXzx1PjwvdT5yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5NGM2MCwgbmFtZTogQ29u
bk1hbiBQcml2YXRlIE5ldHdvcms8YnI+Cm9mb25vZFsxNzUzOV06IHBsdWdpbnMvZHVuX2d3LmM6
ZHVuX2d3X2luaXQoKTxicj4Kb2Zvbm9kWzE3NTM5XTogcGx1Z2lucy9kdW5fZ3cuYzptb2RlbV93
YXRjaCgpIG1vZGVtOiAweDljOTlmNDAsIGFkZGVkOiAxPGJyPgpvZm9ub2RbMTc1MzldOiBwbHVn
aW5zL2hmcF9hZy5jOm1vZGVtX3dhdGNoKCkgbW9kZW06IDB4OWM5OWY0MCwgYWRkZWQ6IDE8YnI+
Cm9mb25vZFsxNzUzOV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtXzx1PjwvdT5kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6PGJyPgoweDgxOTRiYTAsIG5hbWU6IGhmcDxicj4Kb2Zvbm9kWzE3NTM5
XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fPHU+PC91PmRyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjo8YnI+CjB4ODE5NGI0MCwgbmFtZTogc2FwPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0u
YzpvZm9ub19tb2RlbV88dT48L3U+ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTk0
YWMwLCBuYW1lOiB0ZWxpdDxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9k
ZW1fPHU+PC91PmRyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5NDljMCwgbmFtZTog
c2ltOTAwPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV88dT48L3U+
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTk0OTYwLCBuYW1lOiBzYW1zdW5nPGJy
PgpvZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV88dT48L3U+ZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTk0OTAwLCBuYW1lOiBzcGVlZHVwY2RtYTxicj4Kb2Zv
bm9kWzE3NTM5XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fPHU+PC91PmRyaXZlcl9yZWdpc3Rl
cigpIGRyaXZlcjo8YnI+CjB4ODE5NDhhMCwgbmFtZTogc3BlZWR1cDxicj4Kb2Zvbm9kWzE3NTM5
XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fPHU+PC91PmRyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjo8YnI+CjB4ODE5NDg0MCwgbmFtZTogYWxjYXRlbDxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL21v
ZGVtLmM6b2Zvbm9fbW9kZW1fPHU+PC91PmRyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4
ODE5NDdlMCwgbmFtZTogaWNlcmE8YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9tb2RlbS5jOm9mb25v
X21vZGVtXzx1PjwvdT5kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDgxOTQ3ODAsIG5h
bWU6IGxpbmt0b3A8YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtXzx1
PjwvdT5kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDgxOTQ3MjAsIG5hbWU6IG5va2lh
Y2RtYTxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fPHU+PC91PmRy
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5NDZjMCwgbmFtZTogbm9raWE8YnI+Cm9m
b25vZFsxNzUzOV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtXzx1PjwvdT5kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6PGJyPgoweDgxOTQ2NjAsIG5hbWU6IHRjNjU8YnI+Cm9mb25vZFsxNzUzOV06
IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtXzx1PjwvdT5kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
PGJyPgoweDgxOTQ1YzAsIG5hbWU6IHN0ZTxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL21vZGVtLmM6
b2Zvbm9fbW9kZW1fPHU+PC91PmRyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5NDU2
MCwgbmFtZTogaWZ4PGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV88
dT48L3U+ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTk0NTAwLCBuYW1lOiBwYWxt
cHJlPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV88dT48L3U+ZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTk0NGEwLCBuYW1lOiBub3ZhdGVsPGJyPgpv
Zm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV88dT48L3U+ZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOjxicj4KMHg4MTk0NDQwLCBuYW1lOiBzaWVycmE8YnI+Cm9mb25vZFsxNzUz
OV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtXzx1PjwvdT5kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6PGJyPgoweDgxOTQzYzAsIG5hbWU6IGh1YXdlaTxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL21v
ZGVtLmM6b2Zvbm9fbW9kZW1fPHU+PC91PmRyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4
ODE5NDM2MCwgbmFtZTogenRlPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpvZm9ub19t
b2RlbV88dT48L3U+ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTk0MzAwLCBuYW1l
OiBoc288YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtXzx1PjwvdT5k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDgxOTQyYTAsIG5hbWU6IG1ibTxicj4Kb2Zv
bm9kWzE3NTM5XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fPHU+PC91PmRyaXZlcl9yZWdpc3Rl
cigpIGRyaXZlcjo8YnI+CjB4ODE5NDI0MCwgbmFtZTogY2FseXBzbzxicj4Kb2Zvbm9kWzE3NTM5
XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fPHU+PC91PmRyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjo8YnI+CjB4ODE5NDFlMCwgbmFtZTogd2F2ZWNvbTxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL21v
ZGVtLmM6b2Zvbm9fbW9kZW1fPHU+PC91PmRyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4
ODE5NDE4MCwgbmFtZTogZzE8YnI+Cm9mb25vZFsxNzUzOV06PGJyPgpzcmMvY2RtYS12b2ljZWNh
bGwuYzpvZm9ub188dT48L3U+Y2RtYV92b2ljZWNhbGxfZHJpdmVyXzx1PjwvdT5yZWdpc3Rlcigp
IGRyaXZlcjo8YnI+CjB4ODE5NDEwMCwgbmFtZTogY2RtYW1vZGVtPGJyPgpvZm9ub2RbMTc1Mzld
OiBzcmMvbW9kZW0uYzpvZm9ub19kZXZpbmZvXzx1PjwvdT5kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6PGJyPgoweDgxOTQxMjAsIG5hbWU6IGNkbWFtb2RlbTxicj4Kb2Zvbm9kWzE3NTM5XTogc3Jj
L2NkbWEtY29ubm1hbi5jOm9mb25vX2NkbWFfPHU+PC91PmNvbm5tYW5fZHJpdmVyX3JlZ2lzdGVy
KCk8YnI+CmRyaXZlcjogMHg4MTk0MTQ0LCBuYW1lOiBjZG1hbW9kZW08YnI+Cm9mb25vZFsxNzUz
OV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtXzx1PjwvdT5kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6PGJyPgoweDgxOTQwNjAsIG5hbWU6IHBob25lc2ltPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMv
bW9kZW0uYzpvZm9ub19tb2RlbV88dT48L3U+ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4K
MHg4MTk0MGEwLCBuYW1lOiBsb2NhbGhmcDxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL2dwcnMuYzpv
Zm9ub19ncHJzX2NvbnRleHRfPHU+PC91PmRyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4
ODE5NDAzNCwgbmFtZTogcGhvbmVzaW08YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9jdG0uYzpvZm9u
b19jdG1fZHJpdmVyXzx1PjwvdT5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTk0MDIwLDxicj4KbmFt
ZTogcGhvbmVzaW08YnI+Cm9mb25vZFsxNzUzOV06IHBsdWdpbnMvcGhvbmVzaW0uYzpwYXJzZV88
dT48L3U+Y29uZmlnKCkgZmlsZW5hbWU8YnI+Ci9ldGMvb2Zvbm8vcGhvbmVzaW0uY29uZjxicj4K
b2Zvbm9kWzE3NTM5XTogUmVhZGluZyBvZiAvZXRjL29mb25vL3Bob25lc2ltLmNvbmYgZmFpbGVk
OiBObyBzdWNoIGZpbGU8YnI+Cm9yIGRpcmVjdG9yeTxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL3Vz
c2QuYzpvZm9ub191c3NkX2RyaXZlcl88dT48L3U+cmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDgx
OTNmZTAsIG5hbWU6IHNwZWVkdXBtb2RlbTxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL3ZvaWNlY2Fs
bC5jOm9mb25vXzx1PjwvdT52b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4K
MHg4MTkzZWMwLCBuYW1lOiBoZnBtb2RlbTxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL21vZGVtLmM6
b2Zvbm9fZGV2aW5mb188dT48L3U+ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTkz
ZjdjLCBuYW1lOiBoZnBtb2RlbTxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL25ldHdvcmsuYzpvZm9u
b19uZXRyZWdfPHU+PC91PmRyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5M2YyMCwg
bmFtZTogaGZwbW9kZW08YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9jYWxsLXZvbHVtZS5jOm9mb25v
X2NhbGxfPHU+PC91PnZvbHVtZV9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDgxOTNm
NTQsIG5hbWU6IGhmcG1vZGVtPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvaGFuZHNmcmVlLmM6b2Zv
bm9fPHU+PC91PmhhbmRzZnJlZV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDgxOTNm
OTgsIG5hbWU6IGhmcG1vZGVtPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvbmV0d29yay5jOm9mb25v
X25ldHJlZ188dT48L3U+ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTkzZTQwLCBu
YW1lOiBkdW5tb2RlbTxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2Ry
aXZlcl88dT48L3U+cmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDgxOTNlNmMsIG5hbWU6IGR1bm1v
ZGVtPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvdm9pY2VjYWxsLmM6b2Zvbm9fPHU+PC91PnZvaWNl
Y2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDgxOTNkNjAsIG5hbWU6IHN0ZW1v
ZGVtPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF88dT48
L3U+ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTkzZGVjLCBuYW1lOiBzdGVtb2Rl
bTxicj4Kb2Zvbm9kWzE3NTM5XTo8YnI+CnNyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vXzx1Pjwv
dT5yYWRpb19zZXR0aW5nc19kcml2ZXJfPHU+PC91PnJlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4
MTkzZGMwLCBuYW1lOiBzdGVtb2RlbTxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL3ZvaWNlY2FsbC5j
Om9mb25vXzx1PjwvdT52b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4
MTkzYzIwLCBuYW1lOiBpZnhtb2RlbTxicj4Kb2Zvbm9kWzE3NTM5XTo8YnI+CnNyYy9hdWRpby1z
ZXR0aW5ncy5jOm9mb25vXzx1PjwvdT5hdWRpb19zZXR0aW5nc19kcml2ZXJfPHU+PC91PnJlZ2lz
dGVyKCkgZHJpdmVyOjxicj4KMHg4MTkzYzcwLCBuYW1lOiBpZnhtb2RlbTxicj4Kb2Zvbm9kWzE3
NTM5XTo8YnI+CnNyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vXzx1PjwvdT5yYWRpb19zZXR0aW5n
c19kcml2ZXJfPHU+PC91PnJlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTkzY2EwLCBuYW1lOiBp
Znhtb2RlbTxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRf
PHU+PC91PmRyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5M2NjYywgbmFtZTogaWZ4
bW9kZW08YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9zdGsuYzpvZm9ub19zdGtfZHJpdmVyXzx1Pjwv
dT5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTkzY2Y0LDxicj4KbmFtZTogaWZ4bW9kZW08YnI+Cm9m
b25vZFsxNzUzOV06IHNyYy9jdG0uYzpvZm9ub19jdG1fZHJpdmVyXzx1PjwvdT5yZWdpc3Rlcigp
IGRyaXZlcjogMHg4MTkzZDFjLDxicj4KbmFtZTogaWZ4bW9kZW08YnI+Cm9mb25vZFsxNzUzOV06
IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0Xzx1PjwvdT5kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6PGJyPgoweDgxOTNiYTAsIG5hbWU6IGhzb21vZGVtPGJyPgpvZm9ub2RbMTc1MzldOjxi
cj4Kc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fPHU+PC91PnJhZGlvX3NldHRpbmdzX2RyaXZl
cl88dT48L3U+cmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDgxOTNiYzAsIG5hbWU6IGhzb21vZGVt
PGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF88dT48L3U+
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTkzYjAwLCBuYW1lOiBtYm1tb2RlbTxi
cj4Kb2Zvbm9kWzE3NTM5XTogc3JjL3N0ay5jOm9mb25vX3N0a19kcml2ZXJfPHU+PC91PnJlZ2lz
dGVyKCkgZHJpdmVyOiAweDgxOTNiMjgsPGJyPgpuYW1lOiBtYm1tb2RlbTxicj4Kb2Zvbm9kWzE3
NTM5XTo8YnI+CnNyYy9sb2NhdGlvbi1yZXBvcnRpbmcuYzo8dT48L3U+b2Zvbm9fbG9jYXRpb25f
cmVwb3J0aW5nXzx1PjwvdT5kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDgxOTNiNDgs
IG5hbWU6IG1ibW1vZGVtPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvdm9pY2VjYWxsLmM6b2Zvbm9f
PHU+PC91PnZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDgxOTNhNjAs
IG5hbWU6IGNhbHlwc29tb2RlbTxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL3N0ay5jOm9mb25vX3N0
a19kcml2ZXJfPHU+PC91PnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTNhYTgsPGJyPgpuYW1lOiBj
YWx5cHNvbW9kZW08YnI+Cm9mb25vZFsxNzUzOV06IHNyYy91c3NkLmM6b2Zvbm9fdXNzZF9kcml2
ZXJfPHU+PC91PnJlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTkzOTQwLCBuYW1lOiBodWF3ZWlt
b2RlbTxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL3ZvaWNlY2FsbC5jOm9mb25vXzx1PjwvdT52b2lj
ZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTkzOTYwLCBuYW1lOiBodWF3
ZWltb2RlbTxicj4Kb2Zvbm9kWzE3NTM5XTo8YnI+CnNyYy9hdWRpby1zZXR0aW5ncy5jOm9mb25v
Xzx1PjwvdT5hdWRpb19zZXR0aW5nc19kcml2ZXJfPHU+PC91PnJlZ2lzdGVyKCkgZHJpdmVyOjxi
cj4KMHg4MTkzOWE4LCBuYW1lOiBodWF3ZWltb2RlbTxicj4Kb2Zvbm9kWzE3NTM5XTo8YnI+CnNy
Yy9yYWRpby1zZXR0aW5ncy5jOm9mb25vXzx1PjwvdT5yYWRpb19zZXR0aW5nc19kcml2ZXJfPHU+
PC91PnJlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTkzOWUwLCBuYW1lOiBodWF3ZWltb2RlbTxi
cj4Kb2Zvbm9kWzE3NTM5XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfPHU+PC91PmRy
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5MzliYywgbmFtZTogaHVhd2VpbW9kZW08
YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9jZG1hLW5ldHJlZy5jOm9mb25vX2NkbWFfPHU+PC91Pm5l
dHJlZ19kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDgxOTNhMGMsIG5hbWU6IGh1YXdl
aW1vZGVtPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF88
dT48L3U+ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTkzOGEwLCBuYW1lOiBpY2Vy
YW1vZGVtPGJyPgpvZm9ub2RbMTc1MzldOjxicj4Kc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9f
PHU+PC91PnJhZGlvX3NldHRpbmdzX2RyaXZlcl88dT48L3U+cmVnaXN0ZXIoKSBkcml2ZXI6PGJy
PgoweDgxOTM4ZTAsIG5hbWU6IGljZXJhbW9kZW08YnI+Cm9mb25vZFsxNzUzOV06PGJyPgpzcmMv
cmFkaW8tc2V0dGluZ3MuYzpvZm9ub188dT48L3U+cmFkaW9fc2V0dGluZ3NfZHJpdmVyXzx1Pjwv
dT5yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5Mzg0MCwgbmFtZTogenRlbW9kZW08YnI+Cm9m
b25vZFsxNzUzOV06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0Xzx1PjwvdT5kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDgxOTM4MDAsIG5hbWU6IHN3bW9kZW08YnI+Cm9mb25v
ZFsxNzUzOV06PGJyPgpzcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub188dT48L3U+cmFkaW9fc2V0
dGluZ3NfZHJpdmVyXzx1PjwvdT5yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5MzdhMCwgbmFt
ZTogbndtb2RlbTxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL3ZvaWNlY2FsbC5jOm9mb25vXzx1Pjwv
dT52b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTkzNjAwLCBuYW1l
OiBhdG1vZGVtPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpvZm9ub19kZXZpbmZvXzx1
PjwvdT5kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDgxOTM2YTAsIG5hbWU6IGF0bW9k
ZW08YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9jYWxsLWJhcnJpbmcuYzpvZm9ub19jYWxsXzx1Pjwv
dT5iYXJyaW5nX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4ODE5MzY1OCwgbmFtZTog
YXRtb2RlbTxicj4Kb2Zvbm9kWzE3NTM5XTo8YnI+CnNyYy9jYWxsLWZvcndhcmRpbmcuYzpvZm9u
b188dT48L3U+Y2FsbF9mb3J3YXJkaW5nX2RyaXZlcl88dT48L3U+cmVnaXN0ZXIoKSBkcml2ZXI6
PGJyPgoweDgxOTMzYTAsIG5hbWU6IGF0bW9kZW08YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9jYWxs
LW1ldGVyLmM6b2Zvbm9fY2FsbF88dT48L3U+bWV0ZXJfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRy
aXZlcjogMHg4MTkzM2UwLCBuYW1lOiBhdG1vZGVtPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvY2Fs
bC1zZXR0aW5ncy5jOm9mb25vXzx1PjwvdT5jYWxsX3NldHRpbmdzX2RyaXZlcl9yZWdpc3Rlcig8
dT48L3U+KTxicj4KZHJpdmVyOiAweDgxOTMyYTAsIG5hbWU6IGF0bW9kZW08YnI+Cm9mb25vZFsx
NzUzOV06IHNyYy9waG9uZWJvb2suYzpvZm9ub188dT48L3U+cGhvbmVib29rX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5MzY3OCwgbmFtZTogYXRtb2RlbTxicj4Kb2Zvbm9kWzE3
NTM5XTogc3JjL3Vzc2QuYzpvZm9ub191c3NkX2RyaXZlcl88dT48L3U+cmVnaXN0ZXIoKSBkcml2
ZXI6PGJyPgoweDgxOTM1ZDQsIG5hbWU6IGF0bW9kZW08YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9z
bXMuYzpvZm9ub19zbXNfZHJpdmVyXzx1PjwvdT5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTkzMzIw
LDxicj4KbmFtZTogYXRtb2RlbTxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL3NpbS5jOm9mb25vX3Np
bV9kcml2ZXJfPHU+PC91PnJlZ2lzdGVyKCkgZHJpdmVyOiAweDgxOTM0YTAsPGJyPgpuYW1lOiBh
dG1vZGVtPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvc2ltLmM6b2Zvbm9fc2ltX2RyaXZlcl88dT48
L3U+cmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5MzUwMCw8YnI+Cm5hbWU6IGF0bW9kZW0tbm9lZjxi
cj4Kb2Zvbm9kWzE3NTM5XTogc3JjL3N0ay5jOm9mb25vX3N0a19kcml2ZXJfPHU+PC91PnJlZ2lz
dGVyKCkgZHJpdmVyOiAweDgxOTM1YjQsPGJyPgpuYW1lOiBhdG1vZGVtPGJyPgpvZm9ub2RbMTc1
MzldOiBzcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ188dT48L3U+ZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOjxicj4KMHg4MTkzNDQwLCBuYW1lOiBhdG1vZGVtPGJyPgpvZm9ub2RbMTc1MzldOiBz
cmMvY2JzLmM6b2Zvbm9fY2JzX2RyaXZlcl88dT48L3U+cmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5
MzM4MCw8YnI+Cm5hbWU6IGF0bW9kZW08YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9jYWxsLXZvbHVt
ZS5jOm9mb25vX2NhbGxfPHU+PC91PnZvbHVtZV9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVy
OiAweDgxOTM2YzQsIG5hbWU6IGF0bW9kZW08YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9ncHJzLmM6
b2Zvbm9fZ3Byc19kcml2ZXJfPHU+PC91PnJlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTkzNmY0
LCBuYW1lOiBhdG1vZGVtPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNf
Y29udGV4dF88dT48L3U+ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTkzNzE4LCBu
YW1lOiBhdG1vZGVtPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvc2ltLWF1dGguYzpvZm9ub19zaW1f
YXV0aF88dT48L3U+ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTkzNzMwLCBuYW1l
OiBhdG1vZGVtPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvZ25zcy5jOm9mb25vX2duc3NfZHJpdmVy
Xzx1PjwvdT5yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5Mzc0OCwgbmFtZTogYXRtb2RlbTxi
cj4Kb2Zvbm9kWzE3NTM5XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fPHU+PC91PmRyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5MzA4MCwgbmFtZTogZ29iaTxicj4Kb2Zvbm9kWzE3
NTM5XTogc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5mb188dT48L3U+ZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOjxicj4KMHg4MTkyZTQwLCBuYW1lOiBxbWltb2RlbTxicj4Kb2Zvbm9kWzE3NTM5XTog
c3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfPHU+PC91PmRyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjo8YnI+CjB4ODE5MmVjMCwgbmFtZTogcW1pbW9kZW08YnI+Cm9mb25vZFsxNzUzOV06IHNyYy92
b2ljZWNhbGwuYzpvZm9ub188dT48L3U+dm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjo8YnI+CjB4ODE5MmU2MCwgbmFtZTogcW1pbW9kZW08YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9z
aW0uYzpvZm9ub19zaW1fZHJpdmVyXzx1PjwvdT5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTkyZjAw
LDxicj4KbmFtZTogcW1pbW9kZW0tbGVnYWN5PGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvc2ltLmM6
b2Zvbm9fc2ltX2RyaXZlcl88dT48L3U+cmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5MmY2MCw8YnI+
Cm5hbWU6IHFtaW1vZGVtPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvc21zLmM6b2Zvbm9fc21zX2Ry
aXZlcl88dT48L3U+cmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE5MmZjMCw8YnI+Cm5hbWU6IHFtaW1v
ZGVtPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvdXNzZC5jOm9mb25vX3Vzc2RfZHJpdmVyXzx1Pjwv
dT5yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5MmZlMCwgbmFtZTogcW1pbW9kZW08YnI+Cm9m
b25vZFsxNzUzOV06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19kcml2ZXJfPHU+PC91PnJlZ2lzdGVy
KCkgZHJpdmVyOjxicj4KMHg4MTkyZmY0LCBuYW1lOiBxbWltb2RlbTxicj4Kb2Zvbm9kWzE3NTM5
XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfPHU+PC91PmRyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjo8YnI+CjB4ODE5MzAwOCwgbmFtZTogcW1pbW9kZW08YnI+Cm9mb25vZFsxNzUzOV06
PGJyPgpzcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub188dT48L3U+cmFkaW9fc2V0dGluZ3NfZHJp
dmVyXzx1PjwvdT5yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5MzAyMCwgbmFtZTogcW1pbW9k
ZW08YnI+Cm9mb25vZFsxNzUzOV06PGJyPgpzcmMvbG9jYXRpb24tcmVwb3J0aW5nLmM6PHU+PC91
Pm9mb25vX2xvY2F0aW9uX3JlcG9ydGluZ188dT48L3U+ZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRy
aXZlcjogMHg4MTkzMDQ0LCBuYW1lOiBxbWltb2RlbTxicj4Kb2Zvbm9kWzE3NTM5XTogc3JjL21v
ZGVtLmM6b2Zvbm9fbW9kZW1fPHU+PC91PmRyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4
ODE5MmRlMCwgbmFtZTogdTg1MDA8YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9tb2RlbS5jOm9mb25v
X2RldmluZm9fPHU+PC91PmRyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5MmRjMCwg
bmFtZTogdTg1MDA8YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtXzx1
PjwvdT5kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDgxOTJkNjAsIG5hbWU6IG45MDA8
YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtXzx1PjwvdT5kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDgxOTJkMDAsIG5hbWU6IGlzaXVzYjxicj4Kb2Zvbm9k
WzE3NTM5XTogc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5mb188dT48L3U+ZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOjxicj4KMHg4MTkyOWYwLCBuYW1lOiBpc2ltb2RlbTxicj4Kb2Zvbm9kWzE3NTM5
XTogc3JjL3Bob25lYm9vay5jOm9mb25vXzx1PjwvdT5waG9uZWJvb2tfZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOjxicj4KMHg4MTkyOWUwLCBuYW1lOiBpc2ltb2RlbTxicj4Kb2Zvbm9kWzE3NTM5
XTogc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfPHU+PC91PmRyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjo8YnI+CjB4ODE5MmEyMCwgbmFtZTogaXNpbW9kZW08YnI+Cm9mb25vZFsxNzUzOV06IHNy
Yy92b2ljZWNhbGwuYzpvZm9ub188dT48L3U+dm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjo8YnI+CjB4ODE5MmE2MCwgbmFtZTogaXNpbW9kZW08YnI+Cm9mb25vZFsxNzUzOV06IHNy
Yy9zbXMuYzpvZm9ub19zbXNfZHJpdmVyXzx1PjwvdT5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTky
YWMwLDxicj4KbmFtZTogaXNpbW9kZW08YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9jYnMuYzpvZm9u
b19jYnNfZHJpdmVyXzx1PjwvdT5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTkyYWUwLDxicj4KbmFt
ZTogaXNpbW9kZW08YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVy
Xzx1PjwvdT5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTkyYjAwLDxicj4KbmFtZTogaXNpbW9kZW08
YnI+Cm9mb25vZFsxNzUzOV06IHNyYy91c3NkLmM6b2Zvbm9fdXNzZF9kcml2ZXJfPHU+PC91PnJl
Z2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTkyYjQ4LCBuYW1lOiBpc2ltb2RlbTxicj4Kb2Zvbm9k
WzE3NTM5XTo8YnI+CnNyYy9jYWxsLWZvcndhcmRpbmcuYzpvZm9ub188dT48L3U+Y2FsbF9mb3J3
YXJkaW5nX2RyaXZlcl88dT48L3U+cmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDgxOTJiNjAsIG5h
bWU6IGlzaW1vZGVtPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvY2FsbC1zZXR0aW5ncy5jOm9mb25v
Xzx1PjwvdT5jYWxsX3NldHRpbmdzX2RyaXZlcl9yZWdpc3Rlcig8dT48L3U+KTxicj4KZHJpdmVy
OiAweDgxOTJiODAsIG5hbWU6IGlzaW1vZGVtPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvY2FsbC1i
YXJyaW5nLmM6b2Zvbm9fY2FsbF88dT48L3U+YmFycmluZ19kcml2ZXJfcmVnaXN0ZXIoKTxicj4K
ZHJpdmVyOiAweDgxOTJiYjAsIG5hbWU6IGlzaW1vZGVtPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMv
Y2FsbC1tZXRlci5jOm9mb25vX2NhbGxfPHU+PC91Pm1ldGVyX2RyaXZlcl9yZWdpc3RlcigpPGJy
Pgpkcml2ZXI6IDB4ODE5MmJlMCwgbmFtZTogaXNpbW9kZW08YnI+Cm9mb25vZFsxNzUzOV06PGJy
PgpzcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub188dT48L3U+cmFkaW9fc2V0dGluZ3NfZHJpdmVy
Xzx1PjwvdT5yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5MmMyMCwgbmFtZTogaXNpbW9kZW08
YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19kcml2ZXJfPHU+PC91PnJl
Z2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTkyYzQ0LCBuYW1lOiBpc2ltb2RlbTxicj4Kb2Zvbm9k
WzE3NTM5XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfPHU+PC91PmRyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5MmM1OCwgbmFtZTogaXNpbW9kZW08YnI+Cm9mb25vZFsx
NzUzOV06PGJyPgpzcmMvYXVkaW8tc2V0dGluZ3MuYzpvZm9ub188dT48L3U+YXVkaW9fc2V0dGlu
Z3NfZHJpdmVyXzx1PjwvdT5yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4ODE5MmM3MCwgbmFtZTog
aXNpbW9kZW08YnI+Cm9mb25vZFsxNzUzOV06IHNyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVyXzx1
PjwvdT5yZWdpc3RlcigpIGRyaXZlcjogMHg4MTkyYzgwLDxicj4KbmFtZTogd2dtb2RlbTIuNTxi
cj4Kb2Zvbm9kWzE3NTM5XTogcGx1Z2lucy91ZGV2bmcuYzp1ZGV2X3N0YXJ0KCk8YnI+Cm9mb25v
ZFsxNzUzOV06IHBsdWdpbnMvdWRldm5nLmM6ZW51bWVyYXRlXzx1PjwvdT5kZXZpY2VzKCk8YnI+
Cm9mb25vZFsxNzUzOV06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiXzx1PjwvdT5kZXZpY2Uo
KSBodWIgWyhudWxsKToobnVsbCldPGJyPgpvZm9ub2RbMTc1MzldOiBwbHVnaW5zL3VkZXZuZy5j
OmNoZWNrX3VzYl88dT48L3U+ZGV2aWNlKCkgdXNiIFs4MDg3OjAwMjBdPGJyPgpvZm9ub2RbMTc1
MzldOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl88dT48L3U+ZGV2aWNlKCkgdXNiIFsxYTQw
OjAxMDFdPGJyPgpvZm9ub2RbMTc1MzldOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl88dT48
L3U+ZGV2aWNlKCkgdXNiIFswNjdiOjIzMDNdPGJyPgpvZm9ub2RbMTc1MzldOiBwbHVnaW5zL3Vk
ZXZuZy5jOmNoZWNrX3VzYl88dT48L3U+ZGV2aWNlKCkgcGwyMzAzIFsobnVsbCk6KG51bGwpXTxi
cj4Kb2Zvbm9kWzE3NTM5XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfPHU+PC91PmRldmlj
ZSgpIHBsMjMwMyBbMDY3YjoyMzAzXTxicj4Kb2Zvbm9kWzE3NTM5XTogcGx1Z2lucy91ZGV2bmcu
YzpjaGVja191c2JfPHU+PC91PmRldmljZSgpIHVzYiBbMDY3YjoyMzAzXTxicj4Kb2Zvbm9kWzE3
NTM5XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfPHU+PC91PmRldmljZSgpIHBsMjMwMyBb
KG51bGwpOihudWxsKV08YnI+Cm9mb25vZFsxNzUzOV06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tf
dXNiXzx1PjwvdT5kZXZpY2UoKSBwbDIzMDMgWzA2N2I6MjMwM108YnI+Cm9mb25vZFsxNzUzOV06
IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiXzx1PjwvdT5kZXZpY2UoKSBodWIgWyhudWxsKToo
bnVsbCldPGJyPgpvZm9ub2RbMTc1MzldOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl88dT48
L3U+ZGV2aWNlKCkgdXNiIFswNDA5OjAwNWFdPGJyPgpvZm9ub2RbMTc1MzldOiBwbHVnaW5zL3Vk
ZXZuZy5jOmNoZWNrX3VzYl88dT48L3U+ZGV2aWNlKCkgdXNiIFswNThmOjYyNTRdPGJyPgpvZm9u
b2RbMTc1MzldOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl88dT48L3U+ZGV2aWNlKCkgdXNi
IFswNThmOjYzNjZdPGJyPgpvZm9ub2RbMTc1MzldOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3Vz
Yl88dT48L3U+ZGV2aWNlKCkgdXNiLXN0b3JhZ2U8YnI+ClsobnVsbCk6KG51bGwpXTxicj4Kb2Zv
bm9kWzE3NTM5XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfPHU+PC91PmRldmljZSgpIGh1
YiBbKG51bGwpOihudWxsKV08YnI+Cm9mb25vZFsxNzUzOV06IHBsdWdpbnMvdWRldm5nLmM6Y2hl
Y2tfdXNiXzx1PjwvdT5kZXZpY2UoKSBodWIgWyhudWxsKToobnVsbCldPGJyPgpvZm9ub2RbMTc1
MzldOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl88dT48L3U+ZGV2aWNlKCkgdXNiIFswNDZk
OmMwNWFdPGJyPgpvZm9ub2RbMTc1MzldOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl88dT48
L3U+ZGV2aWNlKCkgdXNiaGlkIFsobnVsbCk6KG51bGwpXTxicj4Kb2Zvbm9kWzE3NTM5XTogcGx1
Z2lucy91ZGV2bmcuYzpjaGVja191c2JfPHU+PC91PmRldmljZSgpIHVzYiBbMDQ1ZTowMGRiXTxi
cj4Kb2Zvbm9kWzE3NTM5XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfPHU+PC91PmRldmlj
ZSgpIHVzYmhpZCBbKG51bGwpOihudWxsKV08YnI+Cm9mb25vZFsxNzUzOV06IHBsdWdpbnMvdWRl
dm5nLmM6Y2hlY2tfdXNiXzx1PjwvdT5kZXZpY2UoKSB1c2JoaWQgWyhudWxsKToobnVsbCldPGJy
PgpvZm9ub2RbMTc1MzldOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl88dT48L3U+ZGV2aWNl
KCkgaHViIFsobnVsbCk6KG51bGwpXTxicj4Kb2Zvbm9kWzE3NTM5XTogcGx1Z2lucy91ZGV2bmcu
YzpjaGVja191c2JfPHU+PC91PmRldmljZSgpIGh1YiBbKG51bGwpOihudWxsKV08YnI+Cm9mb25v
ZFsxNzUzOV06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiXzx1PjwvdT5kZXZpY2UoKSB1c2Ig
WzgwODc6MDAyMF08YnI+Cm9mb25vZFsxNzUzOV06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNi
Xzx1PjwvdT5kZXZpY2UoKSB1c2IgWzA0MDM6NjAxMF08YnI+Cm9mb25vZFsxNzUzOV06IHBsdWdp
bnMvdWRldm5nLmM6Y2hlY2tfdXNiXzx1PjwvdT5kZXZpY2UoKSBmdGRpX3NpbyBbKG51bGwpOihu
dWxsKV08YnI+Cm9mb25vZFsxNzUzOV06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiXzx1Pjwv
dT5kZXZpY2UoKSBmdGRpX3NpbyBbMDQwMzo2MDEwXTxicj4Kb2Zvbm9kWzE3NTM5XTogcGx1Z2lu
cy91ZGV2bmcuYzpjaGVja191c2JfPHU+PC91PmRldmljZSgpIGZ0ZGlfc2lvIFsobnVsbCk6KG51
bGwpXTxicj4Kb2Zvbm9kWzE3NTM5XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfPHU+PC91
PmRldmljZSgpIGZ0ZGlfc2lvIFswNDAzOjYwMTBdPGJyPgpvZm9ub2RbMTc1MzldOiBwbHVnaW5z
L3VkZXZuZy5jOmNoZWNrX3VzYl88dT48L3U+ZGV2aWNlKCkgaHViIFsobnVsbCk6KG51bGwpXTxi
cj4KPC9ibG9ja3F1b3RlPgo8YnI+CkkgZG9uJiMzOTt0IHNlZSB0aGUgc2ltY29tIGRldmljZS4g
SSBoYXZlIGdvdCB0aGVzZXMgbWVzc2FnZXMgaW4gbXkgY29uc29sZSA6PGJyPgo8YnI+CkphbiCg
NyAxMzoxMjoxOCBtcjMwMDAgb2Zvbm9kWzE5NjI0XTogcGx1Z2lucy91ZGV2bmcuYzp1ZGV2X3N0
YXJ0KCk8YnI+CkphbiCgNyAxMzoxMjoxOCBtcjMwMDAgb2Zvbm9kWzE5NjI0XTogcGx1Z2lucy91
ZGV2bmcuYzplbnVtZXJhdGVfPHU+PC91PmRldmljZXMoKTxicj4KSmFuIKA3IDEzOjEyOjIyIG1y
MzAwMCBvZm9ub2RbMTk2MjRdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl88dT48L3U+ZGV2
aWNlKCkgb3B0aW9uIFswNWM2OjkwMDBdPGJyPgpKYW4goDcgMTM6MTI6MjIgbXIzMDAwIG9mb25v
ZFsxOTYyNF06IHBsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wbGF0
Zm9ybS9vaGNpLjAvPHU+PC91PnVzYjIvMi0xLzItMToxLjAvdHR5VVNCMC90dHkvPHU+PC91PnR0
eVVTQjA8YnI+CkphbiCgNyAxMzoxMjoyMiBtcjMwMDAgb2Zvbm9kWzE5NjI0XTogcGx1Z2lucy91
ZGV2bmcuYzphZGRfZGV2aWNlKCkgL2Rldi90dHlVU0IwIChzaW1jb20pIDI1NS8yNTUvMjU1IFsw
MF0gPT0mZ3Q7IChudWxsKSAobnVsbCk8YnI+CkphbiCgNyAxMzoxMjoyMiBtcjMwMDAgb2Zvbm9k
WzE5NjI0XTogcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSB0dHkgYWRkPGJy
PgpKYW4goDcgMTM6MTI6MjIgbXIzMDAwIG9mb25vZFsxOTYyNF06IHBsdWdpbnMvdWRldi5jOnVk
ZXZfZXZlbnQoKSBzdWJzeXN0ZW0gdHR5IGZpbmlzaGVkPGJyPgpKYW4goDcgMTM6MTI6MjIgbXIz
MDAwIG9mb25vZFsxOTYyNF06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiXzx1PjwvdT5kZXZp
Y2UoKSBvcHRpb24gWzA1YzY6OTAwMF08YnI+CkphbiCgNyAxMzoxMjoyMiBtcjMwMDAgb2Zvbm9k
WzE5NjI0XTogcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BsYXRm
b3JtL29oY2kuMC88dT48L3U+dXNiMi8yLTEvMi0xOjEuMS90dHlVU0IxL3R0eS88dT48L3U+dHR5
VVNCMTxicj4KSmFuIKA3IDEzOjEyOjIyIG1yMzAwMCBvZm9ub2RbMTk2MjRdOiBwbHVnaW5zL3Vk
ZXZuZy5jOmFkZF9kZXZpY2UoKSAvZGV2L3R0eVVTQjEgKHNpbWNvbSkgMjU1LzI1NS8yNTUgWzAx
XSA9PSZndDsgKG51bGwpIChudWxsKTxicj4KSmFuIKA3IDEzOjEyOjIyIG1yMzAwMCBvZm9ub2Rb
MTk2MjRdOiBwbHVnaW5zL3VkZXYuYzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSBhZGQ8YnI+
CkphbiCgNyAxMzoxMjoyMiBtcjMwMDAgb2Zvbm9kWzE5NjI0XTogcGx1Z2lucy91ZGV2LmM6dWRl
dl9ldmVudCgpIHN1YnN5c3RlbSB0dHkgZmluaXNoZWQ8YnI+CkphbiCgNyAxMzoxMjoyMiBtcjMw
MDAgb2Zvbm9kWzE5NjI0XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfPHU+PC91PmRldmlj
ZSgpIG9wdGlvbiBbMDVjNjo5MDAwXTxicj4KSmFuIKA3IDEzOjEyOjIyIG1yMzAwMCBvZm9ub2Rb
MTk2MjRdOiBwbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvc3lzL2RldmljZXMvcGxhdGZv
cm0vb2hjaS4wLzx1PjwvdT51c2IyLzItMS8yLTE6MS4yL3R0eVVTQjIvdHR5Lzx1PjwvdT50dHlV
U0IyPGJyPgpKYW4goDcgMTM6MTI6MjIgbXIzMDAwIG9mb25vZFsxOTYyNF06IHBsdWdpbnMvdWRl
dm5nLmM6YWRkX2RldmljZSgpIC9kZXYvdHR5VVNCMiAoc2ltY29tKSAyNTUvMjU1LzI1NSBbMDJd
ID09Jmd0OyAobnVsbCkgKG51bGwpPGJyPgpKYW4goDcgMTM6MTI6MjIgbXIzMDAwIG9mb25vZFsx
OTYyNF06IHBsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBzdWJzeXN0ZW0gdHR5IGFkZDxicj4K
SmFuIKA3IDEzOjEyOjIzIG1yMzAwMCBvZm9ub2RbMTk2MjRdOiBwbHVnaW5zL3VkZXYuYzp1ZGV2
X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSBmaW5pc2hlZDxicj4KSmFuIKA3IDEzOjEyOjIzIG1yMzAw
MCBvZm9ub2RbMTk2MjRdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl88dT48L3U+ZGV2aWNl
KCkgb3B0aW9uIFswNWM2OjkwMDBdPGJyPgpKYW4goDcgMTM6MTI6MjMgbXIzMDAwIG9mb25vZFsx
OTYyNF06IHBsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wbGF0Zm9y
bS9vaGNpLjAvPHU+PC91PnVzYjIvMi0xLzItMToxLjMvdHR5VVNCMy90dHkvPHU+PC91PnR0eVVT
QjM8YnI+CkphbiCgNyAxMzoxMjoyMyBtcjMwMDAgb2Zvbm9kWzE5NjI0XTogcGx1Z2lucy91ZGV2
bmcuYzphZGRfZGV2aWNlKCkgL2Rldi90dHlVU0IzIChzaW1jb20pIDI1NS8yNTUvMjU1IFswM10g
PT0mZ3Q7IChudWxsKSAobnVsbCk8YnI+CkphbiCgNyAxMzoxMjoyMyBtcjMwMDAgb2Zvbm9kWzE5
NjI0XTogcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSB0dHkgYWRkPGJyPgpK
YW4goDcgMTM6MTI6MjMgbXIzMDAwIG9mb25vZFsxOTYyNF06IHBsdWdpbnMvdWRldi5jOnVkZXZf
ZXZlbnQoKSBzdWJzeXN0ZW0gdHR5IGZpbmlzaGVkPGJyPgpKYW4goDcgMTM6MTI6MjMgbXIzMDAw
IG9mb25vZFsxOTYyNF06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiXzx1PjwvdT5kZXZpY2Uo
KSBvcHRpb24gWzA1YzY6OTAwMF08YnI+CkphbiCgNyAxMzoxMjoyMyBtcjMwMDAgb2Zvbm9kWzE5
NjI0XTogcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BsYXRmb3Jt
L29oY2kuMC88dT48L3U+dXNiMi8yLTEvMi0xOjEuNC90dHlVU0I0L3R0eS88dT48L3U+dHR5VVNC
NDxicj4KSmFuIKA3IDEzOjEyOjIzIG1yMzAwMCBvZm9ub2RbMTk2MjRdOiBwbHVnaW5zL3VkZXZu
Zy5jOmFkZF9kZXZpY2UoKSAvZGV2L3R0eVVTQjQgKHNpbWNvbSkgMjU1LzI1NS8yNTUgWzA0XSA9
PSZndDsgKG51bGwpIChudWxsKTxicj4KSmFuIKA3IDEzOjEyOjIzIG1yMzAwMCBvZm9ub2RbMTk2
MjRdOiBwbHVnaW5zL3VkZXYuYzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSBhZGQ8YnI+Ckph
biCgNyAxMzoxMjoyMyBtcjMwMDAgb2Zvbm9kWzE5NjI0XTogcGx1Z2lucy91ZGV2LmM6dWRldl9l
dmVudCgpIHN1YnN5c3RlbSB0dHkgZmluaXNoZWQ8YnI+CkphbiCgNyAxMzoxMjoyMyBtcjMwMDAg
b2Zvbm9kWzE5NjI0XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja19tb2RlbV88dT48L3U+bGlzdCgp
PGJyPgpKYW4goDcgMTM6MTI6MjMgbXIzMDAwIG9mb25vZFsxOTYyNF06IHBsdWdpbnMvdWRldm5n
LmM6Y3JlYXRlX21vZGVtKDx1PjwvdT4pIC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS9vaGNpLjAvPHU+
PC91PnVzYjIvMi0xPGJyPgpKYW4goDcgMTM6MTI6MjMgbXIzMDAwIG9mb25vZFsxOTYyNF06IHBs
dWdpbnMvdWRldm5nLmM6Y3JlYXRlX21vZGVtKDx1PjwvdT4pIGRyaXZlcj1zaW1jb22gPGJyPjwv
YmxvY2txdW90ZT48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQtd2lkdGg6MXB4O2JvcmRlci1sZWZ0LWNvbG9y
OnJnYigyMDQsMjA0LDIwNCk7Ym9yZGVyLWxlZnQtc3R5bGU6c29saWQ7cGFkZGluZy1sZWZ0OjFl
eCI+CgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPHU+PC91Pi0tLS0tLS0tLS0tLS0t
LS0tPGJyPgo8YnI+CnVkZXZuZyBkbyB0aGUgY3JlYXRpb24uPGJyPgo8YnI+CjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3Jk
ZXItbGVmdC13aWR0aDoxcHg7Ym9yZGVyLWxlZnQtY29sb3I6cmdiKDIwNCwyMDQsMjA0KTtib3Jk
ZXItbGVmdC1zdHlsZTpzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4Kb2Zvbm9kWzE3NTM5XTogc3Jj
L21vZGVtLmM6b2Zvbm9fbW9kZW1fPHU+PC91PmNyZWF0ZSgpIG5hbWU6IChudWxsKSwgdHlwZTog
c2ltY29tPGJyPgpvZm9ub2RbMTc1MzldOiBzcmMvbW9kZW0uYzpzZXRfbW9kZW1fPHU+PC91PnBy
b3BlcnR5KCkgbW9kZW0gMHg5Y2ExNWI4IHByb3BlcnR5PGJyPgpQYXRoPGJyPgpvZm9ub2RbMTc1
MzldOiBwbHVnaW5zL3VkZXYuYzphZGRfbW9kZW0oKTxicj4KL2RldmljZXMvcGNpMDAwMDowMC8w
MDAwOjAwOjx1PjwvdT4xZC4wL3VzYjIvMi0xLzItMS42LzItMS42OjEuMS88dT48L3U+dHR5VVNC
My90dHkvdHR5VVNCMzxicj4KKHNpbWNvbSk8YnI+Cm9mb25vZFsxNzUzOV06PGJyPgpzcmMvcHJp
dmF0ZS1uZXR3b3JrLmM6b2Zvbm9fPHU+PC91PnByaXZhdGVfbmV0d29ya19kcml2ZXJfPHU+PC91
PnJlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg4MTk0ZTAwLCBuYW1lOiBFeGFtcGxlIFByaXZhdGUg
TmV0d29yayBEcml2ZXI8YnI+Cm9mb25vZFsxNzUzOV06IHBsdWdpbnMvYmx1ZXRvb3RoLmM6bWFu
YWdlcl88dT48L3U+cHJvcGVydGllc19jYigpPGJyPgpvZm9ub2RbMTc1MzldOiBwbHVnaW5zL2Js
dWV0b290aC5jOnBhcnNlXzx1PjwvdT5hZGFwdGVycygpPGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj4K
T24gdGhlIG90aGVyIHNpZGUsIGl0IGFwcGVhcnMgaXRzIHVkZXYgd2hpY2ggY3JlYXRlIHRoZSBt
b2RlbS4uLiBJIHdvdWxkbiYjMzk7dCBiZSB0aGUgY2FzZS4uLjxicj4KPGJyPgpTbywgdHJ5IHRv
IGRpc2FibGUgZGV0ZWN0aW9uIGluIHVkZXYuIEFuZCBjaGVjayB5b3UgaGF2ZSB0aGlzIGRldmlj
ZSBsaW5lIGluIGxzdXNiIDo8YnI+Cjxicj4KIyBsc3VzYjxicj4KWy4uLl08YnI+CkJ1cyAwMDIg
RGV2aWNlIDA0MTogSUQgMDVjNjo5MDAwPGJyPgo8YnI+Ck1heWJlIHlvdXIgZGV2aWNlIGhhcyBn
b3QgYSBkaWZmZXJlbnQgSUQgPzxicj4KPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48
ZGl2PjxkaXY+U0lNOTAwIGlzIHByZXNlbnRlZCBpbiBzeXN0ZW0gYXMgc2VyaWFsIGRldmljZSwg
c28gd2UgaGF2ZSBubyBJRC4gV2UgdXNlIHVkZXYgcnVsZXMgZm9yIGRldGVjdGluZyBtb2RlbS48
L2Rpdj48ZGl2PkFsbCB3aGF0IEkgYWNoaWV2ZWQgLSBzaW1jb20gcGx1Z2luIGFkZGVkIHRvIHBs
dWdpbnMgbGlzdCBhbmQgbG9hZGVkIHdpdGggU0lNOTAwIChuZWVkIHBhdGNoaW5nIHVkZXYuYyBp
biBteSBjYXNlKS4gQnV0IG1vZGVtLWVuZWJsZSBub3Qgd29yaywgYW5kIEkgY2FuJiMzOTt0IHVu
ZGVyc3RhbmQgd2h5LjwvZGl2PgoKPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PjxkaXY+
b2Zvbm9kWzkwNDZdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9jcmVhdGUoKSBuYW1lOiAobnVs
bCksIHR5cGU6IHNpbWNvbTwvZGl2PjxkaXY+b2Zvbm9kWzkwNDZdOiBzcmMvbW9kZW0uYzpzZXRf
bW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDk1MDM1ZDggcHJvcGVydHkgUGF0aDwvZGl2PjxkaXY+
b2Zvbm9kWzkwNDZdOiBwbHVnaW5zL3VkZXYuYzphZGRfbW9kZW0oKSAvZGV2aWNlcy9wY2kwMDAw
OjAwLzAwMDA6MDA6MWQuMC91c2IyLzItMS8yLTEuNi8yLTEuNjoxLjEvdHR5VVNCMy90dHkvdHR5
VVNCMyAoc2ltY29tKTwvZGl2PgoKPGRpdj5vZm9ub2RbOTA0Nl06IHBsdWdpbnMvdWRldi5jOmFk
ZF9zaW1jb20oKSBtb2RlbSAweDk1MDM1ZDg8L2Rpdj48ZGl2Pm9mb25vZFs5MDQ2XTogc3JjL21v
ZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg5NTAzNWQ4IHByb3BlcnR5IERldmlj
ZTwvZGl2PjxkaXY+b2Zvbm9kWzkwNDZdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9yZWdpc3Rl
cigpIDB4OTUwMzVkODwvZGl2PgoKPGRpdj5vZm9ub2RbOTA0Nl06IHBsdWdpbnMvc2ltY29tLmM6
c2ltY29tX3Byb2JlKCkgMHg5NTAzNWQ4PC9kaXY+PGRpdj5vZm9ub2RbOTA0Nl06IHNyYy9tb2Rl
bS5jOmVtaXRfbW9kZW1fYWRkZWQoKSAweDk1MDM1ZDg8L2Rpdj48ZGl2Pm9mb25vZFs5MDQ2XTog
c3JjL21vZGVtLmM6Y2FsbF9tb2RlbXdhdGNoZXMoKSAweDk1MDM1ZDggYWRkZWQ6MTwvZGl2Pjxk
aXY+b2Zvbm9kWzkwNDZdOiBwbHVnaW5zL2hmcF9hZy5jOm1vZGVtX3dhdGNoKCkgbW9kZW06IDB4
OTUwMzVkOCwgYWRkZWQ6IDE8L2Rpdj4KCjxkaXY+b2Zvbm9kWzkwNDZdOiBwbHVnaW5zL2R1bl9n
dy5jOm1vZGVtX3dhdGNoKCkgbW9kZW06IDB4OTUwMzVkOCwgYWRkZWQ6IDE8L2Rpdj48ZGl2Pm9m
b25vZFs5MDQ2XTogZXhhbXBsZXMvZW11bGF0b3IuYzptb2RlbV93YXRjaCgpIG1vZGVtOiAweDk1
MDM1ZDgsIGFkZGVkOiAxPC9kaXY+PGRpdj5vZm9ub2RbOTA0Nl06IHBsdWdpbnMvc21hcnQtbWVz
c2FnaW5nLmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg5NTAzNWQ4LCBhZGRlZDogMTwvZGl2PgoK
PGRpdj5vZm9ub2RbOTA0Nl06IHBsdWdpbnMvcHVzaC1ub3RpZmljYXRpb24uYzptb2RlbV93YXRj
aCgpIG1vZGVtOiAweDk1MDM1ZDgsIGFkZGVkOiAxPC9kaXY+PGRpdj5vZm9ub2RbOTA0Nl06IHNy
Yy9wcml2YXRlLW5ldHdvcmsuYzpvZm9ub19wcml2YXRlX25ldHdvcmtfZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDgxOTVlMDAsIG5hbWU6IEV4YW1wbGUgUHJpdmF0ZSBOZXR3b3JrIERyaXZl
cjwvZGl2PgoKPGRpdj5vZm9ub2RbOTA0Nl06IHBsdWdpbnMvYmx1ZXRvb3RoLmM6bWFuYWdlcl9w
cm9wZXJ0aWVzX2NiKCmgPC9kaXY+PGRpdj5vZm9ub2RbOTA0Nl06IHBsdWdpbnMvYmx1ZXRvb3Ro
LmM6cGFyc2VfYWRhcHRlcnMoKaA8L2Rpdj48ZGl2Pm9mb25vZFs5MDQ2XTogcGx1Z2lucy9zaW1j
b20uYzpzaW1jb21fZW5hYmxlKCkgMHg5NTAzNWQ4PC9kaXY+PGRpdj5vZm9ub2RbOTA0Nl06IHNy
Yy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OTUwMzVkOCBwcm9wZXJ0eSBN
b2RlbTwvZGl2PgoKPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PGRpdiBzdHlsZT5CdXQgSSB0
aGluaywgdGhhdCB0aGlzIG1heSBiZSBzb2x2ZWQsIGlmIHRoaXMgaXMgcHJvYmxlbSBpbiBkZXZp
Y2Ugc2V0dXAuIE5vdyBJJiMzOTttIGJ1c3ksIGJ1dCBtYXliZSBkZWJ1ZyB0aGlzIGlzc3VlIGlu
IG5lYXIgdGltZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2IHN0eWxlPkJlc3QgcmVnYXJkcyw8
L2Rpdj4KCjxkaXYgc3R5bGU+UmVuYXQgWmFyaXBvdjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pgo=

--===============1394090113699264746==--

