Content-Type: multipart/mixed; boundary="===============2042068090884328873=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH v7 0/7] lte atom auth and IP protocol 
Date: Thu, 18 Oct 2018 20:49:45 +0200
Message-ID: <20181018184952.10797-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2042068090884328873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 would like to submit this patch for the lte atom

This patch adds in core atom:
-  the protocol for the default LTE APN, ip, ipv6 and both
- the authentication handling, with 3 properties:
	method, username, password

then these are used in two atoms:
- atmodem, with standard AT commands syntax
- gemaltomodem, with vendor-specific syntax

The behavior of the patch is described in the api document (part 1),
and in the core atom header (part 2).

Related to the previous version, this version:
- introduces a separate atom for Gemalto vendor-specific syntax
- implements in the core the suggestions of Denis

history of versions fixes:
- a missing return in case of error in at_lte_set_default_attach_info_cb
- discards the use of lte_driver_data in favour of its member chat
	for passing among callbacks, as the persistence of the first
	cannot be guaranteed, or at least controlled by the driver atom
- fixes the memory management of the object passed among callbacks
	by using a reference counted structure


Giacinto Cifelli (7):
  lte-api: protocol and authentication properties
  lte.h: added proto and authentication handling
  lte: protocol and authentication for default ctx
  atmodem/atutil: shared functions for cgdcont
  atmodem/lte: proto and authentication handling
  gemalto/lte: Gemalto vendor lte atom
  plugins/gemalto: use Gemalto lte atom

 Makefile.am                         |   5 +-
 doc/lte-api.txt                     |  39 +++++
 drivers/atmodem/atutil.c            |  49 ++++++
 drivers/atmodem/atutil.h            |   6 +
 drivers/atmodem/lte.c               | 119 ++++++++++++---
 drivers/gemaltomodem/gemaltomodem.c |   2 +
 drivers/gemaltomodem/gemaltomodem.h |   4 +
 drivers/gemaltomodem/gemaltoutil.c  | 106 +++++++++++++
 drivers/gemaltomodem/gemaltoutil.h  |  31 ++++
 drivers/gemaltomodem/lte.c          | 221 +++++++++++++++++++++++++++
 include/lte.h                       |   5 +
 plugins/gemalto.c                   |  16 +-
 src/lte.c                           | 222 +++++++++++++++++++++-------
 13 files changed, 749 insertions(+), 76 deletions(-)
 create mode 100644 drivers/gemaltomodem/gemaltoutil.c
 create mode 100644 drivers/gemaltomodem/gemaltoutil.h
 create mode 100644 drivers/gemaltomodem/lte.c

-- =

2.17.1


--===============2042068090884328873==--

