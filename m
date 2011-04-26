Content-Type: multipart/mixed; boundary="===============4972904291118925343=="
MIME-Version: 1.0
From: martin.xu@intel.com
Subject: [PATCH 1/1] Switch to offline mode only when the modem is NOT online
Date: Tue, 26 Apr 2011 17:16:48 +0800
Message-ID: <1303809408-926-1-git-send-email-martin.xu@intel.com>
In-Reply-To: <martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4972904291118925343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Xu <martin.xu@intel.com>

---
 plugins/huawei.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 1f69a8c..5f2c47f 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -217,7 +217,8 @@ static gboolean notify_sim_state(struct ofono_modem *mo=
dem,
 		 */
 		ofono_modem_set_powered(modem, TRUE);
 =

-		g_at_chat_send(data->pcui, "AT+CFUN=3D5", none_prefix,
+		if (ofono_modem_get_online(modem) =3D=3D FALSE)
+			g_at_chat_send(data->pcui, "AT+CFUN=3D5", none_prefix,
 				cfun_offline, modem, NULL);
 =

 		return FALSE;
-- =

1.7.2.2


--===============4972904291118925343==--

