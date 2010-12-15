Content-Type: multipart/mixed; boundary="===============6727058703872710990=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.uklinux.net>
Subject: PATCH: Enable udev-based autodetection of calypso modem on Freerunner
Date: Wed, 15 Dec 2010 22:12:16 +0000
Message-ID: <87ipyud6tb.fsf@ossau.uklinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6727058703872710990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

With the patch below, ofono-0.36 (the current Debian unstable version)
detects the calypso modem on my freerunner.  (Whereas without it, it
doesn't.)

I don't feel confident that the ofono.rules change is in its nicest
possible form, and (IIUC) it's dependent on these earlier rules in
/lib/udev/rules.d/55-openmoko-gta01-gta02.rules on my phone:

# Samsung UARTS
KERNEL=3D=3D"s3c2410_serial[0-9]",   NAME=3D"ttySAC%n"
KERNEL=3D=3D"ttySAC[0-9]",   NAME=3D"ttySAC%n"

Given that the actual udev DB entry, under 2.6.34, is:

P: /devices/platform/s3c2440-uart.0/tty/ttySAC0
N: ttySAC0
S: char/204:64
E: UDEV_LOG=3D3
E: DEVPATH=3D/devices/platform/s3c2440-uart.0/tty/ttySAC0
E: MAJOR=3D204
E: MINOR=3D64
E: DEVNAME=3D/dev/ttySAC0
E: SUBSYSTEM=3Dtty
E: DEVLINKS=3D/dev/char/204:64

what's the neatest way of writing a udev rule for that?

Regards,
        Neil



--===============6727058703872710990==
Content-Type: text/x-diff
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Enable-udev-based-autodetection-of-calypso-modem-on-.patch"

PkZyb20gNzljYzYzYzMwZGRlZDI2OWNkYjhlOGRiYmE3ODAzNjg0N2Y2MzU3ZSBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogTmVpbCBKZXJyYW0gPG5laWxAb3NzYXUudWtsaW51eC5uZXQ+
CkRhdGU6IFdlZCwgMTUgRGVjIDIwMTAgMjE6NTY6NTAgKzAwMDAKU3ViamVjdDogW1BBVENIXSBF
bmFibGUgdWRldi1iYXNlZCBhdXRvZGV0ZWN0aW9uIG9mIGNhbHlwc28gbW9kZW0gb24gRnJlZXJ1
bm5lcgoKQXMgaHR0cHM6Ly9vZm9uby5vcmcvd2lraS9vZm9uby1zdXBwb3J0ZWQtbW9kZW1zIHNh
eXMgZm9yIGNhbHlwc286ICJJdAp3b3JrcyB3aXRoIG1vZGVtLmNvbmYuIEhvd2V2ZXIgaXQgbWF5
IG5lZWQgdWRldiBydWxlIG5vdy4iICBUaGlzIHBhdGNoCmFkZHJlc3NlcyB0aGF0LgoKKiBwbHVn
aW5zL3VkZXYuYyAoYWRkX2NhbHlwc28pOiBOZXcgZnVuY3Rpb24uCiAgKGFkZF9tb2RlbSk6IENh
bGwgYWRkX2NhbHlwc28gZm9yICJjYWx5cHNvIiBkcml2ZXIuCgoqIHBsdWdpbnMvb2Zvbm8ucnVs
ZXM6IEFkZCB1ZGV2IHJ1bGVzIGZvciBGcmVlcnVubmVyIGNhbHlwc28gdW5kZXIKICAyLjYuMjkg
YW5kIDIuNi4zNCBrZXJuZWxzLgotLS0KIHBsdWdpbnMvb2Zvbm8ucnVsZXMgfCAgICA3ICsrKysr
KysKIHBsdWdpbnMvdWRldi5jICAgICAgfCAgIDE2ICsrKysrKysrKysrKysrKysKIDIgZmlsZXMg
Y2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9w
bHVnaW5zL29mb25vLnJ1bGVzIGIvcGx1Z2lucy9vZm9uby5ydWxlcwppbmRleCBkYThhOGVmLi5h
MGZkYzk2IDEwMDY0NAotLS0gYS9wbHVnaW5zL29mb25vLnJ1bGVzCisrKyBiL3BsdWdpbnMvb2Zv
bm8ucnVsZXMKQEAgLTIsNiArMiwxMyBAQAogCiBBQ1RJT04hPSJhZGR8Y2hhbmdlIiwgR09UTz0i
b2Zvbm9fZW5kIgogCitTVUJTWVNURU0hPSJ0dHkiLCBHT1RPPSJvZm9ub19jYWx5cHNvX2VuZCIK
K05BTUUhPSJ0dHlTQUMwKiIsIEdPVE89Im9mb25vX2NhbHlwc29fZW5kIgorCitFTlZ7T0ZPTk9f
RFJJVkVSfT0iY2FseXBzbyIKKworTEFCRUw9Im9mb25vX2NhbHlwc29fZW5kIgorCiBTVUJTWVNU
RU0hPSJ0dHkiLCBHT1RPPSJvZm9ub190dHlfZW5kIgogS0VSTkVMIT0idHR5VVNCWzAtOV0qIiwg
R09UTz0ib2Zvbm9fdHR5X2VuZCIKIApkaWZmIC0tZ2l0IGEvcGx1Z2lucy91ZGV2LmMgYi9wbHVn
aW5zL3VkZXYuYwppbmRleCAyNTU3NTVlLi44MzdlZTljIDEwMDY0NAotLS0gYS9wbHVnaW5zL3Vk
ZXYuYworKysgYi9wbHVnaW5zL3VkZXYuYwpAQCAtNDQ5LDYgKzQ0OSwyMCBAQCBzdGF0aWMgdm9p
ZCBhZGRfaXNpKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0sCiAJb2Zvbm9fbW9kZW1fcmVnaXN0
ZXIobW9kZW0pOwogfQogCitzdGF0aWMgdm9pZCBhZGRfY2FseXBzbyhzdHJ1Y3Qgb2Zvbm9fbW9k
ZW0gKm1vZGVtLAorCQkJCQlzdHJ1Y3QgdWRldl9kZXZpY2UgKnVkZXZfZGV2aWNlKQoreworCXN0
cnVjdCB1ZGV2X2xpc3RfZW50cnkgKmVudHJ5OworCWNvbnN0IGNoYXIgKmRldm5vZGU7CisKKwlE
QkcoIm1vZGVtICVwIiwgbW9kZW0pOworCisJZGV2bm9kZSA9IHVkZXZfZGV2aWNlX2dldF9kZXZu
b2RlKHVkZXZfZGV2aWNlKTsKKwlvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLCAiRGV2aWNl
IiwgZGV2bm9kZSk7CisKKwlvZm9ub19tb2RlbV9yZWdpc3Rlcihtb2RlbSk7Cit9CisKIHN0YXRp
YyB2b2lkIGFkZF9tb2RlbShzdHJ1Y3QgdWRldl9kZXZpY2UgKnVkZXZfZGV2aWNlKQogewogCXN0
cnVjdCBvZm9ub19tb2RlbSAqbW9kZW07CkBAIC01MzMsNiArNTQ3LDggQEAgZG9uZToKIAkJYWRk
X2lzaShtb2RlbSwgdWRldl9kZXZpY2UpOwogCWVsc2UgaWYgKGdfc3RyY21wMChkcml2ZXIsICJu
OTAwIikgPT0gMCkKIAkJYWRkX2lzaShtb2RlbSwgdWRldl9kZXZpY2UpOworCWVsc2UgaWYgKGdf
c3RyY21wMChkcml2ZXIsICJjYWx5cHNvIikgPT0gMCkKKwkJYWRkX2NhbHlwc28obW9kZW0sIHVk
ZXZfZGV2aWNlKTsKIH0KIAogc3RhdGljIGdib29sZWFuIGRldnBhdGhfcmVtb3ZlKGdwb2ludGVy
IGtleSwgZ3BvaW50ZXIgdmFsdWUsIGdwb2ludGVyIHVzZXJfZGF0YSkKLS0gCjEuNy4xCgo=

--===============6727058703872710990==--

