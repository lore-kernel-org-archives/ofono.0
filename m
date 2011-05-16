Content-Type: multipart/mixed; boundary="===============2342312947041613001=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v5 0/5] Private network request to ConnMan
Date: Mon, 16 May 2011 14:37:32 +0200
Message-ID: <1305549457-32298-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2342312947041613001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Changelog from v4:
	- add new header and its reference into Makefile.am
	- close fd for each ppp_net_new() error
	- close fd into emulator when there are memory errors
	- copy into application memory private network settings returned by
	  ConnMan
	- add redundant marker when request needs to be cancelled
	- check error in ConnMan DBus reply to call accordingly release DBus
	  method

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
 gatchat/ppp_net.c         |   38 ++++--
 include/private-network.h |   56 +++++++++
 plugins/connman.c         |  299 +++++++++++++++++++++++++++++++++++++++++=
++++
 src/emulator.c            |   75 ++++++++++--
 src/ofono.h               |    6 +
 src/private-network.c     |   91 ++++++++++++++
 10 files changed, 582 insertions(+), 29 deletions(-)
 create mode 100644 include/private-network.h
 create mode 100644 plugins/connman.c
 create mode 100644 src/private-network.c


--===============2342312947041613001==--

