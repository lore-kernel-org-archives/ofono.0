Content-Type: multipart/mixed; boundary="===============1289142724913960923=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@nokia.com>
Subject: [PATCH 8/9] Minor modifications due to sms_agent_dispatch_datagram()
 enhancements.
Date: Wed, 29 Dec 2010 14:51:24 +0200
Message-ID: <1293627085-24428-9-git-send-email-oleg.zhurakivskyy@nokia.com>
In-Reply-To: <1293627085-24428-1-git-send-email-oleg.zhurakivskyy@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1289142724913960923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/smart-messaging.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/smart-messaging.c b/plugins/smart-messaging.c
index e7889f2..4554ab3 100644
--- a/plugins/smart-messaging.c
+++ b/plugins/smart-messaging.c
@@ -87,7 +87,7 @@ static void vcard_received(const char *from, const struct=
 tm *remote,
 =

 	sms_agent_dispatch_datagram(sm->agent, "ReceiveBusinessCard",
 					from, remote, local, buffer, len,
-					NULL, NULL, NULL);
+					NULL, NULL, NULL, NULL, NULL);
 }
 =

 static void vcal_received(const char *from, const struct tm *remote,
@@ -102,7 +102,7 @@ static void vcal_received(const char *from, const struc=
t tm *remote,
 =

 	sms_agent_dispatch_datagram(sm->agent, "ReceiveAppointment",
 					from, remote, local, buffer, len,
-					NULL, NULL, NULL);
+					NULL, NULL, NULL, NULL, NULL);
 }
 =

 static DBusMessage *smart_messaging_register_agent(DBusConnection *conn,
-- =

1.7.1


--===============1289142724913960923==--

