Content-Type: multipart/mixed; boundary="===============3818767467649020296=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/5] simutil: SIM applications directory decoding utils.
Date: Mon, 17 Jan 2011 18:38:51 +0100
Message-ID: <1295285934-9306-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1295285934-9306-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3818767467649020296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simutil.h |    2 ++
 2 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index 8abf3d5..b3e2f52 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -1465,3 +1465,60 @@ gboolean sim_sst_is_active(unsigned char *efsst, uns=
igned char len,
 =

 	return (efsst[index / 4] >> (((index % 4) * 2) + 1)) & 1;
 }
+
+GSList *sim_parse_app_template_entries(const unsigned char *buffer, int le=
n)
+{
+	GSList *ret =3D NULL;
+	const unsigned char *dataobj;
+	int dataobj_len;
+
+	/* Find all the application entries */
+	while ((dataobj =3D ber_tlv_find_by_tag(buffer, 0x61, len,
+						&dataobj_len)) !=3D NULL) {
+		struct ofono_sim_app_record app;
+		const unsigned char *aid, *label;
+		int label_len;
+
+		/* Find the aid (mandatory) */
+		aid =3D ber_tlv_find_by_tag(dataobj, 0x4f, dataobj_len,
+						&app.aid_len);
+		if (!aid || app.aid_len < 0x01 || app.aid_len > 0x10)
+			goto error;
+
+		memcpy(app.aid, aid, app.aid_len);
+
+		/* Find the label (optional) */
+		label =3D ber_tlv_find_by_tag(dataobj, 0x50, dataobj_len,
+						&label_len);
+		if (label) {
+			/*
+			 * Label field uses the extra complicated
+			 * encoding in 102.221 Annex A
+			 */
+			app.label =3D sim_string_to_utf8(label, label_len);
+
+			if (app.label =3D=3D NULL)
+				goto error;
+		} else
+			app.label =3D NULL;
+
+		ret =3D g_slist_prepend(ret, g_memdup(&app, sizeof(app)));
+
+		len -=3D (dataobj - buffer) + dataobj_len;
+		buffer =3D dataobj + dataobj_len;
+	}
+
+	return ret;
+
+error:
+	while (ret) {
+		GSList *t =3D ret;
+
+		g_free(((struct ofono_sim_app_record *) ret->data)->label);
+
+		ret =3D ret->next;
+		g_slist_free_1(t);
+	}
+
+	return NULL;
+}
diff --git a/src/simutil.h b/src/simutil.h
index ad84907..4418ec9 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -446,3 +446,5 @@ gboolean sim_sst_is_available(unsigned char *service_ss=
t, unsigned char len,
 						enum sim_sst_service index);
 gboolean sim_sst_is_active(unsigned char *service_sst, unsigned char len,
 						enum sim_sst_service index);
+
+GSList *sim_parse_app_template_entries(const unsigned char *buffer, int le=
n);
-- =

1.7.1.86.g0e460.dirty


--===============3818767467649020296==--

