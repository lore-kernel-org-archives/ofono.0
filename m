Content-Type: multipart/mixed; boundary="===============6152751121288388065=="
MIME-Version: 1.0
From: =?unknown-8bit?q?J=C3=B6rg?= Rebenstorf <j.rebenstorf@phytec.de>
Subject: using ofono location service with PLS8-E failed
Date: Thu, 27 Sep 2018 15:57:23 +0200
Message-ID: <9903b312-562f-fb87-34c6-b0b3d27cd138@phytec.de>
In-Reply-To: <6c543f4e-c9a7-2d41-1f6a-aa77efa06657@phytec.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6152751121288388065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


I tried to use the org.ofono.LocationReporting service to get NMEA data.

Because I did not find any example program in the
project to test the gps location feature I wrote the following python
script to use the service:

#!/usr/bin/python
from gi.repository import GLibre
import dbus
import os, sys, fcntl
import glib
bus =3D dbus.SystemBus()
if len(sys.argv) =3D=3D 2:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path =3D sys.argv[1]
else:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 manager =3D dbus.Interface(bus.=
get_object('org.ofono', '/'),
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'org.ofo=
no.Manager')
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 modems =3D manager.GetModems()
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path =3D modems[0][0]
print("Connecting modem %s..." % path)
modem =3D dbus.Interface(bus.get_object('org.ofono', path),
'org.ofono.LocationReporting')
print("Modem %s connected..." % modem)
fd =3D modem.Request()
unix_fd =3D fd.take()
flags =3D fcntl.fcntl(unix_fd, fcntl.F_GETFL)
flags =3D flags & ~os.O_NONBLOCK
fcntl.fcntl(unix_fd, fcntl.F_SETFL, flags)
file =3D os.fdopen(unix_fd)
while 1:
 =C2=A0=C2=A0=C2=A0 ret =3D file.readline()
 =C2=A0=C2=A0=C2=A0 print(ret)

Sadly, my script does not output any data from my PLS8-E modem. Did I do
sth. wrong or might sth. be broken in ofono - is the feature supported
with this modem?

"enable-modem" and my script above were executed and the daemon with
debug flag ...

OFONO_AT_DEBUG=3D1 /usr/sbin/ofonod -n -d | tee -a /tmp/ofonod.log &

... reported the following:

ofonod[346]: oFono version 1.24
ofonod[346]: ../ofono-1.24/src/plugin.c:__ofono_plugin_init()
ofonod[346]:
../ofono-1.24/src/gprs-provision.c:ofono_gprs_provision_driver_register()
driver: 0x146eac name: GPRS context provisioning
ofonod[346]:
../ofono-1.24/plugins/push-notification.c:push_notification_init()
ofonod[346]: ../ofono-1.24/plugins/smart-messaging.c:smart_messaging_init()
ofonod[346]:
../ofono-1.24/src/cdma-provision.c:ofono_cdma_provision_driver_register()
driver: 0x146e80 name: CDMA provisioning
ofonod[346]:
../ofono-1.24/src/gprs-provision.c:ofono_gprs_provision_driver_register()
driver: 0x146e54 name: Provisioning
ofonod[346]: ../ofono-1.24/plugins/upower.c:upower_init() upower init
ofonod[346]:
../ofono-1.24/src/handsfree-audio.c:ofono_handsfree_card_driver_register()
driver: 0x146e00
ofonod[346]: ../ofono-1.24/plugins/dun_gw_bluez5.c:dun_gw_init()
ofonod[346]:
../ofono-1.24/src/handsfree-audio.c:ofono_handsfree_card_driver_register()
driver: 0x146d64
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146d78, name: hfp
ofonod[346]: ../ofono-1.24/plugins/xmm7xxx.c:xmm7xxx_init()
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146d14, name: xmm7xxx
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146ccc, name: ublox
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146c74, name: quectel
ofonod[346]: ../ofono-1.24/plugins/telit.c:telit_init()
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146c24, name: telit
ofonod[346]: ../ofono-1.24/plugins/connman.c:connman_init()
ofonod[346]:
../ofono-1.24/src/private-network.c:ofono_private_network_driver_register()
driver: 0x146bf8, name: ConnMan Private Network
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146bb0, name: sim7100
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146b68, name: sim900
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146b20, name: samsung
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146ad8, name: speedupcdma
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146a88, name: speedup
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146a40, name: alcatel
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x1469e8, name: icera
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x1469a0, name: linktop
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146958, name: nokiacdma
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146910, name: nokia
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x1468b8, name: gemalto
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146870, name: cinterion
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x1467e8, name: ste
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146790, name: ifx
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146748, name: palmpre
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x1466f8, name: novatel
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x1466b0, name: sierra
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146638, name: huawei
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x1465f0, name: zte
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146590, name: hso
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146540, name: mbm
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x1464f0, name: calypso
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x1464a8, name: wavecom
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146460, name: g1
ofonod[346]:
../ofono-1.24/src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register()
driver: 0x146404, name: cdmamodem
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_devinfo_driver_register()
driver: 0x14642c, name: cdmamodem
ofonod[346]:
../ofono-1.24/src/cdma-connman.c:ofono_cdma_connman_driver_register()
driver: 0x14644c, name: cdmamodem
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x146364, name: phonesim
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x14639c, name: localhfp
ofonod[346]:
../ofono-1.24/src/gprs.c:ofono_gprs_context_driver_register() driver:
0x146348, name: phonesim
ofonod[346]: ../ofono-1.24/src/ctm.c:ofono_ctm_driver_register() driver:
0x146334, name: phonesim
ofonod[346]:
../ofono-1.24/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x14630c, name: phonesim
ofonod[346]: ../ofono-1.24/plugins/phonesim.c:parse_config() filename
/etc/ofono/phonesim.conf
ofonod[346]:
../ofono-1.24/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x1462c4, name: xmm7modem
ofonod[346]: ../ofono-1.24/src/ims.c:ofono_ims_driver_register() driver:
0x1462f4, name: xmm7modem
ofonod[346]:
../ofono-1.24/src/location-reporting.c:ofono_location_reporting_driver_regi=
ster()
driver: 0x146284, name: gemaltomodem
ofonod[346]:
../ofono-1.24/src/gprs.c:ofono_gprs_context_driver_register() driver:
0x146204, name: ubloxmodem
ofonod[346]: ../ofono-1.24/src/netmon.c:ofono_netmon_driver_register()
driver: 0x146230, name: ubloxmodem
ofonod[346]: ../ofono-1.24/src/lte.c:ofono_lte_driver_register() driver:
0x14624c, name: ubloxmodem
ofonod[346]: ../ofono-1.24/src/ussd.c:ofono_ussd_driver_register()
driver: 0x1461c0, name: speedupmodem
ofonod[346]:
../ofono-1.24/src/voicecall.c:ofono_voicecall_driver_register() driver:
0x146074, name: hfpmodem
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_devinfo_driver_register()
driver: 0x146120, name: hfpmodem
ofonod[346]: ../ofono-1.24/src/network.c:ofono_netreg_driver_register()
driver: 0x1460d4, name: hfpmodem
ofonod[346]:
../ofono-1.24/src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x146108, name: hfpmodem
ofonod[346]:
../ofono-1.24/src/handsfree.c:ofono_handsfree_driver_register() driver:
0x146150, name: hfpmodem
ofonod[346]: ../ofono-1.24/src/siri.c:ofono_siri_driver_register()
driver: 0x146188, name: hfpmodem
ofonod[346]: ../ofono-1.24/src/network.c:ofono_netreg_driver_register()
driver: 0x145fec, name: dunmodem
ofonod[346]: ../ofono-1.24/src/gprs.c:ofono_gprs_driver_register()
driver: 0x146010, name: dunmodem
ofonod[346]:
../ofono-1.24/src/voicecall.c:ofono_voicecall_driver_register() driver:
0x145f14, name: stemodem
ofonod[346]:
../ofono-1.24/src/gprs.c:ofono_gprs_context_driver_register() driver:
0x145fa8, name: stemodem
ofonod[346]:
../ofono-1.24/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x145f6c, name: stemodem
ofonod[346]:
../ofono-1.24/src/voicecall.c:ofono_voicecall_driver_register() driver:
0x145de0, name: ifxmodem
ofonod[346]:
../ofono-1.24/src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x145e40, name: ifxmodem
ofonod[346]:
../ofono-1.24/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x145e54, name: ifxmodem
ofonod[346]:
../ofono-1.24/src/gprs.c:ofono_gprs_context_driver_register() driver:
0x145e94, name: ifxmodem
ofonod[346]: ../ofono-1.24/src/stk.c:ofono_stk_driver_register() driver:
0x145ec0, name: ifxmodem
ofonod[346]: ../ofono-1.24/src/ctm.c:ofono_ctm_driver_register() driver:
0x145ee0, name: ifxmodem
ofonod[346]:
../ofono-1.24/src/gprs.c:ofono_gprs_context_driver_register() driver:
0x145d6c, name: hsomodem
ofonod[346]:
../ofono-1.24/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x145d90, name: hsomodem
ofonod[346]:
../ofono-1.24/src/location-reporting.c:ofono_location_reporting_driver_regi=
ster()
driver: 0x145d00, name: telitmodem
ofonod[346]:
../ofono-1.24/src/gprs.c:ofono_gprs_context_driver_register() driver:
0x145d28, name: telitncmmodem
ofonod[346]:
../ofono-1.24/src/gprs.c:ofono_gprs_context_driver_register() driver:
0x145c74, name: mbmmodem
ofonod[346]: ../ofono-1.24/src/stk.c:ofono_stk_driver_register() driver:
0x145c98, name: mbmmodem
ofonod[346]:
../ofono-1.24/src/location-reporting.c:ofono_location_reporting_driver_regi=
ster()
driver: 0x145cb8, name: mbmmodem
ofonod[346]:
../ofono-1.24/src/voicecall.c:ofono_voicecall_driver_register() driver:
0x145bd4, name: calypsomodem
ofonod[346]: ../ofono-1.24/src/stk.c:ofono_stk_driver_register() driver:
0x145c2c, name: calypsomodem
ofonod[346]: ../ofono-1.24/src/ussd.c:ofono_ussd_driver_register()
driver: 0x145ac8, name: huaweimodem
ofonod[346]:
../ofono-1.24/src/voicecall.c:ofono_voicecall_driver_register() driver:
0x145adc, name: huaweimodem
ofonod[346]:
../ofono-1.24/src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x145b34, name: huaweimodem
ofonod[346]:
../ofono-1.24/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x145b74, name: huaweimodem
ofonod[346]:
../ofono-1.24/src/gprs.c:ofono_gprs_context_driver_register() driver:
0x145b48, name: huaweimodem
ofonod[346]:
../ofono-1.24/src/cdma-netreg.c:ofono_cdma_netreg_driver_register()
driver: 0x145ba4, name: huaweimodem
ofonod[346]:
../ofono-1.24/src/gprs.c:ofono_gprs_context_driver_register() driver:
0x145a4c, name: iceramodem
ofonod[346]:
../ofono-1.24/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x145a78, name: iceramodem
ofonod[346]:
../ofono-1.24/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x1459f4, name: ztemodem
ofonod[346]:
../ofono-1.24/src/gprs.c:ofono_gprs_context_driver_register() driver:
0x1459b0, name: swmodem
ofonod[346]:
../ofono-1.24/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x145968, name: nwmodem
ofonod[346]:
../ofono-1.24/src/voicecall.c:ofono_voicecall_driver_register() driver:
0x1457d4, name: atmodem
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_devinfo_driver_register()
driver: 0x145874, name: atmodem
ofonod[346]:
../ofono-1.24/src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x14582c, name: atmodem
ofonod[346]:
../ofono-1.24/src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x145544, name: atmodem
ofonod[346]:
../ofono-1.24/src/call-meter.c:ofono_call_meter_driver_register()
driver: 0x145584, name: atmodem
ofonod[346]:
../ofono-1.24/src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x145490, name: atmodem
ofonod[346]:
../ofono-1.24/src/phonebook.c:ofono_phonebook_driver_register() driver:
0x14585c, name: atmodem
ofonod[346]: ../ofono-1.24/src/ussd.c:ofono_ussd_driver_register()
driver: 0x1457b0, name: atmodem
ofonod[346]: ../ofono-1.24/src/sms.c:ofono_sms_driver_register() driver:
0x145500, name: atmodem
ofonod[346]: ../ofono-1.24/src/sim.c:ofono_sim_driver_register() driver:
0x1456b8, name: atmodem
ofonod[346]: ../ofono-1.24/src/sim.c:ofono_sim_driver_register() driver:
0x14571c, name: atmodem-noef
ofonod[346]: ../ofono-1.24/src/stk.c:ofono_stk_driver_register() driver:
0x145788, name: atmodem
ofonod[346]: ../ofono-1.24/src/network.c:ofono_netreg_driver_register()
driver: 0x1455f0, name: atmodem
ofonod[346]: ../ofono-1.24/src/cbs.c:ofono_cbs_driver_register() driver:
0x145528, name: atmodem
ofonod[346]:
../ofono-1.24/src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x1458a4, name: atmodem
ofonod[346]: ../ofono-1.24/src/gprs.c:ofono_gprs_driver_register()
driver: 0x1458d4, name: atmodem
ofonod[346]:
../ofono-1.24/src/gprs.c:ofono_gprs_context_driver_register() driver:
0x1458f0, name: atmodem
ofonod[346]: ../ofono-1.24/src/gnss.c:ofono_gnss_driver_register()
driver: 0x14591c, name: atmodem
ofonod[346]: ../ofono-1.24/src/lte.c:ofono_lte_driver_register() driver:
0x145930, name: atmodem
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x1453f0, name: gobi
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_devinfo_driver_register()
driver: 0x1451cc, name: qmimodem
ofonod[346]: ../ofono-1.24/src/network.c:ofono_netreg_driver_register()
driver: 0x14523c, name: qmimodem
ofonod[346]:
../ofono-1.24/src/voicecall.c:ofono_voicecall_driver_register() driver:
0x1451ec, name: qmimodem
ofonod[346]: ../ofono-1.24/src/sim.c:ofono_sim_driver_register() driver:
0x145260, name: qmimodem-legacy
ofonod[346]: ../ofono-1.24/src/sim.c:ofono_sim_driver_register() driver:
0x1452c4, name: qmimodem
ofonod[346]: ../ofono-1.24/src/sms.c:ofono_sms_driver_register() driver:
0x145328, name: qmimodem
ofonod[346]: ../ofono-1.24/src/ussd.c:ofono_ussd_driver_register()
driver: 0x145348, name: qmimodem
ofonod[346]: ../ofono-1.24/src/gprs.c:ofono_gprs_driver_register()
driver: 0x14535c, name: qmimodem
ofonod[346]:
../ofono-1.24/src/gprs.c:ofono_gprs_context_driver_register() driver:
0x145370, name: qmimodem
ofonod[346]: ../ofono-1.24/src/lte.c:ofono_lte_driver_register() driver:
0x14538c, name: qmimodem
ofonod[346]:
../ofono-1.24/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x14539c, name: qmimodem
ofonod[346]:
../ofono-1.24/src/location-reporting.c:ofono_location_reporting_driver_regi=
ster()
driver: 0x1453c4, name: qmimodem
ofonod[346]: ../ofono-1.24/src/netmon.c:ofono_netmon_driver_register()
driver: 0x1453dc, name: qmimodem
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x145164, name: u8500
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_devinfo_driver_register()
driver: 0x145144, name: u8500
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x1450fc, name: n900
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x1450b4, name: isiusb
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_devinfo_driver_register()
driver: 0x144e1c, name: isimodem
ofonod[346]:
../ofono-1.24/src/phonebook.c:ofono_phonebook_driver_register() driver:
0x144e0c, name: isimodem
ofonod[346]: ../ofono-1.24/src/network.c:ofono_netreg_driver_register()
driver: 0x144e3c, name: isimodem
ofonod[346]:
../ofono-1.24/src/voicecall.c:ofono_voicecall_driver_register() driver:
0x144e60, name: isimodem
ofonod[346]: ../ofono-1.24/src/sms.c:ofono_sms_driver_register() driver:
0x144eb0, name: isimodem
ofonod[346]: ../ofono-1.24/src/cbs.c:ofono_cbs_driver_register() driver:
0x144ed0, name: isimodem
ofonod[346]: ../ofono-1.24/src/sim.c:ofono_sim_driver_register() driver:
0x144ee4, name: isimodem
ofonod[346]: ../ofono-1.24/src/ussd.c:ofono_ussd_driver_register()
driver: 0x144f48, name: isimodem
ofonod[346]:
../ofono-1.24/src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x144f5c, name: isimodem
ofonod[346]:
../ofono-1.24/src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x144f7c, name: isimodem
ofonod[346]:
../ofono-1.24/src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x144fac, name: isimodem
ofonod[346]:
../ofono-1.24/src/call-meter.c:ofono_call_meter_driver_register()
driver: 0x144fc4, name: isimodem
ofonod[346]:
../ofono-1.24/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x144fec, name: isimodem
ofonod[346]: ../ofono-1.24/src/gprs.c:ofono_gprs_driver_register()
driver: 0x145014, name: isimodem
ofonod[346]:
../ofono-1.24/src/gprs.c:ofono_gprs_context_driver_register() driver:
0x145028, name: isimodem
ofonod[346]:
../ofono-1.24/src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x145044, name: isimodem
ofonod[346]: ../ofono-1.24/src/sim.c:ofono_sim_driver_register() driver:
0x145050, name: wgmodem2.5
ofonod[346]: ../ofono-1.24/drivers/rilmodem/rilmodem.c:rilmodem_init()
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_devinfo_driver_register()
driver: 0x144b98, name: rilmodem
ofonod[346]: ../ofono-1.24/drivers/rilmodem/sim.c:ril_sim_init()
ofonod[346]: ../ofono-1.24/src/sim.c:ofono_sim_driver_register() driver:
0x144c74, name: rilmodem
ofonod[346]:
../ofono-1.24/src/voicecall.c:ofono_voicecall_driver_register() driver:
0x144bdc, name: rilmodem
ofonod[346]: ../ofono-1.24/src/sms.c:ofono_sms_driver_register() driver:
0x144cd8, name: rilmodem
ofonod[346]: ../ofono-1.24/src/network.c:ofono_netreg_driver_register()
driver: 0x144bb8, name: rilmodem
ofonod[346]:
../ofono-1.24/src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x144c2c, name: rilmodem
ofonod[346]: ../ofono-1.24/src/gprs.c:ofono_gprs_driver_register()
driver: 0x144c44, name: rilmodem
ofonod[346]:
../ofono-1.24/src/gprs.c:ofono_gprs_context_driver_register() driver:
0x144c58, name: rilmodem
ofonod[346]: ../ofono-1.24/src/ussd.c:ofono_ussd_driver_register()
driver: 0x144cf8, name: rilmodem
ofonod[346]:
../ofono-1.24/src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x144d0c, name: rilmodem
ofonod[346]:
../ofono-1.24/src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x144d3c, name: rilmodem
ofonod[346]:
../ofono-1.24/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x144d5c, name: rilmodem
ofonod[346]:
../ofono-1.24/src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x144d84, name: rilmodem
ofonod[346]: ../ofono-1.24/src/netmon.c:ofono_netmon_driver_register()
driver: 0x144d9c, name: rilmodem
ofonod[346]: ../ofono-1.24/src/stk.c:ofono_stk_driver_register() driver:
0x144db0, name: rilmodem
ofonod[346]: ../ofono-1.24/src/cbs.c:ofono_cbs_driver_register() driver:
0x144dc8, name: rilmodem
ofonod[346]: ../ofono-1.24/src/lte.c:ofono_lte_driver_register() driver:
0x144ddc, name: rilmodem
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x144b30, name: ril_intel
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x144ae8, name: infineon
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_driver_register()
driver: 0x144aa0, name: ril
ofonod[346]: ../ofono-1.24/plugins/udevng.c:udev_start()
ofonod[346]: ../ofono-1.24/plugins/udevng.c:enumerate_devices()
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() hub
[1d6b:0002]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() usb
[1d6b:0002]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() usb
[0424:2517]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() usb
[0424:2660]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device()
usb-storage [0424:4040]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() hub
[0424:2660]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() usb
[0424:2517]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() usb
[0ab1:0003]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() usb
[0424:2517]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[0536:030a]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[0536:030a]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[0536:030a]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() usb
[0424:2517]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() usb
[0424:2514]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device()
/sys/devices/soc0/soc/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.6=
/1-1.6.1
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device()
/sys/devices/soc0/soc/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.6=
/1-1.6.1/1-1.6.1:1.0/tty/ttyACM2
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device() /dev/ttyACM2
(gemalto) 2/2/1 [00] =3D=3D> (null) (null)
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_ether
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_ether
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device()
/sys/devices/soc0/soc/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.6=
/1-1.6.1
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device()
/sys/devices/soc0/soc/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.6=
/1-1.6.1/1-1.6.1:1.10/net/usb0
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device() usb0 (gemalto)
2/6/0 [0a] =3D=3D> (null) (null)
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_ether
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_ether
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_ether
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device()
/sys/devices/soc0/soc/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.6=
/1-1.6.1
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device()
/sys/devices/soc0/soc/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.6=
/1-1.6.1/1-1.6.1:1.12/net/usb1
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device() usb1 (gemalto)
2/6/0 [0c] =3D=3D> (null) (null)
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_ether
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device()
/sys/devices/soc0/soc/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.6=
/1-1.6.1
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device()
/sys/devices/soc0/soc/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.6=
/1-1.6.1/1-1.6.1:1.2/tty/ttyACM3
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device() /dev/ttyACM3
(gemalto) 2/2/1 [02] =3D=3D> (null) (null)
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device()
/sys/devices/soc0/soc/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.6=
/1-1.6.1
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device()
/sys/devices/soc0/soc/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.6=
/1-1.6.1/1-1.6.1:1.4/tty/ttyACM5
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device() /dev/ttyACM5
(gemalto) 2/2/1 [04] =3D=3D> (null) (null)
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device()
/sys/devices/soc0/soc/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.6=
/1-1.6.1
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device()
/sys/devices/soc0/soc/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.6=
/1-1.6.1/1-1.6.1:1.6/tty/ttyACM6
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device() /dev/ttyACM6
(gemalto) 2/2/1 [06] =3D=3D> (null) (null)
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device()
/sys/devices/soc0/soc/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.6=
/1-1.6.1
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device()
/sys/devices/soc0/soc/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.6=
/1-1.6.1/1-1.6.1:1.8/tty/ttyACM7
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_device() /dev/ttyACM7
(gemalto) 2/2/1 [08] =3D=3D> (null) (null)
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[1e2d:0061]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() usb
[0424:2514]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() ftdi_sio
[0403:6010]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() ftdi_sio
[0403:6010]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() ftdi_sio
[0403:6010]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() ftdi_sio
[0403:6010]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() hub
[0424:2514]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() usb
[0424:2517]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() ftdi_sio
[0403:6010]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() ftdi_sio
[0403:6010]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() ftdi_sio
[0403:6010]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() ftdi_sio
[0403:6010]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() hub
[0424:2517]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() hub
[1d6b:0002]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() usb
[1d6b:0002]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() usb
[0424:2514]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[0536:030a]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[0536:030a]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() cdc_acm
[0536:030a]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() usb
[0424:2514]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() ftdi_sio
[0403:6001]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() ftdi_sio
[0403:6001]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() usb
[0424:2514]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() usb
[1cbe:0004]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:check_usb_device() hub
[0424:2514]
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[346]: ../ofono-1.24/plugins/udevng.c:create_modem()
/sys/devices/soc0/soc/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.6=
/1-1.6.1
ofonod[346]: ../ofono-1.24/plugins/udevng.c:create_modem() driver=3Dgemalto
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_create() name:
(null), type: gemalto
ofonod[346]: ../ofono-1.24/plugins/udevng.c:setup_gemalto()
/sys/devices/soc0/soc/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.6=
/1-1.6.1
ofonod[346]: ../ofono-1.24/plugins/udevng.c:setup_gemalto() /dev/ttyACM2
2/2/1 00 (null) tty
ofonod[346]: ../ofono-1.24/plugins/udevng.c:setup_gemalto() /dev/ttyACM3
2/2/1 02 (null) tty
ofonod[346]: ../ofono-1.24/plugins/udevng.c:setup_gemalto() /dev/ttyACM5
2/2/1 04 (null) tty
ofonod[346]: ../ofono-1.24/plugins/udevng.c:setup_gemalto() /dev/ttyACM6
2/2/1 06 (null) tty
ofonod[346]: ../ofono-1.24/plugins/udevng.c:setup_gemalto() /dev/ttyACM7
2/2/1 08 (null) tty
ofonod[346]: ../ofono-1.24/plugins/udevng.c:setup_gemalto() usb0 2/6/0
0a (null) net
ofonod[346]: ../ofono-1.24/plugins/udevng.c:setup_gemalto() usb1 2/6/0
0c (null) net
ofonod[346]: ../ofono-1.24/plugins/udevng.c:setup_gemalto()
application=3D/dev/ttyACM3 gps=3D/dev/ttyACM5 modem=3D/dev/ttyACM2
network=3Dusb1 qmi=3D(null)
ofonod[346]: ../ofono-1.24/src/modem.c:set_modem_property() modem
0x17f3730 property Application
ofonod[346]: ../ofono-1.24/src/modem.c:set_modem_property() modem
0x17f3730 property GPS
ofonod[346]: ../ofono-1.24/src/modem.c:set_modem_property() modem
0x17f3730 property Modem
ofonod[346]: ../ofono-1.24/src/modem.c:set_modem_property() modem
0x17f3730 property Device
ofonod[346]: ../ofono-1.24/src/modem.c:set_modem_property() modem
0x17f3730 property Model
ofonod[346]: ../ofono-1.24/src/modem.c:set_modem_property() modem
0x17f3730 property NetworkInterface
ofonod[346]: ../ofono-1.24/src/modem.c:set_modem_property() modem
0x17f3730 property SystemPath
ofonod[346]: ../ofono-1.24/src/modem.c:ofono_modem_register() 0x17f3730
ofonod[346]: ../ofono-1.24/src/modem.c:emit_modem_added() 0x17f3730
ofonod[346]: ../ofono-1.24/src/modem.c:get_modem_property() modem
0x17f3730 property SystemPath
ofonod[346]: ../ofono-1.24/src/modem.c:call_modemwatches() 0x17f3730 added:1
ofonod[346]: ../ofono-1.24/plugins/dun_gw_bluez5.c:modem_watch() modem:
0x17f3730, added: 1
ofonod[346]: ../ofono-1.24/plugins/hfp_ag_bluez5.c:modem_watch() modem:
0x17f3730, added: 1
ofonod[346]: ../ofono-1.24/plugins/smart-messaging.c:modem_watch()
modem: 0x17f3730, added: 1
ofonod[346]: ../ofono-1.24/plugins/push-notification.c:modem_watch()
modem: 0x17f3730, added: 1
ofonod[346]: ../ofono-1.24/plugins/hfp_hf_bluez5.c:connect_handler()
Registering External Profile handler ...
ofonod[346]: ../ofono-1.24/plugins/bluez5.c:bt_register_profile()
Bluetooth: Registering 0000111e-0000-1000-8000-00805f9b34fb (hfp_hf) profile
ofonod[346]: ../ofono-1.24/plugins/bluez5.c:profile_register_cb()
ofonod[346]: ../ofono-1.24/src/modem.c:get_modem_property() modem
0x17f3730 property SystemPath
ofonod[346]: ../ofono-1.24/plugins/gemalto.c:gemalto_enable() 0x17f3730
ofonod[346]: ../ofono-1.24/src/modem.c:get_modem_property() modem
0x17f3730 property Application
ofonod[346]: ../ofono-1.24/src/modem.c:get_modem_property() modem
0x17f3730 property Modem
ofonod[346]: ../ofono-1.24/plugins/gemalto.c:open_device() Opening
device /dev/ttyACM3
ofonod[346]: ../ofono-1.24/plugins/gemalto.c:gemalto_initialize()
ofonod[346]: ../ofono-1.24/src/modem.c:get_modem_property() modem
0x17f3730 property Modem
ofonod[346]: ../ofono-1.24/plugins/gemalto.c:open_device() Opening
device /dev/ttyACM2
ofonod[346]:
../ofono-1.24/plugins/gemalto.c:gemalto_hardware_monitor_enable()
ofonod[346]: Mdm> ATE0\r
ofonod[346]: App> ATE0 +CMEE=3D1\r
ofonod[346]: Mdm< \r\nOK\r\n
ofonod[346]: Mdm> AT&C0\r
ofonod[346]: Mdm< \r\nOK\r\n
ofonod[346]: App< \r\nOK\r\n
ofonod[346]: App> AT&C0\r
ofonod[346]: App< \r\nOK\r\n
ofonod[346]: App> AT+CFUN=3D4\r
ofonod[346]: Mdm< \r\n^SYSSTART AIRPLANE MODE\r\n
ofonod[346]: App< \r\nOK\r\n\r\n^SYSSTART AIRPLANE MODE\r\n
ofonod[346]: App> AT^SCTM=3D0,1\r
ofonod[346]: App< \r\nOK\r\n
ofonod[346]: App> AT+CPIN?\r
ofonod[346]: App< \r\n+CPIN: READY\r\n\r\nOK\r\n
ofonod[346]: ../ofono-1.24/src/modem.c:modem_change_state() old state:
0, new state: 1
ofonod[346]: ../ofono-1.24/plugins/gemalto.c:gemalto_pre_sim() 0x17f3730
ofonod[346]: App> AT+GCAP\r
ofonod[346]: App< \r\n+GCAP: +CGSM,+FCLASS,+DS\r\n\r\nOK\r\n
ofonod[346]: App> AT^SGPSC=3D?\r
ofonod[346]: App< \r\n^SGPSC: "Engine",("0","1","2")\r\n^SGPSC:
"Info",("Xtra","Urc"),("off","on"),(0-10080)\r\n^SGPSC:
"Nmea/Freq",(1-65535)\r\n^SGPSC: "Nmea/Glonass",("off","on")\r\n^SGPSC:
"Nmea/DeadReckoning",("off","on")\r\n^SGPSC:
"Nmea/DRSync",("off","on")\r\n^SGPSC:
"Nmea/Output",("off","on","buffered","last")\r\n^SGPSC:
"Nmea/Urc",("off","on")\r\n^SGPSC:
"Power/Antenna",("off","on","auto")\r\n\r\nOK\r\n
ofonod[346]: App> AT+CLCK=3D?\r
ofonod[346]: App< \r\n+CME ERROR: 4\r\n
ofonod[346]: ../ofono-1.24/src/sim.c:ofono_sim_add_state_watch() 0x17f0738
ofonod[346]: ../ofono-1.24/src/sim.c:ofono_sim_add_state_watch() 0x17f0738
ofonod[346]: ../ofono-1.24/src/sim.c:ofono_sim_add_state_watch() 0x17f0738
ofonod[346]: ../ofono-1.24/src/sim.c:ofono_sim_add_state_watch() 0x17f0738
ofonod[346]: App> AT^SIND=3D"simstatus",1\r
ofonod[346]: App< \r\n^SIND: simstatus,1,5\r\n\r\nOK\r\n
ofonod[346]: App> AT+CGMI\r
ofonod[346]: App< \r\nCinterion\r\n\r\nOK\r\n
ofonod[346]: App> AT+CRSM=3D192,12258\r
ofonod[346]: App< \r\n+CRSM:
144,0,"621C8202412183022FE2A5038001618A01058B032F06038002000A880110"\r\n\r\=
nOK\r\n
ofonod[346]:
../ofono-1.24/drivers/atmodem/sim.c:get_response_common_cb()
crsm_info_cb: 90, 00, 30
ofonod[346]: App> AT+CGMM\r
ofonod[346]: App< \r\nPLS8-E\r\n\r\nOK\r\n
ofonod[346]: App> AT+CRSM=3D176,12258,0,0,10\r
ofonod[346]: App< \r\n+CRSM: 144,0,"98942000003101240075"\r\n\r\nOK\r\n
ofonod[346]: ../ofono-1.24/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 10
ofonod[346]: ../ofono-1.24/src/simfs.c:sim_fs_op_read_block_cb() bufoff:
0, dataoff: 0, tocopy: 10
ofonod[346]: App> AT+CGMR\r
ofonod[346]: App< \r\nREVISION 03.017\r\n\r\nOK\r\n
ofonod[346]: App> AT+CRSM=3D192,28421\r
ofonod[346]: App< \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[346]: App> AT+CGSN\r
ofonod[346]: App< \r\n358709053043190\r\n\r\nOK\r\n
ofonod[346]: App> AT+CRSM=3D192,12037\r
ofonod[346]: App< \r\n+CRSM:
144,0,"621C8202412183022F05A5038001618A01058B032F060480020008880128"\r\n\r\=
nOK\r\n
ofonod[346]:
../ofono-1.24/drivers/atmodem/sim.c:get_response_common_cb()
crsm_info_cb: 90, 00, 30
ofonod[346]: App> AT+CRSM=3D176,12037,0,0,8\r
ofonod[346]: App< \r\n+CRSM: 144,0,"6465656EFFFFFFFF"\r\n\r\nOK\r\n
ofonod[346]: ../ofono-1.24/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 8
ofonod[346]: ../ofono-1.24/src/simfs.c:sim_fs_op_read_block_cb() bufoff:
0, dataoff: 0, tocopy: 8
ofonod[346]: App> AT+CPIN?\r
ofonod[346]: App< \r\n+CPIN: READY\r\n\r\nOK\r\n
ofonod[346]: ../ofono-1.24/drivers/atmodem/sim.c:at_cpin_cb()
crsm_pin_cb: READY
ofonod[346]: ../ofono-1.24/src/sim.c:sim_pin_query_cb() sim->pin_type:
0, pin_type: 0
ofonod[346]: ../ofono-1.24/drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[346]: App> AT^SPIC\r
ofonod[346]: App< \r\n^SPIC: 2\r\n\r\nOK\r\n
ofonod[346]: ../ofono-1.24/drivers/atmodem/sim.c:cinterion_spic_cb()
Retry : 2, type : 0
ofonod[346]: App> AT+CUAD\r
ofonod[346]: App< \r\n+CME ERROR: 4\r\n
ofonod[346]: App> AT+CRSM=3D192,28590\r
ofonod[346]: App< \r\n+CRSM:
144,0,"621B8202412183026FAEA5038001618A01058B036F060C800200018800"\r\n\r\nO=
K\r\n
ofonod[346]:
../ofono-1.24/drivers/atmodem/sim.c:get_response_common_cb()
crsm_info_cb: 90, 00, 29
ofonod[346]: App> AT+CRSM=3D176,28590,0,0,1\r
ofonod[346]: App< \r\n+CRSM: 144,0,"03"\r\n\r\nOK\r\n
ofonod[346]: ../ofono-1.24/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 1
ofonod[346]: ../ofono-1.24/src/simfs.c:sim_fs_op_read_block_cb() bufoff:
0, dataoff: 0, tocopy: 1
ofonod[346]: App> AT+CRSM=3D192,28589\r
ofonod[346]: App< \r\n+CRSM:
144,0,"621C8202412183026FADA5038001618A01058B036F060780020004880118"\r\n\r\=
nOK\r\n
ofonod[346]:
../ofono-1.24/drivers/atmodem/sim.c:get_response_common_cb()
crsm_info_cb: 90, 00, 30
ofonod[346]: App> AT+CRSM=3D176,28589,0,0,4\r
ofonod[346]: App< \r\n+CRSM: 144,0,"01000102"\r\n\r\nOK\r\n
ofonod[346]: ../ofono-1.24/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 4
ofonod[346]: ../ofono-1.24/src/simfs.c:sim_fs_op_read_block_cb() bufoff:
0, dataoff: 0, tocopy: 4
ofonod[346]: App> AT+CRSM=3D192,28438\r
ofonod[346]: App< \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[346]: App> AT+CRSM=3D192,28472\r
ofonod[346]: App< \r\n+CRSM:
144,0,"621C8202412183026F38A5038001618A01058B036F06028002000C880120"\r\n\r\=
nOK\r\n
ofonod[346]:
../ofono-1.24/drivers/atmodem/sim.c:get_response_common_cb()
crsm_info_cb: 90, 00, 30
ofonod[346]: App> AT+CRSM=3D176,28472,0,0,12\r
ofonod[346]: App< \r\n+CRSM: 144,0,"022A170C2336000000020000"\r\n\r\nOK\r\n
ofonod[346]: ../ofono-1.24/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 12
ofonod[346]: ../ofono-1.24/src/simfs.c:sim_fs_op_read_block_cb() bufoff:
0, dataoff: 0, tocopy: 12
ofonod[346]: App> AT+CIMI\r
ofonod[346]: App< \r\n262011401939536\r\n\r\nOK\r\n
ofonod[346]: ../ofono-1.24/drivers/atmodem/sim.c:at_cimi_cb() cimi_cb:
262011401939536
ofonod[346]: ../ofono-1.24/src/modem.c:modem_change_state() old state:
1, new state: 2
ofonod[346]: ../ofono-1.24/src/modem.c:get_modem_property() modem
0x17f3730 property Model
ofonod[346]: ../ofono-1.24/plugins/gemalto.c:gemalto_post_sim() 0x17f3730
ofonod[346]:
../ofono-1.24/drivers/atmodem/gprs-context.c:at_gprs_context_probe()
ofonod[346]: ../ofono-1.24/drivers/atmodem/lte.c:at_lte_probe()@lte probe
ofonod[346]: ../ofono-1.24/src/lte.c:ofono_lte_create() LTE atom created
ofonod[346]: ../ofono-1.24/src/modem.c:get_modem_property() modem
0x17f3730 property AlwaysOnline
ofonod[346]: App> AT+CSCS=3D?\r
ofonod[346]:
../ofono-1.24/drivers/atmodem/lte.c:at_lte_set_default_attach_info() LTE
config with APN:
ofonod[346]: App< \r\n+CSCS: ("IRA","GSM","UCS2")\r\n\r\nOK\r\n
ofonod[346]: App> AT+CSMS=3D?\r
ofonod[346]: App< \r\n+CSMS: (0-1)\r\n\r\nOK\r\n
ofonod[346]: ../ofono-1.24/drivers/atmodem/sms.c:at_csms_query_cb() CSMS
query parsed successfully
ofonod[346]: App> AT+CGDCONT=3D?\r
ofonod[346]: App< \r\n+CGDCONT: (1-16),"IP",,,(0-2),(0-4)\r\n+CGDCONT:
(1-16),"PPP",,,(0-2),(0-4)\r\n+CGDCONT:
(1-16),"IPV6",,,(0-2),(0-4)\r\n+CGDCONT:
(1-16),"IPV4V6",,,(0-2),(0-4)\r\n\r\nOK\r\n
ofonod[346]: App> AT+CGDCONT=3D0,"IP"\r
ofonod[346]: App< \r\n+CME ERROR: 21\r\n
ofonod[346]:
../ofono-1.24/drivers/atmodem/lte.c:at_lte_set_default_attach_info_cb() ok 0
ofonod[346]: App> AT+CRSM=3D192,28480\r
ofonod[346]: App< \r\n+CRSM:
144,0,"621E82054221001E0483026F40A5038001618A01058B036F060F800200788800"\r\=
n\r\nOK\r\n
ofonod[346]:
../ofono-1.24/drivers/atmodem/sim.c:get_response_common_cb()
crsm_info_cb: 90, 00, 32
ofonod[346]: App> AT+CPBS=3D?\r
ofonod[346]: App< \r\n+CPBS:
("SM","DC","FD","MC","ME","RC","EN","ON")\r\n\r\nOK\r\n
ofonod[346]: App> AT+CSMS=3D1\r
ofonod[346]: App< \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
ofonod[346]: App> AT+CGREG=3D?\r
ofonod[346]: App< \r\n+CGREG: (0-2)\r\n\r\nOK\r\n
ofonod[346]: App> AT+CRSM=3D178,28480,1,4,30\r
ofonod[346]: App< \r\n+CRSM:
144,0,"456967656E65205275666E756D6D65720791947141589576FFFFFFFFFFFF"\r\n\r\=
nOK\r\n
ofonod[346]: ../ofono-1.24/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 30
ofonod[346]: App> AT+CSMS?\r
ofonod[346]: App< \r\n+CSMS: 1,1,1,1\r\n\r\nOK\r\n
ofonod[346]: App> AT+CGREG=3D2\r
ofonod[346]: App< \r\nOK\r\n
ofonod[346]: App> AT+CGAUTO=3D0\r
ofonod[346]: App< \r\nERROR\r\n
ofonod[346]: App> AT+CGEREP=3D2,1\r
ofonod[346]: App< \r\nOK\r\n
ofonod[346]: ../ofono-1.24/plugins/bluez5.c:bt_register_profile()
Bluetooth: Registering 00001103-0000-1000-8000-00805f9b34fb (dun_gw) profile
ofonod[346]: App> AT+CRSM=3D178,28480,2,4,30\r
ofonod[346]: ../ofono-1.24/plugins/bluez5.c:profile_register_cb()
ofonod[346]: App< \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\=
nOK\r\n
ofonod[346]: ../ofono-1.24/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 30
ofonod[346]: App> AT+CMGF=3D?\r
ofonod[346]: App< \r\n+CMGF: (0-1)\r\n\r\nOK\r\n
ofonod[346]: App> AT+CPSB=3D1\r
ofonod[346]: App< \r\nERROR\r\n
ofonod[346]: App> AT+CRSM=3D178,28480,3,4,30\r
ofonod[346]: App< \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\=
nOK\r\n
ofonod[346]: ../ofono-1.24/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 30
ofonod[346]: App> AT+CPMS=3D?\r
ofonod[346]: App< \r\n+CPMS:
("ME","MT","SM","SR"),("ME","MT","SM","SR"),("ME","MT","SM","SR")\r\n\r\nOK=
\r\n
ofonod[346]: App> AT+CRSM=3D178,28480,4,4,30\r
ofonod[346]: App< \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\=
nOK\r\n
ofonod[346]: ../ofono-1.24/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 30
ofonod[346]: App> AT+CMGF=3D0\r
ofonod[346]: App< \r\nOK\r\n
ofonod[346]: App> AT+CRSM=3D192,28489\r
ofonod[346]: App< \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[346]: App> AT+CPMS=3D"ME","ME","ME"\r
ofonod[346]: App< \r\n+CPMS: 0,255,0,255,0,255\r\n\r\nOK\r\n
ofonod[346]: App> AT+CNMI=3D?\r
ofonod[346]: App< \r\n+CNMI: (0,1,2),(0,1,2,3),(0,2),(0,1),(1)\r\n\r\nOK\r\n
ofonod[346]: ../ofono-1.24/drivers/atmodem/sms.c:build_cnmi_string()
ofonod[346]: ../ofono-1.24/drivers/atmodem/sms.c:construct_ack_pdu()
ofonod[346]: App> AT+CNMI=3D2,2,2,1,1\r
ofonod[346]: App< \r\nOK\r\n
ofonod[346]: ../ofono-1.24/src/sms.c:sms_restore_tx_queue()
ofonod[346]: ../ofono-1.24/plugins/push-notification.c:sms_watch()
registered
ofonod[346]: ../ofono-1.24/plugins/smart-messaging.c:sms_watch() registered
ofonod[346]: App> AT+CMGL=3D4\r
ofonod[346]: App< \r\nOK\r\n
ofonod[346]: ../ofono-1.24/drivers/atmodem/sms.c:at_cmgl_done()
ofonod[346]: App> AT+CGSMS=3D3\r
ofonod[346]: App< \r\nOK\r\n
ofonod[346]: ../ofono-1.24/src/modem.c:get_modem_property() modem
0x17f3730 property SystemPath
ofonod[346]:
../ofono-1.24/drivers/gemaltomodem/location-reporting.c:gemalto_location_re=
porting_enable()
lr=3D0x1740b40
ofonod[346]: App> AT^SGPSC=3D"Engine",2\r
ofonod[346]: App< \r\n^SGPSC: "Engine","2"\r\n\r\nOK\r\n
ofonod[346]:
../ofono-1.24/drivers/gemaltomodem/location-reporting.c:gemalto_sgpsc_cb()
lr=3D0x1740b40 ok=3D1
ofonod[346]: ../ofono-1.24/src/modem.c:get_modem_property() modem
0x17f3730 property GPS

Is there some working example available how to use the location service
(with this modem) or any recommendations what to check for?

Is it possible that ...
AT^SGPSC=3D"NMEA/Output","on"
... is simply missing in the AT command sequence?

Best regards,
J=C3=B6rg


--===============6152751121288388065==--

