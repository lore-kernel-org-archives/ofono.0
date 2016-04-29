Content-Type: multipart/mixed; boundary="===============0456076396641135200=="
MIME-Version: 1.0
From: Martin Chaplet <m.chaplet@kerlink.fr>
Subject: Re: Add Support for Sierra MC73xx
Date: Fri, 29 Apr 2016 17:38:08 +0200
Message-ID: <57237FE0.2050701@kerlink.fr>
In-Reply-To: <57237A03.6000807@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0456076396641135200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thanks for your quick reply !

On 29/04/2016 17:13, Denis Kenzior wrote:
> Hi Martin,
>
> On 04/29/2016 08:08 AM, Martin Chaplet wrote:
>> Hi everybody,
>>
>>
>> I'm trying to use MC7304 chip with ofono (yes, exactly like Dirk Meul
>> few months ago).
>>
>> It's a QMI-interfaced GSM.
>> I've used Bj=C3=B8rn Mork's patches and with a little hack in setup_sier=
ra
>> (forcing qmi device name), the modem is "detected" and initialized.
>> ... But the "gprs" feature is not detected !
>>
>> I'm a newbie on ofono project ... Can anyone can explain me how the
>> features detection is done please ?
>>
>> FYI, Please find below ofono debug log :
>>
>>
>> ofonod[1110]: src/modem.c:ofono_modem_create() name: (null), type:
>> sierra
>> ofonod[1110]: plugins/udevng.c:setup_sierra()
>> /sys/devices/soc0/soc.0/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/1-1
>> ofonod[1110]: plugins/udevng.c:setup_sierra() /dev/ttyUSB0 255/255/255
>> 00 (null)
>> ofonod[1110]: plugins/udevng.c:setup_sierra() /dev/ttyUSB1 255/0/0 02
>> (null)
>> ofonod[1110]: plugins/udevng.c:setup_sierra() /dev/ttyUSB2 255/0/0 03
>> (null)
>> ofonod[1110]: plugins/udevng.c:setup_sierra() wwan0 255/255/255 08
>> (null)
>> ofonod[1110]: plugins/udevng.c:setup_sierra() wwan1 255/255/255 0a
>> (null)
>> ofonod[1110]: plugins/udevng.c:setup_sierra() wwan2 255/255/255 0b
>> (null)
>
> If this is a QMI card, then setup_sierra isn't the right place for
> this detection.  It should likely be setup_gobi.

Yes, you're right. It came from Bj=C3=B8rn Mork's patches who did this patc=
h :

https://lists.ofono.org/pipermail/ofono/2013-February/014239.html

The "gobi" driver is plugged "manually" by ofono_modem_set_driver function

This card is mainly QMI but also have Diag, NMEA and AT interfaces
(ttyUSB). I think that's why he did it in setup_sierra.


>
>> ofonod[1110]: src/modem.c:ofono_modem_set_driver() type: gobi
>> ofonod[1110]: plugins/udevng.c:setup_sierra() modem=3D/dev/ttyUSB2
>> app=3D(null) net=3Dwwan0 diag=3D/dev/ttyUSB0 qmi=3D/dev/cdc-wdm1
>> ofonod[1110]: src/modem.c:set_modem_property() modem 0x20d4d28 property
>> Device
>> ofonod[1110]: src/modem.c:set_modem_property() modem 0x20d4d28 property
>> Modem
>> ofonod[1110]: src/modem.c:set_modem_property() modem 0x20d4d28
>> property App
>> ofonod[1110]: src/modem.c:set_modem_property() modem 0x20d4d28
>> property Diag
>> ofonod[1110]: src/modem.c:set_modem_property() modem 0x20d4d28 property
>> NetworkInterface
>> ofonod[1110]: src/modem.c:ofono_modem_register() 0x20d4d28
>> ofonod[1110]: plugins/gobi.c:gobi_probe() 0x20d4d28
>> ofonod[1110]: src/modem.c:emit_modem_added() 0x20d4d28
>> ofonod[1110]: src/modem.c:call_modemwatches() 0x20d4d28 added:1
>> ofonod[1110]: plugins/smart-messaging.c:modem_watch() modem: 0x20d4d28,
>> added: 1
>> ofonod[1110]: plugins/push-notification.c:modem_watch() modem:
>> 0x20d4d28, added: 1
>> ofonod[1110]: plugins/gobi.c:gobi_enable() 0x20d4d28
>> ofonod[1110]: src/modem.c:get_modem_property() modem 0x20d4d28 property
>> Device
>> ofonod[1110]: plugins/gobi.c:discover_cb()
>> ofonod[1110]: plugins/gobi.c:discover_cb() WDS 1.36
>> ofonod[1110]: plugins/gobi.c:discover_cb() DMS 1.14
>> ofonod[1110]: plugins/gobi.c:discover_cb() NAS 1.25
>> ofonod[1110]: plugins/gobi.c:discover_cb() QOS 1.3
>> ofonod[1110]: plugins/gobi.c:discover_cb() WMS 1.10
>> ofonod[1110]: plugins/gobi.c:discover_cb() PDS 1.0
>> ofonod[1110]: plugins/gobi.c:discover_cb() AUTH 1.2
>> ofonod[1110]: plugins/gobi.c:discover_cb() AT 1.2
>> ofonod[1110]: plugins/gobi.c:discover_cb() VOICE 2.1
>> ofonod[1110]: plugins/gobi.c:discover_cb() CAT 2.16
>> ofonod[1110]: plugins/gobi.c:discover_cb() UIM 1.25
>> ofonod[1110]: plugins/gobi.c:discover_cb() PBM 1.4
>> ofonod[1110]: plugins/gobi.c:discover_cb() SAR 1.0
>> ofonod[1110]: plugins/gobi.c:discover_cb() (null) 1.0
>> ofonod[1110]: plugins/gobi.c:discover_cb() TS 1.0
>> ofonod[1110]: plugins/gobi.c:discover_cb() TMS 1.0
>> ofonod[1110]: plugins/gobi.c:discover_cb() (null) 1.10
>> ofonod[1110]: plugins/gobi.c:discover_cb() (null) 1.0
>> ofonod[1110]: plugins/gobi.c:discover_cb() (null) 1.0
>> ofonod[1110]: plugins/gobi.c:discover_cb() (null) 1.0
>> ofonod[1110]: plugins/gobi.c:discover_cb() (null) 1.0
>> ofonod[1110]: plugins/gobi.c:discover_cb() (null) 1.0
>> ofonod[1110]: plugins/gobi.c:discover_cb() (null) 1.0
>> ofonod[1110]: plugins/gobi.c:create_dms_cb()
>> ofonod[1110]: plugins/gobi.c:get_caps_cb()
>> ofonod[1110]: plugins/gobi.c:get_caps_cb() service capabilities 4
>> ofonod[1110]: plugins/gobi.c:get_caps_cb() sim supported 2
>> ofonod[1110]: plugins/gobi.c:get_caps_cb() radio =3D 4
>> ofonod[1110]: plugins/gobi.c:get_caps_cb() radio =3D 5
>> ofonod[1110]: plugins/gobi.c:get_caps_cb() radio =3D 8
>> ofonod[1110]: plugins/gobi.c:get_oper_mode_cb()
>> ofonod[1110]: src/modem.c:modem_change_state() old state: 0, new
>> state: 1
>> ofonod[1110]: plugins/gobi.c:gobi_pre_sim() 0x20d4d28
>> ofonod[1110]: drivers/qmimodem/devinfo.c:qmi_devinfo_probe()
>> ofonod[1110]: drivers/qmimodem/sim.c:qmi_sim_probe()
>> ofonod[1110]: drivers/qmimodem/voicecall.c:qmi_voicecall_probe()
>> ofonod[1110]:
>> drivers/qmimodem/location-reporting.c:qmi_location_reporting_probe()
>> ofonod[1110]: drivers/qmimodem/devinfo.c:create_dms_cb()
>> ofonod[1110]: drivers/qmimodem/devinfo.c:qmi_query_manufacturer()
>> ofonod[1110]: drivers/qmimodem/voicecall.c:create_voice_cb()
>> ofonod[1110]: drivers/qmimodem/sim.c:create_uim_cb()
>> ofonod[1110]: drivers/qmimodem/location-reporting.c:create_pds_cb()
>> ofonod[1110]: drivers/qmimodem/devinfo.c:string_cb()
>> ofonod[1110]: drivers/qmimodem/devinfo.c:qmi_query_model()
>> ofonod[1110]: drivers/qmimodem/sim.c:event_registration_cb()
>> ofonod[1110]: drivers/qmimodem/sim.c:event_registration_cb() event mask
>> 0x0003
>> ofonod[1110]: drivers/qmimodem/location-reporting.c:set_event_cb()
>> ofonod[1110]: drivers/qmimodem/devinfo.c:string_cb()
>> ofonod[1110]: drivers/qmimodem/devinfo.c:qmi_query_revision()
>> ofonod[1110]: drivers/qmimodem/sim.c:get_card_status_cb()
>> ofonod[1110]: src/sim.c:ofono_sim_add_state_watch() 0x20d9aa0
>> ofonod[1110]: src/sim.c:ofono_sim_add_state_watch() 0x20d9aa0
>> ofonod[1110]: src/sim.c:ofono_sim_add_state_watch() 0x20d9aa0
>> ofonod[1110]: drivers/qmimodem/sim.c:get_card_status_cb()
>> ofono_sim_register OK
>> ofonod[1110]: drivers/qmimodem/sim.c:get_card_status_cb() exit func
>> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_attributes() file id
>> 0x6fb7 path len 0
>> ofonod[1110]: drivers/qmimodem/devinfo.c:string_cb()
>> ofonod[1110]: drivers/qmimodem/devinfo.c:qmi_query_serial()
>> ofonod[1110]: drivers/qmimodem/sim.c:get_file_attributes_cb()
>> ofonod[1110]: src/voicecall.c:ecc_g2_read_cb() 0
>> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_attributes() file id
>> 0x6fb7 path len 0
>> ofonod[1110]: drivers/qmimodem/devinfo.c:get_ids_cb()
>> ofonod[1110]: drivers/qmimodem/sim.c:get_file_attributes_cb()
>> ofonod[1110]: src/voicecall.c:ecc_g3_read_cb() 0
>> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_attributes() file id
>> 0x2fe2 path len 0
>> ofonod[1110]: drivers/qmimodem/sim.c:get_file_attributes_cb()
>> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_transparent() file id
>> 0x2fe2 path len 0
>> ofonod[1110]: drivers/qmimodem/sim.c:read_generic_cb()
>> ofonod[1110]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff:
>> 0, tocopy: 10
>> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_attributes() file id
>> 0x6f05 path len 0
>> ofonod[1110]: drivers/qmimodem/sim.c:get_file_attributes_cb()
>> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_attributes() file id
>> 0x2f05 path len 0
>> ofonod[1110]: drivers/qmimodem/sim.c:get_file_attributes_cb()
>> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_transparent() file id
>> 0x2f05 path len 0
>> ofonod[1110]: drivers/qmimodem/sim.c:read_generic_cb()
>> ofonod[1110]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff:
>> 0, tocopy: 10
>> ofonod[1110]: drivers/qmimodem/sim.c:qmi_query_passwd_state() passwd
>> state 0
>> ofonod[1110]: src/sim.c:sim_pin_query_cb() sim->pin_type: 0, pin_type: 0
>> ofonod[1110]: drivers/qmimodem/sim.c:qmi_query_pin_retries() passwd
>> state 0
>> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_attributes() file id
>> 0x6fae path len 0
>> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_attributes() file id
>> 0x6fad path len 0
>> ofonod[1110]: drivers/qmimodem/sim.c:get_file_attributes_cb()
>> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_attributes() file id
>> 0x6f16 path len 0
>> ofonod[1110]: drivers/qmimodem/sim.c:get_file_attributes_cb()
>> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_attributes() file id
>> 0x6f38 path len 0
>> ofonod[1110]: drivers/qmimodem/sim.c:get_file_attributes_cb()
>> ofonod[1110]: drivers/qmimodem/sim.c:qmi_read_transparent() file id
>> 0x6f07 path len 0
>> ofonod[1110]: drivers/qmimodem/sim.c:read_generic_cb()
>> ofonod[1110]: Unable to read IMSI, emergency calls only
>
> Your modem doesn't seem to want to read anything from the SIM.  So
> that is why your gprs isn't showing up.
>
> Do you have a SIM in there or a PIN set?


OK, so I understand that Data feature is detected by scanning SIM
capabilities + chip capabilities (UMTS, LTE, ...)
Am I right ?

My SIM doesn't have PIN and I can use Standard QMI tools (libqmi) to
bring up a connection.
I will so investigate around SIM QMI requests / replies.

> Regards,
> -Denis
>
Thanks for your help,
Regards,

Martin

--===============0456076396641135200==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9d2lu
ZG93cy0xMjUyIgogICAgICBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiPgogIDwvaGVhZD4KICA8
Ym9keSBiZ2NvbG9yPSIjRkZGRkZGIiB0ZXh0PSIjMTA2ZjljIj4KICAgIDxmb250IGZhY2U9IkNh
bGlicmkiPkhpIERlbmlzLDxicj4KICAgICAgPGJyPgogICAgICBUaGFua3MgZm9yIHlvdXIgcXVp
Y2sgcmVwbHkgITxicj4KICAgIDwvZm9udD48YnI+CiAgICA8ZGl2IGNsYXNzPSJtb3otY2l0ZS1w
cmVmaXgiPk9uIDI5LzA0LzIwMTYgMTc6MTMsIERlbmlzIEtlbnppb3IKICAgICAgd3JvdGU6PGJy
PgogICAgPC9kaXY+CiAgICA8YmxvY2txdW90ZSBjaXRlPSJtaWQ6NTcyMzdBMDMuNjAwMDgwN0Bn
bWFpbC5jb20iIHR5cGU9ImNpdGUiPkhpCiAgICAgIE1hcnRpbiwKICAgICAgPGJyPgogICAgICA8
YnI+CiAgICAgIE9uIDA0LzI5LzIwMTYgMDg6MDggQU0sIE1hcnRpbiBDaGFwbGV0IHdyb3RlOgog
ICAgICA8YnI+CiAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPkhpIGV2ZXJ5Ym9keSwKICAg
ICAgICA8YnI+CiAgICAgICAgPGJyPgogICAgICAgIDxicj4KICAgICAgICBJJ20gdHJ5aW5nIHRv
IHVzZSBNQzczMDQgY2hpcCB3aXRoIG9mb25vICh5ZXMsIGV4YWN0bHkgbGlrZSBEaXJrCiAgICAg
ICAgTWV1bAogICAgICAgIDxicj4KICAgICAgICBmZXcgbW9udGhzIGFnbykuCiAgICAgICAgPGJy
PgogICAgICAgIDxicj4KICAgICAgICBJdCdzIGEgUU1JLWludGVyZmFjZWQgR1NNLgogICAgICAg
IDxicj4KICAgICAgICBJJ3ZlIHVzZWQgQmr4cm4gTW9yaydzIHBhdGNoZXMgYW5kIHdpdGggYSBs
aXR0bGUgaGFjayBpbgogICAgICAgIHNldHVwX3NpZXJyYQogICAgICAgIDxicj4KICAgICAgICAo
Zm9yY2luZyBxbWkgZGV2aWNlIG5hbWUpLCB0aGUgbW9kZW0gaXMgImRldGVjdGVkIiBhbmQKICAg
ICAgICBpbml0aWFsaXplZC4KICAgICAgICA8YnI+CiAgICAgICAgLi4uIEJ1dCB0aGUgImdwcnMi
IGZlYXR1cmUgaXMgbm90IGRldGVjdGVkICEKICAgICAgICA8YnI+CiAgICAgICAgPGJyPgogICAg
ICAgIEknbSBhIG5ld2JpZSBvbiBvZm9ubyBwcm9qZWN0IC4uLiBDYW4gYW55b25lIGNhbiBleHBs
YWluIG1lIGhvdwogICAgICAgIHRoZQogICAgICAgIDxicj4KICAgICAgICBmZWF0dXJlcyBkZXRl
Y3Rpb24gaXMgZG9uZSBwbGVhc2UgPwogICAgICAgIDxicj4KICAgICAgICA8YnI+CiAgICAgICAg
RllJLCBQbGVhc2UgZmluZCBiZWxvdyBvZm9ubyBkZWJ1ZyBsb2cgOgogICAgICAgIDxicj4KICAg
ICAgICA8YnI+CiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEwXTogc3JjL21vZGVtLmM6
b2Zvbm9fbW9kZW1fY3JlYXRlKCkgbmFtZTogKG51bGwpLAogICAgICAgIHR5cGU6IHNpZXJyYQog
ICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBf
c2llcnJhKCkKICAgICAgICA8YnI+Ci9zeXMvZGV2aWNlcy9zb2MwL3NvYy4wLzIxMDAwMDAuYWlw
cy1idXMvMjE4NDAwMC51c2IvY2lfaGRyYy4wL3VzYjEvMS0xCiAgICAgICAgPGJyPgogICAgICAg
IG9mb25vZFsxMTEwXTogcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9zaWVycmEoKSAvZGV2L3R0eVVT
QjAKICAgICAgICAyNTUvMjU1LzI1NQogICAgICAgIDxicj4KICAgICAgICAwMCAobnVsbCkKICAg
ICAgICA8YnI+CiAgICAgICAgb2Zvbm9kWzExMTBdOiBwbHVnaW5zL3VkZXZuZy5jOnNldHVwX3Np
ZXJyYSgpIC9kZXYvdHR5VVNCMQogICAgICAgIDI1NS8wLzAgMDIgKG51bGwpCiAgICAgICAgPGJy
PgogICAgICAgIG9mb25vZFsxMTEwXTogcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9zaWVycmEoKSAv
ZGV2L3R0eVVTQjIKICAgICAgICAyNTUvMC8wIDAzIChudWxsKQogICAgICAgIDxicj4KICAgICAg
ICBvZm9ub2RbMTExMF06IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfc2llcnJhKCkgd3dhbjAgMjU1
LzI1NS8yNTUKICAgICAgICAwOCAobnVsbCkKICAgICAgICA8YnI+CiAgICAgICAgb2Zvbm9kWzEx
MTBdOiBwbHVnaW5zL3VkZXZuZy5jOnNldHVwX3NpZXJyYSgpIHd3YW4xIDI1NS8yNTUvMjU1CiAg
ICAgICAgMGEgKG51bGwpCiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEwXTogcGx1Z2lu
cy91ZGV2bmcuYzpzZXR1cF9zaWVycmEoKSB3d2FuMiAyNTUvMjU1LzI1NQogICAgICAgIDBiIChu
dWxsKQogICAgICAgIDxicj4KICAgICAgPC9ibG9ja3F1b3RlPgogICAgICA8YnI+CiAgICAgIElm
IHRoaXMgaXMgYSBRTUkgY2FyZCwgdGhlbiBzZXR1cF9zaWVycmEgaXNuJ3QgdGhlIHJpZ2h0IHBs
YWNlIGZvcgogICAgICB0aGlzIGRldGVjdGlvbi6gIEl0IHNob3VsZCBsaWtlbHkgYmUgc2V0dXBf
Z29iaS4KICAgICAgPGJyPgogICAgPC9ibG9ja3F1b3RlPgogICAgPGJyPgogICAgWWVzLCB5b3Un
cmUgcmlnaHQuIEl0IGNhbWUgZnJvbSBCavhybiBNb3JrJ3MgcGF0Y2hlcyB3aG8gZGlkIHRoaXMK
ICAgIHBhdGNoIDo8YnI+CiAgICA8YnI+CiAgICA8YSBjbGFzcz0ibW96LXR4dC1saW5rLWZyZWV0
ZXh0IiBocmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9waXBlcm1haWwvb2Zvbm8vMjAxMy1G
ZWJydWFyeS8wMTQyMzkuaHRtbCI+aHR0cHM6Ly9saXN0cy5vZm9uby5vcmcvcGlwZXJtYWlsL29m
b25vLzIwMTMtRmVicnVhcnkvMDE0MjM5Lmh0bWw8L2E+PGJyPgogICAgPGJyPgogICAgVGhlICJn
b2JpIiBkcml2ZXIgaXMgcGx1Z2dlZCAibWFudWFsbHkiIGJ5IG9mb25vX21vZGVtX3NldF9kcml2
ZXIKICAgIGZ1bmN0aW9uPGJyPgogICAgPGJyPgogICAgVGhpcyBjYXJkIGlzIG1haW5seSBRTUkg
YnV0IGFsc28gaGF2ZSBEaWFnLCBOTUVBIGFuZCBBVCBpbnRlcmZhY2VzCiAgICAodHR5VVNCKS4g
SSB0aGluayB0aGF0J3Mgd2h5IGhlIGRpZCBpdCBpbiBzZXR1cF9zaWVycmEuPGJyPgogICAgPGJy
PgogICAgPGJyPgogICAgPGJsb2NrcXVvdGUgY2l0ZT0ibWlkOjU3MjM3QTAzLjYwMDA4MDdAZ21h
aWwuY29tIiB0eXBlPSJjaXRlIj4KICAgICAgPGJyPgogICAgICA8YmxvY2txdW90ZSB0eXBlPSJj
aXRlIj5vZm9ub2RbMTExMF06CiAgICAgICAgc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fc2V0X2Ry
aXZlcigpIHR5cGU6IGdvYmkKICAgICAgICA8YnI+CiAgICAgICAgb2Zvbm9kWzExMTBdOiBwbHVn
aW5zL3VkZXZuZy5jOnNldHVwX3NpZXJyYSgpIG1vZGVtPS9kZXYvdHR5VVNCMgogICAgICAgIDxi
cj4KICAgICAgICBhcHA9KG51bGwpIG5ldD13d2FuMCBkaWFnPS9kZXYvdHR5VVNCMCBxbWk9L2Rl
di9jZGMtd2RtMQogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IHNyYy9tb2RlbS5j
OnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4MjBkNGQyOAogICAgICAgIHByb3BlcnR5CiAg
ICAgICAgPGJyPgogICAgICAgIERldmljZQogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTEx
MF06IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4MjBkNGQyOAogICAg
ICAgIHByb3BlcnR5CiAgICAgICAgPGJyPgogICAgICAgIE1vZGVtCiAgICAgICAgPGJyPgogICAg
ICAgIG9mb25vZFsxMTEwXTogc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0g
MHgyMGQ0ZDI4CiAgICAgICAgcHJvcGVydHkgQXBwCiAgICAgICAgPGJyPgogICAgICAgIG9mb25v
ZFsxMTEwXTogc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHgyMGQ0ZDI4
CiAgICAgICAgcHJvcGVydHkgRGlhZwogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06
IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4MjBkNGQyOAogICAgICAg
IHByb3BlcnR5CiAgICAgICAgPGJyPgogICAgICAgIE5ldHdvcmtJbnRlcmZhY2UKICAgICAgICA8
YnI+CiAgICAgICAgb2Zvbm9kWzExMTBdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9yZWdpc3Rl
cigpIDB4MjBkNGQyOAogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IHBsdWdpbnMv
Z29iaS5jOmdvYmlfcHJvYmUoKSAweDIwZDRkMjgKICAgICAgICA8YnI+CiAgICAgICAgb2Zvbm9k
WzExMTBdOiBzcmMvbW9kZW0uYzplbWl0X21vZGVtX2FkZGVkKCkgMHgyMGQ0ZDI4CiAgICAgICAg
PGJyPgogICAgICAgIG9mb25vZFsxMTEwXTogc3JjL21vZGVtLmM6Y2FsbF9tb2RlbXdhdGNoZXMo
KSAweDIwZDRkMjggYWRkZWQ6MQogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IHBs
dWdpbnMvc21hcnQtbWVzc2FnaW5nLmM6bW9kZW1fd2F0Y2goKSBtb2RlbToKICAgICAgICAweDIw
ZDRkMjgsCiAgICAgICAgPGJyPgogICAgICAgIGFkZGVkOiAxCiAgICAgICAgPGJyPgogICAgICAg
IG9mb25vZFsxMTEwXTogcGx1Z2lucy9wdXNoLW5vdGlmaWNhdGlvbi5jOm1vZGVtX3dhdGNoKCkg
bW9kZW06CiAgICAgICAgPGJyPgogICAgICAgIDB4MjBkNGQyOCwgYWRkZWQ6IDEKICAgICAgICA8
YnI+CiAgICAgICAgb2Zvbm9kWzExMTBdOiBwbHVnaW5zL2dvYmkuYzpnb2JpX2VuYWJsZSgpIDB4
MjBkNGQyOAogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IHNyYy9tb2RlbS5jOmdl
dF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4MjBkNGQyOAogICAgICAgIHByb3BlcnR5CiAgICAg
ICAgPGJyPgogICAgICAgIERldmljZQogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06
IHBsdWdpbnMvZ29iaS5jOmRpc2NvdmVyX2NiKCkKICAgICAgICA8YnI+CiAgICAgICAgb2Zvbm9k
WzExMTBdOiBwbHVnaW5zL2dvYmkuYzpkaXNjb3Zlcl9jYigpIFdEUyAxLjM2CiAgICAgICAgPGJy
PgogICAgICAgIG9mb25vZFsxMTEwXTogcGx1Z2lucy9nb2JpLmM6ZGlzY292ZXJfY2IoKSBETVMg
MS4xNAogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IHBsdWdpbnMvZ29iaS5jOmRp
c2NvdmVyX2NiKCkgTkFTIDEuMjUKICAgICAgICA8YnI+CiAgICAgICAgb2Zvbm9kWzExMTBdOiBw
bHVnaW5zL2dvYmkuYzpkaXNjb3Zlcl9jYigpIFFPUyAxLjMKICAgICAgICA8YnI+CiAgICAgICAg
b2Zvbm9kWzExMTBdOiBwbHVnaW5zL2dvYmkuYzpkaXNjb3Zlcl9jYigpIFdNUyAxLjEwCiAgICAg
ICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEwXTogcGx1Z2lucy9nb2JpLmM6ZGlzY292ZXJfY2Io
KSBQRFMgMS4wCiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEwXTogcGx1Z2lucy9nb2Jp
LmM6ZGlzY292ZXJfY2IoKSBBVVRIIDEuMgogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTEx
MF06IHBsdWdpbnMvZ29iaS5jOmRpc2NvdmVyX2NiKCkgQVQgMS4yCiAgICAgICAgPGJyPgogICAg
ICAgIG9mb25vZFsxMTEwXTogcGx1Z2lucy9nb2JpLmM6ZGlzY292ZXJfY2IoKSBWT0lDRSAyLjEK
ICAgICAgICA8YnI+CiAgICAgICAgb2Zvbm9kWzExMTBdOiBwbHVnaW5zL2dvYmkuYzpkaXNjb3Zl
cl9jYigpIENBVCAyLjE2CiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEwXTogcGx1Z2lu
cy9nb2JpLmM6ZGlzY292ZXJfY2IoKSBVSU0gMS4yNQogICAgICAgIDxicj4KICAgICAgICBvZm9u
b2RbMTExMF06IHBsdWdpbnMvZ29iaS5jOmRpc2NvdmVyX2NiKCkgUEJNIDEuNAogICAgICAgIDxi
cj4KICAgICAgICBvZm9ub2RbMTExMF06IHBsdWdpbnMvZ29iaS5jOmRpc2NvdmVyX2NiKCkgU0FS
IDEuMAogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IHBsdWdpbnMvZ29iaS5jOmRp
c2NvdmVyX2NiKCkgKG51bGwpIDEuMAogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06
IHBsdWdpbnMvZ29iaS5jOmRpc2NvdmVyX2NiKCkgVFMgMS4wCiAgICAgICAgPGJyPgogICAgICAg
IG9mb25vZFsxMTEwXTogcGx1Z2lucy9nb2JpLmM6ZGlzY292ZXJfY2IoKSBUTVMgMS4wCiAgICAg
ICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEwXTogcGx1Z2lucy9nb2JpLmM6ZGlzY292ZXJfY2Io
KSAobnVsbCkgMS4xMAogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IHBsdWdpbnMv
Z29iaS5jOmRpc2NvdmVyX2NiKCkgKG51bGwpIDEuMAogICAgICAgIDxicj4KICAgICAgICBvZm9u
b2RbMTExMF06IHBsdWdpbnMvZ29iaS5jOmRpc2NvdmVyX2NiKCkgKG51bGwpIDEuMAogICAgICAg
IDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IHBsdWdpbnMvZ29iaS5jOmRpc2NvdmVyX2NiKCkg
KG51bGwpIDEuMAogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IHBsdWdpbnMvZ29i
aS5jOmRpc2NvdmVyX2NiKCkgKG51bGwpIDEuMAogICAgICAgIDxicj4KICAgICAgICBvZm9ub2Rb
MTExMF06IHBsdWdpbnMvZ29iaS5jOmRpc2NvdmVyX2NiKCkgKG51bGwpIDEuMAogICAgICAgIDxi
cj4KICAgICAgICBvZm9ub2RbMTExMF06IHBsdWdpbnMvZ29iaS5jOmRpc2NvdmVyX2NiKCkgKG51
bGwpIDEuMAogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IHBsdWdpbnMvZ29iaS5j
OmNyZWF0ZV9kbXNfY2IoKQogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IHBsdWdp
bnMvZ29iaS5jOmdldF9jYXBzX2NiKCkKICAgICAgICA8YnI+CiAgICAgICAgb2Zvbm9kWzExMTBd
OiBwbHVnaW5zL2dvYmkuYzpnZXRfY2Fwc19jYigpIHNlcnZpY2UgY2FwYWJpbGl0aWVzCiAgICAg
ICAgNAogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IHBsdWdpbnMvZ29iaS5jOmdl
dF9jYXBzX2NiKCkgc2ltIHN1cHBvcnRlZCAyCiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsx
MTEwXTogcGx1Z2lucy9nb2JpLmM6Z2V0X2NhcHNfY2IoKSByYWRpbyA9IDQKICAgICAgICA8YnI+
CiAgICAgICAgb2Zvbm9kWzExMTBdOiBwbHVnaW5zL2dvYmkuYzpnZXRfY2Fwc19jYigpIHJhZGlv
ID0gNQogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IHBsdWdpbnMvZ29iaS5jOmdl
dF9jYXBzX2NiKCkgcmFkaW8gPSA4CiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEwXTog
cGx1Z2lucy9nb2JpLmM6Z2V0X29wZXJfbW9kZV9jYigpCiAgICAgICAgPGJyPgogICAgICAgIG9m
b25vZFsxMTEwXTogc3JjL21vZGVtLmM6bW9kZW1fY2hhbmdlX3N0YXRlKCkgb2xkIHN0YXRlOiAw
LCBuZXcKICAgICAgICBzdGF0ZTogMQogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06
IHBsdWdpbnMvZ29iaS5jOmdvYmlfcHJlX3NpbSgpIDB4MjBkNGQyOAogICAgICAgIDxicj4KICAg
ICAgICBvZm9ub2RbMTExMF06IGRyaXZlcnMvcW1pbW9kZW0vZGV2aW5mby5jOnFtaV9kZXZpbmZv
X3Byb2JlKCkKICAgICAgICA8YnI+CiAgICAgICAgb2Zvbm9kWzExMTBdOiBkcml2ZXJzL3FtaW1v
ZGVtL3NpbS5jOnFtaV9zaW1fcHJvYmUoKQogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTEx
MF06IGRyaXZlcnMvcW1pbW9kZW0vdm9pY2VjYWxsLmM6cW1pX3ZvaWNlY2FsbF9wcm9iZSgpCiAg
ICAgICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEwXToKICAgICAgICA8YnI+CmRyaXZlcnMvcW1p
bW9kZW0vbG9jYXRpb24tcmVwb3J0aW5nLmM6cW1pX2xvY2F0aW9uX3JlcG9ydGluZ19wcm9iZSgp
CiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEwXTogZHJpdmVycy9xbWltb2RlbS9kZXZp
bmZvLmM6Y3JlYXRlX2Rtc19jYigpCiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEwXToK
ICAgICAgICBkcml2ZXJzL3FtaW1vZGVtL2RldmluZm8uYzpxbWlfcXVlcnlfbWFudWZhY3R1cmVy
KCkKICAgICAgICA8YnI+CiAgICAgICAgb2Zvbm9kWzExMTBdOiBkcml2ZXJzL3FtaW1vZGVtL3Zv
aWNlY2FsbC5jOmNyZWF0ZV92b2ljZV9jYigpCiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsx
MTEwXTogZHJpdmVycy9xbWltb2RlbS9zaW0uYzpjcmVhdGVfdWltX2NiKCkKICAgICAgICA8YnI+
CiAgICAgICAgb2Zvbm9kWzExMTBdOgogICAgICAgIGRyaXZlcnMvcW1pbW9kZW0vbG9jYXRpb24t
cmVwb3J0aW5nLmM6Y3JlYXRlX3Bkc19jYigpCiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsx
MTEwXTogZHJpdmVycy9xbWltb2RlbS9kZXZpbmZvLmM6c3RyaW5nX2NiKCkKICAgICAgICA8YnI+
CiAgICAgICAgb2Zvbm9kWzExMTBdOiBkcml2ZXJzL3FtaW1vZGVtL2RldmluZm8uYzpxbWlfcXVl
cnlfbW9kZWwoKQogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IGRyaXZlcnMvcW1p
bW9kZW0vc2ltLmM6ZXZlbnRfcmVnaXN0cmF0aW9uX2NiKCkKICAgICAgICA8YnI+CiAgICAgICAg
b2Zvbm9kWzExMTBdOiBkcml2ZXJzL3FtaW1vZGVtL3NpbS5jOmV2ZW50X3JlZ2lzdHJhdGlvbl9j
YigpCiAgICAgICAgZXZlbnQgbWFzawogICAgICAgIDxicj4KICAgICAgICAweDAwMDMKICAgICAg
ICA8YnI+CiAgICAgICAgb2Zvbm9kWzExMTBdOgogICAgICAgIGRyaXZlcnMvcW1pbW9kZW0vbG9j
YXRpb24tcmVwb3J0aW5nLmM6c2V0X2V2ZW50X2NiKCkKICAgICAgICA8YnI+CiAgICAgICAgb2Zv
bm9kWzExMTBdOiBkcml2ZXJzL3FtaW1vZGVtL2RldmluZm8uYzpzdHJpbmdfY2IoKQogICAgICAg
IDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IGRyaXZlcnMvcW1pbW9kZW0vZGV2aW5mby5jOnFt
aV9xdWVyeV9yZXZpc2lvbigpCiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEwXTogZHJp
dmVycy9xbWltb2RlbS9zaW0uYzpnZXRfY2FyZF9zdGF0dXNfY2IoKQogICAgICAgIDxicj4KICAg
ICAgICBvZm9ub2RbMTExMF06IHNyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3N0YXRlX3dhdGNoKCkg
MHgyMGQ5YWEwCiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEwXTogc3JjL3NpbS5jOm9m
b25vX3NpbV9hZGRfc3RhdGVfd2F0Y2goKSAweDIwZDlhYTAKICAgICAgICA8YnI+CiAgICAgICAg
b2Zvbm9kWzExMTBdOiBzcmMvc2ltLmM6b2Zvbm9fc2ltX2FkZF9zdGF0ZV93YXRjaCgpIDB4MjBk
OWFhMAogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IGRyaXZlcnMvcW1pbW9kZW0v
c2ltLmM6Z2V0X2NhcmRfc3RhdHVzX2NiKCkKICAgICAgICA8YnI+CiAgICAgICAgb2Zvbm9fc2lt
X3JlZ2lzdGVyIE9LCiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEwXTogZHJpdmVycy9x
bWltb2RlbS9zaW0uYzpnZXRfY2FyZF9zdGF0dXNfY2IoKSBleGl0CiAgICAgICAgZnVuYwogICAg
ICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IGRyaXZlcnMvcW1pbW9kZW0vc2ltLmM6cW1p
X3JlYWRfYXR0cmlidXRlcygpIGZpbGUKICAgICAgICBpZAogICAgICAgIDxicj4KICAgICAgICAw
eDZmYjcgcGF0aCBsZW4gMAogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IGRyaXZl
cnMvcW1pbW9kZW0vZGV2aW5mby5jOnN0cmluZ19jYigpCiAgICAgICAgPGJyPgogICAgICAgIG9m
b25vZFsxMTEwXTogZHJpdmVycy9xbWltb2RlbS9kZXZpbmZvLmM6cW1pX3F1ZXJ5X3NlcmlhbCgp
CiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEwXTogZHJpdmVycy9xbWltb2RlbS9zaW0u
YzpnZXRfZmlsZV9hdHRyaWJ1dGVzX2NiKCkKICAgICAgICA8YnI+CiAgICAgICAgb2Zvbm9kWzEx
MTBdOiBzcmMvdm9pY2VjYWxsLmM6ZWNjX2cyX3JlYWRfY2IoKSAwCiAgICAgICAgPGJyPgogICAg
ICAgIG9mb25vZFsxMTEwXTogZHJpdmVycy9xbWltb2RlbS9zaW0uYzpxbWlfcmVhZF9hdHRyaWJ1
dGVzKCkgZmlsZQogICAgICAgIGlkCiAgICAgICAgPGJyPgogICAgICAgIDB4NmZiNyBwYXRoIGxl
biAwCiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEwXTogZHJpdmVycy9xbWltb2RlbS9k
ZXZpbmZvLmM6Z2V0X2lkc19jYigpCiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEwXTog
ZHJpdmVycy9xbWltb2RlbS9zaW0uYzpnZXRfZmlsZV9hdHRyaWJ1dGVzX2NiKCkKICAgICAgICA8
YnI+CiAgICAgICAgb2Zvbm9kWzExMTBdOiBzcmMvdm9pY2VjYWxsLmM6ZWNjX2czX3JlYWRfY2Io
KSAwCiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEwXTogZHJpdmVycy9xbWltb2RlbS9z
aW0uYzpxbWlfcmVhZF9hdHRyaWJ1dGVzKCkgZmlsZQogICAgICAgIGlkCiAgICAgICAgPGJyPgog
ICAgICAgIDB4MmZlMiBwYXRoIGxlbiAwCiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEw
XTogZHJpdmVycy9xbWltb2RlbS9zaW0uYzpnZXRfZmlsZV9hdHRyaWJ1dGVzX2NiKCkKICAgICAg
ICA8YnI+CiAgICAgICAgb2Zvbm9kWzExMTBdOiBkcml2ZXJzL3FtaW1vZGVtL3NpbS5jOnFtaV9y
ZWFkX3RyYW5zcGFyZW50KCkgZmlsZQogICAgICAgIGlkCiAgICAgICAgPGJyPgogICAgICAgIDB4
MmZlMiBwYXRoIGxlbiAwCiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsxMTEwXTogZHJpdmVy
cy9xbWltb2RlbS9zaW0uYzpyZWFkX2dlbmVyaWNfY2IoKQogICAgICAgIDxicj4KICAgICAgICBv
Zm9ub2RbMTExMF06IHNyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrX2NiKCkgYnVmb2Zm
OiAwLAogICAgICAgIGRhdGFvZmY6CiAgICAgICAgPGJyPgogICAgICAgIDAsIHRvY29weTogMTAK
ICAgICAgICA8YnI+CiAgICAgICAgb2Zvbm9kWzExMTBdOiBkcml2ZXJzL3FtaW1vZGVtL3NpbS5j
OnFtaV9yZWFkX2F0dHJpYnV0ZXMoKSBmaWxlCiAgICAgICAgaWQKICAgICAgICA8YnI+CiAgICAg
ICAgMHg2ZjA1IHBhdGggbGVuIDAKICAgICAgICA8YnI+CiAgICAgICAgb2Zvbm9kWzExMTBdOiBk
cml2ZXJzL3FtaW1vZGVtL3NpbS5jOmdldF9maWxlX2F0dHJpYnV0ZXNfY2IoKQogICAgICAgIDxi
cj4KICAgICAgICBvZm9ub2RbMTExMF06IGRyaXZlcnMvcW1pbW9kZW0vc2ltLmM6cW1pX3JlYWRf
YXR0cmlidXRlcygpIGZpbGUKICAgICAgICBpZAogICAgICAgIDxicj4KICAgICAgICAweDJmMDUg
cGF0aCBsZW4gMAogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IGRyaXZlcnMvcW1p
bW9kZW0vc2ltLmM6Z2V0X2ZpbGVfYXR0cmlidXRlc19jYigpCiAgICAgICAgPGJyPgogICAgICAg
IG9mb25vZFsxMTEwXTogZHJpdmVycy9xbWltb2RlbS9zaW0uYzpxbWlfcmVhZF90cmFuc3BhcmVu
dCgpIGZpbGUKICAgICAgICBpZAogICAgICAgIDxicj4KICAgICAgICAweDJmMDUgcGF0aCBsZW4g
MAogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IGRyaXZlcnMvcW1pbW9kZW0vc2lt
LmM6cmVhZF9nZW5lcmljX2NiKCkKICAgICAgICA8YnI+CiAgICAgICAgb2Zvbm9kWzExMTBdOiBz
cmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9mZjogMCwKICAgICAgICBk
YXRhb2ZmOgogICAgICAgIDxicj4KICAgICAgICAwLCB0b2NvcHk6IDEwCiAgICAgICAgPGJyPgog
ICAgICAgIG9mb25vZFsxMTEwXTogZHJpdmVycy9xbWltb2RlbS9zaW0uYzpxbWlfcXVlcnlfcGFz
c3dkX3N0YXRlKCkKICAgICAgICBwYXNzd2Qgc3RhdGUgMAogICAgICAgIDxicj4KICAgICAgICBv
Zm9ub2RbMTExMF06IHNyYy9zaW0uYzpzaW1fcGluX3F1ZXJ5X2NiKCkgc2ltLSZndDtwaW5fdHlw
ZTogMCwKICAgICAgICBwaW5fdHlwZTogMAogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTEx
MF06IGRyaXZlcnMvcW1pbW9kZW0vc2ltLmM6cW1pX3F1ZXJ5X3Bpbl9yZXRyaWVzKCkKICAgICAg
ICBwYXNzd2Qgc3RhdGUgMAogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IGRyaXZl
cnMvcW1pbW9kZW0vc2ltLmM6cW1pX3JlYWRfYXR0cmlidXRlcygpIGZpbGUKICAgICAgICBpZAog
ICAgICAgIDxicj4KICAgICAgICAweDZmYWUgcGF0aCBsZW4gMAogICAgICAgIDxicj4KICAgICAg
ICBvZm9ub2RbMTExMF06IGRyaXZlcnMvcW1pbW9kZW0vc2ltLmM6cW1pX3JlYWRfYXR0cmlidXRl
cygpIGZpbGUKICAgICAgICBpZAogICAgICAgIDxicj4KICAgICAgICAweDZmYWQgcGF0aCBsZW4g
MAogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IGRyaXZlcnMvcW1pbW9kZW0vc2lt
LmM6Z2V0X2ZpbGVfYXR0cmlidXRlc19jYigpCiAgICAgICAgPGJyPgogICAgICAgIG9mb25vZFsx
MTEwXTogZHJpdmVycy9xbWltb2RlbS9zaW0uYzpxbWlfcmVhZF9hdHRyaWJ1dGVzKCkgZmlsZQog
ICAgICAgIGlkCiAgICAgICAgPGJyPgogICAgICAgIDB4NmYxNiBwYXRoIGxlbiAwCiAgICAgICAg
PGJyPgogICAgICAgIG9mb25vZFsxMTEwXTogZHJpdmVycy9xbWltb2RlbS9zaW0uYzpnZXRfZmls
ZV9hdHRyaWJ1dGVzX2NiKCkKICAgICAgICA8YnI+CiAgICAgICAgb2Zvbm9kWzExMTBdOiBkcml2
ZXJzL3FtaW1vZGVtL3NpbS5jOnFtaV9yZWFkX2F0dHJpYnV0ZXMoKSBmaWxlCiAgICAgICAgaWQK
ICAgICAgICA8YnI+CiAgICAgICAgMHg2ZjM4IHBhdGggbGVuIDAKICAgICAgICA8YnI+CiAgICAg
ICAgb2Zvbm9kWzExMTBdOiBkcml2ZXJzL3FtaW1vZGVtL3NpbS5jOmdldF9maWxlX2F0dHJpYnV0
ZXNfY2IoKQogICAgICAgIDxicj4KICAgICAgICBvZm9ub2RbMTExMF06IGRyaXZlcnMvcW1pbW9k
ZW0vc2ltLmM6cW1pX3JlYWRfdHJhbnNwYXJlbnQoKSBmaWxlCiAgICAgICAgaWQKICAgICAgICA8
YnI+CiAgICAgICAgMHg2ZjA3IHBhdGggbGVuIDAKICAgICAgICA8YnI+CiAgICAgICAgb2Zvbm9k
WzExMTBdOiBkcml2ZXJzL3FtaW1vZGVtL3NpbS5jOnJlYWRfZ2VuZXJpY19jYigpCiAgICAgICAg
PGJyPgogICAgICAgIG9mb25vZFsxMTEwXTogVW5hYmxlIHRvIHJlYWQgSU1TSSwgZW1lcmdlbmN5
IGNhbGxzIG9ubHkKICAgICAgICA8YnI+CiAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgPGJyPgog
ICAgICBZb3VyIG1vZGVtIGRvZXNuJ3Qgc2VlbSB0byB3YW50IHRvIHJlYWQgYW55dGhpbmcgZnJv
bSB0aGUgU0lNLqAgU28KICAgICAgdGhhdCBpcyB3aHkgeW91ciBncHJzIGlzbid0IHNob3dpbmcg
dXAuCiAgICAgIDxicj4KICAgICAgPGJyPgogICAgICBEbyB5b3UgaGF2ZSBhIFNJTSBpbiB0aGVy
ZSBvciBhIFBJTiBzZXQ/CiAgICAgIDxicj4KICAgIDwvYmxvY2txdW90ZT4KICAgIDxicj4KICAg
IDxicj4KICAgIE9LLCBzbyBJIHVuZGVyc3RhbmQgdGhhdCBEYXRhIGZlYXR1cmUgaXMgZGV0ZWN0
ZWQgYnkgc2Nhbm5pbmcgU0lNCiAgICBjYXBhYmlsaXRpZXMgKyBjaGlwIGNhcGFiaWxpdGllcyAo
VU1UUywgTFRFLCAuLi4pPGJyPgogICAgQW0gSSByaWdodCA/PGJyPgogICAgPGJyPgogICAgTXkg
U0lNIGRvZXNuJ3QgaGF2ZSBQSU4gYW5kIEkgY2FuIHVzZSBTdGFuZGFyZCBRTUkgdG9vbHMgKGxp
YnFtaSkgdG8KICAgIGJyaW5nIHVwIGEgY29ubmVjdGlvbi48YnI+CiAgICBJIHdpbGwgc28gaW52
ZXN0aWdhdGUgYXJvdW5kIFNJTSBRTUkgcmVxdWVzdHMgLyByZXBsaWVzLjxicj4KICAgIDxicj4K
ICAgIDxibG9ja3F1b3RlIGNpdGU9Im1pZDo1NzIzN0EwMy42MDAwODA3QGdtYWlsLmNvbSIgdHlw
ZT0iY2l0ZSI+UmVnYXJkcywKICAgICAgPGJyPgogICAgICAtRGVuaXMKICAgICAgPGJyPgogICAg
ICA8YnI+CiAgICA8L2Jsb2NrcXVvdGU+CiAgICBUaGFua3MgZm9yIHlvdXIgaGVscCw8YnI+CiAg
ICBSZWdhcmRzLDxicj4KICAgIDxicj4KICAgIE1hcnRpbjxicj4KICA8L2JvZHk+CjwvaHRtbD4K

--===============0456076396641135200==--

