Content-Type: multipart/mixed; boundary="===============7602770443832927499=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH] telit: disable auto attach procedures with AUTOATT
Date: Thu, 16 Aug 2012 11:48:30 +0200
Message-ID: <1345110510-1536-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7602770443832927499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/telit.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index 6ae7249..feedd18 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -307,6 +307,12 @@ static void cfun_enable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 =

 	ofono_modem_set_powered(m, TRUE);
 =

+	/*
+	 * Tell the modem not to automatically initiate auto-attach
+	 * proceedures on its own.
+	 */
+	g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_prefix, NULL, NULL, NUL=
L);
+
 	/* Enable sim state notification */
 	g_at_chat_send(data->chat, "AT#QSS=3D1", none_prefix, NULL, NULL, NULL);
 =

-- =

1.7.7.6


--
Scanned by MailScanner.


--===============7602770443832927499==--

