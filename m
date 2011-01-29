Content-Type: multipart/mixed; boundary="===============4387133643522451173=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] stemodem: fix issue with gatchat usage
Date: Sat, 29 Jan 2011 11:03:37 -0800
Message-ID: <1296327817-8420-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4387133643522451173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/stemodem/radio-settings.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/stemodem/radio-settings.c b/drivers/stemodem/radio-set=
tings.c
index 5b50126..d6ed2e1 100644
--- a/drivers/stemodem/radio-settings.c
+++ b/drivers/stemodem/radio-settings.c
@@ -187,6 +187,15 @@ static void ste_set_rat_mode(struct ofono_radio_settin=
gs *rs,
 	}
 }
 =

+static gboolean ste_radio_settings_register(gpointer user)
+{
+	struct ofono_radio_settings *rs =3D user;
+
+	ofono_radio_settings_register(rs);
+
+	return FALSE;
+}
+
 static int ste_radio_settings_probe(struct ofono_radio_settings *rs,
 					unsigned int vendor, void *data)
 {
@@ -197,10 +206,10 @@ static int ste_radio_settings_probe(struct ofono_radi=
o_settings *rs,
 	if (rsd =3D=3D NULL)
 		return -ENOMEM;
 =

-	rsd->chat =3D chat;
+	rsd->chat =3D g_at_chat_clone(chat);
 =

 	ofono_radio_settings_set_data(rs, rsd);
-	ofono_radio_settings_register(rs);
+	g_idle_add(ste_radio_settings_register, rs);
 =

 	return 0;
 }
@@ -209,6 +218,8 @@ static void ste_radio_settings_remove(struct ofono_radi=
o_settings *rs)
 {
 	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
 	ofono_radio_settings_set_data(rs, NULL);
+
+	g_at_chat_unref(rsd->chat);
 	g_free(rsd);
 }
 =

-- =

1.7.0.4


--===============4387133643522451173==--

