Content-Type: multipart/mixed; boundary="===============2891453666170114528=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/3] gsmdial: use g_at_chat_suspend
Date: Mon, 10 May 2010 11:39:41 -0700
Message-ID: <1273516783-5132-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1273516783-5132-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2891453666170114528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index a531aa3..fd9b73b 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -235,6 +235,8 @@ static void ppp_connect(const char *iface, const char *=
ip,
 static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
 {
 	g_print("PPP Link down: %d\n", reason);
+	g_at_chat_resume(control);
+	g_at_chat_resume(modem);
 }
 =

 static void connect_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -253,10 +255,8 @@ static void connect_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	 * shutdown gatchat or else it tries to take all the input
 	 * from the modem and does not let PPP get it.
 	 */
-	g_at_chat_unref(control);
-	control =3D NULL;
-	g_at_chat_unref(modem);
-	modem =3D NULL;
+	g_at_chat_suspend(control);
+	g_at_chat_suspend(modem);
 =

 	/* open ppp */
 	ppp =3D g_at_ppp_new(channel);
-- =

1.6.6.1


--===============2891453666170114528==--

