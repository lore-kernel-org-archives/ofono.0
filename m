Content-Type: multipart/mixed; boundary="===============0326801965938611189=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH v5b 0/3] stemodem: Add RTNL handling to gprs-context.c
Date: Fri, 12 Nov 2010 16:02:37 +0100
Message-ID: <1289574160-22899-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0326801965938611189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

This patch-set applies on top of:
"[PATCH v5] stemodem: Add RTNL functionality managing CAIF Network Interfac=
es."

I have broken this patch-set into three separate patches as requested.
1) Bug-fixes and renaming
2) Restructuring for creating interfaces statically
3) Introducing calls to caif_rtnl_* to actually use the network interfaces.

Regards,
Sjur

Sjur Br=C3=A6ndeland (3):
  stemodem: Fix for error handling, memleak and changed some defines
  stemodem: Create network interfaces statically
  stemodem: Use RTNL to create interfaces

 drivers/stemodem/gprs-context.c |  222 ++++++++++++++++++++++++++---------=
----
 1 files changed, 147 insertions(+), 75 deletions(-)


--===============0326801965938611189==--

