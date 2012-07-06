Content-Type: multipart/mixed; boundary="===============7110964150211223364=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 1/3] service: manage delivery report setting
Date: Fri, 06 Jul 2012 11:32:25 +0200
Message-ID: <1341567147-18467-2-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1341567147-18467-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7110964150211223364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   13 +++++++++++++
 src/service.h |    2 ++
 2 files changed, 15 insertions(+)

diff --git a/src/service.c b/src/service.c
index 83e1fe1..5913a55 100644
--- a/src/service.c
+++ b/src/service.c
@@ -75,6 +75,7 @@ struct mms_service {
 	char *identity;
 	char *path;
 	char *mmsc;
+	gboolean dr;
 	mms_service_bearer_handler_func_t bearer_handler;
 	void *bearer_data;
 	guint bearer_timeout;
@@ -1849,6 +1850,18 @@ int mms_service_set_bearer_handler(struct mms_servic=
e *service,
 	return 0;
 }

+int mms_service_set_delivery_report(struct mms_service *service, gboolean =
dr)
+{
+	DBG("service %p dr %d", service, dr);
+
+	if (service =3D=3D NULL)
+		return -EINVAL;
+
+	service->dr =3D dr;
+
+	return 0;
+}
+
 static inline gboolean bearer_is_active(struct mms_service *service)
 {
 	if (service->bearer_setup =3D=3D TRUE)
diff --git a/src/service.h b/src/service.h
index 56c0585..bafe8c0 100644
--- a/src/service.h
+++ b/src/service.h
@@ -42,6 +42,8 @@ int mms_service_set_bearer_handler(struct mms_service *se=
rvice,
 				mms_service_bearer_handler_func_t handler,
 							void *user_data);

+int mms_service_set_delivery_report(struct mms_service *service, gboolean =
dr);
+
 void mms_service_push_notify(struct mms_service *service,
 					unsigned char *data, int len);

--
1.7.9.5


--===============7110964150211223364==--

