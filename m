Content-Type: multipart/mixed; boundary="===============6814288243715327792=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: [PATCH v2 1/5] qmimodem: telit LE910 V1 - fix ESN string
Date: Wed, 22 Mar 2017 18:14:49 +0000
Message-ID: <1490206493-17454-2-git-send-email-lnowak.tyco@gmail.com>
In-Reply-To: <1490206493-17454-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6814288243715327792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lukasz Nowak <lnowak@tycoint.com>

Telit QMI modems report "0", rather than a NULL string,
if ESN is not available.
---
 drivers/qmimodem/devinfo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/devinfo.c b/drivers/qmimodem/devinfo.c
index 34aec94..77c6874 100644
--- a/drivers/qmimodem/devinfo.c
+++ b/drivers/qmimodem/devinfo.c
@@ -125,7 +125,8 @@ static void get_ids_cb(struct qmi_result *result, void =
*user_data)
 	}
 =

 	str =3D qmi_result_get_string(result, QMI_DMS_RESULT_ESN);
-	if (!str) {
+	/* Telit qmi modems return a "0" string when ESN is not available. */
+	if (!str || strcmp(str, "0") =3D=3D 0) {
 		str =3D qmi_result_get_string(result, QMI_DMS_RESULT_IMEI);
 		if (!str) {
 			CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
-- =

2.7.4


--===============6814288243715327792==--

