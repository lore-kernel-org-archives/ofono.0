Content-Type: multipart/mixed; boundary="===============4206869786626332443=="
MIME-Version: 1.0
From: Ryan M. Raasch <ryan.raasch@gmail.com>
Subject: [PATCH] Inserted the GSM syntax option in modem.conf. (Revised).
Date: Fri, 30 Oct 2009 14:18:00 +0100
Message-ID: <1256908680-30214-1-git-send-email-ryan.raasch@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4206869786626332443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

This is patch to allow the gsm syntax to be specified in the
modem.conf file. It is a 2nd version based on code change requests.

Greetings,
Ryan

---
 plugins/atgen.c     |   12 +++++++++++-
 plugins/modemconf.c |    1 +
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/plugins/atgen.c b/plugins/atgen.c
index 42b6c6b..8300da2 100644
--- a/plugins/atgen.c
+++ b/plugins/atgen.c
@@ -113,7 +113,17 @@ static int atgen_enable(struct ofono_modem *modem)
 		return -EIO;
 	}
 =

-	syntax =3D g_at_syntax_new_gsmv1();
+	value =3D ofono_modem_get_string(modem, "GsmSyntax");
+	if (value) {
+		if (g_str_equal(value, "V1"))
+			syntax =3D g_at_syntax_new_gsmv1();
+		else if (g_str_equal(value, "Permissive"))
+			syntax =3D g_at_syntax_new_gsm_permissive();
+		else
+			return -EINVAL;
+	} else
+		syntax =3D g_at_syntax_new_gsmv1();
+
 	chat =3D g_at_chat_new(channel, syntax);
 	g_at_syntax_unref(syntax);
 	g_io_channel_unref(channel);
diff --git a/plugins/modemconf.c b/plugins/modemconf.c
index 440b205..4b66590 100644
--- a/plugins/modemconf.c
+++ b/plugins/modemconf.c
@@ -44,6 +44,7 @@ static const char *tty_opts[] =3D {
 	"Parity",
 	"XonXoff",
 	"RtsCts",
+	"GsmSyntax",
 	NULL,
 };
 =

-- =

1.6.4.GIT


--===============4206869786626332443==--

