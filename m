Content-Type: multipart/mixed; boundary="===============2212150415507230272=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 0/4] Request private petwork creation to ConnMan
Date: Fri, 22 Apr 2011 14:06:29 +0200
Message-ID: <1303473993-3606-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2212150415507230272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This new version contains some fixes of some typos into plugins/connman.c:
	- in dun_emulator_watch() missing some brackets
	- in connman_init(), multiple return and unused variable err.

Guillaume Zajac (4):
  gatppp: Add new contructor to use external fd
  emulator: add routine to request/release private network from ConnMan
  connman: add plugin in oFono to request request/release private
    network
  Makefile: add connman plugin build

 Makefile.am        |    3 +
 gatchat/gatppp.c   |   43 +++++++++-
 gatchat/gatppp.h   |    2 +
 gatchat/ppp.h      |    2 +-
 gatchat/ppp_net.c  |   46 ++++++----
 include/emulator.h |   10 ++
 plugins/connman.c  |  235 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/emulator.c     |   75 +++++++++++++++--
 8 files changed, 387 insertions(+), 29 deletions(-)
 create mode 100644 plugins/connman.c


--===============2212150415507230272==--

