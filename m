Content-Type: multipart/mixed; boundary="===============6914188108624138948=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [RFC PATCH 0/1] atmodem/lte: added Gemalto vendor
Date: Sat, 13 Oct 2018 10:09:19 +0200
Message-ID: <20181013080920.3487-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6914188108624138948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I would like to submit for review the following patch, for adding
the Gemalto vendor. I submit in a single patch also the modifications
under discussion in a separate thread, for ease of reading.

The main point I would like to ask is where to put the vendor-specific
but shared functions for formating the AT commands, because the same
procedures are used for gprs-context.

The point is valid also for other vendors: for example uBlox requires
the following format: "CHAP:apn" or "PAP:apn", if there is a context
authentication, in the AccessPoint string, on top of the authentication
command.


Giacinto Cifelli (1):
  atmodem/lte: Gemalto vendor specific extension

 drivers/atmodem/atutil.c | 103 +++++++++++++++++++++++++
 drivers/atmodem/atutil.h |  27 +++++++
 drivers/atmodem/lte.c    | 161 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 281 insertions(+), 10 deletions(-)

-- =

2.17.1


--===============6914188108624138948==--

