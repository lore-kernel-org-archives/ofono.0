Content-Type: multipart/mixed; boundary="===============8406455499369106321=="
MIME-Version: 1.0
From: George Matveev <george@matveev.se>
Subject: [PATCH 3/7] huaweimodem: Phone type defined using enum
 called_number_type
Date: Sun, 23 Jan 2011 11:16:32 +0100
Message-ID: <1295777796-19978-4-git-send-email-george@matveev.se>
In-Reply-To: <1295777796-19978-1-git-send-email-george@matveev.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8406455499369106321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/huaweimodem/voicecall.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/huaweimodem/voicecall.c b/drivers/huaweimodem/voicecal=
l.c
index 0c0aaa1..598a26e 100644
--- a/drivers/huaweimodem/voicecall.c
+++ b/drivers/huaweimodem/voicecall.c
@@ -37,6 +37,7 @@
 =

 #include "gatchat.h"
 #include "gatresult.h"
+#include "common.h"
 =

 #include "huaweimodem.h"
 =

@@ -120,7 +121,7 @@ static void huawei_dial(struct ofono_voicecall *vc,
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


--===============8406455499369106321==--

