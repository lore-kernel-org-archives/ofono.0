Content-Type: multipart/mixed; boundary="===============0725435581402687030=="
MIME-Version: 1.0
From: matti kaasinen <matti.kaasinen@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Mon, 11 Jan 2016 17:02:50 +0200
Message-ID: <CADnUhn0c1g7zu2aORxRZzyRK2tkGvZw0PugFvgV2WUWy4V5NGg@mail.gmail.com>
In-Reply-To: <CADnUhn1efXRB7fZGkSfsToHH5gxd-tK4OxJxF9MhP334P1Pvcw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0725435581402687030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis,
I noticed from the logs that 'net' should have been probed by
huawei_cdc_ncm module instead of plain cdc_ncm. I managed getting sysfs
lines after "net finished" line in ofonod log after changing cdc_ncm to
huawei_cdc_ncm (below):
..plugins/udev.c:udev_event() subsystem net finished
..plugins/udevng.c:check_usb_device() huawei_cdc_ncm [12d1:1506]
..plugins/udevng.c:add_device()
/sys/devices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1.auto/usb2/2=
-1
..plugins/udevng.c:add_device()
/sys/devices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1.auto/usb2/2=
-1/2-1:1.1/net/wwan0
..plugins/udevng.c:add_device() wwan0 (huawei) 255/2/22  =3D=3D> (null) (nu=
ll)


I also got net record from setup_huawei() printout:
..plugins/udevng.c:setup_huawei() mdm=3D/dev/ttyUSB0 pcui=3D/dev/ttyUSB2
diag=3D/dev/ttyUSB1 qmi=3D(null) net=3Dwwan0


Now this process proceeded further providing printout from
provision_get_settings():
..plugins/provision.c:provision_get_settings() Provisioning for MCC 244,
MNC 05, SPN 'elisa'
..plugins/provision.c:provision_get_settings() Found 1 APs
..plugins/provision.c:provision_get_settings() Name: '(null)'
..plugins/provision.c:provision_get_settings() APN: 'internet'
..plugins/provision.c:provision_get_settings() Type:
OFONO_GPRS_CONTEXT_TYPE_INTERNET
..plugins/provision.c:provision_get_settings() Username: '(null)'
..plugins/provision.c:provision_get_settings() Password: '(null)'


After that came some errors:
..src/sim.c:ofono_sim_remove_spn_watch() 0x11cf60
ofonod: PCUI: > AT+CPBS=3D?\r
ofonod: PCUI: < \r\n+CME ERROR: 14\r\n
ofonod: PCUI: > AT+CPBS=3D?\r
ofonod: PCUI: < \r\n+CME ERROR: 14\r\n
ofonod: PCUI: > AT+CPBS=3D?\r
ofonod: PCUI: < \r\n+CPBS: ("SM","EN","ON")\r\n\r\nOK\r\n

I did not see any progress on connman side.

Modifications in plugins/udevng.c
vendor_list[]:
    { "huawei",    "huawei_cdc_ncm",    "12d1"        },

setup_huawei():
                g_strcmp0(info->interface, "255/2/22") =3D=3D 0 ||
                g_strcmp0(info->interface, "255/1/56") =3D=3D 0) {
            net =3D info->devnode;


Where should I look next?
I could provide full log, but I am not sure if attachments/messages with
attachments pass through.

Thanks,
Matti

2016-01-08 17:36 GMT+02:00 matti kaasinen <matti.kaasinen@gmail.com>:

> Denis,
> It was not that easy as adding that "255/2/22" -line ( without '(' ) for
> net detection.
> It still returns null for net. Ofono.log attached.
>
> -Matti
>
> 2016-01-08 15:59 GMT+02:00 matti kaasinen <matti.kaasinen@gmail.com>:
>
>> Denis,
>>
>> I studied both my desktop operation (ModemManager & NetworkManager) and
>> Cortex A8 board operation with ofono & connaman. I took logs from both of
>> them (attached). I also took lsusb listing and verified sysfs with my
>> desktop logs.
>> From ModemManager logs it seems that ModemManager does not suppoer
>> cdc-wdm interface. It finds three interfaces:
>> tty/ttyUSB2 at (primary)
>> net/wwan0 data (primary)
>> tty/ttyUSB0 data (secondary)
>>
>> Cortex A8 board sysfs seems have following nodes:
>>
>> /sys/devices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1.auto/usb=
2/2-1/2-1:1.0/ttyUSB0
>>
>> /sys/devices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1.auto/usb=
2/2-1/2-1:1.1/net/wwan0
>>
>> /sys/devices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1.auto/usb=
2/2-1/2-1:1.2/ttyUSB1
>>
>> /sys/devices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1.auto/usb=
2/2-1/2-1:1.3/ttyUSB2
>>
>> Thereafter it seems using ttuUSB2 for communication (AT commands anyway).
>> Compared to sysfs/lsusb and ofono.log
>> ttyUSB2 and ttyUSB0 match (bDeviceSubClass/bDeviceProtocol). Both use
>> ttyUSB2. However ofono does not get setup_huawei()/net, so it does not h=
ave
>> net/wwan0=3Dnet. As you noted, most likely setup_huawei() logic requires
>> following modification:
>>         } else if (g_strcmp0(info->interface, "255/1/8") =3D=3D 0 ||
>>                 (g_strcmp0(info->interface, "255/2/22") =3D=3D 0 ||
>>                 g_strcmp0(info->interface, "255/1/56") =3D=3D 0) {
>>             net =3D info->devnode;
>>
>> I'll try that and see how it works.
>> -Matti
>>
>> 2016-01-07 18:39 GMT+02:00 Denis Kenzior <denkenz@gmail.com>:
>>
>>> Matti,
>>>
>>> On 01/07/2016 03:54 AM, matti kaasinen wrote:
>>>
>>>> Denis,
>>>>
>>>> I inserted that line to vendor_list[]. Unfortunately it did not make a=
ny
>>>> difference.
>>>> I need to execute /usr/lib/ofono/
>>>> enable-modem
>>>> online-modem
>>>>
>>>> After that cellular_...._context1 becomes powered on
>>>> connmanctl monitor reports these events. It also reports Strength
>>>> changes.
>>>>
>>>
>>> Sounds like the modem is being detected
>>>
>>>
>>>> When I try to execute:
>>>> connmanctl connect cellular_244052161781216_context1
>>>>
>>>> I get:
>>>> Error /net/connman/service/cellular_244052161781216_context1:
>>>> Input/output error
>>>>
>>>>
>>> It is hard to say anything without detailed oFono logs.  Can you enable
>>> AT command logging and debug information using:
>>>
>>> as root:
>>> export OFONO_AT_DEBUG=3D1
>>> src/ofonod -n -d
>>>
>>> When I try to execute:
>>>> connmanctl config cellular_244052161781216_context1 --autoconnect yes
>>>>
>>>> I get:
>>>> Error cellular_244052161781216_context1: Invalid service
>>>>
>>>> This is just like it used to be before change.
>>>>
>>>> Supposing that I can somehow get this modem connected,
>>>> is it so that I need to create some agent as followes:
>>>> 1) Monitoring modem presence, e.g using
>>>> /usr/lib/ofono/test/list-contexts command.
>>>> 2) When above command returns proper context execute enable-modem and
>>>> online-modem.
>>>>
>>>> After that there should be a new service available for connaman.
>>>> Should I also write an agent monitoring/excuting connect from that eve=
nt
>>>> or is there some more advanced way of doing that. Or should it work as
>>>> smoothly as it works with older version of this modem using cdc_ether
>>>> when some (hopefully minor problem gets solved) - just plug modem in a=
nd
>>>> it gets connected?
>>>>
>>>>
>>> It should work the same as older devices.
>>>
>>> I think the issue is that the NetworkInterface associated with the
>>> context is not being detected properly.  E.g. rules in plugins/udevng.c
>>> need to be updated.  Check out setup_huawei() function and make sure th=
at
>>> the logic that assigns "net" is correct for your device.
>>>
>>> Regards,
>>> -Denis
>>>
>>>
>>
>

--===============0725435581402687030==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+PGRpdj48ZGl2PjxkaXY+PGRpdj48ZGl2Pjxk
aXY+RGVuaXMsPGJyPjwvZGl2Pkkgbm90aWNlZCBmcm9tIHRoZSBsb2dzIHRoYXQgJiMzOTtuZXQm
IzM5OyBzaG91bGQgaGF2ZSBiZWVuIHByb2JlZCBieSBodWF3ZWlfY2RjX25jbSBtb2R1bGUgaW5z
dGVhZCBvZiBwbGFpbiBjZGNfbmNtLiBJIG1hbmFnZWQgZ2V0dGluZyBzeXNmcyBsaW5lcyBhZnRl
ciAmcXVvdDtuZXQgZmluaXNoZWQmcXVvdDsgbGluZSBpbiBvZm9ub2QgbG9nIGFmdGVyIGNoYW5n
aW5nIGNkY19uY20gdG8gaHVhd2VpX2NkY19uY20gKGJlbG93KTo8YnI+Li5wbHVnaW5zL3VkZXYu
Yzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIG5ldCBmaW5pc2hlZDxicj4uLnBsdWdpbnMvdWRldm5n
LmM6Y2hlY2tfdXNiX2RldmljZSgpIGh1YXdlaV9jZGNfbmNtIFsxMmQxOjE1MDZdPGJyPi4ucGx1
Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL29jcC80NzQw
MDAwMC51c2IvNDc0MDFjMDAudXNiL211c2ItaGRyYy4xLmF1dG8vdXNiMi8yLTE8YnI+Li5wbHVn
aW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvc3lzL2RldmljZXMvcGxhdGZvcm0vb2NwLzQ3NDAw
MDAwLnVzYi80NzQwMWMwMC51c2IvbXVzYi1oZHJjLjEuYXV0by91c2IyLzItMS8yLTE6MS4xL25l
dC93d2FuMDxicj4uLnBsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIHd3YW4wIChodWF3ZWkp
IDI1NS8yLzIywqAgPT0mZ3Q7IChudWxsKSAobnVsbCk8YnI+PGJyPjwvZGl2Pjxicj5JIGFsc28g
Z290IG5ldCByZWNvcmQgZnJvbSBzZXR1cF9odWF3ZWkoKSBwcmludG91dDo8YnI+Li5wbHVnaW5z
L3VkZXZuZy5jOnNldHVwX2h1YXdlaSgpIG1kbT0vZGV2L3R0eVVTQjAgcGN1aT0vZGV2L3R0eVVT
QjIgZGlhZz0vZGV2L3R0eVVTQjEgcW1pPShudWxsKSBuZXQ9d3dhbjA8YnI+PGJyPjwvZGl2Pjxi
cj5Ob3cgdGhpcyBwcm9jZXNzIHByb2NlZWRlZCBmdXJ0aGVyIHByb3ZpZGluZyBwcmludG91dCBm
cm9tIHByb3Zpc2lvbl9nZXRfc2V0dGluZ3MoKTo8YnI+PC9kaXY+Li5wbHVnaW5zL3Byb3Zpc2lv
bi5jOnByb3Zpc2lvbl9nZXRfc2V0dGluZ3MoKSBQcm92aXNpb25pbmcgZm9yIE1DQyAyNDQsIE1O
QyAwNSwgU1BOICYjMzk7ZWxpc2EmIzM5Ozxicj4uLnBsdWdpbnMvcHJvdmlzaW9uLmM6cHJvdmlz
aW9uX2dldF9zZXR0aW5ncygpIEZvdW5kIDEgQVBzPGJyPi4ucGx1Z2lucy9wcm92aXNpb24uYzpw
cm92aXNpb25fZ2V0X3NldHRpbmdzKCkgTmFtZTogJiMzOTsobnVsbCkmIzM5Ozxicj4uLnBsdWdp
bnMvcHJvdmlzaW9uLmM6cHJvdmlzaW9uX2dldF9zZXR0aW5ncygpIEFQTjogJiMzOTtpbnRlcm5l
dCYjMzk7PGJyPi4ucGx1Z2lucy9wcm92aXNpb24uYzpwcm92aXNpb25fZ2V0X3NldHRpbmdzKCkg
VHlwZTogT0ZPTk9fR1BSU19DT05URVhUX1RZUEVfSU5URVJORVQ8YnI+Li5wbHVnaW5zL3Byb3Zp
c2lvbi5jOnByb3Zpc2lvbl9nZXRfc2V0dGluZ3MoKSBVc2VybmFtZTogJiMzOTsobnVsbCkmIzM5
Ozxicj4uLnBsdWdpbnMvcHJvdmlzaW9uLmM6cHJvdmlzaW9uX2dldF9zZXR0aW5ncygpIFBhc3N3
b3JkOiAmIzM5OyhudWxsKSYjMzk7PGJyPjxicj48YnI+QWZ0ZXIgdGhhdCBjYW1lIHNvbWUgZXJy
b3JzOjxicj4uLnNyYy9zaW0uYzpvZm9ub19zaW1fcmVtb3ZlX3Nwbl93YXRjaCgpIDB4MTFjZjYw
PGJyPm9mb25vZDogUENVSTogJmd0OyBBVCtDUEJTPT9ccjxicj5vZm9ub2Q6IFBDVUk6ICZsdDsg
XHJcbitDTUUgRVJST1I6IDE0XHJcbjxicj5vZm9ub2Q6IFBDVUk6ICZndDsgQVQrQ1BCUz0/XHI8
YnI+b2Zvbm9kOiBQQ1VJOiAmbHQ7IFxyXG4rQ01FIEVSUk9SOiAxNFxyXG48YnI+b2Zvbm9kOiBQ
Q1VJOiAmZ3Q7IEFUK0NQQlM9P1xyPGJyPm9mb25vZDogUENVSTogJmx0OyBcclxuK0NQQlM6ICgm
cXVvdDtTTSZxdW90OywmcXVvdDtFTiZxdW90OywmcXVvdDtPTiZxdW90OylcclxuXHJcbk9LXHJc
bjxicj48YnI+PC9kaXY+SSBkaWQgbm90IHNlZSBhbnkgcHJvZ3Jlc3Mgb24gY29ubm1hbiBzaWRl
Ljxicj48YnI+PC9kaXY+PGRpdj5Nb2RpZmljYXRpb25zIGluIHBsdWdpbnMvdWRldm5nLmM8YnI+
dmVuZG9yX2xpc3RbXTo8YnI+wqDCoMKgIHsgJnF1b3Q7aHVhd2VpJnF1b3Q7LMKgwqDCoCAmcXVv
dDtodWF3ZWlfY2RjX25jbSZxdW90OyzCoMKgwqAgJnF1b3Q7MTJkMSZxdW90O8KgwqDCoCDCoMKg
wqAgfSw8YnI+PGJyPnNldHVwX2h1YXdlaSgpOjxicj7CoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKg
wqAgZ19zdHJjbXAwKGluZm8tJmd0O2ludGVyZmFjZSwgJnF1b3Q7MjU1LzIvMjImcXVvdDspID09
IDAgfHw8YnI+wqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIGdfc3RyY21wMChpbmZvLSZndDtp
bnRlcmZhY2UsICZxdW90OzI1NS8xLzU2JnF1b3Q7KSA9PSAwKSB7PGJyPsKgwqDCoCDCoMKgwqAg
wqDCoMKgIG5ldCA9IGluZm8tJmd0O2Rldm5vZGU7PGJyPjxicj48L2Rpdj48ZGl2Pjxicj48L2Rp
dj5XaGVyZSBzaG91bGQgSSBsb29rIG5leHQ/PGJyPjwvZGl2PkkgY291bGQgcHJvdmlkZSBmdWxs
IGxvZywgYnV0IEkgYW0gbm90IHN1cmUgaWYgYXR0YWNobWVudHMvbWVzc2FnZXMgd2l0aCBhdHRh
Y2htZW50cyBwYXNzIHRocm91Z2guPGJyPjxicj48L2Rpdj5UaGFua3MsPGJyPjwvZGl2Pk1hdHRp
PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjIwMTYtMDEtMDggMTc6MzYgR01UKzAyOjAwIG1hdHRpIGthYXNpbmVuIDxzcGFuIGRp
cj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOm1hdHRpLmthYXNpbmVuQGdtYWlsLmNvbSIgdGFy
Z2V0PSJfYmxhbmsiPm1hdHRpLmthYXNpbmVuQGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPjo8YnI+
PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7
Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0
ciI+PGRpdj48ZGl2PjxkaXY+RGVuaXMsPGJyPjwvZGl2Pkl0IHdhcyBub3QgdGhhdCBlYXN5IGFz
IGFkZGluZyB0aGF0ICZxdW90OzI1NS8yLzIyJnF1b3Q7IC1saW5lICggd2l0aG91dCAmIzM5Oygm
IzM5OyApIGZvciBuZXQgZGV0ZWN0aW9uLjxicj48L2Rpdj5JdCBzdGlsbCByZXR1cm5zIG51bGwg
Zm9yIG5ldC4gT2Zvbm8ubG9nIGF0dGFjaGVkLjxzcGFuIGNsYXNzPSJIT0VuWmIiPjxmb250IGNv
bG9yPSIjODg4ODg4Ij48YnI+PGJyPjwvZm9udD48L3NwYW4+PC9kaXY+PHNwYW4gY2xhc3M9IkhP
RW5aYiI+PGZvbnQgY29sb3I9IiM4ODg4ODgiPjxkaXY+LU1hdHRpIDxicj48L2Rpdj48L2ZvbnQ+
PC9zcGFuPjwvZGl2PjxkaXYgY2xhc3M9IkhPRW5aYiI+PGRpdiBjbGFzcz0iaDUiPjxkaXYgY2xh
c3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjIwMTYtMDEtMDgg
MTU6NTkgR01UKzAyOjAwIG1hdHRpIGthYXNpbmVuIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJl
Zj0ibWFpbHRvOm1hdHRpLmthYXNpbmVuQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm1hdHRp
LmthYXNpbmVuQGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPjo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNj
Y2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+
PGRpdj48ZGl2PjxkaXY+PGRpdj5EZW5pcyw8YnI+PGJyPjwvZGl2Pkkgc3R1ZGllZCBib3RoIG15
IGRlc2t0b3Agb3BlcmF0aW9uIChNb2RlbU1hbmFnZXIgJmFtcDsgTmV0d29ya01hbmFnZXIpIGFu
ZCBDb3J0ZXggQTggYm9hcmQgb3BlcmF0aW9uIHdpdGggb2Zvbm8gJmFtcDsgY29ubmFtYW4uIEkg
dG9vayBsb2dzIGZyb20gYm90aCBvZiB0aGVtIChhdHRhY2hlZCkuIEkgYWxzbyB0b29rIGxzdXNi
IGxpc3RpbmcgYW5kIHZlcmlmaWVkIHN5c2ZzIHdpdGggbXkgZGVza3RvcCBsb2dzLjxicj48L2Rp
dj5Gcm9tIE1vZGVtTWFuYWdlciBsb2dzIGl0IHNlZW1zIHRoYXQgTW9kZW1NYW5hZ2VyIGRvZXMg
bm90IHN1cHBvZXIgY2RjLXdkbSBpbnRlcmZhY2UuIEl0IGZpbmRzIHRocmVlIGludGVyZmFjZXM6
PGJyPnR0eS90dHlVU0IyIGF0IChwcmltYXJ5KTxicj5uZXQvd3dhbjAgZGF0YSAocHJpbWFyeSk8
YnI+dHR5L3R0eVVTQjAgZGF0YSAoc2Vjb25kYXJ5KTxicj48YnI+PC9kaXY+PGRpdj5Db3J0ZXgg
QTggYm9hcmQgc3lzZnMgc2VlbXMgaGF2ZSBmb2xsb3dpbmcgbm9kZXM6PGJyPi9zeXMvZGV2aWNl
cy9wbGF0Zm9ybS9vY3AvNDc0MDAwMDAudXNiLzQ3NDAxYzAwLnVzYi9tdXNiLWhkcmMuMS5hdXRv
L3VzYjIvMi0xLzItMToxLjAvdHR5VVNCMDxicj4vc3lzL2RldmljZXMvcGxhdGZvcm0vb2NwLzQ3
NDAwMDAwLnVzYi80NzQwMWMwMC51c2IvbXVzYi1oZHJjLjEuYXV0by91c2IyLzItMS8yLTE6MS4x
L25ldC93d2FuMDxicj4vc3lzL2RldmljZXMvcGxhdGZvcm0vb2NwLzQ3NDAwMDAwLnVzYi80NzQw
MWMwMC51c2IvbXVzYi1oZHJjLjEuYXV0by91c2IyLzItMS8yLTE6MS4yL3R0eVVTQjE8YnI+L3N5
cy9kZXZpY2VzL3BsYXRmb3JtL29jcC80NzQwMDAwMC51c2IvNDc0MDFjMDAudXNiL211c2ItaGRy
Yy4xLmF1dG8vdXNiMi8yLTEvMi0xOjEuMy90dHlVU0IyPGJyPjxicj48L2Rpdj5UaGVyZWFmdGVy
IGl0IHNlZW1zIHVzaW5nIHR0dVVTQjIgZm9yIGNvbW11bmljYXRpb24gKEFUIGNvbW1hbmRzIGFu
eXdheSkuPGJyPjwvZGl2PkNvbXBhcmVkIHRvIHN5c2ZzL2xzdXNiIGFuZCBvZm9uby5sb2c8YnI+
PC9kaXY+dHR5VVNCMiBhbmQgdHR5VVNCMCBtYXRjaCAoYkRldmljZVN1YkNsYXNzL2JEZXZpY2VQ
cm90b2NvbCkuIEJvdGggdXNlIHR0eVVTQjIuIEhvd2V2ZXIgb2Zvbm8gZG9lcyBub3QgZ2V0IHNl
dHVwX2h1YXdlaSgpL25ldCwgc28gaXQgZG9lcyBub3QgaGF2ZSBuZXQvd3dhbjA9bmV0LiBBcyB5
b3Ugbm90ZWQsIG1vc3QgbGlrZWx5IHNldHVwX2h1YXdlaSgpIGxvZ2ljIHJlcXVpcmVzIGZvbGxv
d2luZyBtb2RpZmljYXRpb246PGJyPsKgwqDCoCDCoMKgwqAgfSBlbHNlIGlmIChnX3N0cmNtcDAo
aW5mby0mZ3Q7aW50ZXJmYWNlLCAmcXVvdDsyNTUvMS84JnF1b3Q7KSA9PSAwIHx8PGJyPsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoZ19zdHJjbXAwKGluZm8tJmd0O2ludGVyZmFjZSwg
JnF1b3Q7MjU1LzIvMjImcXVvdDspID09IDAgfHw8YnI+wqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDC
oMKgIGdfc3RyY21wMChpbmZvLSZndDtpbnRlcmZhY2UsICZxdW90OzI1NS8xLzU2JnF1b3Q7KSA9
PSAwKSB7PGJyPsKgwqDCoCDCoMKgwqAgwqDCoMKgIG5ldCA9IGluZm8tJmd0O2Rldm5vZGU7PGJy
Pjxicj48L2Rpdj5JJiMzOTtsbCB0cnkgdGhhdCBhbmQgc2VlIGhvdyBpdCB3b3Jrcy48c3Bhbj48
Zm9udCBjb2xvcj0iIzg4ODg4OCI+PGJyPjwvZm9udD48L3NwYW4+PC9kaXY+PHNwYW4+PGZvbnQg
Y29sb3I9IiM4ODg4ODgiPi1NYXR0aTxicj48L2ZvbnQ+PC9zcGFuPjwvZGl2PjxkaXY+PGRpdj48
ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj4yMDE2
LTAxLTA3IDE4OjM5IEdNVCswMjowMCBEZW5pcyBLZW56aW9yIDxzcGFuIGRpcj0ibHRyIj4mbHQ7
PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+ZGVua2Vu
ekBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj46PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9x
dW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlk
O3BhZGRpbmctbGVmdDoxZXgiPk1hdHRpLDxzcGFuPjxicj4KPGJyPgpPbiAwMS8wNy8yMDE2IDAz
OjU0IEFNLCBtYXR0aSBrYWFzaW5lbiB3cm90ZTo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFp
bF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNv
bGlkO3BhZGRpbmctbGVmdDoxZXgiPgpEZW5pcyw8YnI+Cjxicj4KSSBpbnNlcnRlZCB0aGF0IGxp
bmUgdG8gdmVuZG9yX2xpc3RbXS4gVW5mb3J0dW5hdGVseSBpdCBkaWQgbm90IG1ha2UgYW55PGJy
PgpkaWZmZXJlbmNlLjxicj4KSSBuZWVkIHRvIGV4ZWN1dGUgL3Vzci9saWIvb2Zvbm8vPGJyPgpl
bmFibGUtbW9kZW08YnI+Cm9ubGluZS1tb2RlbTxicj4KPGJyPgpBZnRlciB0aGF0IGNlbGx1bGFy
Xy4uLi5fY29udGV4dDEgYmVjb21lcyBwb3dlcmVkIG9uPGJyPgpjb25ubWFuY3RsIG1vbml0b3Ig
cmVwb3J0cyB0aGVzZSBldmVudHMuIEl0IGFsc28gcmVwb3J0cyBTdHJlbmd0aCBjaGFuZ2VzLjxi
cj4KPC9ibG9ja3F1b3RlPgo8YnI+PC9zcGFuPgpTb3VuZHMgbGlrZSB0aGUgbW9kZW0gaXMgYmVp
bmcgZGV0ZWN0ZWQ8c3Bhbj48YnI+Cjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFk
ZGluZy1sZWZ0OjFleCI+Cjxicj4KV2hlbiBJIHRyeSB0byBleGVjdXRlOjxicj4KY29ubm1hbmN0
bCBjb25uZWN0IGNlbGx1bGFyXzI0NDA1MjE2MTc4MTIxNl9jb250ZXh0MTxicj4KPGJyPgpJIGdl
dDo8YnI+CkVycm9yIC9uZXQvY29ubm1hbi9zZXJ2aWNlL2NlbGx1bGFyXzI0NDA1MjE2MTc4MTIx
Nl9jb250ZXh0MTo8YnI+CklucHV0L291dHB1dCBlcnJvcjxicj4KPGJyPgo8L2Jsb2NrcXVvdGU+
Cjxicj48L3NwYW4+Ckl0IGlzIGhhcmQgdG8gc2F5IGFueXRoaW5nIHdpdGhvdXQgZGV0YWlsZWQg
b0Zvbm8gbG9ncy7CoCBDYW4geW91IGVuYWJsZSBBVCBjb21tYW5kIGxvZ2dpbmcgYW5kIGRlYnVn
IGluZm9ybWF0aW9uIHVzaW5nOjxicj4KPGJyPgphcyByb290Ojxicj4KZXhwb3J0IE9GT05PX0FU
X0RFQlVHPTE8YnI+CnNyYy9vZm9ub2QgLW4gLWQ8c3Bhbj48YnI+Cjxicj4KPGJsb2NrcXVvdGUg
Y2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6
MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CldoZW4gSSB0cnkgdG8gZXhlY3V0ZTo8
YnI+CmNvbm5tYW5jdGwgY29uZmlnIGNlbGx1bGFyXzI0NDA1MjE2MTc4MTIxNl9jb250ZXh0MSAt
LWF1dG9jb25uZWN0IHllczxicj4KPGJyPgpJIGdldDo8YnI+CkVycm9yIGNlbGx1bGFyXzI0NDA1
MjE2MTc4MTIxNl9jb250ZXh0MTogSW52YWxpZCBzZXJ2aWNlPGJyPgo8YnI+ClRoaXMgaXMganVz
dCBsaWtlIGl0IHVzZWQgdG8gYmUgYmVmb3JlIGNoYW5nZS48YnI+Cjxicj4KU3VwcG9zaW5nIHRo
YXQgSSBjYW4gc29tZWhvdyBnZXQgdGhpcyBtb2RlbSBjb25uZWN0ZWQsPGJyPgppcyBpdCBzbyB0
aGF0IEkgbmVlZCB0byBjcmVhdGUgc29tZSBhZ2VudCBhcyBmb2xsb3dlczo8YnI+CjEpIE1vbml0
b3JpbmcgbW9kZW0gcHJlc2VuY2UsIGUuZyB1c2luZzxicj4KL3Vzci9saWIvb2Zvbm8vdGVzdC9s
aXN0LWNvbnRleHRzIGNvbW1hbmQuPGJyPgoyKSBXaGVuIGFib3ZlIGNvbW1hbmQgcmV0dXJucyBw
cm9wZXIgY29udGV4dCBleGVjdXRlIGVuYWJsZS1tb2RlbSBhbmQ8YnI+Cm9ubGluZS1tb2RlbS48
YnI+Cjxicj4KQWZ0ZXIgdGhhdCB0aGVyZSBzaG91bGQgYmUgYSBuZXcgc2VydmljZSBhdmFpbGFi
bGUgZm9yIGNvbm5hbWFuLjxicj4KU2hvdWxkIEkgYWxzbyB3cml0ZSBhbiBhZ2VudCBtb25pdG9y
aW5nL2V4Y3V0aW5nIGNvbm5lY3QgZnJvbSB0aGF0IGV2ZW50PGJyPgpvciBpcyB0aGVyZSBzb21l
IG1vcmUgYWR2YW5jZWQgd2F5IG9mIGRvaW5nIHRoYXQuIE9yIHNob3VsZCBpdCB3b3JrIGFzPGJy
PgpzbW9vdGhseSBhcyBpdCB3b3JrcyB3aXRoIG9sZGVyIHZlcnNpb24gb2YgdGhpcyBtb2RlbSB1
c2luZyBjZGNfZXRoZXI8YnI+CndoZW4gc29tZSAoaG9wZWZ1bGx5IG1pbm9yIHByb2JsZW0gZ2V0
cyBzb2x2ZWQpIC0ganVzdCBwbHVnIG1vZGVtIGluIGFuZDxicj4KaXQgZ2V0cyBjb25uZWN0ZWQ/
PGJyPgo8YnI+CjwvYmxvY2txdW90ZT4KPGJyPjwvc3Bhbj4KSXQgc2hvdWxkIHdvcmsgdGhlIHNh
bWUgYXMgb2xkZXIgZGV2aWNlcy48YnI+Cjxicj4KSSB0aGluayB0aGUgaXNzdWUgaXMgdGhhdCB0
aGUgTmV0d29ya0ludGVyZmFjZSBhc3NvY2lhdGVkIHdpdGggdGhlIGNvbnRleHQgaXMgbm90IGJl
aW5nIGRldGVjdGVkIHByb3Blcmx5LsKgIEUuZy4gcnVsZXMgaW4gcGx1Z2lucy91ZGV2bmcuYyBu
ZWVkIHRvIGJlIHVwZGF0ZWQuwqAgQ2hlY2sgb3V0IHNldHVwX2h1YXdlaSgpIGZ1bmN0aW9uIGFu
ZCBtYWtlIHN1cmUgdGhhdCB0aGUgbG9naWMgdGhhdCBhc3NpZ25zICZxdW90O25ldCZxdW90OyBp
cyBjb3JyZWN0IGZvciB5b3VyIGRldmljZS48YnI+Cjxicj4KUmVnYXJkcyw8YnI+Ci1EZW5pczxi
cj4KPGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2Pgo8L2Rpdj48L2Rpdj48L2Jsb2Nr
cXVvdGU+PC9kaXY+PGJyPjwvZGl2Pgo8L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJy
PjwvZGl2Pgo=

--===============0725435581402687030==--

