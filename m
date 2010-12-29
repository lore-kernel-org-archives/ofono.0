Content-Type: multipart/mixed; boundary="===============5256842790366766454=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@nokia.com>
Subject: [PATCH 6/9] oFono smsagent enhancements to permit more flexible
 parameter set to be dispatched.
Date: Wed, 29 Dec 2010 14:51:22 +0200
Message-ID: <1293627085-24428-7-git-send-email-oleg.zhurakivskyy@nokia.com>
In-Reply-To: <1293627085-24428-1-git-send-email-oleg.zhurakivskyy@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5256842790366766454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsagent.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/smsagent.h b/src/smsagent.h
index 39513d6..348d36d 100644
--- a/src/smsagent.h
+++ b/src/smsagent.h
@@ -31,6 +31,8 @@ typedef void (*sms_agent_dispatch_cb)(struct sms_agent *a=
gent,
 					enum sms_agent_result result,
 					void *data);
 =

+typedef void (*sms_agent_dict_append_cb)(DBusMessageIter *dict, void *para=
m);
+
 struct sms_agent *sms_agent_new(const char *interface,
 					const char *service, const char *path);
 =

@@ -49,4 +51,6 @@ int sms_agent_dispatch_datagram(struct sms_agent *agent, =
const char *method,
 				const struct tm *local_sent_time,
 				const unsigned char *content, unsigned int len,
 				sms_agent_dispatch_cb cb, void *user_data,
+				sms_agent_dict_append_cb dict_cb,
+				void *dict_cb_data,
 				ofono_destroy_func destroy);
-- =

1.7.1


--===============5256842790366766454==--

