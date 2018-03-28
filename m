Content-Type: multipart/mixed; boundary="===============0206447427080330395=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 19/30] qmi: drop unused struct field
Date: Wed, 28 Mar 2018 21:00:05 +0200
Message-ID: <20180328190016.28509-20-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0206447427080330395==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/qmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 75c68434..a65a4bf4 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1909,7 +1909,6 @@ static bool service_create(struct qmi_device *device,
 =

 struct service_create_shared_data {
 	struct qmi_service *service;
-	struct qmi_device *device;
 	qmi_create_func_t func;
 	void *user_data;
 	qmi_destroy_func_t destroy;
@@ -1967,7 +1966,6 @@ bool qmi_service_create_shared(struct qmi_device *dev=
ice,
 		return false;
 =

 	data->service =3D qmi_service_ref(service);
-	data->device =3D device;
 	data->func =3D func;
 	data->user_data =3D user_data;
 	data->destroy =3D destroy;
-- =

2.15.1


--===============0206447427080330395==--

