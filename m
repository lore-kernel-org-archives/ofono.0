Content-Type: multipart/mixed; boundary="===============1631714368459562141=="
MIME-Version: 1.0
From: Tengchou Yang <tyang@masimolabs.com>
Subject: About Ofono Sierra Driver
Date: Sat, 21 Apr 2012 02:42:45 +0000
Message-ID: <260FC4C1070A3E478572AECA705D15CC03EA5C38@troi.masimolabs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1631714368459562141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear All:
I am a new user of ofono library. Here is the problem I got. Hope that you =
guys can help me out.
First of all, I have a modem which is from sierra wireless MC5728V. this is=
 such an AT command base device. =

What I did is add the sierra command under /etc/udev/rules.d/ofono.rules
+29 ATTRS{idVendor}=3D=3D"1199", ATTRS{idProduct}=3D=3D"0028", ENV{OFONO_DR=
IVER}=3D"sierra"
And correct the code in vim plugins/udevng.c
+ 224                         if (g_strcmp0(info->number, "00") =3D=3D 0){
+ 225                                 mdm =3D info->devnode;
+ 226                                 net =3D info->devnode;
+ 227                         }

And I run ofonod -nd
please kindly see the command below

---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------
ofonod[19322]: oFono version 1.5
ofonod[19322]: src/plugin.c:__ofono_plugin_init() =

ofonod[19322]: plugins/push-notification.c:push_notification_init() =

ofonod[19322]: plugins/smart-messaging.c:smart_messaging_init() =

ofonod[19322]: src/cdma-provision.c:ofono_cdma_provision_driver_register() =
driver: 0x817a720 name: CDMA provisioning
ofonod[19322]: src/gprs-provision.c:ofono_gprs_provision_driver_register() =
driver: 0x817a6e0 name: Provisioning
ofonod[19322]: plugins/connman.c:connman_init() =

ofonod[19322]: src/private-network.c:ofono_private_network_driver_register(=
) driver: 0x817a6a0, name: ConnMan Private Network
ofonod[19322]: plugins/dun_gw.c:dun_gw_init() =

ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x817a5a0,=
 name: hfp
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x817a540,=
 name: sap
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x817a4c0,=
 name: telit
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x817a420,=
 name: sim900
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x817a3c0,=
 name: samsung
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x817a360,=
 name: speedupcdma
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x817a300,=
 name: speedup
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x817a2a0,=
 name: alcatel
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x817a240,=
 name: icera
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x817a1e0,=
 name: linktop
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x817a180,=
 name: nokiacdma
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x817a120,=
 name: nokia
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x817a0c0,=
 name: tc65
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x817a020,=
 name: ste
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x8179fc0,=
 name: ifx
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x8179f60,=
 name: palmpre
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x8179f00,=
 name: novatel
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x8179ea0,=
 name: sierra
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x8179e20,=
 name: huawei
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x8179dc0,=
 name: zte
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x8179d60,=
 name: hso
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x8179d00,=
 name: mbm
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x8179ca0,=
 name: calypso
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x8179c40,=
 name: wavecom
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x8179be0,=
 name: gobi
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x8179b80,=
 name: g1
ofonod[19322]: src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register() =
driver: 0x8179b00, name: cdmamodem
ofonod[19322]: src/modem.c:ofono_devinfo_driver_register() driver: 0x8179b2=
0, name: cdmamodem
ofonod[19322]: src/cdma-connman.c:ofono_cdma_connman_driver_register() driv=
er: 0x8179b44, name: cdmamodem
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x8179a60,=
 name: phonesim
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x8179aa0,=
 name: localhfp
ofonod[19322]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x81=
79a34, name: phonesim
ofonod[19322]: src/ctm.c:ofono_ctm_driver_register() driver: 0x8179a20, nam=
e: phonesim
ofonod[19322]: plugins/phonesim.c:parse_config() filename /usr/local/etc/of=
ono/phonesim.conf
ofonod[19322]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x=
8179900, name: hfpmodem
ofonod[19322]: src/modem.c:ofono_devinfo_driver_register() driver: 0x81799b=
c, name: hfpmodem
ofonod[19322]: src/network.c:ofono_netreg_driver_register() driver: 0x81799=
60, name: hfpmodem
ofonod[19322]: src/call-volume.c:ofono_call_volume_driver_register() driver=
: 0x8179994, name: hfpmodem
ofonod[19322]: src/handsfree.c:ofono_handsfree_driver_register() driver: 0x=
81799d8, name: hfpmodem
ofonod[19322]: src/network.c:ofono_netreg_driver_register() driver: 0x81798=
80, name: dunmodem
ofonod[19322]: src/gprs.c:ofono_gprs_driver_register() driver: 0x81798ac, n=
ame: dunmodem
ofonod[19322]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x=
81797a0, name: stemodem
ofonod[19322]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x81=
7982c, name: stemodem
ofonod[19322]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x8179800, name: stemodem
ofonod[19322]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x=
8179660, name: ifxmodem
ofonod[19322]: src/audio-settings.c:ofono_audio_settings_driver_register() =
driver: 0x81796b0, name: ifxmodem
ofonod[19322]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x81796e0, name: ifxmodem
ofonod[19322]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x81=
7970c, name: ifxmodem
ofonod[19322]: src/stk.c:ofono_stk_driver_register() driver: 0x8179730, nam=
e: ifxmodem
ofonod[19322]: src/ctm.c:ofono_ctm_driver_register() driver: 0x8179758, nam=
e: ifxmodem
ofonod[19322]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x81=
795e0, name: hsomodem
ofonod[19322]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x8179600, name: hsomodem
ofonod[19322]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x81=
79540, name: mbmmodem
ofonod[19322]: src/stk.c:ofono_stk_driver_register() driver: 0x8179564, nam=
e: mbmmodem
ofonod[19322]: src/location-reporting.c:ofono_location_reporting_driver_reg=
ister() driver: 0x8179584, name: mbmmodem
ofonod[19322]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x=
81794a0, name: calypsomodem
ofonod[19322]: src/stk.c:ofono_stk_driver_register() driver: 0x81794e8, nam=
e: calypsomodem
ofonod[19322]: src/ussd.c:ofono_ussd_driver_register() driver: 0x8179380, n=
ame: huaweimodem
ofonod[19322]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x=
81793a0, name: huaweimodem
ofonod[19322]: src/audio-settings.c:ofono_audio_settings_driver_register() =
driver: 0x81793e8, name: huaweimodem
ofonod[19322]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x8179420, name: huaweimodem
ofonod[19322]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x81=
793fc, name: huaweimodem
ofonod[19322]: src/cdma-netreg.c:ofono_cdma_netreg_driver_register() driver=
: 0x817944c, name: huaweimodem
ofonod[19322]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x8179320, name: ztemodem
ofonod[19322]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x81=
792e0, name: swmodem
ofonod[19322]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x8179280, name: nwmodem
ofonod[19322]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x=
81790e0, name: atmodem
ofonod[19322]: src/modem.c:ofono_devinfo_driver_register() driver: 0x817918=
0, name: atmodem
ofonod[19322]: src/call-barring.c:ofono_call_barring_driver_register() driv=
er: 0x8179138, name: atmodem
ofonod[19322]: src/call-forwarding.c:ofono_call_forwarding_driver_register(=
) driver: 0x8178ea0, name: atmodem
ofonod[19322]: src/call-meter.c:ofono_call_meter_driver_register() driver: =
0x8178ee0, name: atmodem
ofonod[19322]: src/call-settings.c:ofono_call_settings_driver_register() dr=
iver: 0x8178da0, name: atmodem
ofonod[19322]: src/phonebook.c:ofono_phonebook_driver_register() driver: 0x=
8179158, name: atmodem
ofonod[19322]: src/ussd.c:ofono_ussd_driver_register() driver: 0x81790bc, n=
ame: atmodem
ofonod[19322]: src/sms.c:ofono_sms_driver_register() driver: 0x8178e20, nam=
e: atmodem
ofonod[19322]: src/sim.c:ofono_sim_driver_register() driver: 0x8178fa0, nam=
e: atmodem
ofonod[19322]: src/sim.c:ofono_sim_driver_register() driver: 0x8179000, nam=
e: atmodem-noef
ofonod[19322]: src/stk.c:ofono_stk_driver_register() driver: 0x817909c, nam=
e: atmodem
ofonod[19322]: src/network.c:ofono_netreg_driver_register() driver: 0x8178f=
40, name: atmodem
ofonod[19322]: src/cbs.c:ofono_cbs_driver_register() driver: 0x8178e80, nam=
e: atmodem
ofonod[19322]: src/call-volume.c:ofono_call_volume_driver_register() driver=
: 0x81791a4, name: atmodem
ofonod[19322]: src/gprs.c:ofono_gprs_driver_register() driver: 0x81791d4, n=
ame: atmodem
ofonod[19322]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x81=
791f8, name: atmodem
ofonod[19322]: src/sim-auth.c:ofono_sim_auth_driver_register() driver: 0x81=
7920c, name: atmodem
ofonod[19322]: src/gnss.c:ofono_gnss_driver_register() driver: 0x8179224, n=
ame: atmodem
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x8178b80,=
 name: u8500
ofonod[19322]: src/modem.c:ofono_devinfo_driver_register() driver: 0x8178b6=
0, name: u8500
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x8178b00,=
 name: n900
ofonod[19322]: src/modem.c:ofono_modem_driver_register() driver: 0x8178aa0,=
 name: isiusb
ofonod[19322]: src/modem.c:ofono_devinfo_driver_register() driver: 0x817879=
0, name: isimodem
ofonod[19322]: src/phonebook.c:ofono_phonebook_driver_register() driver: 0x=
8178780, name: isimodem
ofonod[19322]: src/network.c:ofono_netreg_driver_register() driver: 0x81787=
c0, name: isimodem
ofonod[19322]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x=
8178800, name: isimodem
ofonod[19322]: src/sms.c:ofono_sms_driver_register() driver: 0x8178860, nam=
e: isimodem
ofonod[19322]: src/cbs.c:ofono_cbs_driver_register() driver: 0x8178880, nam=
e: isimodem
ofonod[19322]: src/sim.c:ofono_sim_driver_register() driver: 0x81788a0, nam=
e: isimodem
ofonod[19322]: src/ussd.c:ofono_ussd_driver_register() driver: 0x81788e8, n=
ame: isimodem
ofonod[19322]: src/call-forwarding.c:ofono_call_forwarding_driver_register(=
) driver: 0x8178900, name: isimodem
ofonod[19322]: src/call-settings.c:ofono_call_settings_driver_register() dr=
iver: 0x8178920, name: isimodem
ofonod[19322]: src/call-barring.c:ofono_call_barring_driver_register() driv=
er: 0x8178950, name: isimodem
ofonod[19322]: src/call-meter.c:ofono_call_meter_driver_register() driver: =
0x8178980, name: isimodem
ofonod[19322]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x81789c0, name: isimodem
ofonod[19322]: src/gprs.c:ofono_gprs_driver_register() driver: 0x81789e4, n=
ame: isimodem
ofonod[19322]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x81=
789f8, name: isimodem
ofonod[19322]: src/audio-settings.c:ofono_audio_settings_driver_register() =
driver: 0x8178a0c, name: isimodem
ofonod[19322]: src/sim.c:ofono_sim_driver_register() driver: 0x8178a20, nam=
e: wgmodem2.5
ofonod[19322]: plugins/udevng.c:udev_start() =

ofonod[19322]: plugins/udevng.c:enumerate_devices() =

ofonod[19322]: plugins/udevng.c:add_device() /sys/devices/pci0000:00/0000:0=
0:1d.0/usb2/2-1/2-1.1/2-1.1:1.0/ttyUSB0/tty/ttyUSB0
ofonod[19322]: plugins/udevng.c:add_device() /dev/ttyUSB0 (sierra) 255/255/=
255 [00] =3D=3D> (null) (null)
ofonod[19322]: plugins/udevng.c:add_device() /sys/devices/pci0000:00/0000:0=
0:1d.0/usb2/2-1/2-1.1/2-1.1:1.0/ttyUSB1/tty/ttyUSB1
ofonod[19322]: plugins/udevng.c:add_device() /dev/ttyUSB1 (sierra) 255/255/=
255 [00] =3D=3D> (null) (null)
ofonod[19322]: plugins/udevng.c:add_device() /sys/devices/pci0000:00/0000:0=
0:1d.0/usb2/2-1/2-1.1/2-1.1:1.0/ttyUSB2/tty/ttyUSB2
ofonod[19322]: plugins/udevng.c:add_device() /dev/ttyUSB2 (sierra) 255/255/=
255 [00] =3D=3D> (null) (null)
ofonod[19322]: plugins/udevng.c:add_device() /sys/devices/pci0000:00/0000:0=
0:1d.0/usb2/2-1/2-1.1/2-1.1:1.0/ttyUSB3/tty/ttyUSB3
ofonod[19322]: plugins/udevng.c:add_device() /dev/ttyUSB3 (sierra) 255/255/=
255 [00] =3D=3D> (null) (null)
ofonod[19322]: plugins/udevng.c:create_modem() /sys/devices/pci0000:00/0000=
:00:1d.0/usb2/2-1/2-1.1
ofonod[19322]: plugins/udevng.c:create_modem() driver=3Dsierra
ofonod[19322]: src/modem.c:ofono_modem_create() name: (null), type: sierra
ofonod[19322]: plugins/udevng.c:setup_sierra() /sys/devices/pci0000:00/0000=
:00:1d.0/usb2/2-1/2-1.1
ofonod[19322]: plugins/udevng.c:setup_sierra() /dev/ttyUSB3 255/255/255 00 =
(null)
ofonod[19322]: plugins/udevng.c:setup_sierra() /dev/ttyUSB2 255/255/255 00 =
(null)
ofonod[19322]: plugins/udevng.c:setup_sierra() /dev/ttyUSB1 255/255/255 00 =
(null)
ofonod[19322]: plugins/udevng.c:setup_sierra() /dev/ttyUSB0 255/255/255 00 =
(null)
ofonod[19322]: plugins/udevng.c:setup_sierra() modem=3D/dev/ttyUSB0 app=3D/=
dev/ttyUSB0 net=3D/dev/ttyUSB0 diag=3D/dev/ttyUSB0
ofonod[19322]: src/modem.c:set_modem_property() modem 0x85cd3e8 property Mo=
dem
ofonod[19322]: src/modem.c:set_modem_property() modem 0x85cd3e8 property App
ofonod[19322]: src/modem.c:set_modem_property() modem 0x85cd3e8 property Di=
ag
ofonod[19322]: src/modem.c:set_modem_property() modem 0x85cd3e8 property Ne=
tworkInterface
ofonod[19322]: src/modem.c:ofono_modem_register() 0x85cd3e8
ofonod[19322]: plugins/sierra.c:sierra_probe() 0x85cd3e8
ofonod[19322]: src/modem.c:emit_modem_added() 0x85cd3e8
ofonod[19322]: src/modem.c:call_modemwatches() 0x85cd3e8 added:1
ofonod[19322]: plugins/hfp_ag.c:modem_watch() modem: 0x85cd3e8, added: 1
ofonod[19322]: plugins/dun_gw.c:modem_watch() modem: 0x85cd3e8, added: 1
ofonod[19322]: plugins/smart-messaging.c:modem_watch() modem: 0x85cd3e8, ad=
ded: 1
ofonod[19322]: plugins/push-notification.c:modem_watch() modem: 0x85cd3e8, =
added: 1
ofonod[19322]: src/modem.c:ofono_modem_create() name: (null), type: sierra
ofonod[19322]: src/modem.c:set_modem_property() modem 0x85cef58 property Pa=
th
ofonod[19322]: src/modem.c:set_modem_property() modem 0x85cef58 property Re=
gistered
ofonod[19322]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.0/=
usb2/2-1/2-1.1/2-1.1:1.0/ttyUSB0/tty/ttyUSB0 (sierra)
ofonod[19322]: src/modem.c:get_modem_property() modem 0x85cef58 property Pa=
th
ofonod[19322]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.0/=
usb2/2-1/2-1.1/2-1.1:1.0/ttyUSB1/tty/ttyUSB1 (sierra)
ofonod[19322]: src/modem.c:get_modem_property() modem 0x85cef58 property Pa=
th
ofonod[19322]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.0/=
usb2/2-1/2-1.1/2-1.1:1.0/ttyUSB2/tty/ttyUSB2 (sierra)
ofonod[19322]: src/modem.c:get_modem_property() modem 0x85cef58 property Pa=
th
ofonod[19322]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.0/=
usb2/2-1/2-1.1/2-1.1:1.0/ttyUSB3/tty/ttyUSB3 (sierra)
ofonod[19322]: plugins/bluetooth.c:manager_properties_cb() =

ofonod[19322]: plugins/bluetooth.c:parse_adapters() =

---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------


And than I open another terminal, run the test program:
./list-modems
it shows no service, as below.
[ /sierra_0 ]
    Features =3D =

    Emergency =3D 0
    Powered =3D 0
    Lockdown =3D 0
    Interfaces =3D =

    Online =3D 0
    Type =3D hardware

I tried to enable the modem, it shows =


Connecting modem /sierra_0...
Traceback (most recent call last):
  File "./test/enable-modem", line 20, in <module>
    modem.SetProperty("Powered", dbus.Boolean(1), timeout =3D 120)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 68, in __ca=
ll__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 143, in __c=
all__
    **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 630, in =
call_blocking
    message, timeout)

and when i making a phone call =


dialnumber XXXXXXX
Traceback (most recent call last):
  File "./test/dial-number", line 41, in <module>
    path =3D vcm.Dial(number, hide_callerid)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 68, in __ca=
ll__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 143, in __c=
all__
    **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 630, in =
call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod: Me=
thod "Dial" with signature "ss" on interface "org.ofono.VoiceCallManager" d=
oesn't exist

But the modem looks fine when I use the putty or minicom to connect to it.
So I can type the command like =


OK                                                                         =
         =

AT+CSQ                                                                     =
         =

20, 99                                                                     =
  =

                                                                           =
  =

OK                                      =

AT+CDVXXXXXXX
OK                                      =

AT+CHV                                  =

OK   =


So the modem have no problem. =

Hope someone can give me some direction.

Sincerely,
Teng-Chou Yang





--===============1631714368459562141==--

