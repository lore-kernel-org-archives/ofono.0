Content-Type: multipart/mixed; boundary="===============6852976491797515463=="
MIME-Version: 1.0
From: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH 1/2] hfp_ag: Fix empty parameter list in functions
Date: Fri, 30 Dec 2011 03:30:32 +0530
Message-ID: <1325196035-10461-1-git-send-email-syamsidhardh@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6852976491797515463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag.c
index 4a244d9..c2d1d30 100644
--- a/plugins/hfp_ag.c
+++ b/plugins/hfp_ag.c
@@ -190,7 +190,7 @@ static void call_modemwatch(struct ofono_modem *modem, =
void *user)
 	modem_watch(modem, TRUE, user);
 }
 =

-static int hfp_ag_init()
+static int hfp_ag_init(void)
 {
 	sim_hash =3D g_hash_table_new(g_direct_hash, g_direct_equal);
 =

@@ -200,7 +200,7 @@ static int hfp_ag_init()
 	return 0;
 }
 =

-static void hfp_ag_exit()
+static void hfp_ag_exit(void)
 {
 	__ofono_modemwatch_remove(modemwatch_id);
 	g_list_free(modems);
-- =

1.7.4.1


--===============6852976491797515463==--

