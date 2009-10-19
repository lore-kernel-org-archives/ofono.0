Content-Type: multipart/mixed; boundary="===============3026327189618107848=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: [PATCH] When setting the serial port,
 the previous settings need to  be preserved.
Date: Mon, 19 Oct 2009 16:28:01 +0200
Message-ID: <632f5f310910190728l2256681es4f8627b179d1ec84@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3026327189618107848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

This took a while to locate. Shouldn't it be possible to use stty
outside the daemon, and then daemon would just continue as usual?

In my case, the cread was being removed, so no input data could be read.

Thanks,
Ryan

Signed-off-by: Ryan M. Raasch <ryan.raasch@gmail.com>
---
 gatchat/gattty.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

--===============3026327189618107848==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-When-setting-the-serial-port-the-previous-settings-n.patch"

ZGlmZiAtLWdpdCBhL2dhdGNoYXQvZ2F0dHR5LmMgYi9nYXRjaGF0L2dhdHR0eS5jDQppbmRleCA2
M2QyNmQ0Li5lZDBmYWRmIDEwMDY0NA0KLS0tIGEvZ2F0Y2hhdC9nYXR0dHkuYw0KKysrIGIvZ2F0
Y2hhdC9nYXR0dHkuYw0KQEAgLTIyMCw2ICsyMjAsNyBAQCBzdGF0aWMgaW50IG9wZW5fZGV2aWNl
KGNvbnN0IGNoYXIgKnR0eSwgR0hhc2hUYWJsZSAqb3B0aW9ucykNCiAJaWYgKGZkIDwgMCkNCiAJ
CXJldHVybiAtMTsNCiANCisJdGNnZXRhdHRyKGZkLCZ0aSk7DQogCXRjZmx1c2goZmQsIFRDSU9G
TFVTSCk7DQogCXRjc2V0YXR0cihmZCwgVENTQU5PVywgJnRpKTsNCiANCg==

--===============3026327189618107848==--

