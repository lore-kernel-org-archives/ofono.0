Content-Type: multipart/mixed; boundary="===============2129261442002434235=="
MIME-Version: 1.0
From: Oskari Timperi <oskari.timperi@ixonos.com>
Subject: [PATCHv3 0/2] Support for Cinterion TC65
Date: Wed, 29 Dec 2010 11:55:08 +0200
Message-ID: <1293616510-18042-1-git-send-email-oskari.timperi@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2129261442002434235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches add initial support for Cinterion TC65 modem.

Oskari Timperi (2):
  Add a plugin for Cinterion TC65 modem
  udev: Handle TC65 modem

 Makefile.am    |    3 +
 plugins/tc65.c |  265 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/udev.c |   15 +++
 3 files changed, 283 insertions(+), 0 deletions(-)
 create mode 100644 plugins/tc65.c

-- See us at Mobile World Congress, 14-17 February 2011, in Barcelona, Spai=
n. Visit the Ixonos booth Hall 1, # 1E19.


--===============2129261442002434235==--

