Content-Type: multipart/mixed; boundary="===============3961297583219386105=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH 4/4] huawei: remove voicecall support
Date: Tue, 25 May 2010 17:23:32 +0300
Message-ID: <20100525142332.10449.4725.stgit@potku.valot.fi>
In-Reply-To: <20100525142205.10449.64616.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3961297583219386105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These modems don't support voicecall anyway. Recommended by Denis.
---

 plugins/huawei.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index d7697b9..1b7a185 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -289,7 +289,6 @@ static void huawei_pre_sim(struct ofono_modem *modem)
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
 	data->sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
-	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
 }
 =

 static void cgreg_notify(GAtResult *result, gpointer user_data)


--===============3961297583219386105==--

