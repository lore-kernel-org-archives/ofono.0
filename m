Content-Type: multipart/mixed; boundary="===============2077362718140967655=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH 1/4] huawei: use g_at_result_iter_skip_next()
Date: Tue, 25 May 2010 17:23:13 +0300
Message-ID: <20100525142313.10449.92771.stgit@potku.valot.fi>
In-Reply-To: <20100525142205.10449.64616.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2077362718140967655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


---

 plugins/huawei.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index a2492a7..1c44be1 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -91,7 +91,7 @@ static void sysinfo_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
-	gint srv_status, srv_domain, roam, sys_mode, sim_state;
+	gint sim_state;
 	GAtResultIter iter;
 =

 	if (!ok)
@@ -102,16 +102,16 @@ static void sysinfo_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	if (!g_at_result_iter_next(&iter, "^SYSINFO:"))
 		return;
 =

-	if (!g_at_result_iter_next_number(&iter, &srv_status))
+	if (!g_at_result_iter_skip_next(&iter))
 		return;
 =

-	if (!g_at_result_iter_next_number(&iter, &srv_domain))
+	if (!g_at_result_iter_skip_next(&iter))
 		return;
 =

-	if (!g_at_result_iter_next_number(&iter, &roam))
+	if (!g_at_result_iter_skip_next(&iter))
 		return;
 =

-	if (!g_at_result_iter_next_number(&iter, &sys_mode))
+	if (!g_at_result_iter_skip_next(&iter))
 		return;
 =

 	if (!g_at_result_iter_next_number(&iter, &sim_state))


--===============2077362718140967655==--

