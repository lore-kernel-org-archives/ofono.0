Content-Type: multipart/mixed; boundary="===============7471422020677358014=="
MIME-Version: 1.0
From: matti kaasinen <matti.kaasinen@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Tue, 12 Jan 2016 10:38:15 +0200
Message-ID: <CADnUhn2f+==CS=5E1Bm07z7ChDch_tF=Vw78onqg+vPQ7b1fNQ@mail.gmail.com>
In-Reply-To: <CADnUhn27aMvBB_AWd+4Eq-WJ7gmdF+=roE7PeNzshZ9MziM+VA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7471422020677358014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2016-01-11 19:52 GMT+02:00 matti kaasinen <matti.kaasinen@gmail.com>:

> What does list-contexts show?  Can you do test/online-modem and
>> test/activate-context, test/process-context-settings?
>>
> I don't think I have had issues with these before. The last one I have not
> tried, though.
>


I tested these commands with following outcome:
huawei plugged
=3D>
connmanctl monitor reports new cellular interface (Powered=3DFalse)

test/list-contexts
=3D>
[ /huawei_0 ]
    [ /huawei_0/context1 ]
        Username =3D
        AuthenticationMethod =3D chap
        Protocol =3D ip
        Name =3D Internet
        Settings =3D { }
        IPv6.Settings =3D { }
        Active =3D 0
        AccessPointName =3D internet
        Password =3D
        Type =3D internet

test./list-modems
=3D>
[ /huawei_0 ]
    Features =3D sms gprs rat sim
    Emergency =3D 0
    Powered =3D 1
    Lockdown =3D 0
    Interfaces =3D org.ofono.Phonebook org.ofono.SmartMessaging
org.ofono.PushNotification org.ofono.MessageManager
org.ofono.ConnectionManager org.ofono.RadioSettings org.ofono.AudioSettings
org.ofono.VoiceCallManager org.ofono.SimManager
    Online =3D 0
    Model =3D E3131
    Revision =3D 21.157.14.00.78
    Type =3D hardware
    Serial =3D 866715019103353
    Manufacturer =3D huawei
    [ org.ofono.Phonebook ]
    [ org.ofono.SmartMessaging ]
    [ org.ofono.PushNotification ]
    [ org.ofono.MessageManager ]
        Alphabet =3D default
        UseDeliveryReports =3D 0
        Bearer =3D cs-preferred
        ServiceCenterAddress =3D +358508771010
    [ org.ofono.ConnectionManager ]
        Powered =3D 1
        Attached =3D 0
        Bearer =3D none
        RoamingAllowed =3D 0
    [ org.ofono.RadioSettings ]
        UmtsBand =3D any
        TechnologyPreference =3D any
        GsmBand =3D any
    [ org.ofono.AudioSettings ]
        Active =3D 0
    [ org.ofono.VoiceCallManager ]
        EmergencyNumbers =3D 08 000 999 110 112 911 118 119
    [ org.ofono.SimManager ]
        Retries =3D [pin2 =3D 3] [puk2 =3D 10] [pin =3D 3] [puk =3D 10]
        MobileCountryCode =3D 244
        FixedDialing =3D 0
        SubscriberNumbers =3D
        PreferredLanguages =3D fi sv en de fr
        BarredDialing =3D 0
Traceback (most recent call last):
  File "./list-modems", line 81, in <module>
    print("        %s =3D %s" % (key, val))
UnicodeEncodeError: 'ascii' codec can't encode character u'\xe4' in
position 127: ordinal not in range(128)


test/online-modem
=3D>
- lots of traffic in ofono log
- modem switches from blinking green to blinking blue
- connmanctl monitor reports cellular interface (Powered=3DTrue + other
status)


activate-context
=3D>
Error activating /huawei_0/context1: org.ofono.Error.NotImplemented:
Implementation not provided

test/process-context-settings
=3D> nothing visible, just returns

BTW: Is it time for the patch, yet? It seems that there is still something
wrong in set-up.


To compare how the old Huawei 3131 works. Everything listed below takes
place in one sequence after plugging modem. No manual intervention is
required.

..ofonod: plugins/udevng.c:check_usb_device() usb [12d1:14db]
..ofonod: plugins/udevng.c:check_usb_device() usb [(null):(null)]
..ofonod: plugins/udevng.c:check_usb_device() cdc_ether [(null):(null)]
..ofonod: plugins/udev.c:udev_event() subsystem net add
..ofonod: plugins/udev.c:udev_event() subsystem net finished
..ofonod: plugins/udevng.c:check_usb_device() cdc_ether [12d1:14db]
..ofonod: plugins/udevng.c:add_device()
/sys/devices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1.auto/usb2/2=
-1
..ofonod: plugins/udevng.c:add_device()
/sys/devices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1.auto/usb2/2=
-1/2-1:1.0/net/eth1
..ofonod: plugins/udevng.c:add_device() eth1 (huawei) 2/6/0  =3D=3D> (null)
(null)
..ofonod: plugins/udevng.c:check_modem_list()
..ofonod: plugins/udevng.c:create_modem()
/sys/devices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1.auto/usb2/2=
-1
..ofonod: plugins/udevng.c:create_modem() driver=3Dhuawei
..ofonod: src/modem.c:ofono_modem_create() name: (null), type: huawei
..ofonod: plugins/udevng.c:setup_huawei()
/sys/devices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1.auto/usb2/2=
-1
..ofonod: plugins/udevng.c:setup_huawei() eth1 2/6/0 00 (null)
..ofonod: plugins/udevng.c:destroy_modem()
/sys/devices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1.auto/usb2/2=
-1
..ofonod: src/modem.c:ofono_modem_remove() 0x11c3c8
..ofonod: plugins/udevng.c:destroy_modem() eth1


connmanctl monitor reports followin service:
Service      ethernet_582c80139263_cable IPv4 =3D [ Method=3Ddhcp,
Address=3D192.168.1.100, Netmask=3D255.255.255.0 ]

Connection in eth1 is active.
Note that driver listed is not kernel drive, like with new 3131 but most
likely ofono driver - at least it is not listed with lsmod. Also there is
no at traffic at all reported from ofonod.

-Matti

--===============7471422020677358014==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+MjAxNi0wMS0xMSAxOTo1MiBHTVQrMDI6MDAgbWF0dGkga2Fhc2luZW4gPHNw
YW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86bWF0dGkua2Fhc2luZW5AZ21haWwuY29t
IiB0YXJnZXQ9Il9ibGFuayI+bWF0dGkua2Fhc2luZW5AZ21haWwuY29tPC9hPiZndDs8L3NwYW4+
Ojxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBw
eCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGlu
Zy1sZWZ0OjFleCI+PHNwYW4gY2xhc3M9IiI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCBy
Z2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPldoYXQgZG9lcyBsaXN0LWNvbnRleHRz
IHNob3c/wqAgQ2FuIHlvdSBkbyB0ZXN0L29ubGluZS1tb2RlbSBhbmQgdGVzdC9hY3RpdmF0ZS1j
b250ZXh0LCB0ZXN0L3Byb2Nlc3MtY29udGV4dC1zZXR0aW5ncz88YnI+PC9ibG9ja3F1b3RlPjwv
c3Bhbj48ZGl2PkkgZG9uJiMzOTt0IHRoaW5rIEkgaGF2ZSBoYWQgaXNzdWVzIHdpdGggdGhlc2Ug
YmVmb3JlLiBUaGUgbGFzdCBvbmUgSSBoYXZlIG5vdCB0cmllZCwgdGhvdWdoLjxicj48L2Rpdj48
L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+
SSB0ZXN0ZWQgdGhlc2UgY29tbWFuZHMgd2l0aCBmb2xsb3dpbmcgb3V0Y29tZTo8YnI+aHVhd2Vp
IHBsdWdnZWQ8YnI+PSZndDs8YnI+Y29ubm1hbmN0bCBtb25pdG9yIHJlcG9ydHMgbmV3IGNlbGx1
bGFyIGludGVyZmFjZSAoUG93ZXJlZD1GYWxzZSk8YnI+PGJyPnRlc3QvbGlzdC1jb250ZXh0czxi
cj49Jmd0Ozxicj5bIC9odWF3ZWlfMCBdPGJyPsKgwqDCoCBbIC9odWF3ZWlfMC9jb250ZXh0MSBd
PGJyPsKgwqDCoMKgwqDCoMKgIFVzZXJuYW1lID0gPGJyPsKgwqDCoMKgwqDCoMKgIEF1dGhlbnRp
Y2F0aW9uTWV0aG9kID0gY2hhcDxicj7CoMKgwqDCoMKgwqDCoCBQcm90b2NvbCA9IGlwPGJyPsKg
wqDCoMKgwqDCoMKgIE5hbWUgPSBJbnRlcm5ldDxicj7CoMKgwqDCoMKgwqDCoCBTZXR0aW5ncyA9
IHsgfTxicj7CoMKgwqDCoMKgwqDCoCBJUHY2LlNldHRpbmdzID0geyB9PGJyPsKgwqDCoMKgwqDC
oMKgIEFjdGl2ZSA9IDA8YnI+wqDCoMKgwqDCoMKgwqAgQWNjZXNzUG9pbnROYW1lID0gaW50ZXJu
ZXQ8YnI+wqDCoMKgwqDCoMKgwqAgUGFzc3dvcmQgPSA8YnI+wqDCoMKgwqDCoMKgwqAgVHlwZSA9
IGludGVybmV0PGJyPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+dGVzdC4vbGlz
dC1tb2RlbXMgPGJyPj0mZ3Q7PGJyPlsgL2h1YXdlaV8wIF08YnI+wqDCoMKgIEZlYXR1cmVzID0g
c21zIGdwcnMgcmF0IHNpbSA8YnI+wqDCoMKgIEVtZXJnZW5jeSA9IDA8YnI+wqDCoMKgIFBvd2Vy
ZWQgPSAxPGJyPsKgwqDCoCBMb2NrZG93biA9IDA8YnI+wqDCoMKgIEludGVyZmFjZXMgPSBvcmcu
b2Zvbm8uUGhvbmVib29rIG9yZy5vZm9uby5TbWFydE1lc3NhZ2luZyBvcmcub2Zvbm8uUHVzaE5v
dGlmaWNhdGlvbiBvcmcub2Zvbm8uTWVzc2FnZU1hbmFnZXIgb3JnLm9mb25vLkNvbm5lY3Rpb25N
YW5hZ2VyIG9yZy5vZm9uby5SYWRpb1NldHRpbmdzIG9yZy5vZm9uby5BdWRpb1NldHRpbmdzIG9y
Zy5vZm9uby5Wb2ljZUNhbGxNYW5hZ2VyIG9yZy5vZm9uby5TaW1NYW5hZ2VyIDxicj7CoMKgwqAg
T25saW5lID0gMDxicj7CoMKgwqAgTW9kZWwgPSBFMzEzMTxicj7CoMKgwqAgUmV2aXNpb24gPSAy
MS4xNTcuMTQuMDAuNzg8YnI+wqDCoMKgIFR5cGUgPSBoYXJkd2FyZTxicj7CoMKgwqAgU2VyaWFs
ID0gODY2NzE1MDE5MTAzMzUzPGJyPsKgwqDCoCBNYW51ZmFjdHVyZXIgPSBodWF3ZWk8YnI+wqDC
oMKgIFsgb3JnLm9mb25vLlBob25lYm9vayBdPGJyPsKgwqDCoCBbIG9yZy5vZm9uby5TbWFydE1l
c3NhZ2luZyBdPGJyPsKgwqDCoCBbIG9yZy5vZm9uby5QdXNoTm90aWZpY2F0aW9uIF08YnI+wqDC
oMKgIFsgb3JnLm9mb25vLk1lc3NhZ2VNYW5hZ2VyIF08YnI+wqDCoMKgwqDCoMKgwqAgQWxwaGFi
ZXQgPSBkZWZhdWx0PGJyPsKgwqDCoMKgwqDCoMKgIFVzZURlbGl2ZXJ5UmVwb3J0cyA9IDA8YnI+
wqDCoMKgwqDCoMKgwqAgQmVhcmVyID0gY3MtcHJlZmVycmVkPGJyPsKgwqDCoMKgwqDCoMKgIFNl
cnZpY2VDZW50ZXJBZGRyZXNzID0gKzM1ODUwODc3MTAxMDxicj7CoMKgwqAgWyBvcmcub2Zvbm8u
Q29ubmVjdGlvbk1hbmFnZXIgXTxicj7CoMKgwqDCoMKgwqDCoCBQb3dlcmVkID0gMTxicj7CoMKg
wqDCoMKgwqDCoCBBdHRhY2hlZCA9IDA8YnI+wqDCoMKgwqDCoMKgwqAgQmVhcmVyID0gbm9uZTxi
cj7CoMKgwqDCoMKgwqDCoCBSb2FtaW5nQWxsb3dlZCA9IDA8YnI+wqDCoMKgIFsgb3JnLm9mb25v
LlJhZGlvU2V0dGluZ3MgXTxicj7CoMKgwqDCoMKgwqDCoCBVbXRzQmFuZCA9IGFueTxicj7CoMKg
wqDCoMKgwqDCoCBUZWNobm9sb2d5UHJlZmVyZW5jZSA9IGFueTxicj7CoMKgwqDCoMKgwqDCoCBH
c21CYW5kID0gYW55PGJyPsKgwqDCoCBbIG9yZy5vZm9uby5BdWRpb1NldHRpbmdzIF08YnI+wqDC
oMKgwqDCoMKgwqAgQWN0aXZlID0gMDxicj7CoMKgwqAgWyBvcmcub2Zvbm8uVm9pY2VDYWxsTWFu
YWdlciBdPGJyPsKgwqDCoMKgwqDCoMKgIEVtZXJnZW5jeU51bWJlcnMgPSAwOCAwMDAgOTk5IDEx
MCAxMTIgOTExIDExOCAxMTkgPGJyPsKgwqDCoCBbIG9yZy5vZm9uby5TaW1NYW5hZ2VyIF08YnI+
wqDCoMKgwqDCoMKgwqAgUmV0cmllcyA9IFtwaW4yID0gM10gW3B1azIgPSAxMF0gW3BpbiA9IDNd
IFtwdWsgPSAxMF0gPGJyPsKgwqDCoMKgwqDCoMKgIE1vYmlsZUNvdW50cnlDb2RlID0gMjQ0PGJy
PsKgwqDCoMKgwqDCoMKgIEZpeGVkRGlhbGluZyA9IDA8YnI+wqDCoMKgwqDCoMKgwqAgU3Vic2Ny
aWJlck51bWJlcnMgPSA8YnI+wqDCoMKgwqDCoMKgwqAgUHJlZmVycmVkTGFuZ3VhZ2VzID0gZmkg
c3YgZW4gZGUgZnIgPGJyPsKgwqDCoMKgwqDCoMKgIEJhcnJlZERpYWxpbmcgPSAwPGJyPlRyYWNl
YmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KTo8YnI+wqAgRmlsZSAmcXVvdDsuL2xpc3QtbW9k
ZW1zJnF1b3Q7LCBsaW5lIDgxLCBpbiAmbHQ7bW9kdWxlJmd0Ozxicj7CoMKgwqAgcHJpbnQoJnF1
b3Q7wqDCoMKgwqDCoMKgwqAgJXMgPSAlcyZxdW90OyAlIChrZXksIHZhbCkpPGJyPlVuaWNvZGVF
bmNvZGVFcnJvcjogJiMzOTthc2NpaSYjMzk7IGNvZGVjIGNhbiYjMzk7dCBlbmNvZGUgY2hhcmFj
dGVyIHUmIzM5O1x4ZTQmIzM5OyBpbiBwb3NpdGlvbiAxMjc6IG9yZGluYWwgbm90IGluIHJhbmdl
KDEyOCk8YnI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+dGVzdC9vbmxp
bmUtbW9kZW08YnI+PSZndDsgPGJyPi0gbG90cyBvZiB0cmFmZmljIGluIG9mb25vIGxvZzxicj4t
IG1vZGVtIHN3aXRjaGVzIGZyb20gYmxpbmtpbmcgZ3JlZW4gdG8gYmxpbmtpbmcgYmx1ZTxicj4t
IGNvbm5tYW5jdGwgbW9uaXRvciByZXBvcnRzIGNlbGx1bGFyIGludGVyZmFjZSAoUG93ZXJlZD1U
cnVlICsgb3RoZXIgc3RhdHVzKSA8YnI+PGJyPjxicj5hY3RpdmF0ZS1jb250ZXh0IDxicj49Jmd0
Ozxicj5FcnJvciBhY3RpdmF0aW5nIC9odWF3ZWlfMC9jb250ZXh0MTogb3JnLm9mb25vLkVycm9y
Lk5vdEltcGxlbWVudGVkOiBJbXBsZW1lbnRhdGlvbiBub3QgcHJvdmlkZWQ8YnI+PGJyPnRlc3Qv
cHJvY2Vzcy1jb250ZXh0LXNldHRpbmdzPGJyPj0mZ3Q7IG5vdGhpbmcgdmlzaWJsZSwganVzdCBy
ZXR1cm5zPGJyPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+QlRXOiBJcyBpdCB0
aW1lIGZvciB0aGUgcGF0Y2gsIHlldD8gSXQgc2VlbXMgdGhhdCB0aGVyZSBpcyBzdGlsbCBzb21l
dGhpbmcgd3JvbmcgaW4gc2V0LXVwLjxicj48YnI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWls
X2V4dHJhIj5UbyBjb21wYXJlIGhvdyB0aGUgb2xkIEh1YXdlaSAzMTMxIHdvcmtzLiBFdmVyeXRo
aW5nIGxpc3RlZCBiZWxvdyB0YWtlcyBwbGFjZSBpbiBvbmUgc2VxdWVuY2UgYWZ0ZXIgcGx1Z2dp
bmcgbW9kZW0uIE5vIG1hbnVhbCBpbnRlcnZlbnRpb24gaXMgcmVxdWlyZWQuPGJyPjxicj4uLm9m
b25vZDogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFsxMmQxOjE0ZGJd
PGJyPi4ub2Zvbm9kOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSB1c2IgWyhu
dWxsKToobnVsbCldPGJyPi4ub2Zvbm9kOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZp
Y2UoKSBjZGNfZXRoZXIgWyhudWxsKToobnVsbCldPGJyPi4ub2Zvbm9kOiBwbHVnaW5zL3VkZXYu
Yzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIG5ldCBhZGQ8YnI+Li5vZm9ub2Q6IHBsdWdpbnMvdWRl
di5jOnVkZXZfZXZlbnQoKSBzdWJzeXN0ZW0gbmV0IGZpbmlzaGVkPGJyPi4ub2Zvbm9kOiBwbHVn
aW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBjZGNfZXRoZXIgWzEyZDE6MTRkYl08YnI+
Li5vZm9ub2Q6IHBsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wbGF0
Zm9ybS9vY3AvNDc0MDAwMDAudXNiLzQ3NDAxYzAwLnVzYi9tdXNiLWhkcmMuMS5hdXRvL3VzYjIv
Mi0xPGJyPi4ub2Zvbm9kOiBwbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvc3lzL2Rldmlj
ZXMvcGxhdGZvcm0vb2NwLzQ3NDAwMDAwLnVzYi80NzQwMWMwMC51c2IvbXVzYi1oZHJjLjEuYXV0
by91c2IyLzItMS8yLTE6MS4wL25ldC9ldGgxPGJyPi4ub2Zvbm9kOiBwbHVnaW5zL3VkZXZuZy5j
OmFkZF9kZXZpY2UoKSBldGgxIChodWF3ZWkpIDIvNi8wwqAgPT0mZ3Q7IChudWxsKSAobnVsbCk8
YnI+Li5vZm9ub2Q6IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfbW9kZW1fbGlzdCgpIDxicj4uLm9m
b25vZDogcGx1Z2lucy91ZGV2bmcuYzpjcmVhdGVfbW9kZW0oKSAvc3lzL2RldmljZXMvcGxhdGZv
cm0vb2NwLzQ3NDAwMDAwLnVzYi80NzQwMWMwMC51c2IvbXVzYi1oZHJjLjEuYXV0by91c2IyLzIt
MTxicj4uLm9mb25vZDogcGx1Z2lucy91ZGV2bmcuYzpjcmVhdGVfbW9kZW0oKSBkcml2ZXI9aHVh
d2VpPGJyPi4ub2Zvbm9kOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9jcmVhdGUoKSBuYW1lOiAo
bnVsbCksIHR5cGU6IGh1YXdlaTxicj4uLm9mb25vZDogcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9o
dWF3ZWkoKSAvc3lzL2RldmljZXMvcGxhdGZvcm0vb2NwLzQ3NDAwMDAwLnVzYi80NzQwMWMwMC51
c2IvbXVzYi1oZHJjLjEuYXV0by91c2IyLzItMTxicj4uLm9mb25vZDogcGx1Z2lucy91ZGV2bmcu
YzpzZXR1cF9odWF3ZWkoKSBldGgxIDIvNi8wIDAwIChudWxsKTxicj4uLm9mb25vZDogcGx1Z2lu
cy91ZGV2bmcuYzpkZXN0cm95X21vZGVtKCkgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL29jcC80NzQw
MDAwMC51c2IvNDc0MDFjMDAudXNiL211c2ItaGRyYy4xLmF1dG8vdXNiMi8yLTE8YnI+Li5vZm9u
b2Q6IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX3JlbW92ZSgpIDB4MTFjM2M4PGJyPi4ub2Zvbm9k
OiBwbHVnaW5zL3VkZXZuZy5jOmRlc3Ryb3lfbW9kZW0oKSBldGgxPGJyPjxicj48YnI+Y29ubm1h
bmN0bCBtb25pdG9yIHJlcG9ydHMgZm9sbG93aW4gc2VydmljZTo8YnI+U2VydmljZcKgwqDCoMKg
wqAgZXRoZXJuZXRfNTgyYzgwMTM5MjYzX2NhYmxlIElQdjQgPSBbIE1ldGhvZD1kaGNwLCBBZGRy
ZXNzPTE5Mi4xNjguMS4xMDAsIE5ldG1hc2s9MjU1LjI1NS4yNTUuMCBdPGJyPjxicj48L2Rpdj48
ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+Q29ubmVjdGlvbiBpbiBldGgxIGlzIGFjdGl2ZS48YnI+
PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPk5vdGUgdGhhdCBkcml2ZXIgbGlzdGVkIGlz
IG5vdCBrZXJuZWwgZHJpdmUsIGxpa2Ugd2l0aCBuZXcgMzEzMSBidXQgbW9zdCBsaWtlbHkgb2Zv
bm8gZHJpdmVyIC0gYXQgbGVhc3QgaXQgaXMgbm90IGxpc3RlZCB3aXRoIGxzbW9kLiBBbHNvIHRo
ZXJlIGlzIG5vIGF0IHRyYWZmaWMgYXQgYWxsIHJlcG9ydGVkIGZyb20gb2Zvbm9kLjxicj48YnI+
LU1hdHRpPGJyPjwvZGl2PjwvZGl2Pgo=

--===============7471422020677358014==--

