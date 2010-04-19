Content-Type: multipart/mixed; boundary="===============4539407058215550849=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: Re: [PATCH] Fix Let data device be optional for mbm driver
Date: Mon, 19 Apr 2010 09:53:24 +0800
Message-ID: <4BCBB794.6050508@intel.com>
In-Reply-To: <1271429576.22838.26.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4539407058215550849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 04/16/2010 10:52 PM, Marcel Holtmann wrote:
> Hi Zhenhua,
>
>> Dell 5530 modem has no data device port. So data device should be
>> optional in mbm drvier.
>
> can you please include the content of /proc/bus/usb/devices for this
> device and the sysfs descriptions for each TTY port.

I realize my previous fix is not proper to 5530. I can see three ports =

(ttyACM0~ttyACM2) for Dell 5530 modem. The sysfs descriptions are posted =

at below URLs:

ttyACM0	http://pastebin.com/aW4PyHBw
ttyACM1	http://pastebin.com/igZxccVe
ttyACM2	http://pastebin.com/T7DFmXTv

ttyACM0 is described as 'Dell Wireless 5530 HSPA Mobile Broadband =

Minicard Modem'.

ttyACM1 is described as 'Dell Wireless 5530 HSPA Mobile Broadband =

Minicard Modem 2'.

I cann't tell which one is modem device or data device. But obviously, =

we should add 'Minicard Modem 2' as suffix candidate. So my updated =

patch is attached. Now we can probe 5530 correctly again. the output is:

ofonod[3737]: src/modem.c:ofono_modem_create() name: 3558620217367190, =

type: mbm
ofonod[3737]: src/modem.c:set_modem_property() modem 0x8a576c0 property Path
ofonod[3737]: src/modem.c:set_modem_property() modem 0x8a576c0 property =

Registered
ofonod[3737]: plugins/udev.c:add_mbm() desc: Dell Wireless 5530 HSPA =

Mobile Broadband Minicard Modem
ofonod[3737]: src/modem.c:get_modem_property() modem 0x8a576c0 property =

Registered
ofonod[3737]: src/modem.c:get_modem_property() modem 0x8a576c0 property =

ModemDevice
ofonod[3737]: src/modem.c:set_modem_property() modem 0x8a576c0 property =

ModemDevice
ofonod[3737]: src/modem.c:get_modem_property() modem 0x8a576c0 property =

ModemDevice
ofonod[3737]: src/modem.c:get_modem_property() modem 0x8a576c0 property =

NetworkInterface
ofonod[3737]: src/modem.c:get_modem_property() modem 0x8a576c0 property Path
ofonod[3737]: plugins/udev.c:add_mbm() desc: Dell Wireless 5530 HSPA =

Mobile Broadband Minicard Modem 2
ofonod[3737]: src/modem.c:get_modem_property() modem 0x8a576c0 property =

Registered
ofonod[3737]: src/modem.c:get_modem_property() modem 0x8a576c0 property =

ModemDevice
ofonod[3737]: src/modem.c:set_modem_property() modem 0x8a576c0 property =

DataDevice
ofonod[3737]: src/modem.c:get_modem_property() modem 0x8a576c0 property =

ModemDevice
ofonod[3737]: src/modem.c:get_modem_property() modem 0x8a576c0 property =

NetworkInterface
ofonod[3737]: src/modem.c:get_modem_property() modem 0x8a576c0 property Path
ofonod[3737]: plugins/udev.c:add_mbm() desc: Dell Wireless 5530 HSPA =

Mobile Broadband Minicard NetworkAdapter
ofonod[3737]: src/modem.c:get_modem_property() modem 0x8a576c0 property =

Registered
ofonod[3737]: src/modem.c:set_modem_property() modem 0x8a576c0 property =

NetworkInterface
ofonod[3737]: src/modem.c:get_modem_property() modem 0x8a576c0 property =

ModemDevice
ofonod[3737]: src/modem.c:get_modem_property() modem 0x8a576c0 property =

NetworkInterface
ofonod[3737]: src/modem.c:set_modem_property() modem 0x8a576c0 property =

Registered
ofonod[3737]: src/modem.c:unregister_property() property 0x8a57ee0

> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>


--===============4539407058215550849==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Fix-Add-Dell5530-modem-port-suffix-for-data-device.patch"

PkZyb20gNDRjOGFiYTYyNjFjOTUyNThjM2I4OTE4YmJjMzIxYjFhMzUxMmQ1ZiBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogWmhlbmh1YSBaaGFuZyA8emhlbmh1YS56aGFuZ0BpbnRlbC5j
b20+CkRhdGU6IE1vbiwgMTkgQXByIDIwMTAgMDk6Mzk6NDkgKzA4MDAKU3ViamVjdDogW1BBVENI
XSBGaXggQWRkIERlbGw1NTMwIG1vZGVtIHBvcnQgc3VmZml4IGZvciBkYXRhIGRldmljZQoKLS0t
CiBwbHVnaW5zL3VkZXYuYyB8ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMo
KyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcGx1Z2lucy91ZGV2LmMgYi9wbHVnaW5z
L3VkZXYuYwppbmRleCBhODliOWQ5Li45NjRhYzY1IDEwMDY0NAotLS0gYS9wbHVnaW5zL3VkZXYu
YworKysgYi9wbHVnaW5zL3VkZXYuYwpAQCAtMTEyLDYgKzExMiw3IEBAIHN0YXRpYyB2b2lkIGFk
ZF9tYm0oc3RydWN0IG9mb25vX21vZGVtICptb2RlbSwKIAkJcmV0dXJuOwogCiAJaWYgKGdfc3Ry
X2hhc19zdWZmaXgoZGVzYywgIk1pbmljYXJkIE1vZGVtIikgfHwKKwkJCWdfc3RyX2hhc19zdWZm
aXgoZGVzYywgIk1pbmljYXJkIE1vZGVtIDIiKSB8fAogCQkJZ19zdHJfaGFzX3N1ZmZpeChkZXNj
LCAiTWluaS1DYXJkIE1vZGVtIikgfHwKIAkJCWdfc3RyX2hhc19zdWZmaXgoZGVzYywgIkJyb2Fk
YmFuZCBNb2RlbSIpIHx8CiAJCQlnX3N0cl9oYXNfc3VmZml4KGRlc2MsICJCcm9hZGJhbmQgVVNC
IE1vZGVtIikpIHsKLS0gCjEuNi42LjEKCg==

--===============4539407058215550849==--

