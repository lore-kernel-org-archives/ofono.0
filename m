Content-Type: multipart/mixed; boundary="===============7773008621979056424=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Add Support for Sierra MC73xx
Date: Fri, 29 Apr 2016 10:13:07 -0500
Message-ID: <57237A03.6000807@gmail.com>
In-Reply-To: <57235CE5.7070300@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7773008621979056424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 04/29/2016 08:08 AM, Martin Chaplet wrote:
> Hi everybody,
>
>
> I'm trying to use MC7304 chip with ofono (yes, exactly like Dirk Meul
> few months ago).
>
> It's a QMI-interfaced GSM.
> I've used Bj=C3=B8rn Mork's patches and with a little hack in setup_sierra
> (forcing qmi device name), the modem is "detected" and initialized.
> ... But the "gprs" feature is not detected !
>
> I'm a newbie on ofono project ... Can anyone can explain me how the
> features detection is done please ?
>
> FYI, Please find below ofono debug log :
>
>
> ofonod[1110]: src/modem.c:ofono_modem_create() name: (null), type: sierra
> ofonod[1110]: plugins/udevng.c:setup_sierra()
> /sys/devices/soc0/soc.0/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/1-1
> ofonod[1110]: plugins/udevng.c:setup_sierra() /dev/ttyUSB0 255/255/255
> 00 (null)
> ofonod[1110]: plugins/udevng.c:setup_sierra() /dev/ttyUSB1 255/0/0 02 (nu=
ll)
> ofonod[1110]: plugins/udevng.c:setup_sierra() /dev/ttyUSB2 255/0/0 03 (nu=
ll)
> ofonod[1110]: plugins/udevng.c:setup_sierra() wwan0 255/255/255 08 (null)
> ofonod[1110]: plugins/udevng.c:setup_sierra() wwan1 255/255/255 0a (null)
> ofonod[1110]: plugins/udevng.c:setup_sierra() wwan2 255/255/255 0b (null)

If this is a QMI card, then setup_sierra isn't the right place for this =

detection.  It should likely be setup_gobi.

> ofonod[1110]: src/modem.c:ofono_modem_set_driver() type: gobi
> ofonod[1110]: plugins/udevng.c:setup_sierra() modem=3D/dev/ttyUSB2
> app=3D(null) net=3Dwwan0 diag=3D/dev/ttyUSB0 qmi=3D/dev/cdc-wdm1
> ofonod[1110]: src/modem.c:set_modem_property() modem 0x20d4d28 property
> Device
> ofonod[1110]: src/modem.c:set_modem_property() modem 0x20d4d28 property
> Modem
> ofonod[1110]: src/modem.c:set_modem_property() modem 0x20d4d28 property A=
pp
> ofonod[1110]: src/modem.c:set_modem_property() modem 0x20d4d28 property D=
iag
> ofonod[1110]: src/modem.c:set_modem_property() modem 0x20d4d28 property
> NetworkInterface
> ofonod[1110]: src/modem.c:ofono_modem_register() 0x20d4d28
> ofonod[1110]: plugins/gobi.c:gobi_probe() 0x20d4d28
> ofonod[1110]: src/modem.c:emit_modem_added() 0x20d4d28
> ofonod[1110]: src/modem.c:call_modemwatches() 0x20d4d28 added:1
> ofonod[1110]: plugins/smart-messaging.c:modem_watch() modem: 0x20d4d28,
> added: 1
> ofonod[1110]: plugins/push-notification.c:modem_watch() modem:
> 0x20d4d28, added: 1
> ofonod[1110]: plugins/gobi.c:gobi_enable() 0x20d4d28
> ofonod[1110]: src/modem.c:get_modem_property() modem 0x20d4d28 property
> Device
> ofonod[1110]: plugins/gobi.c:discover_cb()
> ofonod[1110]: plugins/gobi.c:discover_cb() WDS 1.36
> ofonod[1110]: plugins/gobi.c:discover_cb() DMS 1.14
> ofonod[1110]: plugins/gobi.c:discover_cb() NAS 1.25
> ofonod[1110]: plugins/gobi.c:discover_cb() QOS 1.3
> ofonod[1110]: plugins/gobi.c:discover_cb() WMS 1.10
> ofonod[1110]: plugins/gobi.c:discover_cb() PDS 1.0
> ofonod[1110]: plugins/gobi.c:discover_cb() AUTH 1.2
> ofonod[1110]: plugins/gobi.c:discover_cb() AT 1.2
> ofonod[1110]: plugins/gobi.c:discover_cb() VOICE 2.1
> ofonod[1110]: plugins/gobi.c:discover_cb() CAT 2.16
> ofonod[1110]: plugins/gobi.c:discover_cb() UIM 1.25
> ofonod[1110]: plugins/gobi.c:discover_cb() PBM 1.4
> ofonod[1110]: plugins/gobi.c:discover_cb() SAR 1.0
> ofonod[1110]: plugins/gobi.c:discover_cb() (null) 1.0
> ofonod[1110]: plugins/gobi.c:discover_cb() TS 1.0
> ofonod[1110]: plugins/gobi.c:discover_cb() TMS 1.0
> ofonod[1110]: plugins/gobi.c:discover_cb() (null) 1.10
> ofonod[1110]: plugins/gobi.c:discover_cb() (null) 1.0
> ofonod[1110]: plugins/gobi.c:discover_cb() (null) 1.0
> ofonod[1110]: plugins/gobi.c:discover_cb() (null) 1.0
> ofonod[1110]: plugins/gobi.c:discover_cb() (null) 1.0
> ofonod[1110]: plugins/gobi.c:discover_cb() (null) 1.0
> ofonod[1110]: plugins/gobi.c:discover_cb() (null) 1.0
> ofonod[1110]: plugins/gobi.c:create_dms_cb()
> ofonod[1110]: plugins/gobi.c:get_caps_cb()
> ofonod[1110]: plugins/gobi.c:get_caps_cb() service capabilities 4
> ofonod[1110]: plugins/gobi.c:get_caps_cb() sim supported 2
> ofonod[1110]: plugins/gobi.c:get_caps_cb() radio =3D 4
> ofonod[1110]: plugins/gobi.c:get_caps_cb() radio =3D 5
> ofonod[1110]: plugins/gobi.c:get_caps_cb() radio =3D 8
> ofonod[1110]: plugins/gobi.c:get_oper_mode_cb()
> ofonod[1110]: src/modem.c:modem_change_state() old state: 0, new state: 1
> ofonod[1110]: plugins/gobi.c:gobi_pre_sim() 0x20d4d28
> ofonod[1110]: drivers/qmimodem/devinfo.c:qmi_devinfo_probe()
> ofonod[1110]: drivers/qmimodem/sim.c:qmi_sim_probe()
> ofonod[1110]: drivers/qmimodem/voicecall.c:qmi_voicecall_probe()
> ofonod[1110]:
> drivers/qmimodem/location-reporting.c:qmi_location_reporting_probe()
> ofonod[1110]: drivers/qmimodem/devinfo.c:create_dms_cb()
> ofonod[1110]: drivers/qmimodem/devinfo.c:qmi_query_manufacturer()
> ofonod[1110]: drivers/qmimodem/voicecall.c:create_voice_cb()
> ofonod[1110]: drivers/qmimodem/sim.c:create_uim_cb()
> ofonod[1110]: drivers/qmimodem/location-reporting.c:create_pds_cb()
> ofonod[1110]: drivers/qmimodem/devinfo.c:string_cb()
> ofonod[1110]: drivers/qmimodem/devinfo.c:qmi_query_model()
> ofonod[1110]: drivers/qmimodem/sim.c:event_registration_cb()
> ofonod[1110]: drivers/qmimodem/sim.c:event_registration_cb() event mask
> 0x0003
> ofonod[1110]: drivers/qmimodem/location-reporting.c:set_event_cb()
> ofonod[1110]: drivers/qmimodem/devinfo.c:string_cb()
> ofonod[1110]: drivers/qmimodem/devinfo.c:qmi_query_revision()
> ofonod[1110]: drivers/qmimodem/sim.c:get_card_status_cb()
> ofonod[1110]: src/sim.c:ofono_sim_add_state_watch() 0x20d9aa0
> ofonod[1110]: src/sim.c:ofono_sim_add_state_watch() 0x20d9aa0
> ofonod[1110]: src/sim.c:ofono_sim_add_state_watch() 0x20d9aa0
> ofonod[1110]: drivers/qmimodem/sim.c:get_card_status_cb()
> ofono_sim_register OK
> ofonod[1110]: drivers/qmimodem/sim.c:get_card_status_cb() exit func
> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_attributes() file id
> 0x6fb7 path len 0
> ofonod[1110]: drivers/qmimodem/devinfo.c:string_cb()
> ofonod[1110]: drivers/qmimodem/devinfo.c:qmi_query_serial()
> ofonod[1110]: drivers/qmimodem/sim.c:get_file_attributes_cb()
> ofonod[1110]: src/voicecall.c:ecc_g2_read_cb() 0
> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_attributes() file id
> 0x6fb7 path len 0
> ofonod[1110]: drivers/qmimodem/devinfo.c:get_ids_cb()
> ofonod[1110]: drivers/qmimodem/sim.c:get_file_attributes_cb()
> ofonod[1110]: src/voicecall.c:ecc_g3_read_cb() 0
> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_attributes() file id
> 0x2fe2 path len 0
> ofonod[1110]: drivers/qmimodem/sim.c:get_file_attributes_cb()
> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_transparent() file id
> 0x2fe2 path len 0
> ofonod[1110]: drivers/qmimodem/sim.c:read_generic_cb()
> ofonod[1110]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff:
> 0, tocopy: 10
> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_attributes() file id
> 0x6f05 path len 0
> ofonod[1110]: drivers/qmimodem/sim.c:get_file_attributes_cb()
> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_attributes() file id
> 0x2f05 path len 0
> ofonod[1110]: drivers/qmimodem/sim.c:get_file_attributes_cb()
> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_transparent() file id
> 0x2f05 path len 0
> ofonod[1110]: drivers/qmimodem/sim.c:read_generic_cb()
> ofonod[1110]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff:
> 0, tocopy: 10
> ofonod[1110]: drivers/qmimodem/sim.c:qmi_query_passwd_state() passwd stat=
e 0
> ofonod[1110]: src/sim.c:sim_pin_query_cb() sim->pin_type: 0, pin_type: 0
> ofonod[1110]: drivers/qmimodem/sim.c:qmi_query_pin_retries() passwd state=
 0
> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_attributes() file id
> 0x6fae path len 0
> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_attributes() file id
> 0x6fad path len 0
> ofonod[1110]: drivers/qmimodem/sim.c:get_file_attributes_cb()
> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_attributes() file id
> 0x6f16 path len 0
> ofonod[1110]: drivers/qmimodem/sim.c:get_file_attributes_cb()
> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_attributes() file id
> 0x6f38 path len 0
> ofonod[1110]: drivers/qmimodem/sim.c:get_file_attributes_cb()
> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_transparent() file id
> 0x6f07 path len 0
> ofonod[1110]: drivers/qmimodem/sim.c:read_generic_cb()
> ofonod[1110]: Unable to read IMSI, emergency calls only

Your modem doesn't seem to want to read anything from the SIM.  So that =

is why your gprs isn't showing up.

Do you have a SIM in there or a PIN set?

Regards,
-Denis

--===============7773008621979056424==--

