Content-Type: multipart/mixed; boundary="===============4761316786214033526=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v3 2/7] hfp_ag_bluez5: Store fd in hash when connect
Date: Mon, 15 Apr 2013 18:41:45 -0300
Message-ID: <1366062110-28031-3-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366062110-28031-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4761316786214033526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The file descriptor is stored after the emulator is registered.
---
 plugins/hfp_ag_bluez5.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index ba84d90..e53709d 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -113,6 +113,8 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 	}
 =

 	ofono_emulator_register(em, fd);
+	g_hash_table_insert(connection_hash, g_strdup(device),
+							GINT_TO_POINTER(fd));
 =

 	return dbus_message_new_method_return(msg);
 =

-- =

1.7.9.5


--===============4761316786214033526==--

