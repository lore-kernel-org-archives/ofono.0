Content-Type: multipart/mixed; boundary="===============0931718746079297176=="
MIME-Version: 1.0
From: Chupligin Sergey <s.chupligin@omprussia.ru>
Subject: [PATCH] Fix build with ell-0.20
Date: Thu, 16 May 2019 19:08:21 +0300
Message-ID: <20190516160821.31440-1-s.chupligin@omprussia.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0931718746079297176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sergey Chupligin <s.chupligin@omprussia.ru>

---
 src/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index 8623a060..c77813e9 100644
--- a/src/main.c
+++ b/src/main.c
@@ -235,8 +235,11 @@ int main(int argc, char **argv)
 =

 	event_loop =3D g_main_loop_new(NULL, FALSE);
 =

+    struct l_debug_desc start_debug[128];
+	struct l_debug_desc stop_debug[128];
+    =

 	l_log_set_stderr();
-	l_debug_enable("*");
+	l_debug_enable_full("*",start_debug, stop_debug);
 	l_main_init();
 =

 	source =3D (struct ell_event_source *) g_source_new(&event_funcs,
-- =

2.20.1


--===============0931718746079297176==--

