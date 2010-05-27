Content-Type: multipart/mixed; boundary="===============6378474611057518396=="
MIME-Version: 1.0
From: pasi.miettinen@ixonos.com
Subject: [PATCH 01/11] In drivers/atmodem/sms.c:at_cmgl_cpms_cb() there is a
 temporary fix for Siemens TC65. If AT+CMGL=4 is sent to TC65,
 the AT command queue jams.
Date: Thu, 27 May 2010 13:54:40 +0300
Message-ID: <1274957690-4893-1-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6378474611057518396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pasi Miettinen <pasi.miettinen@ixonos.com>

---
 drivers/atmodem/sms.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 8049df6..27de77b 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -544,6 +544,10 @@ static void at_cmgl_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 =

 static void at_cmgl_cpms_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
+
+	DBG("PASS AT+CMGL=3D4!!!");
+	return;
+
 	struct cpms_request *req =3D user_data;
 	struct ofono_sms *sms =3D req->sms;
 	struct sms_data *data =3D ofono_sms_get_data(sms);
-- =

1.6.0.4


--===============6378474611057518396==--

