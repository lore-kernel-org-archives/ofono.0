Content-Type: multipart/mixed; boundary="===============5494725557406915393=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v3 0/3] Request private network to ConnMan
Date: Tue, 03 May 2011 16:44:40 +0200
Message-ID: <1304433883-3806-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5494725557406915393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Changelog from v2 is:
	- merge patch 3 and 4
	- calls to ConnMan DBus methods are async
	- setup_ppp() function is called from reply of
	  RequestPrivateNetwork() DBus method
	- pending calls are stored into hash table and can be cancelled
	- there is no more struct private_network_settings

Guillaume Zajac (3):
  gatppp: Add new contructor to use external fd
  emulator: add drivers to request/release private network from ConnMan
  connman: add plugin in oFono to request request/release private
    network

 Makefile.am        |    3 +
 gatchat/gatppp.c   |   48 +++++++++-
 gatchat/gatppp.h   |    1 +
 gatchat/ppp.h      |    2 +-
 gatchat/ppp_net.c  |   55 +++++++----
 include/emulator.h |   18 ++++
 plugins/connman.c  |  255 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/emulator.c     |   83 +++++++++++++----
 8 files changed, 420 insertions(+), 45 deletions(-)
 create mode 100644 plugins/connman.c


--===============5494725557406915393==--

