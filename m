Content-Type: multipart/mixed; boundary="===============5457517746187261680=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 07/30] qmi: figure out request id without accessing header
Date: Wed, 28 Mar 2018 20:59:53 +0200
Message-ID: <20180328190016.28509-8-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5457517746187261680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We want to drop the 'head' parameter from request_submit as it barely
service any purpose.  This patch changes discover_data to figure out its
'tid' value from the device struct instead of looking into the request
header.
---
 drivers/qmimodem/qmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 3d6009fa..538da02c 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1272,7 +1272,9 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 			QMI_CTL_GET_VERSION_INFO,
 			NULL, 0, discover_callback, data, (void **) &hdr);
 =

-	data->tid =3D hdr->transaction;
+	data->tid =3D device->next_control_tid - 1;
+	if (data->tid =3D=3D 0)
+		data->tid =3D 255;
 =

 	data->timeout =3D g_timeout_add_seconds(5, discover_reply, data);
 	__qmi_device_discovery_started(device, &data->super);
-- =

2.15.1


--===============5457517746187261680==--

