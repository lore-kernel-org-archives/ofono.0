Content-Type: multipart/mixed; boundary="===============5152191962291268369=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCHv2 01/11] simutil: Added app type to application parser
Date: Tue, 10 Oct 2017 14:36:10 -0700
Message-ID: <1507671380-7625-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5152191962291268369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Parsing a SIM application only copied the 16 byte AID
portion, which included the application type. Parsing out
the type makes sorting much easier for modules using the
parser.
---
 src/simutil.c |  2 ++
 src/simutil.h | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/src/simutil.c b/src/simutil.c
index 4731d3b..f43c2c2 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -1570,6 +1570,8 @@ GSList *sim_parse_app_template_entries(const unsigned=
 char *buffer, int len)
 =

 		memcpy(app.aid, aid, app.aid_len);
 =

+		app.type =3D GUINT16_FROM_BE(*((unsigned short *)(app.aid + 5)));
+
 		/* Find the label (optional) */
 		label =3D ber_tlv_find_by_tag(dataobj, 0x50, dataobj_len,
 						&label_len);
diff --git a/src/simutil.h b/src/simutil.h
index 1faf948..9984b2c 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -261,6 +261,17 @@ enum sim_csp_entry {
 	SIM_CSP_ENTRY_INFORMATION_NUMBERS =3D	0xD5,
 };
 =

+/* 101.220 Annex E */
+enum sim_app_type {
+	SIM_APP_TYPE_UICC =3D		0x1001,
+	SIM_APP_TYPE_USIM =3D		0x1002,
+	SIM_APP_TYPE_USIM_TOOLKIT =3D	0x1003,
+	SIM_APP_TYPE_ISIM =3D		0x1004,
+	SIM_APP_TYPE_USIM_API =3D		0x1005,
+	SIM_APP_TYPE_ISIM_API =3D		0x1006,
+	SIM_APP_TYPE_CONTACT_MGR =3D	0x1007
+};
+
 enum ber_tlv_data_type {
 	BER_TLV_DATA_TYPE_UNIVERSAL =3D		0,
 	BER_TLV_DATA_TYPE_APPLICATION =3D		1,
@@ -296,6 +307,7 @@ struct sim_app_record {
 	unsigned char aid[16];
 	int aid_len;
 	char *label;
+	enum sim_app_type type;
 };
 =

 struct simple_tlv_iter {
-- =

2.7.4


--===============5152191962291268369==--

