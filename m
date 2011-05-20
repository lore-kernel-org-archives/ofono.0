Content-Type: multipart/mixed; boundary="===============6449668130333297840=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v6 0/5] Escape sequence and ATO0 implementation
Date: Fri, 20 May 2011 11:38:11 +0200
Message-ID: <1305884296-2601-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6449668130333297840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Change log from v5:
	- regroups multiple patches in one patch
	- contains ATO0 implementation
	- contains all resume function
	- contains fix for not removing io_disconnect function
	  while unrefing GAtPPP if it is suspended

Guillaume Zajac (5):
  gathdlc: add g_at_hdlc_resume() API
  ppp_net: add ppp_net_resume_interface() API
  gatppp: add public suspend/resume APIs and suspended state
  emulator: add dun_ato_cb() definition and register it in GAtServer
  gsmdial: add escape sequence/ATH0/ATO0 testing option

 gatchat/gathdlc.c |   16 +++++++++++
 gatchat/gathdlc.h |    1 +
 gatchat/gatppp.c  |   64 +++++++++++++++++++++++++++++++++++++++++++++-
 gatchat/gatppp.h  |    2 +
 gatchat/gsmdial.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 gatchat/ppp.h     |    1 +
 gatchat/ppp_net.c |   10 +++++++
 src/emulator.c    |   54 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 219 insertions(+), 2 deletions(-)


--===============6449668130333297840==--

