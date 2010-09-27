Content-Type: multipart/mixed; boundary="===============0352215235596860954=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 1/2] Include datagram support to history API
Date: Mon, 27 Sep 2010 16:24:36 +0300
Message-ID: <1285593877-31638-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0352215235596860954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/history.h |    5 +++++
 src/history.c     |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
 src/ofono.h       |    8 ++++++++
 3 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/include/history.h b/include/history.h
index c1c4aa1..e661f24 100644
--- a/include/history.h
+++ b/include/history.h
@@ -58,6 +58,11 @@ struct ofono_history_driver {
 				const struct ofono_uuid *uuid, const char *from,
 				const struct tm *remote, const struct tm *local,
 				const char *text);
+	void (*datagram_received)(struct ofono_history_context *context,
+				const struct ofono_uuid *uuid, const char *from,
+				int dst, int src, const struct tm *remote,
+				const struct tm *local,
+				const unsigned char *buffer, unsigned len);
 	void (*sms_send_pending)(struct ofono_history_context *context,
 					const struct ofono_uuid *uuid,
 					const char *to,
diff --git a/src/history.c b/src/history.c
index 0229cf5..2610141 100644
--- a/src/history.c
+++ b/src/history.c
@@ -47,7 +47,15 @@ struct history_call_foreach_data {
 struct history_sms_foreach_data {
 	const struct ofono_uuid *uuid;
 	const char *address;
-	const char *text;
+	union {
+		const char *text;
+		struct {
+			const unsigned char *data;
+			unsigned len;
+			guint16 dst;
+			guint16 src;
+		};
+	};
 	union {
 		struct {
 			const struct tm *remote;
@@ -193,6 +201,43 @@ void __ofono_history_sms_received(struct ofono_modem *=
modem,
 					history_sms_received, &hfd);
 }
 =

+static void history_datagram_received(struct ofono_atom *atom, void *data)
+{
+	struct ofono_history_context *context =3D __ofono_atom_get_data(atom);
+	struct history_sms_foreach_data *hfd =3D data;
+
+	if (context->driver->datagram_received =3D=3D NULL)
+		return;
+
+	context->driver->datagram_received(context, hfd->uuid, hfd->address,
+						hfd->dst, hfd->src,
+						hfd->remote, hfd->local,
+						hfd->data, hfd->len);
+}
+
+void __ofono_history_datagram_received(struct ofono_modem *modem,
+					const struct ofono_uuid *uuid,
+					const char *from, int dst, int src,
+					const struct tm *remote,
+					const struct tm *local,
+					const unsigned char *buffer,
+					unsigned len)
+{
+	struct history_sms_foreach_data hfd;
+
+	hfd.uuid =3D uuid;
+	hfd.address =3D from;
+	hfd.dst =3D dst;
+	hfd.src =3D src;
+	hfd.remote =3D remote;
+	hfd.local =3D local;
+	hfd.data =3D buffer;
+	hfd.len =3D len;
+
+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_HISTORY,
+					history_datagram_received, &hfd);
+}
+
 static void history_sms_send_pending(struct ofono_atom *atom, void *data)
 {
 	struct ofono_history_context *context =3D __ofono_atom_get_data(atom);
diff --git a/src/ofono.h b/src/ofono.h
index 41ce011..b068f48 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -311,6 +311,14 @@ void __ofono_history_sms_received(struct ofono_modem *=
modem,
 					const struct tm *local,
 					const char *text);
 =

+void __ofono_history_datagram_received(struct ofono_modem *modem,
+					const struct ofono_uuid *uuid,
+					const char *from, int dst, int src,
+					const struct tm *remote,
+					const struct tm *local,
+					const unsigned char *buffer,
+					unsigned len);
+
 void __ofono_history_sms_send_pending(struct ofono_modem *modem,
 					const struct ofono_uuid *uuid,
 					const char *to,
-- =

1.7.0.4


--===============0352215235596860954==--

