Content-Type: multipart/mixed; boundary="===============8687328783404928997=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 0/2] Create sim atom for CDMA modems
Date: Wed, 11 Jan 2012 17:23:30 +0100
Message-ID: <1326299012-13084-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8687328783404928997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

First patch creates a new sim driver without elementary file entries named =
"atmodem-noef"
Second patch creates a sim atom for CDMA modem that uses this drivers in ca=
se sim state is not embedded.

Kind regards,
Guillaume

Guillaume Zajac (2):
  atmodem: Create new sim driver without EF entries
  huawei: Create sim atom for cdma modems

 drivers/atmodem/sim.c |   16 ++++++++++++++++
 plugins/huawei.c      |   12 ++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)


--===============8687328783404928997==--

