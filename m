Content-Type: multipart/mixed; boundary="===============5163110164429578191=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 6/7] hfp_ag_bluez5: Store emulator when connect
Date: Fri, 12 Apr 2013 17:41:04 -0300
Message-ID: <1365799265-19946-7-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1365799265-19946-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5163110164429578191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The emulator is stored after being registered.
---
 plugins/hfp_ag_bluez5.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index b485e17..dbf053b 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -116,6 +116,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 	}
 =

 	ofono_emulator_register(em, fd);
+	g_hash_table_insert(emulator_hash, g_strdup(device), em);
 =

 	return dbus_message_new_method_return(msg);
 =

-- =

1.7.9.5


--===============5163110164429578191==--

