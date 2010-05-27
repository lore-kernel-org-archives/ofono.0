Content-Type: multipart/mixed; boundary="===============1283963066324971610=="
MIME-Version: 1.0
From: pasi.miettinen@ixonos.com
Subject: [PATCH 07/11] Removed Siemens TC65 specific code.
Date: Thu, 27 May 2010 13:54:46 +0300
Message-ID: <1274957690-4893-7-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1274957690-4893-6-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1283963066324971610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pasi Miettinen <pasi.miettinen@ixonos.com>

---
 drivers/atmodem/sms.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index a1c885b..adaf4f2 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -561,9 +561,6 @@ static void at_cmgl_cpms_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	struct ofono_sms *sms =3D req->sms;
 	struct sms_data *data =3D ofono_sms_get_data(sms);
 =

-	DBG("PASS AT+CMGL=3D4!!!");
-	return;
-
 	if (!ok) {
 		ofono_error("Initial CPMS request failed");
 		at_cmgl_done(sms);
-- =

1.6.0.4


--===============1283963066324971610==--

