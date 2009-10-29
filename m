Content-Type: multipart/mixed; boundary="===============3484297810479075590=="
MIME-Version: 1.0
From: Ryan M. Raasch <ryan.raasch@gmail.com>
Subject: [PATCH] Inserted the GSM syntax option in modem.conf.
Date: Thu, 29 Oct 2009 12:04:23 +0100
Message-ID: <1256814263-15298-1-git-send-email-ryan.raasch@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3484297810479075590==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Since the modems need to be setup in particular ways, this patch
allows for the GSM syntax to be specified by the configuration file.


Regards,
Ryan

---
 plugins/atgen.c     |    9 ++++++++-
 plugins/modemconf.c |    6 ++++++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/plugins/atgen.c b/plugins/atgen.c
index db59e36..67a1e8c 100644
--- a/plugins/atgen.c
+++ b/plugins/atgen.c
@@ -117,7 +117,14 @@ static int atgen_enable(struct ofono_modem *modem)
 		return -EIO;
 	}
 =

-	syntax =3D g_at_syntax_new_gsmv1();
+	value =3D ofono_modem_get_string(modem, "GsmSyntax");
+	if (value && g_str_equal(value, "GSM_V1"))
+		syntax =3D g_at_syntax_new_gsmv1();
+	else if (value && g_str_equal(value, "GSM_Permissive"))
+		syntax =3D g_at_syntax_new_gsm_permissive();
+	else if (value)
+		return -EINVAL;
+
 	chat =3D g_at_chat_new(channel, syntax);
 	g_at_syntax_unref(syntax);
 	g_io_channel_unref(channel);
diff --git a/plugins/modemconf.c b/plugins/modemconf.c
index 6b317e6..a5e5824 100644
--- a/plugins/modemconf.c
+++ b/plugins/modemconf.c
@@ -138,6 +138,12 @@ static int set_device(struct ofono_modem *modem,
 	} else
 		ofono_modem_set_string(modem, "Rtscts", "on");
 =

+	value =3D g_key_file_get_string(keyfile, group, "GsmSyntax", NULL);
+	if (value) {
+		ofono_modem_set_string(modem, "GsmSyntax", value);
+		g_free(value);
+	} else
+		ofono_modem_set_string(modem, "GsmSyntax", "GSM_V1");
 =

 	return 0;
 }
-- =

1.6.4.GIT


--===============3484297810479075590==--

