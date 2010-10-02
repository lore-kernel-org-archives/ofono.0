Content-Type: multipart/mixed; boundary="===============1349167678866300961=="
MIME-Version: 1.0
From: Debayan Banerjee <debayanin@gmail.com>
Subject: Re: Huawei EC1260 not working
Date: Sat, 02 Oct 2010 16:19:04 +0530
Message-ID: <AANLkTim=Kgq_m2MXNhH3TN=J1o_FZQHEbJ0SivjVd6xD@mail.gmail.com>
In-Reply-To: <AANLkTikPJo-oWhNuYssyViRVcbySf3UKv_B9+R7bYf=t@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1349167678866300961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2 October 2010 12:42, Debayan Banerjee <debayanin@gmail.com> wrote:
>>
>> I built 0.61, which is the latest stable release. Still no luck :(
>
> i can see a new interface for the modem in ofono in d-feet dbus
> debugger but connman still does not show this device.


[root(a)ws190 nivio]# OFONO_AT_DEBUG=3D1 /usr/local/sbin/ofonod -n -d
ofonod[3662]: oFono version 0.31
ofonod[3662]: src/plugin.c:__ofono_plugin_init()
ofonod[3662]: plugins/smart-messaging.c:smart_messaging_init()
ofonod[3662]: src/modem.c:ofono_modem_driver_register() driver:
0x80f1aa0, name: ste
ofonod[3662]: src/modem.c:ofono_modem_driver_register() driver:
0x80f1a40, name: ifx
ofonod[3662]: src/modem.c:ofono_modem_driver_register() driver:
0x80f19e0, name: palmpre
ofonod[3662]: src/modem.c:ofono_modem_driver_register() driver:
0x80f1900, name: hfp
ofonod[3662]: src/modem.c:ofono_modem_driver_register() driver:
0x80f18a0, name: nokia
ofonod[3662]: src/modem.c:ofono_modem_driver_register() driver:
0x80f1840, name: novatel
ofonod[3662]: src/modem.c:ofono_modem_driver_register() driver:
0x80f17e0, name: huawei
ofonod[3662]: src/modem.c:ofono_modem_driver_register() driver:
0x80f1780, name: zte
ofonod[3662]: src/modem.c:ofono_modem_driver_register() driver:
0x80f1720, name: hso
ofonod[3662]: src/modem.c:ofono_modem_driver_register() driver:
0x80f16c0, name: mbm
ofonod[3662]: src/modem.c:ofono_modem_driver_register() driver:
0x80f1660, name: calypso
ofonod[3662]: src/modem.c:ofono_modem_driver_register() driver:
0x80f1600, name: wavecom
ofonod[3662]: src/modem.c:ofono_modem_driver_register() driver:
0x80f15a0, name: g1
ofonod[3662]: src/modem.c:ofono_modem_driver_register() driver:
0x80f1540, name: atgen
ofonod[3662]: src/modem.c:ofono_modem_driver_register() driver:
0x80f14e0, name: phonesim
ofonod[3662]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x80f1420, name: stemodem
ofonod[3662]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x80f1484, name: stemodem
ofonod[3662]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x80f1468, name: stemodem
ofonod[3662]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x80f1360, name: ifxmodem
ofonod[3662]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x80f13b0, name: ifxmodem
ofonod[3662]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x80f13c4, name: ifxmodem
ofonod[3662]: src/stk.c:ofono_stk_driver_register() driver: 0x80f13e0,
name: ifxmodem
ofonod[3662]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x80f1310, name: hsomodem
ofonod[3662]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x80f132c, name: hsomodem
ofonod[3662]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x80f12b8, name: mbmmodem
ofonod[3662]: src/stk.c:ofono_stk_driver_register() driver: 0x80f12dc,
name: mbmmodem
ofonod[3662]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x80f11e0, name: hfpmodem
ofonod[3662]: src/network.c:ofono_netreg_driver_register() driver:
0x80f1240, name: hfpmodem
ofonod[3662]: src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x80f1278, name: hfpmodem
ofonod[3662]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x80f1160, name: calypsomodem
ofonod[3662]: src/stk.c:ofono_stk_driver_register() driver: 0x80f11a8,
name: calypsomodem
ofonod[3662]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x80f10c0, name: huaweimodem
ofonod[3662]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x80f1108, name: huaweimodem
ofonod[3662]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x80f111c, name: huaweimodem
ofonod[3662]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x80f1080, name: nwmodem
ofonod[3662]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x80f0f40, name: atmodem
ofonod[3662]: src/modem.c:ofono_devinfo_driver_register() driver:
0x80f0fec, name: atmodem
ofonod[3662]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x80f0f98, name: atmodem
ofonod[3662]: src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x80f0d80, name: atmodem
ofonod[3662]: src/call-meter.c:ofono_call_meter_driver_register()
driver: 0x80f0dc0, name: atmodem
ofonod[3662]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x80f0ca0, name: atmodem
ofonod[3662]: src/phonebook.c:ofono_phonebook_driver_register()
driver: 0x80f0fb8, name: atmodem
ofonod[3662]: src/ssn.c:ofono_ssn_driver_register() driver: 0x80f0fe0,
name: atmodem
ofonod[3662]: src/ussd.c:ofono_ussd_driver_register() driver:
0x80f0f00, name: atmodem
ofonod[3662]: src/sms.c:ofono_sms_driver_register() driver: 0x80f0d00,
name: atmodem
ofonod[3662]: src/sim.c:ofono_sim_driver_register() driver: 0x80f0e80,
name: atmodem
ofonod[3662]: src/stk.c:ofono_stk_driver_register() driver: 0x80f0edc,
name: atmodem
ofonod[3662]: src/network.c:ofono_netreg_driver_register() driver:
0x80f0e20, name: atmodem
ofonod[3662]: src/cbs.c:ofono_cbs_driver_register() driver: 0x80f0d60,
name: atmodem
ofonod[3662]: src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x80f1008, name: atmodem
ofonod[3662]: src/gprs.c:ofono_gprs_driver_register() driver:
0x80f1030, name: atmodem
ofonod[3662]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x80f1054, name: atmodem
ofonod[3662]: src/modem.c:ofono_modem_driver_register() driver:
0x80f0aa0, name: n900
ofonod[3662]: src/modem.c:ofono_modem_driver_register() driver:
0x80f0a40, name: isigen
ofonod[3662]: src/modem.c:ofono_devinfo_driver_register() driver:
0x80f07ac, name: isimodem
ofonod[3662]: src/phonebook.c:ofono_phonebook_driver_register()
driver: 0x80f079c, name: isimodem
ofonod[3662]: src/network.c:ofono_netreg_driver_register() driver:
0x80f07e0, name: isimodem
ofonod[3662]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x80f0820, name: isimodem
ofonod[3662]: src/sms.c:ofono_sms_driver_register() driver: 0x80f0880,
name: isimodem
ofonod[3662]: src/cbs.c:ofono_cbs_driver_register() driver: 0x80f08a0,
name: isimodem
ofonod[3662]: src/sim.c:ofono_sim_driver_register() driver: 0x80f08c0,
name: isimodem
ofonod[3662]: src/ssn.c:ofono_ssn_driver_register() driver: 0x80f0904,
name: isimodem
ofonod[3662]: src/ussd.c:ofono_ussd_driver_register() driver:
0x80f0910, name: isimodem
ofonod[3662]: src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x80f0940, name: isimodem
ofonod[3662]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x80f0960, name: isimodem
ofonod[3662]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x80f0988, name: isimodem
ofonod[3662]: src/call-meter.c:ofono_call_meter_driver_register()
driver: 0x80f09a0, name: isimodem
ofonod[3662]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x80f09c8, name: isimodem
ofonod[3662]: src/gprs.c:ofono_gprs_driver_register() driver:
0x80f09dc, name: isimodem
ofonod[3662]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x80f09f0, name: isimodem
ofonod[3662]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x80f0a04, name: isimodem
ofonod[3662]: src/modem.c:ofono_modem_create() name: (null), type: huawei
ofonod[3662]: src/modem.c:set_modem_property() modem 0x907b180 property Path
ofonod[3662]: src/modem.c:set_modem_property() modem 0x907b180
property Registered
ofonod[3662]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0/ttyUSB0/tty/ttyUSB0
(huawei)
ofonod[3662]: plugins/udev.c:add_huawei() modem 0x907b180
ofonod[3662]: src/modem.c:get_modem_property() modem 0x907b180
property ModemRegistered
ofonod[3662]: src/modem.c:get_modem_property() modem 0x907b180
property PcuiRegistered
ofonod[3662]: src/modem.c:set_modem_property() modem 0x907b180 property Mod=
em
ofonod[3662]: src/modem.c:set_modem_property() modem 0x907b180
property ModemRegistered
ofonod[3662]: src/modem.c:get_modem_property() modem 0x907b180 property Path
ofonod[3662]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.1/ttyUSB1/tty/ttyUSB1
(huawei)
ofonod[3662]: plugins/udev.c:add_huawei() modem 0x907b180
ofonod[3662]: src/modem.c:get_modem_property() modem 0x907b180
property ModemRegistered
ofonod[3662]: src/modem.c:get_modem_property() modem 0x907b180
property PcuiRegistered
ofonod[3662]: src/modem.c:get_modem_property() modem 0x907b180 property Path
ofonod[3662]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.2/ttyUSB2/tty/ttyUSB2
(huawei)
ofonod[3662]: plugins/udev.c:add_huawei() modem 0x907b180
ofonod[3662]: src/modem.c:get_modem_property() modem 0x907b180
property ModemRegistered
ofonod[3662]: src/modem.c:get_modem_property() modem 0x907b180
property PcuiRegistered
ofonod[3662]: src/modem.c:set_modem_property() modem 0x907b180 property Pcui
ofonod[3662]: src/modem.c:set_modem_property() modem 0x907b180
property PcuiRegistered
ofonod[3662]: plugins/huawei.c:huawei_probe() 0x907b180
ofonod[3662]: plugins/smart-messaging.c:modem_watch() modem: 0x907b180, add=
ed: 1
ofonod[3662]: plugins/bluetooth.c:manager_properties_cb()
ofonod[3662]: plugins/bluetooth.c:parse_adapters()



[root(a)ws190 nivio]# lsusb
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 002 Device 011: ID 12d1:140b Huawei Technologies Co., Ltd.
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 002: ID 152d:0310 JMicron Technology Corp. / JMicron
USA Technology Corp.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub








-- =

Debayan Banerjee
Software Engineer

--===============1349167678866300961==--

