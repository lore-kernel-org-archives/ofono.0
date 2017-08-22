Content-Type: multipart/mixed; boundary="===============5681080580276223229=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH] qmi/sms: require WMS version >= 1.2 for bearer calls
Date: Tue, 22 Aug 2017 14:25:43 +0200
Message-ID: <20170822122543.2656-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5681080580276223229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I've never seen a major 0 service. The gobi2000 comes with
WMS 1.0 and doesn't support the bearer command. Guessing
it's 1.2 required.
---
 drivers/qmimodem/sms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 91501b75c4f4..3f4bdeb2a09c 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -277,7 +277,7 @@ static void qmi_bearer_query(struct ofono_sms *sms,
 =

 	DBG("");
 =

-	if (data->major < 1 && data->minor < 2)
+	if (data->major < 1 || (data->major =3D=3D 1 && data->minor < 2))
 		goto error;
 =

 	if (qmi_service_send(data->wms, QMI_WMS_GET_DOMAIN_PREF, NULL,
@@ -315,7 +315,7 @@ static void qmi_bearer_set(struct ofono_sms *sms, int b=
earer,
 =

 	DBG("bearer %d", bearer);
 =

-	if (data->major < 1 && data->minor < 2)
+	if (data->major < 1 || (data->major =3D=3D 1 && data->minor < 2))
 		goto error;
 =

 	domain =3D bearer_to_domain(bearer);
-- =

2.14.1


--===============5681080580276223229==--

