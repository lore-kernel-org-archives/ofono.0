Content-Type: multipart/mixed; boundary="===============6614970077126381237=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 2/2] tools/auto-enable.c and tools/huawei-audio.c: removed
 calls to g_thread_init
Date: Thu, 20 Sep 2018 06:39:41 +0200
Message-ID: <1537418381-18473-2-git-send-email-gciofono@gmail.com>
In-Reply-To: <1537418381-18473-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6614970077126381237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/auto-enable.c  | 5 -----
 tools/huawei-audio.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/tools/auto-enable.c b/tools/auto-enable.c
index 87fb0a8..5195aaa 100644
--- a/tools/auto-enable.c
+++ b/tools/auto-enable.c
@@ -492,11 +492,6 @@ int main(int argc, char **argv)
 	guint watch;
 	struct sigaction sa;
 =

-#ifdef NEED_THREADS
-	if (g_thread_supported() =3D=3D FALSE)
-		g_thread_init(NULL);
-#endif
-
 	context =3D g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
 =

diff --git a/tools/huawei-audio.c b/tools/huawei-audio.c
index 9997a58..10b599f 100644
--- a/tools/huawei-audio.c
+++ b/tools/huawei-audio.c
@@ -775,11 +775,6 @@ int main(int argc, char **argv)
 	guint watch;
 	struct sigaction sa;
 =

-#ifdef NEED_THREADS
-	if (g_thread_supported() =3D=3D FALSE)
-		g_thread_init(NULL);
-#endif
-
 	context =3D g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
 =

-- =

1.9.1


--===============6614970077126381237==--

