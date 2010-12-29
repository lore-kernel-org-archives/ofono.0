Content-Type: multipart/mixed; boundary="===============8561822093259659837=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@nokia.com>
Subject: [PATCH 7/9] Minor modifications due to sms_agent_dispatch_datagram()
 enhancements.
Date: Wed, 29 Dec 2010 14:51:23 +0200
Message-ID: <1293627085-24428-8-git-send-email-oleg.zhurakivskyy@nokia.com>
In-Reply-To: <1293627085-24428-1-git-send-email-oleg.zhurakivskyy@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8561822093259659837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/push-notification.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/push-notification.c b/plugins/push-notification.c
index d910f70..75f013b 100644
--- a/plugins/push-notification.c
+++ b/plugins/push-notification.c
@@ -84,7 +84,7 @@ static void push_received(const char *from, const struct =
tm *remote,
 =

 	sms_agent_dispatch_datagram(pn->agent, "ReceiveNotification",
 					from, remote, local, buffer, len,
-					NULL, NULL, NULL);
+					NULL, NULL, NULL, NULL, NULL);
 }
 =

 static DBusMessage *push_notification_register_agent(DBusConnection *conn,
-- =

1.7.1


--===============8561822093259659837==--

