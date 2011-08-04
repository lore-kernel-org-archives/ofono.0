Content-Type: multipart/mixed; boundary="===============6380810401729612505=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 0/2] add profile version to HandsfreeAgent
Date: Thu, 04 Aug 2011 14:55:42 +0200
Message-ID: <1312462544-21581-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6380810401729612505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some phones with HFP Audio Gateway version previous to 1.5 (i.e.
Samsung SGH-D600 returning 0x0101 as profile version) do not accept
an AT+BRSF with latest features.
The Handsfree agent should adapt its AT+BRSF command depending on the
remote version, so add version information as parameter of
NewConnection method.

Fr=C3=A9d=C3=A9ric Danis (2):
  hfpmodem: fix hf features
  hfp_hf: retrieve AG version

 drivers/hfpmodem/slc.c |    5 +++++
 drivers/hfpmodem/slc.h |    1 +
 plugins/hfp_hf.c       |    7 ++++---
 3 files changed, 10 insertions(+), 3 deletions(-)


--===============6380810401729612505==--

