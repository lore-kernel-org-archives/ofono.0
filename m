Content-Type: multipart/mixed; boundary="===============6393831681455756694=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 08/30] qmi: make qmi_service_send return result
Date: Wed, 28 Mar 2018 20:59:54 +0200
Message-ID: <20180328190016.28509-9-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6393831681455756694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The function qmi_service_send used to return the request's transaction
id, but nowhere in the codebase was this actually used.  This patch
switches the return value of that function to just indicate success or
failure, which is sufficient for all current users of the function.
---
 drivers/qmimodem/qmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 538da02c..2c209d59 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2257,6 +2257,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	struct qmi_device *device;
 	struct service_send_data *data;
 	struct qmi_service_hdr *hdr;
+	int r;
 =

 	if (!service)
 		return 0;
@@ -2284,7 +2285,10 @@ uint16_t qmi_service_send(struct qmi_service *servic=
e,
 =

 	qmi_param_free(param);
 =

-	return hdr->transaction;
+	if (r)
+		return 0; /* request submission failed */
+
+	return 1;
 }
 =

 bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
-- =

2.15.1


--===============6393831681455756694==--

