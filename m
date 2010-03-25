Content-Type: multipart/mixed; boundary="===============8998022139580432472=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 2/7] Make the function to parse mcc and mnc public
Date: Fri, 26 Mar 2010 00:07:31 +0800
Message-ID: <1269533256-29095-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269533256-29095-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8998022139580432472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.c |    6 +++---
 src/simutil.h |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index d9383b7..9fb111f 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -538,7 +538,7 @@ static char *sim_network_name_parse(const unsigned char=
 *buffer, int length,
 	return ret;
 }
 =

-static void parse_mcc_mnc(const guint8 *bcd, char *mcc, char *mnc)
+void sim_parse_mcc_mnc(const guint8 *bcd, char *mcc, char *mnc)
 {
 	static const char digit_lut[] =3D "0123456789*#abd\0";
 	guint8 digit;
@@ -609,7 +609,7 @@ struct sim_spdi *sim_spdi_new(const guint8 *tlv, int le=
ngth)
 =

 		oper =3D g_new0(struct spdi_operator, 1);
 =

-		parse_mcc_mnc(plmn_list, oper->mcc, oper->mnc);
+		sim_parse_mcc_mnc(plmn_list, oper->mcc, oper->mnc);
 		spdi->operators =3D g_slist_insert_sorted(spdi->operators, oper,
 						spdi_operator_compare);
 	}
@@ -694,7 +694,7 @@ static struct opl_operator *opl_operator_alloc(const gu=
int8 *record)
 {
 	struct opl_operator *oper =3D g_new0(struct opl_operator, 1);
 =

-	parse_mcc_mnc(record, oper->mcc, oper->mnc);
+	sim_parse_mcc_mnc(record, oper->mcc, oper->mnc);
 	record +=3D 3;
 =

 	oper->lac_tac_low =3D (record[0] << 8) | record[1];
diff --git a/src/simutil.h b/src/simutil.h
index 043c21f..7590cca 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -181,6 +181,7 @@ const struct sim_eons_operator_info *sim_eons_lookup(st=
ruct sim_eons *eons,
 						const char *mnc);
 void sim_eons_free(struct sim_eons *eons);
 =

+void sim_parse_mcc_mnc(const guint8 *bcd, char *mcc, char *mnc);
 struct sim_spdi *sim_spdi_new(const guint8 *tlv, int length);
 gboolean sim_spdi_lookup(struct sim_spdi *spdi,
 				const char *mcc, const char *mnc);
-- =

1.6.3.3


--===============8998022139580432472==--

