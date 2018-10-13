Content-Type: multipart/mixed; boundary="===============1060668089844845996=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH v4 0/4] lte atom auth and IP protocol 
Date: Sat, 13 Oct 2018 07:48:51 +0200
Message-ID: <20181013054855.20150-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1060668089844845996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 would like to submit this patch for the lte atom

This patch adds:
-  the protocol for the default LTE APN, ip, ipv6 and both
- the authentication handling, with 3 properties:
	method, username, password

The behavior of the patch is described in the api document (part 1/4),
and in the core atom header (part 2/4). The same description is
duplicated for convenience in the core atom source (part 3/4).
The part 4/4 is the driver/atmodem reflex of these changes.

This patch implements these extended parameters as described by the
3GPP TS 27.007.


Related to the v3, this new version fixes:
- a missing return in case of error in at_lte_set_default_attach_info_cb
- discards the use of lte_driver_data in favour of its member chat
	for passing among callbacks, as the persistence of the first
	cannot be guaranteed, or at least controlled by the driver atom
- fixes the memory management of the object passed among callbacks
	by using a reference counted structure


Giacinto Cifelli (4):
  lte-api: protocol and authentication properties
  lte.h: added proto and authentication handling
  src/lte: added proto and authentication handling
  atmodem/lte: proto and authentication handling

 doc/lte-api.txt       |  39 +++++++
 drivers/atmodem/lte.c | 133 ++++++++++++++++++++++--
 include/lte.h         |   5 +
 src/lte.c             | 236 ++++++++++++++++++++++++++++++++----------
 4 files changed, 347 insertions(+), 66 deletions(-)

-- =

2.17.1


--===============1060668089844845996==--

