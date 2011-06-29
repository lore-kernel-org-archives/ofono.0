Content-Type: multipart/mixed; boundary="===============0734916166526556831=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v4 0/4] ACFC and PFC options implementation
Date: Wed, 29 Jun 2011 10:20:22 +0200
Message-ID: <1309335626-32202-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0734916166526556831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Change log from v3:
	- Fix some style issues
	- update g_at_ppp_set_[acfc/pfc]_enabled() signatures
	- update lcp functions setting acfc/pfc options
	- we can now enable/disable ACFC or PFC to re-use the PPP object
	  with different parameters

Guillaume Zajac (4):
  GAtPPP: Add ACFC option support
  GAtPPP: Add PFC option support
  emulator: Activate ACFC and PFC options onto GAtPPP object
  gsmdial: Activate ACFC and PFC options on GAtPPP object

 gatchat/gatppp.c  |  155 +++++++++++++++++++++++++++++++++++++++++++++----=
----
 gatchat/gatppp.h  |    3 +
 gatchat/gsmdial.c |    3 +
 gatchat/ppp.h     |   12 ++++
 gatchat/ppp_lcp.c |   64 +++++++++++++++++++++-
 src/emulator.c    |    3 +
 6 files changed, 215 insertions(+), 25 deletions(-)


--===============0734916166526556831==--

