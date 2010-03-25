Content-Type: multipart/mixed; boundary="===============4623284867853836104=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 4/4] gsmdial: shutdown ppp link if we have one.
Date: Wed, 24 Mar 2010 21:41:55 -0700
Message-ID: <1269492115-15412-5-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1269492115-15412-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4623284867853836104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If we have created a ppp link, shut it down when the signal handler
is called.
---
 gatchat/gsmdial.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index aee9eea..a18f486 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -101,6 +101,8 @@ static gboolean signal_cb(GIOChannel *channel, GIOCondi=
tion cond, gpointer data)
 	case SIGTERM:
 		if (terminated =3D=3D 0) {
 			char buf[64];
+			if (ppp)
+				g_at_ppp_shutdown(ppp);
 =

 			g_timeout_add_seconds(10, quit_eventloop, NULL);
 			sprintf(buf, "AT+CFUN=3D%u", option_offmode);
@@ -285,7 +287,7 @@ static void connect_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	ppp =3D g_at_ppp_new(channel);
 	if (!ppp) {
 		g_print("Unable to create PPP object\n");
-		return;
+		exit(1);
 	}
 	g_at_ppp_set_credentials(ppp, option_username,
 				option_password);
-- =

1.6.6.1


--===============4623284867853836104==--

