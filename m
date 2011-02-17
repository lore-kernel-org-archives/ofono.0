Content-Type: multipart/mixed; boundary="===============8109381152628160972=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 5/5] bluetooth: add DBG() messages
Date: Thu, 17 Feb 2011 19:00:49 -0300
Message-ID: <1297980049-30760-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1297980049-30760-4-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8109381152628160972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 5f2d80d..7c2d5b0 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -280,6 +280,8 @@ static void device_properties_cb(DBusPendingCall *call,=
 gpointer user_data)
 		goto done;
 	}
 =

+	DBG("");
+
 	bluetooth_parse_properties(reply, "UUIDs", has_uuid, &have_uuid,
 				"Adapter", parse_string, &adapter,
 				"Address", parse_string, &device_addr,
@@ -410,6 +412,8 @@ static void adapter_properties_cb(DBusPendingCall *call=
, gpointer user_data)
 		goto done;
 	}
 =

+	DBG("");
+
 	bluetooth_parse_properties(reply,
 					"Devices", parse_devices, &device_list,
 					"Address", parse_string, &addr,
-- =

1.7.4


--===============8109381152628160972==--

