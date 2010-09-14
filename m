Content-Type: multipart/mixed; boundary="===============8104183767087792918=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/6] Fix common misspellings in drivers
Date: Tue, 14 Sep 2010 00:06:01 -0300
Message-ID: <1284433565-26126-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <4C8EDFF9.4060006@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8104183767087792918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix common misspellings by using the list available at
http://en.wikipedia.org/wiki/Wikipedia:Lists_of_common_misspellings/For_mac=
hines.

From the list cited above, the substitution script found the following
misspellings:

subsidary(-ies)->subsidiary(-ies)
transfering->transferring
---
 drivers/atmodem/voicecall.c     |    2 +-
 drivers/hfpmodem/voicecall.c    |    2 +-
 drivers/isimodem/gpds.h         |    2 +-
 drivers/isimodem/gprs-context.c |    2 +-
 drivers/isimodem/gprs.c         |    2 +-
 drivers/stemodem/voicecall.c    |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

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
-- =

1.7.2.3


--===============8104183767087792918==--

