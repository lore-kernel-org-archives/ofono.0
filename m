Content-Type: multipart/mixed; boundary="===============7006888445912874804=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH v8 0/5] lte atom auth and IP protocol
Date: Fri, 19 Oct 2018 13:31:36 +0200
Message-ID: <20181019113141.20734-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7006888445912874804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I would like to submit this patch for the lte atom

This patch adds in core atom:
-  the protocol for the default LTE APN, ip, ipv6 and both
- the authentication handling, with 3 properties:
	method, username, password

then these are used in the atmodem atom:

The behavior of the patch is described in the api document (part 1),
and in the core atom header (part 2).

Related to the previous version, this version:
- changes the name of the function at_auth_type_from_method in
  atmodem/atutils, as suggested by Jonas, and calls it without passing
  from an intermediate local variable.


Giacinto Cifelli (5):
  lte-api: protocol and authentication properties
  lte.h: added proto and authentication handling
  lte: protocol and authentication for default ctx
  atmodem/atutil: shared functions for cgdcont
  atmodem/lte: proto and authentication handling

 doc/lte-api.txt          |  39 +++++++
 drivers/atmodem/atutil.c |  49 +++++++++
 drivers/atmodem/atutil.h |   6 ++
 drivers/atmodem/lte.c    | 118 ++++++++++++++++++---
 include/lte.h            |   5 +
 src/lte.c                | 222 +++++++++++++++++++++++++++++----------
 6 files changed, 367 insertions(+), 72 deletions(-)

-- =

2.17.1


--===============7006888445912874804==--

