Content-Type: multipart/mixed; boundary="===============6849210077894420836=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v6 0/5] *** SUBJECT HERE ***
Date: Thu, 19 May 2011 11:55:29 +0200
Message-ID: <1305798934-14242-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6849210077894420836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

*** BLURB HERE ***

Guillaume Zajac (5):
  gatppp: Add new contructor to use external fd
  private-network: add header into include and Makefile.am
  private-network: add request/release functions and new feature to
    Makefile.am
  emulator: add request/release private network calls
  connman: add plugin in oFono to request/release private network

 Makefile.am               |   10 +-
 gatchat/gatppp.c          |   33 +++++-
 gatchat/gatppp.h          |    1 +
 gatchat/ppp.h             |    2 +-
 gatchat/ppp_net.c         |   47 +++++---
 include/private-network.h |   56 +++++++++
 plugins/connman.c         |  299 +++++++++++++++++++++++++++++++++++++++++=
++++
 src/emulator.c            |   75 ++++++++++--
 src/ofono.h               |    6 +
 src/private-network.c     |   91 ++++++++++++++
 10 files changed, 590 insertions(+), 30 deletions(-)
 create mode 100644 include/private-network.h
 create mode 100644 plugins/connman.c
 create mode 100644 src/private-network.c


--===============6849210077894420836==--

