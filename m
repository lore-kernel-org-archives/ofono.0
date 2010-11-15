Content-Type: multipart/mixed; boundary="===============4888997187428694557=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: [RFC PATCH 0/2] Differentiate HSPA technologies
Date: Mon, 15 Nov 2010 15:23:46 +0100
Message-ID: <ec27632d1746f72703cc59e1f2cadf2a@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4888997187428694557==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


   Hello,

In some use cases, I need to be able to list the active and available
technologies. This patch set splits the three HSPA modes to enable which
this requires.

R=C3=A9mi Denis-Courmont (2):
      Distinguish HSDPA, HSUPA or both as access technologies
      Update the network documentation

 doc/network-api.txt |    5 +++--
 src/common.c        |    4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net
http://fi.linkedin.com/in/remidenis


--===============4888997187428694557==--

