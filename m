Content-Type: multipart/mixed; boundary="===============2649394493201375919=="
MIME-Version: 1.0
From: Oskari Timperi <oskari.timperi@ixonos.com>
Subject: [PATCHv2 0/3] Support for Cinterion TC65
Date: Wed, 22 Dec 2010 13:12:59 +0200
Message-ID: <1293016382-4607-1-git-send-email-oskari.timperi@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2649394493201375919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a second try on the matter, with corrections
suggested by Denis.

Oskari Timperi (3):
  Add a plugin for Cinterion TC65 modem
  Add TC65 to Makefile.am
  udev initialization for TC65

 Makefile.am    |    3 +
 plugins/tc65.c |  263 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/udev.c |   15 +++
 3 files changed, 281 insertions(+), 0 deletions(-)
 create mode 100644 plugins/tc65.c

-- See us at Mobile World Congress, 14-17 February 2011, in Barcelona, Spai=
n. Visit the Ixonos booth Hall 1, # 1E19.


--===============2649394493201375919==--

