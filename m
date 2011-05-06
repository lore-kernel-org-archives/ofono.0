Content-Type: multipart/mixed; boundary="===============2333401243532430656=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v4 0/5] Private network request to ConnMan
Date: Fri, 06 May 2011 16:01:48 +0200
Message-ID: <1304690513-3137-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2333401243532430656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Changelog from v3 is:
	- Add private-network source/include
	- ConnMan plugin is independant from emulator
	- Each application that need VPN will pass a callback as argument
	  when private network is requested. This callback will contain the
	  private network settings.

Guillaume Zajac (5):
  gatppp: Add new contructor to use external fd
  private-network: add callback typedef drivers and settings
  private-network: add request/release functions and new feature to
    Makefile.am
  emulator: add request/release private network calls
  connman: add plugin in oFono to request request/release private
    network

 Makefile.am               |   10 +-
 gatchat/gatppp.c          |   33 +++++-
 gatchat/gatppp.h          |    1 +
 gatchat/ppp.h             |    2 +-
 gatchat/ppp_net.c         |   40 ++++---
 include/private-network.h |   59 +++++++++
 plugins/connman.c         |  297 +++++++++++++++++++++++++++++++++++++++++=
++++
 src/emulator.c            |   49 ++++++--
 src/ofono.h               |    6 +
 src/private-network.c     |   89 ++++++++++++++
 10 files changed, 556 insertions(+), 30 deletions(-)
 create mode 100644 include/private-network.h
 create mode 100644 plugins/connman.c
 create mode 100644 src/private-network.c


--===============2333401243532430656==--

