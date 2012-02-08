Content-Type: multipart/mixed; boundary="===============1773517215188094237=="
MIME-Version: 1.0
From: Jan Pohanka <xhpohanka@gmail.com>
Subject: Re: setup ofono for telit h910 on embedded system
Date: Wed, 08 Feb 2012 07:38:15 +0100
Message-ID: <op.v9ckp1jnyxxkfz@localhost.localdomain>
In-Reply-To: <4F316099.8090005@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1773517215188094237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Nicolas,

thank you for the response. Please see reactions below...


Dne Tue, 07 Feb 2012 18:34:17 +0100 nicolas.bertrand  =

<nicolas.bertrand@linux.intel.com> napsal(a):


>
> What is your version of ofono?
>
I'm using the latest release ofono-1.3.

> The log is not complete and so we can't see this information.

full log is at the end of the message

>
> Some features about telit devices have been implemented recently, using  =

> a ofono version >=3D 1.1 should be better and then you won't need  =

> ofono.rules anymore , it's a deprecated file.
>
Unfortunately I have not found much documentation how to properly register  =

a modem to ofono. Just these two links  =

(http://wiki.maemo.org/User:Jebba/Ofono,  =

http://ofono.org/wiki/how-enable-modem-ofono). Both suggests ofono.rules  =

file and the first one also /etc/ofono/modem.conf file. Which one should  =

be used now, please?
Even if the Telit h910 is not fully supported, it uses some standard AT  =

commands so I think I should be able to control it at least on basic level  =

using ofono. Am I right?

Here is the log from the ofonod -nd

ofonod[321]: oFono version 1.3
ofonod[321]: src/plugin.c:__ofono_plugin_init()
ofonod[321]: plugins/push-notification.c:push_notification_init()
ofonod[321]: plugins/smart-messaging.c:smart_messaging_init()
ofonod[321]: src/cdma-provision.c:ofono_cdma_provision_driver_register()  =

driver: 0xdc418 name: CD
MA provisioning
ofonod[321]: src/gprs-provision.c:ofono_gprs_provision_driver_register()  =

driver: 0xdc3ec name: Pr
ovisioning
ofonod[321]: plugins/connman.c:connman_init()
ofonod[321]: src/private-network.c:ofono_private_network_driver_register()  =

driver: 0xdc3c0, name:
  ConnMan Private Network
ofonod[321]: plugins/dun_gw.c:dun_gw_init()
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdc2e0,  =

name: hfp
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdc288,  =

name: sap
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdc214,  =

name: telit
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdc1a8,  =

name: sim900
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdc160,  =

name: samsung
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdc118,  =

name: speedupcdma
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdc0d0,  =

name: speedup
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdc088,  =

name: alcatel
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdc040,  =

name: linktop
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdbff8,  =

name: nokiacdma
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdbfb0,  =

name: nokia
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdbf68,  =

name: tc65
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdbee0,  =

name: ste
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdbe90,  =

name: ifx
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdbe48,  =

name: palmpre
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdbdf8,  =

name: novatel
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdbdb0,  =

name: sierra
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdbd38,  =

name: huawei
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdbcf0,  =

name: zte
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdbc90,  =

name: hso
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdbc40,  =

name: mbm
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdbbf0,  =

name: calypso
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdbba8,  =

name: wavecom
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdbb60,  =

name: gobi
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdbb18,  =

name: g1
ofonod[321]: src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register()  =

driver: 0xdbac0, name: c
dmamodem
ofonod[321]: src/modem.c:ofono_devinfo_driver_register() driver: 0xdbae8,  =

name: cdmamodem
ofonod[321]: src/cdma-connman.c:ofono_cdma_connman_driver_register()  =

driver: 0xdbb04, name: cdmam
odem
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdba28,  =

name: phonesim
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdba58,  =

name: localhfp
ofonod[321]: src/gprs.c:ofono_gprs_context_driver_register() driver:  =

0xdba14, name: phonesim
ofonod[321]: src/ctm.c:ofono_ctm_driver_register() driver: 0xdba00, name:  =

phonesim
ofonod[321]: plugins/phonesim.c:parse_config() filename  =

/etc/ofono/phonesim.conf
ofonod[321]: src/voicecall.c:ofono_voicecall_driver_register() driver:  =

0xdb91c, name: hfpmodem
ofonod[321]: src/modem.c:ofono_devinfo_driver_register() driver: 0xdb9c0,  =

name: hfpmodem
ofonod[321]: src/network.c:ofono_netreg_driver_register() driver: 0xdb974,  =

name: hfpmodem
ofonod[321]: src/call-volume.c:ofono_call_volume_driver_register() driver:  =

0xdb9a8, name: hfpmode
m
ofonod[321]: src/handsfree.c:ofono_handsfree_driver_register() driver:  =

0xdb9ec, name: hfpmodem
ofonod[321]: src/network.c:ofono_netreg_driver_register() driver: 0xdb89c,  =

name: dunmodem
ofonod[321]: src/gprs.c:ofono_gprs_driver_register() driver: 0xdb8c0,  =

name: dunmodem
ofonod[321]: src/voicecall.c:ofono_voicecall_driver_register() driver:  =

0xdb7d8, name: stemodem
ofonod[321]: src/gprs.c:ofono_gprs_context_driver_register() driver:  =

0xdb860, name: stemodem
ofonod[321]: src/radio-settings.c:ofono_radio_settings_driver_register()  =

driver: 0xdb828, name: s
temodem
ofonod[321]: src/voicecall.c:ofono_voicecall_driver_register() driver:  =

0xdb6c8, name: ifxmodem
ofonod[321]: src/audio-settings.c:ofono_audio_settings_driver_register()  =

driver: 0xdb718, name: i
fxmodem
ofonod[321]: src/radio-settings.c:ofono_radio_settings_driver_register()  =

driver: 0xdb72c, name: i
fxmodem
ofonod[321]: src/gprs.c:ofono_gprs_context_driver_register() driver:  =

0xdb760, name: ifxmodem
ofonod[321]: src/stk.c:ofono_stk_driver_register() driver: 0xdb784, name:  =

ifxmodem
ofonod[321]: src/ctm.c:ofono_ctm_driver_register() driver: 0xdb7a4, name:  =

ifxmodem
ofonod[321]: src/gprs.c:ofono_gprs_context_driver_register() driver:  =

0xdb660, name: hsomodem
ofonod[321]: src/radio-settings.c:ofono_radio_settings_driver_register()  =

driver: 0xdb67c, name: h
somodem
ofonod[321]: src/gprs.c:ofono_gprs_context_driver_register() driver:  =

0xdb5e4, name: mbmmodem
ofonod[321]: src/stk.c:ofono_stk_driver_register() driver: 0xdb600, name:  =

mbmmodem
ofonod[321]:  =

src/location-reporting.c:ofono_location_reporting_driver_register()  =

driver: 0xdb620,
  name: mbmmodem
ofonod[321]: src/voicecall.c:ofono_voicecall_driver_register() driver:  =

0xdb54c, name: calypsomode
m
ofonod[321]: src/stk.c:ofono_stk_driver_register() driver: 0xdb59c, name:  =

calypsomodem
ofonod[321]: src/ussd.c:ofono_ussd_driver_register() driver: 0xdb45c,  =

name: huaweimodem
ofonod[321]: src/voicecall.c:ofono_voicecall_driver_register() driver:  =

0xdb470, name: huaweimodem
ofonod[321]: src/audio-settings.c:ofono_audio_settings_driver_register()  =

driver: 0xdb4c0, name: h
uaweimodem
ofonod[321]: src/radio-settings.c:ofono_radio_settings_driver_register()  =

driver: 0xdb4f0, name: h
uaweimodem
ofonod[321]: src/gprs.c:ofono_gprs_context_driver_register() driver:  =

0xdb4d4, name: huaweimodem
ofonod[321]: src/cdma-netreg.c:ofono_cdma_netreg_driver_register() driver:  =

0xdb51c, name: huaweim
odem
ofonod[321]: src/radio-settings.c:ofono_radio_settings_driver_register()  =

driver: 0xdb410, name: n
wmodem
ofonod[321]: src/voicecall.c:ofono_voicecall_driver_register() driver:  =

0xdb290, name: atmodem
ofonod[321]: src/modem.c:ofono_devinfo_driver_register() driver: 0xdb328,  =

name: atmodem
ofonod[321]: src/call-barring.c:ofono_call_barring_driver_register()  =

driver: 0xdb2e0, name: atmod
em
ofonod[321]: src/call-forwarding.c:ofono_call_forwarding_driver_register()  =

driver: 0xdb0a0, name:
  atmodem
ofonod[321]: src/call-meter.c:ofono_call_meter_driver_register() driver:  =

0xdb0e0, name: atmodem
ofonod[321]: src/call-settings.c:ofono_call_settings_driver_register()  =

driver: 0xdafec, name: atm
odem
ofonod[321]: src/phonebook.c:ofono_phonebook_driver_register() driver:  =

0xdb310, name: atmodem
ofonod[321]: src/ussd.c:ofono_ussd_driver_register() driver: 0xdb26c,  =

name: atmodem
ofonod[321]: src/sms.c:ofono_sms_driver_register() driver: 0xdb05c, name:  =

atmodem
ofonod[321]: src/sim.c:ofono_sim_driver_register() driver: 0xdb1ac, name:  =

atmodem
ofonod[321]: src/sim.c:ofono_sim_driver_register() driver: 0xdb1f4, name:  =

atmodem-noef
ofonod[321]: src/stk.c:ofono_stk_driver_register() driver: 0xdb244, name:  =

atmodem
ofonod[321]: src/network.c:ofono_netreg_driver_register() driver: 0xdb13c,  =

name: atmodem
ofonod[321]: src/cbs.c:ofono_cbs_driver_register() driver: 0xdb084, name:  =

atmodem
ofonod[321]: src/call-volume.c:ofono_call_volume_driver_register() driver:  =

0xdb354, name: atmodem
ofonod[321]: src/gprs.c:ofono_gprs_driver_register() driver: 0xdb384,  =

name: atmodem
ofonod[321]: src/gprs.c:ofono_gprs_context_driver_register() driver:  =

0xdb398, name: atmodem
ofonod[321]: src/sim-auth.c:ofono_sim_auth_driver_register() driver:  =

0xdb3b4, name: atmodem
ofonod[321]: src/gnss.c:ofono_gnss_driver_register() driver: 0xdb3d4,  =

name: atmodem
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdadd0,  =

name: u8500
ofonod[321]: src/modem.c:ofono_devinfo_driver_register() driver: 0xdadb4,  =

name: u8500
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdad6c,  =

name: n900
ofonod[321]: src/modem.c:ofono_modem_driver_register() driver: 0xdad24,  =

name: isiusb
ofonod[321]: src/modem.c:ofono_devinfo_driver_register() driver: 0xdaadc,  =

name: isimodem
ofonod[321]: src/phonebook.c:ofono_phonebook_driver_register() driver:  =

0xdaacc, name: isimodem
ofonod[321]: src/network.c:ofono_netreg_driver_register() driver: 0xdaaf8,  =

name: isimodem
ofonod[321]: src/voicecall.c:ofono_voicecall_driver_register() driver:  =

0xdab1c, name: isimodem
ofonod[321]: src/sms.c:ofono_sms_driver_register() driver: 0xdab64, name:  =

isimodem
ofonod[321]: src/cbs.c:ofono_cbs_driver_register() driver: 0xdab84, name:  =

isimodem
ofonod[321]: src/sim.c:ofono_sim_driver_register() driver: 0xdab98, name:  =

isimodem
ofonod[321]: src/ussd.c:ofono_ussd_driver_register() driver: 0xdabe0,  =

name: isimodem
ofonod[321]: src/call-forwarding.c:ofono_call_forwarding_driver_register()  =

driver: 0xdabf4, name:
  isimodem
ofonod[321]: src/call-settings.c:ofono_call_settings_driver_register()  =

driver: 0xdac14, name: isi
modem
ofonod[321]: src/call-barring.c:ofono_call_barring_driver_register()  =

driver: 0xdac44, name: isimo
dem
ofonod[321]: src/call-meter.c:ofono_call_meter_driver_register() driver:  =

0xdac5c, name: isimodem
ofonod[321]: src/radio-settings.c:ofono_radio_settings_driver_register()  =

driver: 0xdac84, name: i
simodem
ofonod[321]: src/gprs.c:ofono_gprs_driver_register() driver: 0xdaca8,  =

name: isimodem
ofonod[321]: src/gprs.c:ofono_gprs_context_driver_register() driver:  =

0xdacbc, name: isimodem
ofonod[321]: src/audio-settings.c:ofono_audio_settings_driver_register()  =

driver: 0xdacd0, name: i
simodem
ofonod[321]: src/sim.c:ofono_sim_driver_register() driver: 0xdacdc, name:  =

wgmodem2.5
ofonod[321]: plugins/udevng.c:udev_start()
ofonod[321]: plugins/udevng.c:enumerate_devices()
ofonod[321]: plugins/udevng.c:check_usb_device() MOSCHIP usb-ethernet  =

driver [9710:7830]
ofonod[321]: plugins/bluetooth.c:manager_properties_cb()
ofonod[321]: plugins/bluetooth.c:parse_adapters()
ofonod[321]: plugins/bluetooth.c:parse_adapters() Calling GetProperties on  =

/org/bluez/224/hci0
ofonod[321]: plugins/bluetooth.c:adapter_properties_cb()
ofonod[321]: plugins/bluetooth.c:parse_devices()
ofonod[321]: plugins/bluetooth.c:adapter_properties_cb() Adapter Address:  =

00:0C:76:D3:B9:3F, Path
: /org/bluez/224/hci0
ofonod[321]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[321]: plugins/udev.c:udev_event() subsystem tty add
ofonod[321]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[321]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[321]: plugins/udev.c:udev_event() subsystem tty add
ofonod[321]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[321]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[321]: plugins/udev.c:udev_event() subsystem tty add
ofonod[321]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[321]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[321]: plugins/udev.c:udev_event() subsystem tty add
ofonod[321]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[321]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[321]: plugins/udev.c:udev_event() subsystem tty add
ofonod[321]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[321]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[321]: plugins/udev.c:udev_event() subsystem tty add
ofonod[321]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[321]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[321]: plugins/udev.c:udev_event() subsystem tty add
ofonod[321]: src/modem.c:ofono_modem_create() name: (null), type: telit
ofonod[321]: src/modem.c:set_modem_property() modem 0xeab98 property Path
ofonod[321]: plugins/udev.c:add_modem()  =

/devices/platform/musb_hdrc/usb1/1-1/1-1.3/1-1.3:1.6/tty/
ttyACM3 (telit)
ofonod[321]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[321]: plugins/udevng.c:check_modem_list()


root(a)jc-dev:~# ./test/list-modems
root(a)jc-dev:~# ./test/enable-modem
Traceback (most recent call last):
   File "./test/enable-modem", line 14, in <module>
     path =3D modems[0][0]
IndexError: list index out of range


best regards
Jan
-- =

Tato zpr=C3=A1va byla vytvo=C5=99ena p=C5=99evratn=C3=BDm po=C5=A1tovn=C3=
=ADm klientem Opery:  =

http://www.opera.com/mail/

--===============1773517215188094237==--

