Content-Type: multipart/mixed; boundary="===============7184722028544598051=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: [PATCH v2 3/5] qmimodem: detect utf-8 string as operator name
Date: Wed, 22 Mar 2017 18:14:51 +0000
Message-ID: <1490206493-17454-4-git-send-email-lnowak.tyco@gmail.com>
In-Reply-To: <1490206493-17454-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7184722028544598051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lukasz Nowak <lnowak@tycoint.com>

Telit QMI modems can return non-utf-8 characters in plmn-desc.
Observed with LE910-SVG and Verizon. When that happens, libdbus
will abort ofono.
If non-utf-8 characters are detected, use mccmnc string.
---
 drivers/qmimodem/network-registration.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/net=
work-registration.c
index 7389ca5..a3f9cf9 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -64,7 +64,7 @@ static bool extract_ss_info(struct qmi_result *result, in=
t *status,
 	const struct qmi_nas_serving_system *ss;
 	const struct qmi_nas_current_plmn *plmn;
 	uint8_t i, roaming;
-	uint16_t value16, len;
+	uint16_t value16, len, opname_len;
 	uint32_t value32;
 =

 	DBG("");
@@ -100,8 +100,21 @@ static bool extract_ss_info(struct qmi_result *result,=
 int *status,
 						GUINT16_FROM_LE(plmn->mcc));
 		snprintf(operator->mnc, OFONO_MAX_MNC_LENGTH + 1, "%02d",
 						GUINT16_FROM_LE(plmn->mnc));
-		strncpy(operator->name, plmn->desc, plmn->desc_len);
-		operator->name[plmn->desc_len] =3D '\0';
+		opname_len =3D plmn->desc_len;
+		if (opname_len > OFONO_MAX_OPERATOR_NAME_LENGTH)
+			opname_len =3D OFONO_MAX_OPERATOR_NAME_LENGTH;
+
+		/*
+		 * Telit QMI modems can return non-utf-8 characters in
+		 * plmn-desc. When that happens, libdbus will abort ofono.
+		 * If non-utf-8 characters are detected, use mccmnc string.
+		 */
+		if (g_utf8_validate(plmn->desc, opname_len, NULL)) {
+			strncpy(operator->name, plmn->desc, opname_len);
+			operator->name[opname_len] =3D '\0';
+		} else
+			snprintf(operator->name, OFONO_MAX_OPERATOR_NAME_LENGTH,
+					"%s%s",	operator->mcc, operator->mnc);
 =

 		DBG("%s (%s:%s)", operator->name, operator->mcc, operator->mnc);
 	}
-- =

2.7.4


--===============7184722028544598051==--

