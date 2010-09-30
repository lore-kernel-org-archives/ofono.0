Content-Type: multipart/mixed; boundary="===============6445654124627761316=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH] smart_messaging: Remove interface on atom removal
Date: Thu, 30 Sep 2010 11:22:05 +0300
Message-ID: <1285834925-18213-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6445654124627761316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/smart_messaging.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/smart_messaging.c b/plugins/smart_messaging.c
index fb44cc1..27f88e7 100644
--- a/plugins/smart_messaging.c
+++ b/plugins/smart_messaging.c
@@ -99,6 +99,9 @@ static void sms_watch(struct ofono_atom *atom,
 		g_dbus_unregister_interface(conn,
 					ofono_modem_get_path(sm->modem),
 					SMART_MESSAGING_INTERFACE);
+
+		ofono_modem_remove_interface(sm->modem,
+						SMART_MESSAGING_INTERFACE);
 		return;
 	}
 =

-- =

1.7.0.4


--===============6445654124627761316==--

