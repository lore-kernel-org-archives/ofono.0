Content-Type: multipart/mixed; boundary="===============1048733262967331803=="
MIME-Version: 1.0
From: iiro.kaihlaniemi@nokia.com
Subject: [PATCH 0/5] isimodem: Add functionality to UICC
Date: Wed, 03 Aug 2011 10:39:36 +0000
Message-ID: <6B9DA0A3415B234191A1ADFA6275C51CB2409D@008-AM1MPN1-041.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1048733262967331803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds some functionality to UICC which has been pretty much dummy=
 so far.

 Makefile.am              |    3 +-
 drivers/isimodem/debug.c |  121 +++++
 drivers/isimodem/debug.h |    2 +
 drivers/isimodem/uicc.c  | 1282 ++++++++++++++++++++++++++++++++++++++++++=
+---
 drivers/isimodem/uicc.h  |   11 +-
 5 files changed, 1346 insertions(+), 73 deletions(-)


--===============1048733262967331803==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWwgZGlyPSJsdHIiPgo8aGVhZD4KPG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBj
b250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9aXNvLTg4NTktMSI+CjxzdHlsZSBpZD0ib3dhUGFy
YVN0eWxlIiB0eXBlPSJ0ZXh0L2NzcyI+UCB7bWFyZ2luLXRvcDowO21hcmdpbi1ib3R0b206MDt9
PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBvY3NpPSIwIiBmcHN0eWxlPSIxIj4KPGRpdiBzdHlsZT0i
ZGlyZWN0aW9uOiBsdHI7Zm9udC1mYW1pbHk6IFRhaG9tYTtjb2xvcjogIzAwMDAwMDtmb250LXNp
emU6IDEwcHQ7Ij5UaGlzIHBhdGNoIGFkZHMgc29tZSBmdW5jdGlvbmFsaXR5IHRvIFVJQ0Mgd2hp
Y2ggaGFzIGJlZW4gcHJldHR5IG11Y2ggZHVtbXkgc28gZmFyLjxicj4KPGJyPgombmJzcDtNYWtl
ZmlsZS5hbSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB8Jm5ic3A7Jm5ic3A7Jm5ic3A7IDMgJiM0Mzst
PGJyPgombmJzcDtkcml2ZXJzL2lzaW1vZGVtL2RlYnVnLmMgfCZuYnNwOyAxMjEgJiM0MzsmIzQz
OyYjNDM7JiM0MzsmIzQzOzxicj4KJm5ic3A7ZHJpdmVycy9pc2ltb2RlbS9kZWJ1Zy5oIHwmbmJz
cDsmbmJzcDsmbmJzcDsgMiAmIzQzOzxicj4KJm5ic3A7ZHJpdmVycy9pc2ltb2RlbS91aWNjLmMm
bmJzcDsgfCAxMjgyICYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQz
OyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0Mzsm
IzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0
MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7
LS0tPGJyPgombmJzcDtkcml2ZXJzL2lzaW1vZGVtL3VpY2MuaCZuYnNwOyB8Jm5ic3A7Jm5ic3A7
IDExICYjNDM7LTxicj4KJm5ic3A7NSBmaWxlcyBjaGFuZ2VkLCAxMzQ2IGluc2VydGlvbnMoJiM0
MzspLCA3MyBkZWxldGlvbnMoLSk8YnI+Cjxicj4KPC9kaXY+CjwvYm9keT4KPC9odG1sPgo=

--===============1048733262967331803==--

