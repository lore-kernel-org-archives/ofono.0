Content-Type: multipart/mixed; boundary="===============0969079110958124674=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 0/3] Use sim atom with cdma modems
Date: Wed, 16 Nov 2011 15:48:58 +0100
Message-ID: <1321454941-32022-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0969079110958124674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This set of patch allows to use "atmodem" sim atom with CDMA modems.
In this way IMSI can be retrieved for CDMA modems without using the sim file
system.
IMSI is needed by:
	- oFono to store credentials while completing a data call.
	- oFono to store voicecall numbers.
	- ofono plugin from ConnMan to publish cellular service to
	  complete a data call with CDMA modems.

Guillaume Zajac (3):
  include: Add public API to create cdma_sim
  sim: Don't use sim file system for CDMA sim
  huaweicdma: Add SIM creation and set_online method driver

 include/sim.h        |    4 +
 plugins/huaweicdma.c |  303 ++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/sim.c            |   66 ++++++++++--
 3 files changed, 358 insertions(+), 15 deletions(-)


--===============0969079110958124674==--

