Content-Type: multipart/mixed; boundary="===============0744201069758378452=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 0/7] Move GPRS attach logic to the modem
Date: Mon, 07 Feb 2011 16:02:19 +0200
Message-ID: <201102071602.20179.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0744201069758378452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

	Hello,

This series moves responsibility for GPRS attach to the modem.

In most cases, the modem will attach on-demand when a first context is
activated. This simplifies the oFono interface and implementation.

Some operators require the device be always attached. This is managed
by a new driver callback to set the attach policy.

TBD: configuration option for the policy

 doc/connman-api.txt     |    8 -
 drivers/atmodem/gprs.c  |   30 +-----
 drivers/isimodem/gprs.c |  131 ++++-----------------------
 include/gprs.h          |    3 =

 src/dbus.c              |   13 --
 src/gprs.c              |  232 ++-----------------------------------------=
-----
 src/ofono.h             |    2 =

 7 files changed, 45 insertions(+), 374 deletions(-)

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============0744201069758378452==--

