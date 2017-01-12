Content-Type: multipart/mixed; boundary="===============1586781759428575187=="
MIME-Version: 1.0
From: Vincent Cesson <cesson.vincent@gmail.com>
Subject: [RFC 0/3] Add Gemalto Cinterion P-Family support
Date: Thu, 12 Jan 2017 18:06:49 +0100
Message-ID: <1484240812-3327-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1586781759428575187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The following patches add support of Gemalto Cinterion P-family modems. It =
is tested on PHS8.

There is already a plugin based on TC65 and renamed from "tc65" to "cinteri=
on" during support of EHS6. But PHS8 is too different. In particular, it ne=
eds several USB interfaces to handle Application, Modem and GPS. The curren=
t plugin does not support these interfaces so I think it is safer to create=
 a new plugin. I used "gemalto" as an alternative name but you might have a=
 better proposal.

The new gemalto plugin is based on cinterion, while udevng part is based on=
 telit. Support includes network registration and SMS sending for now. Data=
 is not functional yet because of a bug in atmodem driver but I will propos=
e a patch alongside. Also I plan to add support of gnss.

Waiting for your comments. Regards,
Vincent

vcesson (3):
  plugins: Add Gemalto plugin for Cinterion P-family
  udevng: Add Gemalto P-family detection
  build: Add Gemalto plugin in Makefile

 Makefile.am       |   3 +
 plugins/gemalto.c | 265 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/udevng.c  |  38 ++++++++
 3 files changed, 306 insertions(+)
 create mode 100644 plugins/gemalto.c

-- =

1.9.1


--===============1586781759428575187==--

