Content-Type: multipart/mixed; boundary="===============7767806676776686839=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv3 0/9] Quectel M95 support
Date: Wed, 10 Jul 2019 23:51:39 +0200
Message-ID: <20190710215148.78083-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7767806676776686839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes since v1/v2:
 * remove c types patch
 * add patch with m95 sms quirks
 * add patch to query device model
 * add patch to create voicecall, phonebook, and sms functionality
 * add patch to enable flow control on modem if configured

Martin Hundeb=C3=B8ll (9):
  atmodem: sms: add quectel m95 quirks
  quectel: always print modem pointer in debug messages
  quectel: unwrap call to at_util_open_device()
  quectel: replace glib uses with ell
  quectel: add basic support for serial connected modems
  quectel: support gpio to power on/off the modem
  quectel: configure flow control when enabled
  quectel: query device model to enable vendor quirks
  quectel: initialize call, phonebook and sms when ready

 drivers/atmodem/sms.c |  24 ++-
 plugins/quectel.c     | 491 ++++++++++++++++++++++++++++++++++++++----
 plugins/udevng.c      |  32 ++-
 3 files changed, 494 insertions(+), 53 deletions(-)

-- =

2.22.0


--===============7767806676776686839==--

