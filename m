Content-Type: multipart/mixed; boundary="===============4401957888634318320=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 2/2] qmimodem/network-registration: register callbacks after
 ofono_netreg_register()
Date: Mon, 11 Sep 2017 02:25:43 +0200
Message-ID: <20170911002543.31030-2-lynxis@fe80.eu>
In-Reply-To: <20170911002543.31030-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4401957888634318320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When registering callbacks before ofono_netreg_register(), callbacks
will use the netreg api which might lead into undefined behaviour,
because certain fields aren't yet initilized.
---
 drivers/qmimodem/network-registration.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/net=
work-registration.c
index c88e80bdf711..70ddea52df40 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -511,10 +511,17 @@ static void event_notify(struct qmi_result *result, v=
oid *user_data)
 static void set_event_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *data =3D ofono_netreg_get_data(netreg);
 =

 	DBG("");
 =

 	ofono_netreg_register(netreg);
+
+	qmi_service_register(data->nas, QMI_NAS_EVENT,
+					event_notify, netreg, NULL);
+
+	qmi_service_register(data->nas, QMI_NAS_SS_INFO_IND,
+					ss_info_notify, netreg, NULL);
 }
 =

 static void create_nas_cb(struct qmi_service *service, void *user_data)
@@ -536,12 +543,6 @@ static void create_nas_cb(struct qmi_service *service,=
 void *user_data)
 =

 	data->nas =3D qmi_service_ref(service);
 =

-	qmi_service_register(data->nas, QMI_NAS_EVENT,
-					event_notify, netreg, NULL);
-
-	qmi_service_register(data->nas, QMI_NAS_SS_INFO_IND,
-					ss_info_notify, netreg, NULL);
-
 	param =3D qmi_param_new();
 	if (!param)
 		goto done;
-- =

2.14.1


--===============4401957888634318320==--

