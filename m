Content-Type: multipart/mixed; boundary="===============1481539443605455076=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 0/4] Request Private Network creation to ConnMan
Date: Fri, 22 Apr 2011 12:02:39 +0200
Message-ID: <1303466563-3111-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1481539443605455076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This set of patch allow to enable a data call from DUN client to DUN server.
DUN server is a Ubuntu computer running with BlueZ, ConnMan and oFono.
ConnMan will use default available interface to connect to Internet.
DUN client can open an Internet page and browse it.


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
 plugins/connman.c  |  239 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/emulator.c     |   75 +++++++++++++++--
 8 files changed, 391 insertions(+), 29 deletions(-)
 create mode 100644 plugins/connman.c


--===============1481539443605455076==--

