Content-Type: multipart/mixed; boundary="===============7422491729566906794=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: [PATCH v5 0/2] Telit LE910 V1 QMI support
Date: Mon, 27 Mar 2017 09:56:16 +0100
Message-ID: <1490604978-10639-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7422491729566906794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lukasz Nowak <lnowak@tycoint.com>

Changes from V3:
- dropped patch:
	[PATCH v4 2/3] udevng: find vendor and product id for child devices =

  instead, this patch set now depends on one from Jonas:
	[PATCH udev 01/15] udevng: simplify logic in check_usb_device
- removed unused "Modem" string from telitqmi

Changes from V3:
- fixed a major synchronization problem in core qmimodem code
  It was not doing anything bad by pure chance. With some of the
  other changes, memory layout has moved around, and the code
  was reliably segfaulting during modem physical power cycle
- added feature to udevng to discover usb vendor:product id
  for child devices, which previously were reporting null:null
- with the vendor:product id available for all devices,
  separated setup function from setup_gobi into setup_telitqmi


Changes from V2:
- made AlwaysOnline flow cleaner in gobi.c
- it turns out that AlwaysOnline is already a part of core logic
  in src/modem.c which have the same effect as if the driver had
  no set_online() function at all. Hence removed changes to
  gobi_set_online() as it is never called.


Changes from V1:
- split into multiple smaller commits
- added comments in code, documenting issues with the Telit QMI firmware
- disabled non-working low-power operating modes in additional cases
- use mccmnc string instead of truncating an invalid operator name

Lukasz Nowak (2):
  qmimodem: add protection against modem_unregister
  udevng: add Telit LE910 V1 support

 drivers/qmimodem/qmi.c | 39 +++++++++++++++++++++++++++++++++------
 drivers/qmimodem/qmi.h |  2 +-
 plugins/udevng.c       | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 7 deletions(-)

-- =

2.7.4


--===============7422491729566906794==--

