Content-Type: multipart/mixed; boundary="===============5364175586063194060=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH] telit: disable auto attach procedures with AUTOATT
Date: Tue, 21 Aug 2012 17:06:37 +0200
Message-ID: <1345561597-30140-1-git-send-email-christopher.vogl@hale.at>
In-Reply-To: <50323A55.1050709@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5364175586063194060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/telit.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index 20ab1df..ec57f01 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -314,6 +314,13 @@ static void cfun_enable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 =

 	ofono_modem_set_powered(m, TRUE);
 =

+	/*
+	 * Tell the modem not to automatically initiate auto-attach
+	 * proceedures on its own.
+	 */
+	g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_prefix,
+				NULL, NULL, NULL);
+
 	/* Enable sim state notification */
 	g_at_chat_send(data->chat, "AT#QSS=3D1", none_prefix, NULL, NULL, NULL);
 =

-- =

1.7.7.6


--
Scanned by MailScanner.


--===============5364175586063194060==--

