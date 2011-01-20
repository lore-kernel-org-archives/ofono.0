Content-Type: multipart/mixed; boundary="===============4678340840223501641=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-auth PATCH 0/5] SIM Authentication D-Bus API
Date: Thu, 20 Jan 2011 18:53:17 +0200
Message-ID: <1295542402-26857-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4678340840223501641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Hi all,

Here is my proposed SIM authentication API, marked as experimental.

First two patches are hopefully easy to swallow. The uglier GBA_U part
and some generic GBA blather can be found in last three patches.

Unfortunately the IMS support requires GBA_U.

--Pekka

Pekka Pessi (5):
  Add doc/sim-authentication-api.txt
  Add doc/sim-authentication-api.txt to dist
  Add GBA_U to SIM authentication API
  Add doc/gba-authentication.txt
  Add doc/gba-authentication.txt to dist

 Makefile.am                    |    5 +-
 doc/gba-authentication.txt     |   70 ++++++++++++++++
 doc/sim-authentication-api.txt |  171 ++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 244 insertions(+), 2 deletions(-)
 create mode 100644 doc/gba-authentication.txt
 create mode 100644 doc/sim-authentication-api.txt


--===============4678340840223501641==--

