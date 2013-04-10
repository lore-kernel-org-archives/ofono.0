Content-Type: multipart/mixed; boundary="===============5883977739764344545=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 5/6] hfp_ag_bluez5: Store emulator when connect
Date: Wed, 10 Apr 2013 16:24:46 -0300
Message-ID: <1365621887-16940-6-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1365621887-16940-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5883977739764344545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag_bluez5.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index b15b64f..2046e7d 100644
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


--===============5883977739764344545==--

