Content-Type: multipart/mixed; boundary="===============0773353558244056126=="
MIME-Version: 1.0
From: =?unknown-8bit?b?6buE5Y+26Z2S?= <hyqzyf@163.com>
Subject: Re:Re: ppp problem
Date: Wed, 26 Jan 2011 09:30:07 +0800
Message-ID: <13c8c90.780f.12dbff12443.Coremail.hyqzyf@163.com>
In-Reply-To: <1295866577.2676.21.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0773353558244056126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

Thanks for reply. Maybe I have a step abnormal not reported.  Command
"AT+CGDATA=3D\"PPP\",%u" is not responded correctly. That is, the first
parameter of at_cgdata_cb is not ture. but I just ignored it, and go
 to setup_ppp(gc) forcibly. Can you please give me any advice. Your
 reply is appreciated.




At 2011-01-24 18:56:17=EF=BC=8C"Marcel Holtmann" <marcel@holtmann.org> wr=
ote:

>Hi,
>
>> I have got a problem about 3G connectrion from ofono, does anyone have
>> idea to resolve it? =

>> The  modem is huawei EM560. =

>> =

>> Here is the log:
>> =

>> ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property
>> Path
>> ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property
>> Registered
>> ofonod[940]:
>> plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:00.7/usb1/1-1/1-1=
.2/1-1.2:2.1/tty/ttyACM0 (huawei)
>> ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property
>> ModemRegistered
>> ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property
>> PcuiRegistered
>> ofonod[940]: plugins/udev.c:add_huawei() add_huaweiingggggggggg by hyq
>> ofonod[940]: plugins/udev.c:add_huawei() name =3DOFONO_HUAWEI_TYPE by
>> hyq
>> ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property
>> Modem
>> ofonod[940]: src/modem.c:set_modem_property() m odem 0x8d49058
>> property ModemRegistered
>> ofonod[940]: plugins/udev.c:add_huawei() after ofono_modem_register by
>> hyq ppp=3D1 pcui=3D0
>> ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property
>> Path
>> ofonod[940]:
>> plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:00.7/usb1/1-1/1-1=
.2/1-1.2:2.3/tty/ttyACM1 (huawei)
>> ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property
>> ModemRegistered
>> ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property
>> PcuiRegistered
>> ofonod[940]: plugins/udev.c:add_huawei() add_huaweiingggggggggg by hyq
>> ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property
>> HasVoice
>> ofonod[940]: plugins/udev.c:add_huawei() after ofono_modem_register by
>> hyq ppp=3D1 pcui=3D0
>> ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property
>> Path
>> ofonod[940]:
>> plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:00.7/usb1/1-1/1-1=
.2/1-1.2:2.7/tty/ttyACM2 (huawei)
>> ofonod[940]: src/modem.c:g et_modem_property() modem 0x8d49058
>> property ModemRegistered
>> ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property
>> PcuiRegistered
>> ofonod[940]: plugins/udev.c:add_huawei() name =3DOFONO_HUAWEI_TYPE by
>> hyq
>> ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property
>> Pcui
>> ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property
>> PcuiRegistered
>> =

>> [root(a)localhost test]# ./activate-context =

>> Entering new phase: 1
>> Entering new phase: 3
>> Entering new phase: 4
>> ofonod[815]: drivers/atmodem/gprs-context.c:ppp_connect() =

>> ofonod[815]: IP: 0.0.0.0
>> ofonod[815]: DNS: 0.0.0.0, 0.0.0.0
>> ofonod[815]: src/gprs.c:pri_activate_callback() 0xa063660 ppp0
>
>no idea what goes wrong here, but the network or your modem firmware
>basically tells you that the IP address is not set.
>
>Run with OFONO_PPP_DEBUG=3D1 and see if it gives you more details.
>
>Regards
>
>Marcel
>
>
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

--===============0773353558244056126==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHByZT5IaSBBbGwsPGJyPjxicj5UaGFua3MgZm9yIHJlcGx5LiBNYXliZSBJIGhhdmUgYSBzdGVw
IGFibm9ybWFsIG5vdCByZXBvcnRlZC4gIENvbW1hbmQ8YnI+IkFUK0NHREFUQT1cIlBQUFwiLCV1
IiBpcyBub3QgcmVzcG9uZGVkIGNvcnJlY3RseS4gVGhhdCBpcywgdGhlIGZpcnN0PGJyPnBhcmFt
ZXRlciBvZiBhdF9jZ2RhdGFfY2IgaXMgbm90IHR1cmUuIGJ1dCBJIGp1c3QgaWdub3JlZCBpdCwg
YW5kIGdvPGJyPiB0byBzZXR1cF9wcHAoZ2MpIGZvcmNpYmx5LiBDYW4geW91IHBsZWFzZSBnaXZl
IG1lIGFueSBhZHZpY2UuIFlvdXI8YnI+IHJlcGx5IGlzIGFwcHJlY2lhdGVkLjxicj48L3ByZT48
ZGl2PjwvZGl2Pjxicj48cHJlPjxicj5BdCZuYnNwOzIwMTEtMDEtMjQmbmJzcDsxODo1NjoxN6Os
Ik1hcmNlbCZuYnNwO0hvbHRtYW5uIiZuYnNwOyZsdDttYXJjZWxAaG9sdG1hbm4ub3JnJmd0OyZu
YnNwO3dyb3RlOgoKJmd0O0hpLAomZ3Q7CiZndDsmZ3Q7Jm5ic3A7SSZuYnNwO2hhdmUmbmJzcDtn
b3QmbmJzcDthJm5ic3A7cHJvYmxlbSZuYnNwO2Fib3V0Jm5ic3A7M0cmbmJzcDtjb25uZWN0cmlv
biZuYnNwO2Zyb20mbmJzcDtvZm9ubywmbmJzcDtkb2VzJm5ic3A7YW55b25lJm5ic3A7aGF2ZQom
Z3Q7Jmd0OyZuYnNwO2lkZWEmbmJzcDt0byZuYnNwO3Jlc29sdmUmbmJzcDtpdD8mbmJzcDsKJmd0
OyZndDsmbmJzcDtUaGUmbmJzcDsmbmJzcDttb2RlbSZuYnNwO2lzJm5ic3A7aHVhd2VpJm5ic3A7
RU01NjAuJm5ic3A7CiZndDsmZ3Q7Jm5ic3A7CiZndDsmZ3Q7Jm5ic3A7SGVyZSZuYnNwO2lzJm5i
c3A7dGhlJm5ic3A7bG9nOgomZ3Q7Jmd0OyZuYnNwOwomZ3Q7Jmd0OyZuYnNwO29mb25vZFs5NDBd
OiZuYnNwO3NyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpJm5ic3A7bW9kZW0mbmJzcDsw
eDhkNDkwNTgmbmJzcDtwcm9wZXJ0eQomZ3Q7Jmd0OyZuYnNwO1BhdGgKJmd0OyZndDsmbmJzcDtv
Zm9ub2RbOTQwXTombmJzcDtzcmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSZuYnNwO21v
ZGVtJm5ic3A7MHg4ZDQ5MDU4Jm5ic3A7cHJvcGVydHkKJmd0OyZndDsmbmJzcDtSZWdpc3RlcmVk
CiZndDsmZ3Q7Jm5ic3A7b2Zvbm9kWzk0MF06CiZndDsmZ3Q7Jm5ic3A7cGx1Z2lucy91ZGV2LmM6
YWRkX21vZGVtKCkmbmJzcDsvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MDAuNy91c2IxLzEt
MS8xLTEuMi8xLTEuMjoyLjEvdHR5L3R0eUFDTTAmbmJzcDsoaHVhd2VpKQomZ3Q7Jmd0OyZuYnNw
O29mb25vZFs5NDBdOiZuYnNwO3NyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpJm5ic3A7
bW9kZW0mbmJzcDsweDhkNDkwNTgmbmJzcDtwcm9wZXJ0eQomZ3Q7Jmd0OyZuYnNwO01vZGVtUmVn
aXN0ZXJlZAomZ3Q7Jmd0OyZuYnNwO29mb25vZFs5NDBdOiZuYnNwO3NyYy9tb2RlbS5jOmdldF9t
b2RlbV9wcm9wZXJ0eSgpJm5ic3A7bW9kZW0mbmJzcDsweDhkNDkwNTgmbmJzcDtwcm9wZXJ0eQom
Z3Q7Jmd0OyZuYnNwO1BjdWlSZWdpc3RlcmVkCiZndDsmZ3Q7Jm5ic3A7b2Zvbm9kWzk0MF06Jm5i
c3A7cGx1Z2lucy91ZGV2LmM6YWRkX2h1YXdlaSgpJm5ic3A7YWRkX2h1YXdlaWluZ2dnZ2dnZ2dn
ZyZuYnNwO2J5Jm5ic3A7aHlxCiZndDsmZ3Q7Jm5ic3A7b2Zvbm9kWzk0MF06Jm5ic3A7cGx1Z2lu
cy91ZGV2LmM6YWRkX2h1YXdlaSgpJm5ic3A7bmFtZSZuYnNwOz1PRk9OT19IVUFXRUlfVFlQRSZu
YnNwO2J5CiZndDsmZ3Q7Jm5ic3A7aHlxCiZndDsmZ3Q7Jm5ic3A7b2Zvbm9kWzk0MF06Jm5ic3A7
c3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkmbmJzcDttb2RlbSZuYnNwOzB4OGQ0OTA1
OCZuYnNwO3Byb3BlcnR5CiZndDsmZ3Q7Jm5ic3A7TW9kZW0KJmd0OyZndDsmbmJzcDtvZm9ub2Rb
OTQwXTombmJzcDtzcmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSZuYnNwO20mbmJzcDtv
ZGVtJm5ic3A7MHg4ZDQ5MDU4CiZndDsmZ3Q7Jm5ic3A7cHJvcGVydHkmbmJzcDtNb2RlbVJlZ2lz
dGVyZWQKJmd0OyZndDsmbmJzcDtvZm9ub2RbOTQwXTombmJzcDtwbHVnaW5zL3VkZXYuYzphZGRf
aHVhd2VpKCkmbmJzcDthZnRlciZuYnNwO29mb25vX21vZGVtX3JlZ2lzdGVyJm5ic3A7YnkKJmd0
OyZndDsmbmJzcDtoeXEmbmJzcDtwcHA9MSZuYnNwO3BjdWk9MAomZ3Q7Jmd0OyZuYnNwO29mb25v
ZFs5NDBdOiZuYnNwO3NyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpJm5ic3A7bW9kZW0m
bmJzcDsweDhkNDkwNTgmbmJzcDtwcm9wZXJ0eQomZ3Q7Jmd0OyZuYnNwO1BhdGgKJmd0OyZndDsm
bmJzcDtvZm9ub2RbOTQwXToKJmd0OyZndDsmbmJzcDtwbHVnaW5zL3VkZXYuYzphZGRfbW9kZW0o
KSZuYnNwOy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDowMC43L3VzYjEvMS0xLzEtMS4yLzEt
MS4yOjIuMy90dHkvdHR5QUNNMSZuYnNwOyhodWF3ZWkpCiZndDsmZ3Q7Jm5ic3A7b2Zvbm9kWzk0
MF06Jm5ic3A7c3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkmbmJzcDttb2RlbSZuYnNw
OzB4OGQ0OTA1OCZuYnNwO3Byb3BlcnR5CiZndDsmZ3Q7Jm5ic3A7TW9kZW1SZWdpc3RlcmVkCiZn
dDsmZ3Q7Jm5ic3A7b2Zvbm9kWzk0MF06Jm5ic3A7c3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3Bl
cnR5KCkmbmJzcDttb2RlbSZuYnNwOzB4OGQ0OTA1OCZuYnNwO3Byb3BlcnR5CiZndDsmZ3Q7Jm5i
c3A7UGN1aVJlZ2lzdGVyZWQKJmd0OyZndDsmbmJzcDtvZm9ub2RbOTQwXTombmJzcDtwbHVnaW5z
L3VkZXYuYzphZGRfaHVhd2VpKCkmbmJzcDthZGRfaHVhd2VpaW5nZ2dnZ2dnZ2dnJm5ic3A7Ynkm
bmJzcDtoeXEKJmd0OyZndDsmbmJzcDtvZm9ub2RbOTQwXTombmJzcDtzcmMvbW9kZW0uYzpzZXRf
bW9kZW1fcHJvcGVydHkoKSZuYnNwO21vZGVtJm5ic3A7MHg4ZDQ5MDU4Jm5ic3A7cHJvcGVydHkK
Jmd0OyZndDsmbmJzcDtIYXNWb2ljZQomZ3Q7Jmd0OyZuYnNwO29mb25vZFs5NDBdOiZuYnNwO3Bs
dWdpbnMvdWRldi5jOmFkZF9odWF3ZWkoKSZuYnNwO2FmdGVyJm5ic3A7b2Zvbm9fbW9kZW1fcmVn
aXN0ZXImbmJzcDtieQomZ3Q7Jmd0OyZuYnNwO2h5cSZuYnNwO3BwcD0xJm5ic3A7cGN1aT0wCiZn
dDsmZ3Q7Jm5ic3A7b2Zvbm9kWzk0MF06Jm5ic3A7c3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3Bl
cnR5KCkmbmJzcDttb2RlbSZuYnNwOzB4OGQ0OTA1OCZuYnNwO3Byb3BlcnR5CiZndDsmZ3Q7Jm5i
c3A7UGF0aAomZ3Q7Jmd0OyZuYnNwO29mb25vZFs5NDBdOgomZ3Q7Jmd0OyZuYnNwO3BsdWdpbnMv
dWRldi5jOmFkZF9tb2RlbSgpJm5ic3A7L2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjAwLjcv
dXNiMS8xLTEvMS0xLjIvMS0xLjI6Mi43L3R0eS90dHlBQ00yJm5ic3A7KGh1YXdlaSkKJmd0OyZn
dDsmbmJzcDtvZm9ub2RbOTQwXTombmJzcDtzcmMvbW9kZW0uYzpnJm5ic3A7ZXRfbW9kZW1fcHJv
cGVydHkoKSZuYnNwO21vZGVtJm5ic3A7MHg4ZDQ5MDU4CiZndDsmZ3Q7Jm5ic3A7cHJvcGVydHkm
bmJzcDtNb2RlbVJlZ2lzdGVyZWQKJmd0OyZndDsmbmJzcDtvZm9ub2RbOTQwXTombmJzcDtzcmMv
bW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSZuYnNwO21vZGVtJm5ic3A7MHg4ZDQ5MDU4Jm5i
c3A7cHJvcGVydHkKJmd0OyZndDsmbmJzcDtQY3VpUmVnaXN0ZXJlZAomZ3Q7Jmd0OyZuYnNwO29m
b25vZFs5NDBdOiZuYnNwO3BsdWdpbnMvdWRldi5jOmFkZF9odWF3ZWkoKSZuYnNwO25hbWUmbmJz
cDs9T0ZPTk9fSFVBV0VJX1RZUEUmbmJzcDtieQomZ3Q7Jmd0OyZuYnNwO2h5cQomZ3Q7Jmd0OyZu
YnNwO29mb25vZFs5NDBdOiZuYnNwO3NyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpJm5i
c3A7bW9kZW0mbmJzcDsweDhkNDkwNTgmbmJzcDtwcm9wZXJ0eQomZ3Q7Jmd0OyZuYnNwO1BjdWkK
Jmd0OyZndDsmbmJzcDtvZm9ub2RbOTQwXTombmJzcDtzcmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJv
cGVydHkoKSZuYnNwO21vZGVtJm5ic3A7MHg4ZDQ5MDU4Jm5ic3A7cHJvcGVydHkKJmd0OyZndDsm
bmJzcDtQY3VpUmVnaXN0ZXJlZAomZ3Q7Jmd0OyZuYnNwOwomZ3Q7Jmd0OyZuYnNwO1tyb290QGxv
Y2FsaG9zdCZuYnNwO3Rlc3RdIyZuYnNwOy4vYWN0aXZhdGUtY29udGV4dCZuYnNwOwomZ3Q7Jmd0
OyZuYnNwO0VudGVyaW5nJm5ic3A7bmV3Jm5ic3A7cGhhc2U6Jm5ic3A7MQomZ3Q7Jmd0OyZuYnNw
O0VudGVyaW5nJm5ic3A7bmV3Jm5ic3A7cGhhc2U6Jm5ic3A7MwomZ3Q7Jmd0OyZuYnNwO0VudGVy
aW5nJm5ic3A7bmV3Jm5ic3A7cGhhc2U6Jm5ic3A7NAomZ3Q7Jmd0OyZuYnNwO29mb25vZFs4MTVd
OiZuYnNwO2RyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYzpwcHBfY29ubmVjdCgpJm5ic3A7
CiZndDsmZ3Q7Jm5ic3A7b2Zvbm9kWzgxNV06Jm5ic3A7SVA6Jm5ic3A7MC4wLjAuMAomZ3Q7Jmd0
OyZuYnNwO29mb25vZFs4MTVdOiZuYnNwO0ROUzombmJzcDswLjAuMC4wLCZuYnNwOzAuMC4wLjAK
Jmd0OyZndDsmbmJzcDtvZm9ub2RbODE1XTombmJzcDtzcmMvZ3Bycy5jOnByaV9hY3RpdmF0ZV9j
YWxsYmFjaygpJm5ic3A7MHhhMDYzNjYwJm5ic3A7cHBwMAomZ3Q7CiZndDtubyZuYnNwO2lkZWEm
bmJzcDt3aGF0Jm5ic3A7Z29lcyZuYnNwO3dyb25nJm5ic3A7aGVyZSwmbmJzcDtidXQmbmJzcDt0
aGUmbmJzcDtuZXR3b3JrJm5ic3A7b3ImbmJzcDt5b3VyJm5ic3A7bW9kZW0mbmJzcDtmaXJtd2Fy
ZQomZ3Q7YmFzaWNhbGx5Jm5ic3A7dGVsbHMmbmJzcDt5b3UmbmJzcDt0aGF0Jm5ic3A7dGhlJm5i
c3A7SVAmbmJzcDthZGRyZXNzJm5ic3A7aXMmbmJzcDtub3QmbmJzcDtzZXQuCiZndDsKJmd0O1J1
biZuYnNwO3dpdGgmbmJzcDtPRk9OT19QUFBfREVCVUc9MSZuYnNwO2FuZCZuYnNwO3NlZSZuYnNw
O2lmJm5ic3A7aXQmbmJzcDtnaXZlcyZuYnNwO3lvdSZuYnNwO21vcmUmbmJzcDtkZXRhaWxzLgom
Z3Q7CiZndDtSZWdhcmRzCiZndDsKJmd0O01hcmNlbAomZ3Q7CiZndDsKJmd0O19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCiZndDtvZm9ubyZuYnNwO21haWxp
bmcmbmJzcDtsaXN0CiZndDtvZm9ub0BvZm9uby5vcmcKJmd0O2h0dHA6Ly9saXN0cy5vZm9uby5v
cmcvbGlzdGluZm8vb2Zvbm8KPC9wcmU+PGJyPjxicj48c3BhbiB0aXRsZT0ibmV0ZWFzZWZvb3Rl
ciI+PHNwYW4gaWQ9Im5ldGVhc2VfbWFpbF9mb290ZXIiPjwvc3Bhbj48L3NwYW4+
--===============0773353558244056126==--

