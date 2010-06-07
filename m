Content-Type: multipart/mixed; boundary="===============2570739177845855921=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: [RFC PATCH 1/4] SetProperty for UseDeliveryReports. smsutil.c/h.
Date: Mon, 07 Jun 2010 12:53:26 +0300
Message-ID: <1275904409-19829-2-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1275904409-19829-1-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2570739177845855921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |    5 +++--
 src/smsutil.h |    3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 278d335..cf9b77c 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2643,7 +2643,8 @@ static inline GSList *sms_list_append(GSList *l, cons=
t struct sms *in)
  * if no concatenation took place.
  */
 GSList *sms_text_prepare(const char *utf8, guint16 ref,
-				gboolean use_16bit, int *ref_offset)
+				gboolean use_16bit, int *ref_offset,
+				const gboolean use_delivery_reports)
 {
 	struct sms template;
 	int offset =3D 0;
@@ -2659,7 +2660,7 @@ GSList *sms_text_prepare(const char *utf8, guint16 re=
f,
 	template.submit.rd =3D FALSE;
 	template.submit.vpf =3D SMS_VALIDITY_PERIOD_FORMAT_RELATIVE;
 	template.submit.rp =3D FALSE;
-	template.submit.srr =3D FALSE;
+	template.submit.srr =3D use_delivery_reports;
 	template.submit.mr =3D 0;
 	template.submit.vp.relative =3D 0xA7; /* 24 Hours */
 =

diff --git a/src/smsutil.h b/src/smsutil.h
index a36a9d3..cfb2765 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -482,7 +482,8 @@ GSList *sms_assembly_add_fragment(struct sms_assembly *=
assembly,
 void sms_assembly_expire(struct sms_assembly *assembly, time_t before);
 =

 GSList *sms_text_prepare(const char *utf8, guint16 ref,
-				gboolean use_16bit, int *ref_offset);
+				gboolean use_16bit, int *ref_offset,
+				const gboolean use_delivery_reports);
 =

 gboolean cbs_dcs_decode(guint8 dcs, gboolean *udhi, enum sms_class *cls,
 			enum sms_charset *charset, gboolean *compressed,
-- =

1.6.0.4



--===============2570739177845855921==--

