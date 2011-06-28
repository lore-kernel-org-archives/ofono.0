Content-Type: multipart/mixed; boundary="===============1079558522159701684=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v3 0/4] ACFC and PFC options implementation
Date: Tue, 28 Jun 2011 12:03:43 +0200
Message-ID: <1309255427-10308-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1079558522159701684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Change log from v2 is:
	- restore send_lcp_frame() function
	- global ACFC and PFC activation option is done into lcp_ppp.c
	  using lcp->req_options field
	- add ACFC and PFC options activation into emulator and gsmdial
	- by default ACFC and PFC options are turned off

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
 gatchat/ppp_lcp.c |   55 +++++++++++++++++--
 src/emulator.c    |    3 +
 6 files changed, 205 insertions(+), 26 deletions(-)


--===============1079558522159701684==--

