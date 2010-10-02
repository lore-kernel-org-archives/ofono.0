Content-Type: multipart/mixed; boundary="===============2661244320082664694=="
MIME-Version: 1.0
From: Debayan Banerjee <debayanin@gmail.com>
Subject: Re: Huawei EC1260 not working
Date: Sat, 02 Oct 2010 16:28:18 +0530
Message-ID: <AANLkTi=N+z8Qs6scxSewnqF3Z6Kov87RKTp1XL0LDTXo@mail.gmail.com>
In-Reply-To: <AANLkTim=Kgq_m2MXNhH3TN=J1o_FZQHEbJ0SivjVd6xD@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2661244320082664694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/10/2 Debayan Banerjee <debayanin@gmail.com>:
> On 2 October 2010 12:42, Debayan Banerjee <debayanin@gmail.com> wrote:
>>>
>>> I built 0.61, which is the latest stable release. Still no luck :(
>>
>> i can see a new interface for the modem in ofono in d-feet dbus
>> debugger but connman still does not show this device.


Here is ofono output when I ran test/enable-modem. They have AT commands:

[root(a)ws190 nivio]# OFONO_AT_DEBUG=3D1 /usr/local/sbin/ofonod -n -d
ofonod[849]: oFono version 0.31
ofonod[849]: src/plugin.c:__ofono_plugin_init()
ofonod[849]: plugins/smart-messaging.c:smart_messaging_init()
ofonod[849]: src/modem.c:ofono_modem_driver_register() driver:
0x80f1aa0, name: ste
ofonod[849]: src/modem.c:ofono_modem_driver_register() driver:
0x80f1a40, name: ifx
ofonod[849]: src/modem.c:ofono_modem_driver_register() driver:
0x80f19e0, name: palmpre
ofonod[849]: src/modem.c:ofono_modem_driver_register() driver:
0x80f1900, name: hfp
ofonod[849]: src/modem.c:ofono_modem_driver_register() driver:
0x80f18a0, name: nokia
ofonod[849]: src/modem.c:ofono_modem_driver_register() driver:
0x80f1840, name: novatel
ofonod[849]: src/modem.c:ofono_modem_driver_register() driver:
0x80f17e0, name: huawei
ofonod[849]: src/modem.c:ofono_modem_driver_register() driver:
0x80f1780, name: zte
ofonod[849]: src/modem.c:ofono_modem_driver_register() driver:
0x80f1720, name: hso
ofonod[849]: src/modem.c:ofono_modem_driver_register() driver:
0x80f16c0, name: mbm
ofonod[849]: src/modem.c:ofono_modem_driver_register() driver:
0x80f1660, name: calypso
ofonod[849]: src/modem.c:ofono_modem_driver_register() driver:
0x80f1600, name: wavecom
ofonod[849]: src/modem.c:ofono_modem_driver_register() driver:
0x80f15a0, name: g1
ofonod[849]: src/modem.c:ofono_modem_driver_register() driver:
0x80f1540, name: atgen
ofonod[849]: src/modem.c:ofono_modem_driver_register() driver:
0x80f14e0, name: phonesim
ofonod[849]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x80f1420, name: stemodem
ofonod[849]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x80f1484, name: stemodem
ofonod[849]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x80f1468, name: stemodem
ofonod[849]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x80f1360, name: ifxmodem
ofonod[849]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x80f13b0, name: ifxmodem
ofonod[849]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x80f13c4, name: ifxmodem
ofonod[849]: src/stk.c:ofono_stk_driver_register() driver: 0x80f13e0,
name: ifxmodem
ofonod[849]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x80f1310, name: hsomodem
ofonod[849]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x80f132c, name: hsomodem
ofonod[849]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x80f12b8, name: mbmmodem
ofonod[849]: src/stk.c:ofono_stk_driver_register() driver: 0x80f12dc,
name: mbmmodem
ofonod[849]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x80f11e0, name: hfpmodem
ofonod[849]: src/network.c:ofono_netreg_driver_register() driver:
0x80f1240, name: hfpmodem
ofonod[849]: src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x80f1278, name: hfpmodem
ofonod[849]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x80f1160, name: calypsomodem
ofonod[849]: src/stk.c:ofono_stk_driver_register() driver: 0x80f11a8,
name: calypsomodem
ofonod[849]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x80f10c0, name: huaweimodem
ofonod[849]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x80f1108, name: huaweimodem
ofonod[849]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x80f111c, name: huaweimodem
ofonod[849]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x80f1080, name: nwmodem
ofonod[849]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x80f0f40, name: atmodem
ofonod[849]: src/modem.c:ofono_devinfo_driver_register() driver:
0x80f0fec, name: atmodem
ofonod[849]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x80f0f98, name: atmodem
ofonod[849]: src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x80f0d80, name: atmodem
ofonod[849]: src/call-meter.c:ofono_call_meter_driver_register()
driver: 0x80f0dc0, name: atmodem
ofonod[849]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x80f0ca0, name: atmodem
ofonod[849]: src/phonebook.c:ofono_phonebook_driver_register() driver:
0x80f0fb8, name: atmodem
ofonod[849]: src/ssn.c:ofono_ssn_driver_register() driver: 0x80f0fe0,
name: atmodem
ofonod[849]: src/ussd.c:ofono_ussd_driver_register() driver:
0x80f0f00, name: atmodem
ofonod[849]: src/sms.c:ofono_sms_driver_register() driver: 0x80f0d00,
name: atmodem
ofonod[849]: src/sim.c:ofono_sim_driver_register() driver: 0x80f0e80,
name: atmodem
ofonod[849]: src/stk.c:ofono_stk_driver_register() driver: 0x80f0edc,
name: atmodem
ofonod[849]: src/network.c:ofono_netreg_driver_register() driver:
0x80f0e20, name: atmodem
ofonod[849]: src/cbs.c:ofono_cbs_driver_register() driver: 0x80f0d60,
name: atmodem
ofonod[849]: src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x80f1008, name: atmodem
ofonod[849]: src/gprs.c:ofono_gprs_driver_register() driver:
0x80f1030, name: atmodem
ofonod[849]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x80f1054, name: atmodem
ofonod[849]: src/modem.c:ofono_modem_driver_register() driver:
0x80f0aa0, name: n900
ofonod[849]: src/modem.c:ofono_modem_driver_register() driver:
0x80f0a40, name: isigen
ofonod[849]: src/modem.c:ofono_devinfo_driver_register() driver:
0x80f07ac, name: isimodem
ofonod[849]: src/phonebook.c:ofono_phonebook_driver_register() driver:
0x80f079c, name: isimodem
ofonod[849]: src/network.c:ofono_netreg_driver_register() driver:
0x80f07e0, name: isimodem
ofonod[849]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x80f0820, name: isimodem
ofonod[849]: src/sms.c:ofono_sms_driver_register() driver: 0x80f0880,
name: isimodem
ofonod[849]: src/cbs.c:ofono_cbs_driver_register() driver: 0x80f08a0,
name: isimodem
ofonod[849]: src/sim.c:ofono_sim_driver_register() driver: 0x80f08c0,
name: isimodem
ofonod[849]: src/ssn.c:ofono_ssn_driver_register() driver: 0x80f0904,
name: isimodem
ofonod[849]: src/ussd.c:ofono_ussd_driver_register() driver:
0x80f0910, name: isimodem
ofonod[849]: src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x80f0940, name: isimodem
ofonod[849]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x80f0960, name: isimodem
ofonod[849]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x80f0988, name: isimodem
ofonod[849]: src/call-meter.c:ofono_call_meter_driver_register()
driver: 0x80f09a0, name: isimodem
ofonod[849]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x80f09c8, name: isimodem
ofonod[849]: src/gprs.c:ofono_gprs_driver_register() driver:
0x80f09dc, name: isimodem
ofonod[849]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x80f09f0, name: isimodem
ofonod[849]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x80f0a04, name: isimodem
ofonod[849]: src/modem.c:ofono_modem_create() name: (null), type: huawei
ofonod[849]: src/modem.c:set_modem_property() modem 0x8ce4180 property Path
ofonod[849]: src/modem.c:set_modem_property() modem 0x8ce4180 property
Registered
ofonod[849]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0/ttyUSB0/tty/ttyUSB0
(huawei)
ofonod[849]: plugins/udev.c:add_huawei() modem 0x8ce4180
ofonod[849]: src/modem.c:get_modem_property() modem 0x8ce4180 property
ModemRegistered
ofonod[849]: src/modem.c:get_modem_property() modem 0x8ce4180 property
PcuiRegistered
ofonod[849]: src/modem.c:set_modem_property() modem 0x8ce4180 property Modem
ofonod[849]: src/modem.c:set_modem_property() modem 0x8ce4180 property
ModemRegistered
ofonod[849]: src/modem.c:get_modem_property() modem 0x8ce4180 property Path
ofonod[849]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.1/ttyUSB1/tty/ttyUSB1
(huawei)
ofonod[849]: plugins/udev.c:add_huawei() modem 0x8ce4180
ofonod[849]: src/modem.c:get_modem_property() modem 0x8ce4180 property
ModemRegistered
ofonod[849]: src/modem.c:get_modem_property() modem 0x8ce4180 property
PcuiRegistered
ofonod[849]: src/modem.c:get_modem_property() modem 0x8ce4180 property Path
ofonod[849]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.2/ttyUSB2/tty/ttyUSB2
(huawei)
ofonod[849]: plugins/udev.c:add_huawei() modem 0x8ce4180
ofonod[849]: src/modem.c:get_modem_property() modem 0x8ce4180 property
ModemRegistered
ofonod[849]: src/modem.c:get_modem_property() modem 0x8ce4180 property
PcuiRegistered
ofonod[849]: src/modem.c:set_modem_property() modem 0x8ce4180 property Pcui
ofonod[849]: src/modem.c:set_modem_property() modem 0x8ce4180 property
PcuiRegistered
ofonod[849]: plugins/huawei.c:huawei_probe() 0x8ce4180
ofonod[849]: plugins/smart-messaging.c:modem_watch() modem: 0x8ce4180, adde=
d: 1
ofonod[849]: plugins/bluetooth.c:manager_properties_cb()
ofonod[849]: plugins/bluetooth.c:parse_adapters()
ofonod[849]: plugins/huawei.c:huawei_enable() 0x8ce4180
ofonod[849]: src/modem.c:get_modem_property() modem 0x8ce4180 property Modem
ofonod[849]: plugins/huawei.c:open_device() Modem /dev/ttyUSB0
ofonod[849]: src/modem.c:get_modem_property() modem 0x8ce4180 property Pcui
ofonod[849]: plugins/huawei.c:open_device() Pcui /dev/ttyUSB2
ofonod[849]: src/modem.c:get_modem_property() modem 0x8ce4180 property HasV=
oice
ofonod[849]: plugins/huawei.c:query_sim_state()
ofonod[849]: PCUI: > ATE0\r
ofonod[849]: PCUI: < \r\nOK\r\n
ofonod[849]: PCUI: > AT+CFUN=3D1\r
ofonod[849]: PCUI: < \r\nOK\r\n
ofonod[849]: plugins/huawei.c:cfun_enable()
ofonod[849]: PCUI: > AT^SYSINFO\r
ofonod[849]: PCUI: < \r\n^SYSINFO:2,255,0,4,240\r\n\r\nOK\r\n
ofonod[849]: plugins/huawei.c:notify_sim_state() 240
ofonod[849]: PCUI: > AT^U2DIAG?\r
ofonod[849]: PCUI: < \r\nCOMMAND NOT SUPPORT\r\n
ofonod[849]: PCUI: > AT^GETPORTMODE\r
ofonod[849]: PCUI: < \r\nCOMMAND NOT SUPPORT\r\n
ofonod[849]: PCUI: > AT^USSDMODE=3D?\r
ofonod[849]: PCUI: < \r\nCOMMAND NOT SUPPORT\r\n
ofonod[849]: PCUI: > AT^CVOICE=3D?\r
ofonod[849]: PCUI: < \r\n^CVOICE:(0)\r\n\r\nOK\r\n
ofonod[849]: PCUI: > AT^CVOICE?\r
ofonod[849]: PCUI: < \r\n^CVOICE:0,8000,16,20\r\n\r\nOK\r\n
ofonod[849]: Voice channel: 8000 Hz, 16 bits, 20ms period
ofonod[849]: PCUI: > AT^DDSETEX=3D?\r
ofonod[849]: PCUI: < \r\n^DDSETEX:(2)\r\n\r\nOK\r\n
ofonod[849]: src/modem.c:set_powered_timeout() modem: 0x8ce4180





Here is the enable-modem output:

[nivio@ws190 test]$ ./enable-modem
Connecting modem /huawei0...
Traceback (most recent call last):
  File "./enable-modem", line 20, in <module>
    modem.SetProperty("Powered", dbus.Boolean(1))
  File "/usr/lib/python2.6/site-packages/dbus/proxies.py", line 68, in __ca=
ll__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.6/site-packages/dbus/proxies.py", line 140, in __c=
all__
    **keywords)
  File "/usr/lib/python2.6/site-packages/dbus/connection.py", line
630, in call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.ofono.Error.Timedout: Operation
failure due to timeout




-- =

Debayan Banerjee
Software Engineer

--===============2661244320082664694==--

