Content-Type: multipart/mixed; boundary="===============1060746626579571681=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: [PATCH] Fix set default baud rate to 115200
Date: Tue, 05 Jan 2010 16:39:38 +0800
Message-ID: <8B81FACE836F9248894A7844CC0BA814176735A7E6@shzsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1060746626579571681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I found N900 could not be powered on by atgen driver due to baud rate probl=
em.
If I add 'Baud=3D115200' into modem.conf, everything is fine. In gatchat/ga=
ttty.c,
the default baud rate is B0 which looks not correct, so I wonder whether we
should set the default baud rate to some values like minicom does.

My proposed fix was attached.

Regards,
Zhenhua
=20

--===============1060746626579571681==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Fix-set-default-baud-rate-to-115200.patch"

RnJvbSBiMmIyYjI2YTg1ZjkxNjVkZjU4MmRjYzhjMzMyZmMwMTkxYTI5ZDgwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGVuaHVhIFpoYW5nIDx6aGVuaHVhLnpoYW5nQGludGVsLmNv
bT4KRGF0ZTogVHVlLCA1IEphbiAyMDEwIDE2OjIzOjA4ICswODAwClN1YmplY3Q6IFtQQVRDSF0g
Rml4IHNldCBkZWZhdWx0IGJhdWQgcmF0ZSB0byAxMTUyMDAKCi0tLQogZ2F0Y2hhdC9nYXR0dHku
YyB8ICAgIDIgKysKIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2dhdGNoYXQvZ2F0dHR5LmMgYi9nYXRjaGF0L2dhdHR0eS5jCmlu
ZGV4IDAyY2EzODkuLjk0ZWMzN2YgMTAwNjQ0Ci0tLSBhL2dhdGNoYXQvZ2F0dHR5LmMKKysrIGIv
Z2F0Y2hhdC9nYXR0dHkuYwpAQCAtMTk4LDYgKzE5OCw4IEBAIHN0YXRpYyBpbnQgb3Blbl9kZXZp
Y2UoY29uc3QgY2hhciAqdHR5LCBHSGFzaFRhYmxlICpvcHRpb25zKQogCW1lbXNldCgmdGksIDAs
IHNpemVvZih0aSkpOwogCWNmbWFrZXJhdygmdGkpOwogCisJc2V0X2JhdWQoIjExNTIwMCIsICZ0
aSk7CisKIAlpZiAob3B0aW9ucykgewogCQlHSGFzaFRhYmxlSXRlciBpdGVyOwogCQljb25zdCBj
aGFyICprZXk7Ci0tIAoxLjYuMy4zCgo=

--===============1060746626579571681==--

