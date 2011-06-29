Content-Type: multipart/mixed; boundary="===============8285967953258635396=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v4 4/4] gsmdial: Activate ACFC and PFC options on GAtPPP object
Date: Wed, 29 Jun 2011 10:20:26 +0200
Message-ID: <1309335626-32202-5-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1309335626-32202-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8285967953258635396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index 1116984..f0b4492 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -372,6 +372,9 @@ static void connect_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 =

 	g_at_ppp_set_credentials(ppp, option_username, option_password);
 =

+	g_at_ppp_set_acfc_enabled(ppp, TRUE);
+	g_at_ppp_set_pfc_enabled(ppp, TRUE);
+
 	/* set connect and disconnect callbacks */
 	g_at_ppp_set_connect_function(ppp, ppp_connect, NULL);
 	g_at_ppp_set_disconnect_function(ppp, ppp_disconnect, NULL);
-- =

1.7.1


--===============8285967953258635396==--

