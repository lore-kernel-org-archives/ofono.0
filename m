Content-Type: multipart/mixed; boundary="===============0925080354477188333=="
MIME-Version: 1.0
From: caiwen.zhang@intel.com
Subject: [PATCH] plugins/ril.c: avoid create a gril each time enable ril modem
Date: Tue, 12 Jan 2016 11:39:59 +0800
Message-ID: <1452569999-15593-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0925080354477188333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Caiwen Zhang <caiwen.zhang@intel.com>

---
 plugins/ril.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/plugins/ril.c b/plugins/ril.c
index ea50d76..688a5bf 100644
--- a/plugins/ril.c
+++ b/plugins/ril.c
@@ -400,9 +400,13 @@ static gboolean connect_rild(gpointer user_data)
 int ril_enable(struct ofono_modem *modem)
 {
 	int ret;
+  struct ril_data *rd =3D ofono_modem_get_data(modem);
 =

 	DBG("");
 =

+	if (rd->ril)
+		return 0;
+
 	ret =3D create_gril(modem);
 	if (ret < 0)
 		g_timeout_add_seconds(RILD_CONNECT_RETRY_TIME_S,
-- =

1.9.1


--===============0925080354477188333==--

