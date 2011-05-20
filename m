Content-Type: multipart/mixed; boundary="===============2981735908974670604=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 6/7] tools: remove set but not used var
Date: Fri, 20 May 2011 16:03:44 -0300
Message-ID: <1305918225-8438-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1305918225-8438-5-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2981735908974670604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/huawei-audio.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/tools/huawei-audio.c b/tools/huawei-audio.c
index 084241e..c7b78aa 100644
--- a/tools/huawei-audio.c
+++ b/tools/huawei-audio.c
@@ -430,7 +430,6 @@ static void check_interfaces(struct modem_data *modem, =
DBusMessageIter *iter)
 {
 	DBusMessageIter entry;
 	gboolean has_callmanager =3D FALSE;
-	gboolean has_audiosettings =3D FALSE;
 =

 	dbus_message_iter_recurse(iter, &entry);
 =

@@ -442,9 +441,6 @@ static void check_interfaces(struct modem_data *modem, =
DBusMessageIter *iter)
 		if (g_str_equal(interface, OFONO_CALLMANAGER_INTERFACE) =3D=3D TRUE)
 			has_callmanager =3D TRUE;
 =

-		if (g_str_equal(interface, OFONO_AUDIO_INTERFACE) =3D=3D TRUE)
-			has_audiosettings =3D TRUE;
-
 		dbus_message_iter_next(&entry);
 	}
 =

-- =

1.7.5.1


--===============2981735908974670604==--

