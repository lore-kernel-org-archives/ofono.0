Content-Type: multipart/mixed; boundary="===============9155857914730535023=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v3 0/7] Clear the ground for AG card implementation
Date: Mon, 15 Apr 2013 18:41:43 -0300
Message-ID: <1366062110-28031-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9155857914730535023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v3 changelog:

* add patches that move hfp version to hfp.h.

***

* patches 1 to 3 stores and closes remote connections.

* patches 4 to 7 moves HFP version definitions to hfp.h.

Paulo Borges (7):
  hfp_ag_bluez5: Create a hash to store connections
  hfp_ag_bluez5: Store fd in hash when connect
  hfp_ag_bluez5: Remove fd from hash when disconnect
  phonesim: Include hfp.h
  hfp_ag_bluez5: Include hfp.h
  hfp: Move HFP versions definitions to hfp.h
  hfp_ag_bluez5: Remove unused includes

 drivers/hfpmodem/slc.h  |    6 -----
 plugins/hfp_ag_bluez5.c |   65 ++++++++++++++++++++++++++++++++++++++++++-=
----
 plugins/phonesim.c      |    1 +
 src/hfp.h               |    6 +++++
 4 files changed, 65 insertions(+), 13 deletions(-)

-- =

1.7.9.5


--===============9155857914730535023==--

