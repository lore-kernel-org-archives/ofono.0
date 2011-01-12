Content-Type: multipart/mixed; boundary="===============2610399627965007364=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@intel.com>
Subject: [PATCH 00/21] Resubmit Zhenhua Zhang work on DUN server with btio 
Date: Wed, 12 Jan 2011 18:15:43 +0100
Message-ID: <1294852564-1258-1-git-send-email-frederic.dalleau@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2610399627965007364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is rebased as of head of today

Zhenhua Zhang (21):
  bluetooth: Add reference count for bluetooth utils
  bluetooth: Add Btio library for DUN
  bluetooth: Add bluetooth server support for DUN
  emulator: Add emulator atom in oFono
  dun_gw: Add DUN server plugin for oFono
  gprs: Rename status_watch to netreg_status_watch
  emulator: Add status watches for ofono emulator
  emulator: Add emulator status watches in gprs atom
  emulator: Add APIs to send GAtServer result
  emulator: Implement dialing up for DUN
  gprs: Make gprs_proto_to/from_string non-static
  gprs: ignore the case of proto str when comparing
  emulator: Register mandatory AT command handlers
  gprs: Refactor to share remove_context method
  gprs: Add DUN +CGATT support in gprs atom
  gprs: Add DUN +CGDCONT support in gprs atom
  gprs: Add DUN server GPRS connect support
  gprs: Add status watch functions
  gprs: Add gprs_get_status
  emulator: Watch GPRS status changes
  emulator: Watch netreg status changes

 Makefile.am            |   15 +-
 btio/btio.c            | 1299 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 btio/btio.h            |   97 ++++
 configure.ac           |    5 +
 include/emulator.h     |   94 ++++
 include/gprs-context.h |    4 +
 include/gprs.h         |   11 +
 plugins/bluetooth.c    |  441 ++++++++++++++++-
 plugins/bluetooth.h    |   15 +
 plugins/dun_gw.c       |  115 +++++
 src/emulator.c         | 1072 +++++++++++++++++++++++++++++++++++++++
 src/gprs.c             |  500 +++++++++++++++++--
 src/modem.c            |    1 +
 src/ofono.h            |   31 ++
 14 files changed, 3636 insertions(+), 64 deletions(-)
 create mode 100644 btio/btio.c
 create mode 100644 btio/btio.h
 create mode 100644 include/emulator.h
 create mode 100644 plugins/dun_gw.c
 create mode 100644 src/emulator.c

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============2610399627965007364==--

