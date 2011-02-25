Content-Type: multipart/mixed; boundary="===============5380574165278122314=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH net-next 0/6] Phonet: small pipe protocol fixes
Date: Fri, 25 Feb 2011 11:13:41 +0200
Message-ID: <201102251113.41620.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5380574165278122314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

	Hello,

This patch series cleans up and fixes a number of small bits in the Phonet =
pipe code, especially the experimental pipe =

controller. Once this small bits are sorted out, I will try to fix the cont=
roller protocol implementation proper so that we do not =

need the compile-time (experimental) flag anymore.

Comments welcome,

 include/net/phonet/pep.h    |   22 ----
 include/net/phonet/phonet.h |    1 =

 net/phonet/af_phonet.c      |   19 ++-
 net/phonet/pep.c            |  240 +++++++++++++++------------------------=
-----
 net/phonet/socket.c         |   14 +-
 5 files changed, 106 insertions(+), 190 deletions(-)

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/

--===============5380574165278122314==--

