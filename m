Content-Type: multipart/mixed; boundary="===============0220437357994392385=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: [PATCH 1/2] atmodem: ensure the modem is in a sane state
Date: Wed, 05 Aug 2009 17:51:19 -0400
Message-ID: <20090805175119.72a57a10@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0220437357994392385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From 4c1d96e52fb706a219dcd7f0985b2d8edd403d64 Mon Sep 17 00:00:00 2001
From: Andres Salomon <dilinger@collabora.co.uk>
Date: Tue, 4 Aug 2009 21:17:32 -0400
Subject: [PATCH 1/2] atmodem: ensure the modem is in a sane state

The HTC G1 modem appears to start in mode V0 by default.  oFono doesn't
specify the default mode that it starts it, so it gets confused by the G1's
responses.

This patch sets the default to verbose mode on, (command) echo off, and
quiet mode off.  Thanks to Denis Kenzior for pointing out the V0 problem
in the first place.
---
 drivers/atmodem/atmodem.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/atmodem.c b/drivers/atmodem/atmodem.c
index fc255b3..822cff2 100644
--- a/drivers/atmodem/atmodem.c
+++ b/drivers/atmodem/atmodem.c
@@ -293,6 +293,9 @@ error:
 =

 static void send_init_commands(const char *vendor, GAtChat *parser)
 {
+	/* ensure modem is in a known state; verbose on, echo/quiet off */
+	g_at_chat_send(parser, "ATE0Q0V1", NULL, NULL, NULL, NULL);
+
 	if (!strcmp(vendor, "ti_calypso")) {
 		int flags =3D g_at_chat_get_flags(parser);
 =

-- =

1.6.3.3


--===============0220437357994392385==--

