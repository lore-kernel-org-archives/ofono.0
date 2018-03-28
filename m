Content-Type: multipart/mixed; boundary="===============4133945129943500652=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 13/30] qmi: assume version_list is up to date
Date: Wed, 28 Mar 2018 20:59:59 +0200
Message-ID: <20180328190016.28509-14-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4133945129943500652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The way things are currently coded, the gobi plugin calls
qmi_device_discover and does nothing else until it succeeds.  As such,
we can safely assume that the version_list is set up when we go to
create a service.
---
 drivers/qmimodem/qmi.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index e11e05b1..3eb9e8c3 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2016,20 +2016,9 @@ static bool service_create(struct qmi_device *device=
, bool shared,
 	data->user_data =3D user_data;
 	data->destroy =3D destroy;
 =

-	if (device->version_list) {
-		service_create_discover(device->version_count,
-						device->version_list, data);
-		goto done;
-	}
-
-	if (qmi_device_discover(device, service_create_discover, data, NULL))
-		goto done;
+	service_create_discover(device->version_count,
+					device->version_list, data);
 =

-	g_free(data);
-
-	return false;
-
-done:
 	data->timeout =3D g_timeout_add_seconds(8, service_create_reply, data);
 	__qmi_device_discovery_started(device, &data->super);
 =

-- =

2.15.1


--===============4133945129943500652==--

