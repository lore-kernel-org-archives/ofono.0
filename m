Content-Type: multipart/mixed; boundary="===============8016642324749769475=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] Fix common misspellings
Date: Mon, 13 Sep 2010 22:32:53 -0300
Message-ID: <1284427973-22306-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8016642324749769475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Apply to all files the list of common misspellings found at
http://en.wikipedia.org/wiki/Wikipedia:Lists_of_common_misspellings/For_mac=
hines.

From the list cited above, the substitution found the following
misspellings:

accomodate->accommodate
fomr->from
priviledge->privilege
proprietory->proprietary
reponsible->responsible
seperately->separately
subsidary(-ies)->subsidiary(-ies)
succeded->succeeded
targetted->targeted
transfering->transferring
witheld->withheld
withold->withhold

Signed-off-by: Lucas De Marchi <lucas.demarchi@profusion.mobi>
---
 TODO                            |    4 ++--
 doc/call-settings-api.txt       |    6 +++---
 doc/ofono-paper.txt             |    4 ++--
 doc/voicecallmanager-api.txt    |    2 +-
 drivers/atmodem/voicecall.c     |    2 +-
 drivers/hfpmodem/voicecall.c    |    2 +-
 drivers/isimodem/gpds.h         |    2 +-
 drivers/isimodem/gprs-context.c |    2 +-
 drivers/isimodem/gprs.c         |    2 +-
 drivers/stemodem/voicecall.c    |    2 +-
 gatchat/gatppp.c                |    2 +-
 gatchat/gsmdial.c               |    2 +-
 gatchat/test-server.c           |    2 +-
 gisi/client.c                   |    2 +-
 gisi/server.c                   |    2 +-
 src/util.c                      |    2 +-
 16 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/TODO b/TODO
index d41df04..d5d9082 100644
--- a/TODO
+++ b/TODO
@@ -26,7 +26,7 @@ SMS
   Proposed solution is to convert such messages to HTML and embed image /
   sound data as embedded MIME in the generated HTML stream.  The EMS messa=
ges
   will have to be detected (by the presence of particular tags in the SMS)
-  and signaled seperately from simple SMS messages.
+  and signaled separately from simple SMS messages.
 =

   Priority: Low
   Complexity: C8
@@ -136,7 +136,7 @@ SIM / SIM File system
   Priority: Low
   Complexity: C2
 =

-- Support proprietory extensions for SIM PIN retry counter.  Most vendors
+- Support proprietary extensions for SIM PIN retry counter.  Most vendors
   provide an extension commands to obtain such a retry counter for PINs and
   PUKs.  Need to enable this as a property in oFono.
 =

diff --git a/doc/call-settings-api.txt b/doc/call-settings-api.txt
index a345b9c..e98ce0c 100644
--- a/doc/call-settings-api.txt
+++ b/doc/call-settings-api.txt
@@ -47,7 +47,7 @@ Properties	string CallingLinePresentation [readonly]
 			Contains the value of the connected line identification
 			restriction property. The value indicates the state of
 			the COLR supplementary service in the network.  If
-			enabled, the network will withold subscriber number
+			enabled, the network will withhold subscriber number
 			information from the calling party on incoming calls.
 			The possible values are:
 				"disabled",
@@ -77,12 +77,12 @@ Properties	string CallingLinePresentation [readonly]
 		string HideCallerId [readwrite]
 =

 			Sets whether the ID of the caller will should be
-			provided or witheld for outgoing calls.  This setting
+			provided or withheld for outgoing calls.  This setting
 			is also modified by the status of the CLIR supplementary
 			service in the network (see the CallingLineRestriction
 			property).  The three possible values are:
 				"default" - Uses the network setting
-				"enabled" - CLIR invoked, caller id is witheld
+				"enabled" - CLIR invoked, caller id is withheld
 				"disabled" - CLIR suppressed, caller id is
 						provided
 =

diff --git a/doc/ofono-paper.txt b/doc/ofono-paper.txt
index df3f0b3..ec6d01b 100644
--- a/doc/ofono-paper.txt
+++ b/doc/ofono-paper.txt
@@ -7,7 +7,7 @@ Linux and other open source components are now used extensi=
vely on both desktop
 and mobile embedded devices.  They provide networking, power management,
 database and other core OS infrastructure.  However, up to this point no
 viable open source solution for mobile telephony existed.  oFono aims to
-change that; it is a telephony host stack specifically targetted at both
+change that; it is a telephony host stack specifically targeted at both
 mobile embedded and desktop systems.
 =

 Launched on May 11, 2009 oFono aims to provide a solid framework for buili=
dng
@@ -97,7 +97,7 @@ for low-level operations.  This interface is based on 3GP=
P TS 27.007 "AT
 command set for User Equipment" and 3GPP TS 27.005 "DTE-DCE interface for =
SMS
 and CBS".  oFono assumes that all operations are fully asynchronous.
 =

-This means that oFono can accomodate a wide variety of devices, including
+This means that oFono can accommodate a wide variety of devices, including
 full-featured modems (AT command based and otherwise), data-only cards, and
 modem like devices (e.g. Bluetooth Handsfree and Sim Access Profile device=
s,
 etc.)
diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index 620720f..11af23a 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -34,7 +34,7 @@ Methods		array{object,dict} GetCalls()
 =

 			Joins the currently Active (or Outgoing, depending
 			on network support) and Held calls together and
-			disconnects both calls. In effect transfering
+			disconnects both calls. In effect transferring
 			one party to the other. This procedure requires
 			an Active and Held call and the Explicit Call Transfer
 			(ECT) supplementary service to be active.
diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index eaf3a95..7c788f4 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -508,7 +508,7 @@ static void at_transfer(struct ofono_voicecall *vc,
 	unsigned int transfer =3D 0x1 | 0x2;
 =

 	/* Transfer can puts held & active calls together and disconnects
-	 * from both.  However, some networks support transfering of
+	 * from both.  However, some networks support transferring of
 	 * dialing/ringing calls as well.
 	 */
 	transfer |=3D 0x4 | 0x8;
diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 8ae4430..e96ec7c 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -562,7 +562,7 @@ static void hfp_transfer(struct ofono_voicecall *vc,
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 	/* Transfer can puts held & active calls together and disconnects
-	 * from both.  However, some networks support transfering of
+	 * from both.  However, some networks support transferring of
 	 * dialing/ringing calls as well.
 	 */
 	unsigned int transfer =3D 0x1 | 0x2 | 0x4 | 0x8;
diff --git a/drivers/isimodem/gpds.h b/drivers/isimodem/gpds.h
index 9bb60e6..a62c47b 100644
--- a/drivers/isimodem/gpds.h
+++ b/drivers/isimodem/gpds.h
@@ -1,7 +1,7 @@
 /*
  * This file is part of oFono - Open Source Telephony
  *
- * Copyright (C) 2010  Nokia Corporation and/or its subsidary(-ies).
+ * Copyright (C) 2010  Nokia Corporation and/or its subsidiary(-ies).
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/drivers/isimodem/gprs-context.c b/drivers/isimodem/gprs-contex=
t.c
index 9fdc677..8144940 100644
--- a/drivers/isimodem/gprs-context.c
+++ b/drivers/isimodem/gprs-context.c
@@ -1,7 +1,7 @@
 /*
  * This file is part of oFono - Open Source Telephony
  *
- * Copyright (C) 2010  Nokia Corporation and/or its subsidary(-ies).
+ * Copyright (C) 2010  Nokia Corporation and/or its subsidiary(-ies).
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/drivers/isimodem/gprs.c b/drivers/isimodem/gprs.c
index 93786ec..adac374 100644
--- a/drivers/isimodem/gprs.c
+++ b/drivers/isimodem/gprs.c
@@ -1,7 +1,7 @@
 /*
  * This file is part of oFono - Open Source Telephony
  *
- * Copyright (C) 2010  Nokia Corporation and/or its subsidary(-ies).
+ * Copyright (C) 2010  Nokia Corporation and/or its subsidiary(-ies).
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index 5cf38bb..6b43ebd 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -340,7 +340,7 @@ static void ste_transfer(struct ofono_voicecall *vc,
 	unsigned int transfer =3D 0x1 | 0x2;
 =

 	/* Transfer can puts held & active calls together and disconnects
-	 * from both.  However, some networks support transfering of
+	 * from both.  However, some networks support transferring of
 	 * dialing/ringing calls as well.
 	 */
 	transfer |=3D 0x4 | 0x8;
diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 63508b5..5e875b8 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -51,7 +51,7 @@ enum ppp_phase {
 	PPP_PHASE_ESTABLISHMENT,	/* LCP started */
 	PPP_PHASE_AUTHENTICATION,	/* Auth started */
 	PPP_PHASE_NETWORK,		/* IPCP started */
-	PPP_PHASE_LINK_UP,		/* IPCP negotiation succeded, link up */
+	PPP_PHASE_LINK_UP,		/* IPCP negotiation succeeded, link up */
 	PPP_PHASE_TERMINATION,		/* LCP Terminate phase */
 };
 =

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index 9aa2f79..57d0d9e 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -250,7 +250,7 @@ static void ppp_connect(const char *iface, const char *=
local, const char *peer,
 	g_print("Secondary DNS Server: %s\n", dns2);
 =

 	if (getuid() !=3D 0) {
-		g_print("Need root priviledge to config PPP interface\n");
+		g_print("Need root privilege to config PPP interface\n");
 		return;
 	}
 =

diff --git a/gatchat/test-server.c b/gatchat/test-server.c
index 49012dc..c405f41 100644
--- a/gatchat/test-server.c
+++ b/gatchat/test-server.c
@@ -159,7 +159,7 @@ static gboolean setup_ppp(gpointer user)
 	GAtIO *io;
 =

 	if (getuid() !=3D 0) {
-		g_print("Need root priviledge for PPP connection\n");
+		g_print("Need root privilege for PPP connection\n");
 		return FALSE;
 	}
 =

diff --git a/gisi/client.c b/gisi/client.c
index 24237b2..cf31447 100644
--- a/gisi/client.c
+++ b/gisi/client.c
@@ -525,7 +525,7 @@ void g_isi_request_cancel(GIsiRequest *req)
  * Subscribe to a given indication type for the resource that an ISI client
  * is associated with. If the same type was already subscribed, the old
  * subscription is overriden.
- * @param cl ISI client (fomr g_isi_client_create())
+ * @param cl ISI client (from g_isi_client_create())
  * @param type indication type
  * @param cb callback to process received indications
  * @param data data for the callback
diff --git a/gisi/server.c b/gisi/server.c
index 8be109d..ae252e1 100644
--- a/gisi/server.c
+++ b/gisi/server.c
@@ -253,7 +253,7 @@ int g_isi_vrespond(GIsiServer *self, const struct iovec=
 *iov, size_t iovlen,
  * Prepare to handle given request type for the resource that an ISI server
  * is associated with. If the same type was already handled, the old
  * handler is overriden.
- * @param self ISI server (fomr g_isi_server_create())
+ * @param self ISI server (from g_isi_server_create())
  * @param type request message type
  * @param cb callback to process received requests
  * @param data data for the callback
diff --git a/src/util.c b/src/util.c
index bb90f6c..391bbb2 100644
--- a/src/util.c
+++ b/src/util.c
@@ -535,7 +535,7 @@ static unsigned short unicode_single_shift_lookup(unsig=
ned short k,
  * GSM encoded string in items_read (if not NULL), not including the
  * terminator character. Returns the number of bytes written into the UTF8
  * encoded string in items_written (if not NULL) not including the terminal
- * '\0' character.  The caller is reponsible for freeing the returned valu=
e.
+ * '\0' character.  The caller is responsible for freeing the returned val=
ue.
  */
 char *convert_gsm_to_utf8_with_lang(const unsigned char *text, long len,
 					long *items_read, long *items_written,
-- =

1.7.2.3


--===============8016642324749769475==--

