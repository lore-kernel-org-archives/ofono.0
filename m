Content-Type: multipart/mixed; boundary="===============0411724712142603049=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 05/12] service: Add a group [delivery_status] in the msg status
Date: Fri, 24 Aug 2012 15:06:04 +0200
Message-ID: <1345813571-15775-6-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1345813571-15775-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0411724712142603049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This group contains an entry for each message recipients. Each recipient
entry will be updated when the corresponding report will be received
and then remove the temporary stored delivery report.
---
 src/service.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/src/service.c b/src/service.c
index c3dc40a..ec1b1b9 100644
--- a/src/service.c
+++ b/src/service.c
@@ -69,6 +69,17 @@ static const char *ctl_chars =3D "\x01\x02\x03\x04\x05\x=
06\x07\x08\x0A"
 =

 static const char *sep_chars =3D "()<>@,;:\\\"/[]?=3D{} \t";
 =

+static const char *delivery_status[] =3D {
+	"none",
+	"expired",
+	"retrieved",
+	"rejected",
+	"deferred",
+	"indeterminate",
+	"forwarded",
+	"unreachable"
+};
+
 struct mms_request;
 =

 typedef gboolean (*mms_request_result_cb_t) (struct mms_request *request);
@@ -1058,6 +1069,28 @@ static DBusMessage *send_message(DBusConnection *con=
n,
 =

 	g_key_file_set_string(meta, "info", "state", "draft");
 =

+	if (service->use_delivery_reports) {
+		char **tos;
+		int i;
+
+		tos =3D g_strsplit(msg->sr.to, ",", 0);
+
+		for (i =3D 0; tos[i] !=3D NULL; i++) {
+			char *to =3D g_strdup(tos[i]);
+
+			mms_address_to_string(to);
+
+			DBG("%s=3D%s", to, delivery_status[0]);
+
+			g_key_file_set_string(meta, "delivery_status", to,
+							delivery_status[0]);
+
+			g_free(to);
+		}
+
+		g_strfreev(tos);
+	}
+
 	mms_store_meta_close(service->identity, msg->uuid, meta, TRUE);
 =

 	if (mms_message_register(service, msg) < 0)
-- =

1.7.9.5


--===============0411724712142603049==--

