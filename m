Content-Type: multipart/mixed; boundary="===============6540348058233681293=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [RFC_v2 0/3] Fix crash when network is lost
Date: Fri, 13 Jul 2012 15:44:25 +0200
Message-ID: <1342187068-10418-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6540348058233681293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change log with previous version:
	- Fix naming issue
	- Simplify the logic

Guillaume Zajac (3):
  gprs-context: Add new driver entry
  gprs-context: Add new driver entry definition
  gprs: Release context in driver and core when network is lost

 drivers/atmodem/gprs-context.c |   11 +++++
 include/gprs-context.h         |    2 +
 src/gprs.c                     |   84 ++++++++++++++++++++++++++++++------=
----
 3 files changed, 76 insertions(+), 21 deletions(-)

-- =

1.7.5.4


--===============6540348058233681293==--

