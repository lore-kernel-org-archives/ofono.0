Content-Type: multipart/mixed; boundary="===============6031122230469154559=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv3 10/10] service: bearer activity needs to be checked
Date: Wed, 18 Apr 2012 15:27:48 +0200
Message-ID: <1334755668-27458-11-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1334755668-27458-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6031122230469154559==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: S=C3=A9bastien Bianti <sebastien.bianti@linux.intel.com>

Because failure and requeing reason can be network lost, and we should
wait for recovery.
---
 src/service.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/src/service.c b/src/service.c
index f25e656..907b581 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1662,17 +1662,22 @@ int mms_service_set_bearer_handler(struct mms_servi=
ce *service,
 	return 0;
 }

-static void deactivate_bearer(struct mms_service *service)
+static inline gboolean bearer_is_active(struct mms_service *service)
 {
-	DBG("service %p", service);
-
 	if (service->bearer_setup =3D=3D TRUE)
-		return;
-
-	if (service->bearer_active =3D=3D FALSE)
-		return;
+		return FALSE;

 	if (service->bearer_handler =3D=3D NULL)
+		return FALSE;
+
+	return service->bearer_active;
+}
+
+static void deactivate_bearer(struct mms_service *service)
+{
+	DBG("service %p", service);
+
+	if (bearer_is_active(service) =3D=3D FALSE)
 		return;

 	DBG("service %p", service);
@@ -1961,6 +1966,9 @@ static void process_request_queue(struct mms_service =
*service)
 		return;

 	while (1) {
+		if (bearer_is_active(service) =3D=3D FALSE)
+			return;
+
 		request =3D g_queue_pop_head(service->request_queue);
 		if (request =3D=3D NULL)
 			break;
--
1.7.4.1


--===============6031122230469154559==--

