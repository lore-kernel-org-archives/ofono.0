Content-Type: multipart/mixed; boundary="===============0134600526658754806=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH][v2 4/4] plugins/gobi: reset the qmi interface when enabling
 the modem
Date: Tue, 05 Dec 2017 18:52:37 +0100
Message-ID: <20171205175237.17399-4-lynxis@fe80.eu>
In-Reply-To: <20171205175237.17399-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0134600526658754806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/gobi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 516b55e9411d..17900010d1db 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -254,6 +254,15 @@ error:
 	shutdown_device(modem);
 }
 =

+static void create_shared_dms(void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct gobi_data *data =3D ofono_modem_get_data(modem);
+
+	qmi_service_create_shared(data->device, QMI_SERVICE_DMS,
+				  create_dms_cb, modem, NULL);
+}
+
 static void discover_cb(uint8_t count, const struct qmi_version *list,
 							void *user_data)
 {
@@ -316,8 +325,10 @@ static void discover_cb(uint8_t count, const struct qm=
i_version *list,
 		return;
 	}
 =

-	qmi_service_create_shared(data->device, QMI_SERVICE_DMS,
-						create_dms_cb, modem, NULL);
+	if (qmi_device_is_sync_supported(data->device))
+		qmi_device_sync(data->device, create_shared_dms, modem);
+	else
+		create_shared_dms(modem);
 }
 =

 static int gobi_enable(struct ofono_modem *modem)
-- =

2.15.1


--===============0134600526658754806==--

