Content-Type: multipart/mixed; boundary="===============6514943576605347078=="
MIME-Version: 1.0
From: George Matveev <george@matveev.se>
Subject: [PATCH 6/7] calypsomodem: Phone type defined using enum
 called_number_type
Date: Sun, 23 Jan 2011 11:16:35 +0100
Message-ID: <1295777796-19978-7-git-send-email-george@matveev.se>
In-Reply-To: <1295777796-19978-1-git-send-email-george@matveev.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6514943576605347078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/calypsomodem/voicecall.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/calypsomodem/voicecall.c b/drivers/calypsomodem/voicec=
all.c
index 837ff69..398f5a2 100644
--- a/drivers/calypsomodem/voicecall.c
+++ b/drivers/calypsomodem/voicecall.c
@@ -37,6 +37,7 @@
 =

 #include "gatchat.h"
 #include "gatresult.h"
+#include "common.h"
 =

 #include "calypsomodem.h"
 =

@@ -85,7 +86,7 @@ static void calypso_dial(struct ofono_voicecall *vc,
 {
 	char buf[256];
 =

-	if (ph->type =3D=3D 145)
+	if (ph->type =3D=3D CALLED_NUMBER_TYPE_INTERNATIONAL)
 		snprintf(buf, sizeof(buf), "ATD+%s", ph->number);
 	else
 		snprintf(buf, sizeof(buf), "ATD%s", ph->number);
-- =

1.5.6.5


--===============6514943576605347078==--

