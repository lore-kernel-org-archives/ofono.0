Content-Type: multipart/mixed; boundary="===============1377799751754491225=="
MIME-Version: 1.0
From: George Matveev <george@matveev.se>
Subject: [PATCH 2/7] atmodem: Phone type defined using enum called_number_type
Date: Sun, 23 Jan 2011 11:16:31 +0100
Message-ID: <1295777796-19978-3-git-send-email-george@matveev.se>
In-Reply-To: <1295777796-19978-1-git-send-email-george@matveev.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1377799751754491225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/atutil.c          |    3 ++-
 drivers/atmodem/call-forwarding.c |    3 ++-
 drivers/atmodem/ssn.c             |    3 ++-
 drivers/atmodem/voicecall.c       |    2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index a55b3f5..8c24e72 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -34,6 +34,7 @@
 =

 #include "atutil.h"
 #include "vendor.h"
+#include "common.h"
 =

 void decode_at_error(struct ofono_error *error, const char *final)
 {
@@ -112,7 +113,7 @@ GSList *at_util_parse_clcc(GAtResult *result)
 =

 	while (g_at_result_iter_next(&iter, "+CLCC:")) {
 		const char *str =3D "";
-		int number_type =3D 129;
+		int number_type =3D CALLED_NUMBER_TYPE_UNKNOWN;
 =

 		if (!g_at_result_iter_next_number(&iter, &id))
 			continue;
diff --git a/drivers/atmodem/call-forwarding.c b/drivers/atmodem/call-forwa=
rding.c
index f11a68e..bd091ad 100644
--- a/drivers/atmodem/call-forwarding.c
+++ b/drivers/atmodem/call-forwarding.c
@@ -38,6 +38,7 @@
 #include "gatresult.h"
 =

 #include "atmodem.h"
+#include "common.h"
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *ccfc_prefix[] =3D { "+CCFC:", NULL };
@@ -89,7 +90,7 @@ static void ccfc_query_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 		g_at_result_iter_next_number(&iter, &(list[num].cls));
 =

 		list[num].phone_number.number[0] =3D '\0';
-		list[num].phone_number.type =3D 129;
+		list[num].phone_number.type =3D CALLED_NUMBER_TYPE_UNKNOWN;
 		list[num].time =3D 20;
 =

 		if (!g_at_result_iter_next_string(&iter, &str))
diff --git a/drivers/atmodem/ssn.c b/drivers/atmodem/ssn.c
index b7a9df4..8ede79b 100644
--- a/drivers/atmodem/ssn.c
+++ b/drivers/atmodem/ssn.c
@@ -36,6 +36,7 @@
 #include "gatresult.h"
 =

 #include "atmodem.h"
+#include "common.h"
 =

 static const char *none_prefix[] =3D { NULL };
 =

@@ -69,7 +70,7 @@ static void cssu_notify(GAtResult *result, gpointer user_=
data)
 	struct ofono_phone_number ph;
 =

 	ph.number[0] =3D '\0';
-	ph.type =3D 129;
+	ph.type =3D CALLED_NUMBER_TYPE_UNKNOWN;
 =

 	g_at_result_iter_init(&iter, result);
 =

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 9e56999..75a53ab 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -379,7 +379,7 @@ static void at_dial(struct ofono_voicecall *vc,
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


--===============1377799751754491225==--

