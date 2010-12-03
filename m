Content-Type: multipart/mixed; boundary="===============5994272329608506365=="
MIME-Version: 1.0
From: Tonny Tzeng <tonny.tzeng@gmail.com>
Subject: [PATCH v2] Skip unsolicied CREG/CGREG correctly while checking GPRS
 attach status
Date: Fri, 03 Dec 2010 23:20:12 +0800
Message-ID: <1291389612.2043.25.camel@Twins.TonnyLab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5994272329608506365==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch is to skip unsolicited CGREG while checking the GPRS attach
status, especially for Huawei modem which sends lac and ci strings in
unquoted format, and casues at_util_parse_reg() return lac value as
status.

---
 drivers/atmodem/atutil.c |   12 ++++++++----
 gatchat/gatresult.c      |    5 +++++
 gatchat/gatresult.h      |    1 +
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index b6f0d92..c190aa2 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -243,13 +243,11 @@ gboolean at_util_parse_reg(GAtResult *result,
const char *prefix,
 		if (g_at_result_iter_next_number(&iter, &s) =3D=3D FALSE)
 			continue;
 =

-		/* Some firmware will report bogus lac/ci when unregistered */
-		if (s !=3D 1 && s !=3D 5)
-			goto out;
-
 		switch (vendor) {
 		case OFONO_VENDOR_HUAWEI:
 		case OFONO_VENDOR_NOVATEL:
+			if (g_at_result_iter_eol(&iter))
+				continue;
 			r =3D g_at_result_iter_next_unquoted_string(&iter, &str);
 =

 			if (r =3D=3D TRUE)
@@ -257,6 +255,8 @@ gboolean at_util_parse_reg(GAtResult *result, const
char *prefix,
 			else
 				goto out;
 =

+			if (g_at_result_iter_eol(&iter))
+				continue;
 			r =3D g_at_result_iter_next_unquoted_string(&iter, &str);
 =

 			if (r =3D=3D TRUE)
@@ -266,11 +266,15 @@ gboolean at_util_parse_reg(GAtResult *result,
const char *prefix,
 =

 			break;
 		default:
+			if (g_at_result_iter_eol(&iter))
+				continue;
 			if (g_at_result_iter_next_string(&iter, &str) =3D=3D TRUE)
 				l =3D strtol(str, NULL, 16);
 			else
 				goto out;
 =

+			if (g_at_result_iter_eol(&iter))
+				continue;
 			if (g_at_result_iter_next_string(&iter, &str) =3D=3D TRUE)
 				c =3D strtol(str, NULL, 16);
 			else
diff --git a/gatchat/gatresult.c b/gatchat/gatresult.c
index 8a6dfae..c919305 100644
--- a/gatchat/gatresult.c
+++ b/gatchat/gatresult.c
@@ -39,6 +39,11 @@ void g_at_result_iter_init(GAtResultIter *iter,
GAtResult *result)
 	iter->line_pos =3D 0;
 }
 =

+gboolean g_at_result_iter_eol(GAtResultIter *iter)
+{
+	return iter->line_pos >=3D strlen(iter->l->data);
+}
+
 gboolean g_at_result_iter_next(GAtResultIter *iter, const char *prefix)
 {
 	char *line;
diff --git a/gatchat/gatresult.h b/gatchat/gatresult.h
index a74741f..33c0b2c 100644
--- a/gatchat/gatresult.h
+++ b/gatchat/gatresult.h
@@ -46,6 +46,7 @@ struct _GAtResultIter {
 typedef struct _GAtResultIter GAtResultIter;
 =

 void g_at_result_iter_init(GAtResultIter *iter, GAtResult *result);
+gboolean g_at_result_iter_eol(GAtResultIter *iter);
 =

 gboolean g_at_result_iter_next(GAtResultIter *iter, const char
*prefix);
 gboolean g_at_result_iter_open_list(GAtResultIter *iter);
-- =

1.7.2.2



--===============5994272329608506365==--

