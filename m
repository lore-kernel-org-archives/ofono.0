Content-Type: multipart/mixed; boundary="===============5770233348668920060=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v1 0/2] cdma-connman add roaming support
Date: Mon, 05 Dec 2011 12:04:00 +0100
Message-ID: <1323083042-24416-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5770233348668920060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Change log from v0:
	- Remove cdma-netreg status watches
	- Only change the property RomaingAllowed.
	- Don't change the data call state when the property is changed.

Kind regards,
Guilllaume

Guillaume Zajac (2):
  doc: Add RoamingAllowed property
  cdma-connman: Add RoamingAllowed support

 doc/cdma-connman-api.txt |    8 ++++++++
 src/cdma-connman.c       |   19 ++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletions(-)


--===============5770233348668920060==--

