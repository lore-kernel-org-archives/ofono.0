Content-Type: multipart/mixed; boundary="===============6787282851980346264=="
MIME-Version: 1.0
From: George Matveev <george@matveev.se>
Subject: [PATCH 5/7] ifxmodem: Phone type defined using enum called_number_type
Date: Sun, 23 Jan 2011 11:16:34 +0100
Message-ID: <1295777796-19978-6-git-send-email-george@matveev.se>
In-Reply-To: <1295777796-19978-1-git-send-email-george@matveev.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6787282851980346264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/voicecall.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index f673624..b8ccbb2 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -37,6 +37,7 @@
 =

 #include "gatchat.h"
 #include "gatresult.h"
+#include "common.h"
 =

 #include "ifxmodem.h"
 =

@@ -310,7 +311,7 @@ static void ifx_dial(struct ofono_voicecall *vc,
 =

 	cbd->user =3D vc;
 =

-	if (ph->type =3D=3D 145)
+	if (ph->type =3D=3D CALLED_NUMBER_TYPE_INTERNATIONAL)
 		snprintf(buf, sizeof(buf), "ATD+%s", ph->number);
 	else
 		snprintf(buf, sizeof(buf), "ATD%s", ph->number);
-- =

1.5.6.5


--===============6787282851980346264==--

