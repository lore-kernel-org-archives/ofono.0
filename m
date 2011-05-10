Content-Type: multipart/mixed; boundary="===============1769409559066761107=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v5 3/3] gsmdial: add ATH0 command test
Date: Tue, 10 May 2011 10:34:16 +0200
Message-ID: <1305016456-24542-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1305016456-24542-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1769409559066761107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index 31bb910..7c8ba47 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -238,9 +238,19 @@ static gboolean execute(const char *cmd)
 	return TRUE;
 }
 =

+static void power_down_ppp(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	if (!ok)
+		return;
+
+	g_at_ppp_unref(ppp);
+	ppp =3D NULL;
+}
+
 static void ppp_suspend(gpointer user_data)
 {
 	g_at_chat_resume(modem);
+	g_at_chat_send(modem, "ATH0", none_prefix, power_down_ppp, NULL, NULL);
 }
 =

 static void start_test_sequence(gpointer data)
-- =

1.7.1


--===============1769409559066761107==--

