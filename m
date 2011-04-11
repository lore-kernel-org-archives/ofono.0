Content-Type: multipart/mixed; boundary="===============1331255100797528128=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 15/20] include: add default context param and api
Date: Mon, 11 Apr 2011 13:20:13 +0300
Message-ID: <1302517218-2147-16-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1331255100797528128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/packet-service.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/include/packet-service.h b/include/packet-service.h
index d8cfd21..0e80ae8 100644
--- a/include/packet-service.h
+++ b/include/packet-service.h
@@ -32,6 +32,16 @@ extern "C" {
 struct ofono_packet_service;
 struct ofono_packet_context;
 =

+struct ofono_default_context_param {
+	int cid;
+	int proto;
+	const char *apn;
+	const char *address;
+	const char *gateway;
+	const char **dns;
+	const char *interface;
+};
+
 typedef void (*ofono_packet_service_status_cb_t)(
 					const struct ofono_error *error,
 					int status, void *data);
@@ -88,6 +98,10 @@ void ofono_packet_service_set_cid_range(struct ofono_pac=
ket_service *ps,
 void ofono_packet_service_add_context(struct ofono_packet_service *ps,
 					struct ofono_packet_context *pc);
 =

+void ofono_packet_service_default_context_notify(
+				struct ofono_packet_service *ps,
+				struct ofono_default_context_param *dc);
+
 int ofono_packet_service_get_technology(struct ofono_packet_service *ps);
 =

 #ifdef __cplusplus
-- =

1.7.0.4


--===============1331255100797528128==--

