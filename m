Content-Type: multipart/mixed; boundary="===============6814836724670982617=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v3 0/2] add profile version to HandsfreeAgent
Date: Mon, 08 Aug 2011 16:34:39 +0200
Message-ID: <1312814081-15279-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6814836724670982617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some phones with HFP Audio Gateway version previous to 1.5 (i.e.
Samsung SGH-D600 returning 0x0101 as profile version) do not accept
an AT+BRSF with latest features.
The Handsfree agent should adapt its AT+BRSF command depending on the
remote version, so add version information as parameter of
NewConnection method.
For localhfp modem, use the highest version possible (0xFFFF) so it
will always send all implemented features.

Fr=C3=A9d=C3=A9ric Danis (2):
  hfpmodem: fix hf features
  hfp_hf: retrieve AG version

 drivers/hfpmodem/slc.c |    7 ++++++-
 drivers/hfpmodem/slc.h |    5 ++++-
 plugins/hfp_hf.c       |    9 +++++----
 plugins/phonesim.c     |    2 +-
 4 files changed, 16 insertions(+), 7 deletions(-)


--===============6814836724670982617==--

