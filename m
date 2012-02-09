Content-Type: multipart/mixed; boundary="===============2687741665336064474=="
MIME-Version: 1.0
From: Robyn Minkler <rminkler@gmail.com>
Subject: Re: dbus error while trying to enable hfp connection with smartphone
Date: Thu, 09 Feb 2012 15:25:52 -0800
Message-ID: <1328829952.14709.6.camel@Ostrea-Edulis.lan>
In-Reply-To: <4F3429D5.2050003@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2687741665336064474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

ofonod is throwing this error when I run enable-modem:

ofonod[17676]: plugins/hfp_hf.c:hfp_connect_reply() Connect reply:
Method "Connect" with signature "" on interface
"org.bluez.HandsfreeGateway" doesn't exist

Is this helpful?

Here's the rest of the ofonod output:

ofonod[17829]: oFono version 0.44
ofonod[17829]: src/plugin.c:__ofono_plugin_init() =

ofonod[17829]: plugins/push-notification.c:push_notification_init() =

ofonod[17829]: plugins/smart-messaging.c:smart_messaging_init() =

ofonod[17829]: plugins/dun_gw.c:dun_gw_init() =

ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x700180, name: hfp
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x7000a0, name: linktop
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x700000, name: nokiacdma
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6fff60, name: nokia
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6ffec0, name: tc65
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6ffda0, name: ste
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6ffd00, name: ifx
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6ffc60, name: palmpre
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6ffbc0, name: novatel
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6ffb20, name: sierra
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6ffa60, name: huawei
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6ff9c0, name: zte
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6ff900, name: hso
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6ff840, name: mbm
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6ff7a0, name: calypso
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6ff700, name: wavecom
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6ff660, name: gobi
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6ff5c0, name: g1
ofonod[17829]:
src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register() driver:
0x6ff500, name: cdmamodem
ofonod[17829]: src/modem.c:ofono_devinfo_driver_register() driver:
0x6ff540, name: cdmamodem
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6ff460, name: phonesim
ofonod[17829]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x6ff420, name: phonesim
ofonod[17829]: src/ctm.c:ofono_ctm_driver_register() driver: 0x6ff3e0,
name: phonesim
ofonod[17829]: plugins/phonesim.c:parse_config()
filename /etc/ofono/phonesim.conf
ofonod[17829]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x6ff220, name: stemodem
ofonod[17829]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x6ff320, name: stemodem
ofonod[17829]:
src/radio-settings.c:ofono_radio_settings_driver_register() driver:
0x6ff2c0, name: stemodem
ofonod[17829]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x6fefc0, name: ifxmodem
ofonod[17829]:
src/audio-settings.c:ofono_audio_settings_driver_register() driver:
0x6ff050, name: ifxmodem
ofonod[17829]:
src/radio-settings.c:ofono_radio_settings_driver_register() driver:
0x6ff080, name: ifxmodem
ofonod[17829]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x6ff0e0, name: ifxmodem
ofonod[17829]: src/stk.c:ofono_stk_driver_register() driver: 0x6ff140,
name: ifxmodem
ofonod[17829]: src/ctm.c:ofono_ctm_driver_register() driver: 0x6ff1a0,
name: ifxmodem
ofonod[17829]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x6feee0, name: hsomodem
ofonod[17829]:
src/radio-settings.c:ofono_radio_settings_driver_register() driver:
0x6fef20, name: hsomodem
ofonod[17829]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x6fedc0, name: mbmmodem
ofonod[17829]: src/stk.c:ofono_stk_driver_register() driver: 0x6fee20,
name: mbmmodem
ofonod[17829]:
src/location-reporting.c:ofono_location_reporting_driver_register()
driver: 0x6fee60, name: mbmmodem
ofonod[17829]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x6fec00, name: hfpmodem
ofonod[17829]: src/network.c:ofono_netreg_driver_register() driver:
0x6feca0, name: hfpmodem
ofonod[17829]: src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x6fed20, name: hfpmodem
ofonod[17829]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x6feae0, name: calypsomodem
ofonod[17829]: src/stk.c:ofono_stk_driver_register() driver: 0x6feb80,
name: calypsomodem
ofonod[17829]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x6fe940, name: huaweimodem
ofonod[17829]:
src/audio-settings.c:ofono_audio_settings_driver_register() driver:
0x6fe9d0, name: huaweimodem
ofonod[17829]:
src/radio-settings.c:ofono_radio_settings_driver_register() driver:
0x6fea40, name: huaweimodem
ofonod[17829]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x6fea00, name: huaweimodem
ofonod[17829]:
src/radio-settings.c:ofono_radio_settings_driver_register() driver:
0x6fe8a0, name: nwmodem
ofonod[17829]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x6fe560, name: atmodem
ofonod[17829]: src/modem.c:ofono_devinfo_driver_register() driver:
0x6fe6e0, name: atmodem
ofonod[17829]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x6fe620, name: atmodem
ofonod[17829]:
src/call-forwarding.c:ofono_call_forwarding_driver_register() driver:
0x6fe1c0, name: atmodem
ofonod[17829]: src/call-meter.c:ofono_call_meter_driver_register()
driver: 0x6fe220, name: atmodem
ofonod[17829]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x6fdfe0, name: atmodem
ofonod[17829]: src/phonebook.c:ofono_phonebook_driver_register() driver:
0x6fe660, name: atmodem
ofonod[17829]: src/ssn.c:ofono_ssn_driver_register() driver: 0x6fe6b0,
name: atmodem
ofonod[17829]: src/ussd.c:ofono_ussd_driver_register() driver: 0x6fe500,
name: atmodem
ofonod[17829]: src/sms.c:ofono_sms_driver_register() driver: 0x6fe0c0,
name: atmodem
ofonod[17829]: src/sim.c:ofono_sim_driver_register() driver: 0x6fe380,
name: atmodem
ofonod[17829]: src/stk.c:ofono_stk_driver_register() driver: 0x6fe4a0,
name: atmodem
ofonod[17829]: src/network.c:ofono_netreg_driver_register() driver:
0x6fe2c0, name: atmodem
ofonod[17829]: src/cbs.c:ofono_cbs_driver_register() driver: 0x6fe180,
name: atmodem
ofonod[17829]: src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x6fe720, name: atmodem
ofonod[17829]: src/gprs.c:ofono_gprs_driver_register() driver: 0x6fe780,
name: atmodem
ofonod[17829]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x6fe7e0, name: atmodem
ofonod[17829]: src/sim-auth.c:ofono_sim_auth_driver_register() driver:
0x6fe820, name: atmodem
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6fdd60, name: u8500
ofonod[17829]: src/modem.c:ofono_devinfo_driver_register() driver:
0x6fdd20, name: u8500
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6fdc80, name: n900
ofonod[17829]: src/modem.c:ofono_modem_driver_register() driver:
0x6fdbe0, name: isiusb
ofonod[17829]: src/modem.c:ofono_devinfo_driver_register() driver:
0x6fd640, name: isimodem
ofonod[17829]: src/phonebook.c:ofono_phonebook_driver_register() driver:
0x6fd620, name: isimodem
ofonod[17829]: src/network.c:ofono_netreg_driver_register() driver:
0x6fd680, name: isimodem
ofonod[17829]: src/network.c:ofono_netreg_driver_register() driver:
0x6fd6e0, name: wgmodem2.5
ofonod[17829]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x6fd740, name: isimodem
ofonod[17829]: src/sms.c:ofono_sms_driver_register() driver: 0x6fd7e0,
name: isimodem
ofonod[17829]: src/cbs.c:ofono_cbs_driver_register() driver: 0x6fd820,
name: isimodem
ofonod[17829]: src/sim.c:ofono_sim_driver_register() driver: 0x6fd860,
name: isimodem
ofonod[17829]: src/ssn.c:ofono_ssn_driver_register() driver: 0x6fd8f0,
name: isimodem
ofonod[17829]: src/ussd.c:ofono_ussd_driver_register() driver: 0x6fd920,
name: isimodem
ofonod[17829]:
src/call-forwarding.c:ofono_call_forwarding_driver_register() driver:
0x6fd960, name: isimodem
ofonod[17829]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x6fd9a0, name: isimodem
ofonod[17829]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x6fda00, name: isimodem
ofonod[17829]: src/call-meter.c:ofono_call_meter_driver_register()
driver: 0x6fda40, name: isimodem
ofonod[17829]:
src/radio-settings.c:ofono_radio_settings_driver_register() driver:
0x6fdaa0, name: isimodem
ofonod[17829]: src/gprs.c:ofono_gprs_driver_register() driver: 0x6fdb00,
name: isimodem
ofonod[17829]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x6fdb40, name: isimodem
ofonod[17829]:
src/audio-settings.c:ofono_audio_settings_driver_register() driver:
0x6fdb70, name: isimodem
ofonod[17829]: plugins/bluetooth.c:manager_properties_cb() =

ofonod[17829]: plugins/bluetooth.c:parse_adapters() =

ofonod[17829]: plugins/bluetooth.c:parse_adapters() Calling
GetProperties on /org/bluez/17603/hci0
ofonod[17829]: plugins/bluetooth.c:adapter_properties_cb() =

ofonod[17829]: plugins/bluetooth.c:parse_devices() =

ofonod[17829]: plugins/bluetooth.c:adapter_properties_cb() Adapter
Address: 88:9F:FA:EA:6A:1B, Path: /org/bluez/17603/hci0
ofonod[17829]: plugins/bluetooth.c:device_properties_cb() =

ofonod[17829]: Using
device: /org/bluez/17603/hci0/dev_78_47_1D_BB_09_8C, devaddr:
78:47:1D:BB:09:8C, adapter: 88:9F:FA:EA:6A:1B
ofonod[17829]: src/modem.c:ofono_modem_create() name:
hfp/889FFAEA6A1B_78471DBB098C, type: hfp
ofonod[17829]: plugins/hfp_hf.c:hfp_register_ofono_handsfree()
Registering oFono Agent to bluetooth daemon
ofonod[17829]: plugins/hfp_ag.c:modem_watch() modem: 0x23a8490, added: 1
ofonod[17829]: plugins/dun_gw.c:modem_watch() modem: 0x23a8490, added: 1
ofonod[17829]: plugins/smart-messaging.c:modem_watch() modem: 0x23a8490,
added: 1
ofonod[17829]: plugins/push-notification.c:modem_watch() modem:
0x23a8490, added: 1
ofonod[17829]: plugins/bluetooth.c:device_properties_cb() =

ofonod[17829]: plugins/hfp_hf.c:hfp_enable() 0x23a8490
ofonod[17829]: plugins/hfp_hf.c:hfp_connect_reply() Connect reply:
Method "Connect" with signature "" on interface
"org.bluez.HandsfreeGateway" doesn't exist

Thanks, =

Robyn


On Thu, 2012-02-09 at 14:17 -0600, Denis Kenzior wrote:
> Hi Robyn,
> =

> On 02/09/2012 01:41 PM, Robyn Minkler wrote:
> > I'm trying to get ofono, telepathy-ring and empathy set up so that I can
> > make and receive calls on my fedora 16 laptop. =

> > =

> > The list-modems script shows my phone, but I get a dbus error when I try
> > to run enable-modems. More information below. =

> > =

> > Does anyone have any suggestions about how I might debug this?
> =

> export OFONO_AT_DEBUG=3D1 and run ofono with -d option
> =

> > =

> > This is with:
> > dbus 1.4.10
> > ofono 1.3
> > =

> > ./list-modems
> > [ /hfp/889FFAEA6A1B_78471DBB098C ]
> >     Name =3D Nexus S
> >     Powered =3D 0
> >     Lockdown =3D 0
> >     Interfaces =3D =

> >     Online =3D 0
> >     Features =3D =

> > =

> > ./enable-modem
> > Connecting modem /hfp/889FFAEA6A1B_78471DBB098C...
> > Traceback (most recent call last):
> >   File "./enable-modem", line 20, in <module>
> >     modem.SetProperty("Powered", dbus.Boolean(1), timeout =3D 120)
> >   File "/usr/lib/python2.7/site-packages/dbus/proxies.py", line 68, in
> > __call__
> >     return self._proxy_method(*args, **keywords)
> >   File "/usr/lib/python2.7/site-packages/dbus/proxies.py", line 140, in
> > __call__
> >     **keywords)
> >   File "/usr/lib/python2.7/site-packages/dbus/connection.py", line 630,
> > in call_blocking
> >     message, timeout)
> > dbus.exceptions.DBusException: org.ofono.Error.Failed: Operation failed
> > =

> =

> Generally two things can go wrong:
> =

> - The bluetooth link could not be established for some reason.  e.g. the
> your adapter is off, the remote device is off, stale pairing setup, etc.
>  Use hcidump utility from bluez to debug this.
> =

> - The Handsfree SLC handshake could not be established.  The AT command
> logs from oFono would help us diagnose that...
> =

> Regards,
> -Denis



--===============2687741665336064474==--

