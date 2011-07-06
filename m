Content-Type: multipart/mixed; boundary="===============4966575551365049658=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@linux.intel.com>
Subject: [PATCH 4/4] ifxmodem: add support for user_confirmation in stk
Date: Wed, 06 Jul 2011 03:06:13 -0700
Message-ID: <1309946773-7747-5-git-send-email-jeevaka.badrappan@linux.intel.com>
In-Reply-To: <1309946773-7747-1-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4966575551365049658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/stk.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/ifxmodem/stk.c b/drivers/ifxmodem/stk.c
index f08cf47..d2082c4 100644
--- a/drivers/ifxmodem/stk.c
+++ b/drivers/ifxmodem/stk.c
@@ -173,6 +173,16 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

+static void ifx_stk_user_confirmation(struct ofono_stk *stk, gboolean conf=
irm)
+{
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
+	char buf[20];
+
+	snprintf(buf, sizeof(buf), "AT+SATD=3D%i", confirm ? 1 : 0);
+
+	g_at_chat_send(sd->chat, buf, none_prefix, NULL, NULL, NULL);
+}
+
 static void sati_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_stk *stk =3D user_data;
@@ -303,6 +313,7 @@ static struct ofono_stk_driver driver =3D {
 	.remove			=3D ifx_stk_remove,
 	.envelope		=3D ifx_stk_envelope,
 	.terminal_response	=3D ifx_stk_terminal_response,
+	.user_confirmation	=3D ifx_stk_user_confirmation,
 };
 =

 void ifx_stk_init(void)
-- =

1.7.4.1


--===============4966575551365049658==--

