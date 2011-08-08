Content-Type: multipart/mixed; boundary="===============5939717835819395171=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 0/2] add profile version to HandsfreeAgent
Date: Mon, 08 Aug 2011 15:45:40 +0200
Message-ID: <1312811142-13831-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5939717835819395171==
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
 drivers/hfpmodem/slc.h |    2 +-
 plugins/hfp_hf.c       |    9 +++++----
 plugins/phonesim.c     |    2 +-
 4 files changed, 13 insertions(+), 7 deletions(-)


--===============5939717835819395171==--

