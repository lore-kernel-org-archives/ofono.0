Content-Type: multipart/mixed; boundary="===============1242726952758390805=="
MIME-Version: 1.0
From: oskari.timperi@ixonos.com
Subject: [PATCHv4 0/2] Support for Cinterion TC65
Date: Mon, 10 Jan 2011 01:44:46 +0200
Message-ID: <1294616688-17246-1-git-send-email-oskari.timperi@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1242726952758390805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Oskari Timperi <oskari.timperi@iki.fi>

These patches add initial support for Cinterion TC65 modem.

Hopefully no-one is messing with my tabs so that these are in
good order. :-)

Oskari Timperi (2):
  Add plugin for Cinterion TC65 modem
  udev: Handle TC65 modem

 Makefile.am    |    3 +
 plugins/tc65.c |  265 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/udev.c |   15 +++
 3 files changed, 283 insertions(+), 0 deletions(-)
 create mode 100644 plugins/tc65.c


--===============1242726952758390805==--

