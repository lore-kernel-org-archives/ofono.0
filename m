Content-Type: multipart/mixed; boundary="===============8893420585835516013=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 00/10] quectel serial support
Date: Wed, 03 Jul 2019 20:09:45 +0200
Message-ID: <20190703180955.18246-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8893420585835516013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a complete rework of the quectel m95 plugin posted[1] almost a
year ago. Instead of doing a new plugin, it now hooks in serial support
into the existing quectel driver, and it uses the kernel line discipline
for the gsm 07.10 multiplexing. It also adds gpio power control using
the gpio support in ell.

The cleanups are mostly done to obey my OCD wrt. coding style.

Expect to see further patches adding tweaks as I get around to test
pin unlocking, sms texting, calls, etc.

[1] https://lists.01.org/pipermail/ofono/2018-August/018293.html

Martin Hundeb=C3=B8ll (10):
  gatresult: include glib header
  atutil: guard call to g_hash_table_destroy()
  quectel: improve coding style
  quectel: use plain c-types over glib/ofono typedefs
  quectel: always print modem pointer in debug messages
  quectel: unwrap call to at_util_open_device()
  quectel: replace glib uses with ell
  quectel: split up initial channel/device configuration
  quectel: add basic support for serial connected modems
  quectel: support gpio to power on/off the modem

 drivers/atmodem/atutil.c |   4 +-
 gatchat/gatresult.h      |   2 +
 plugins/quectel.c        | 358 +++++++++++++++++++++++++++++++++------
 plugins/udevng.c         |  42 ++++-
 4 files changed, 351 insertions(+), 55 deletions(-)

-- =

2.22.0


--===============8893420585835516013==--

