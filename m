Content-Type: multipart/mixed; boundary="===============1397842865424074414=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@nokia.com>
Subject: [PATCH 5/9] oFono smsagent enhancements to permit more flexible
 parameter set to be dispatched.
Date: Wed, 29 Dec 2010 14:51:21 +0200
Message-ID: <1293627085-24428-6-git-send-email-oleg.zhurakivskyy@nokia.com>
In-Reply-To: <1293627085-24428-1-git-send-email-oleg.zhurakivskyy@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1397842865424074414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsagent.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/smsagent.c b/src/smsagent.c
index 9d6f21d..12f6da3 100644
--- a/src/smsagent.c
+++ b/src/smsagent.c
@@ -255,6 +255,8 @@ int sms_agent_dispatch_datagram(struct sms_agent *agent=
, const char *method,
 				const struct tm *local_sent_time,
 				const unsigned char *content, unsigned int len,
 				sms_agent_dispatch_cb cb, void *user_data,
+				sms_agent_dict_append_cb dict_cb,
+				void *dict_cb_data,
 				ofono_destroy_func destroy)
 {
 	struct sms_agent_request *req;
@@ -299,6 +301,9 @@ int sms_agent_dispatch_datagram(struct sms_agent *agent=
, const char *method,
 =

 	ofono_dbus_dict_append(&dict, "Sender", DBUS_TYPE_STRING, &from);
 =

+	if (dict_cb)
+		dict_cb(&dict, dict_cb_data);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	if (!dbus_connection_send_with_reply(conn, req->msg, &req->call, -1)) {
-- =

1.7.1


--===============1397842865424074414==--

