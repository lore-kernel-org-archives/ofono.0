Content-Type: multipart/mixed; boundary="===============7841757390145795298=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH 2/2] bluez5: fix crash on DBus transport disconnection
Date: Thu, 10 Nov 2016 10:22:45 +0100
Message-ID: <1478769765-9839-2-git-send-email-kubax.t.pawlak@intel.com>
In-Reply-To: <1478769765-9839-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7841757390145795298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Do not register dbus notification if message failed to be sent out
because transport was already disconnected
---
 plugins/bluez5.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/plugins/bluez5.c b/plugins/bluez5.c
index 979076e..e72e352 100644
--- a/plugins/bluez5.c
+++ b/plugins/bluez5.c
@@ -155,8 +155,10 @@ void bt_unregister_profile(DBusConnection *conn, const=
 char *object)
 		return;
 	}
 =

-	dbus_pending_call_set_notify(c, unregister_profile_cb, NULL, NULL);
-	dbus_pending_call_unref(c);
+	if (c) {
+		dbus_pending_call_set_notify(c, unregister_profile_cb, NULL, NULL);
+		dbus_pending_call_unref(c);
+	}
 =

 	dbus_message_unref(msg);
 }
-- =

2.5.5

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


--===============7841757390145795298==--

