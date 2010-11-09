Content-Type: multipart/mixed; boundary="===============7914409925416935919=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 6/8] Add gprs-context to DUN
Date: Tue, 09 Nov 2010 02:42:59 -0200
Message-ID: <1289277781-6378-7-git-send-email-gustavo@padovan.org>
In-Reply-To: <1289277781-6378-6-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7914409925416935919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/dunmodem/dunmodem.h |    3 +++
 plugins/dun.c               |    8 ++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/dunmodem/dunmodem.h b/drivers/dunmodem/dunmodem.h
index f4c54dc..3af1fec 100644
--- a/drivers/dunmodem/dunmodem.h
+++ b/drivers/dunmodem/dunmodem.h
@@ -19,10 +19,13 @@
  *
  */
 =

+#include <drivers/atmodem/atutil.h>
+
 struct dun_data {
 	char *dun_path;
 	char *rfcomm;
 	GAtChat *chat;
+	struct ofono_gprs_context *gc;
 };
 =

 void dun_netreg_init();
diff --git a/plugins/dun.c b/plugins/dun.c
index 7e0b768..dff0d4c 100644
--- a/plugins/dun.c
+++ b/plugins/dun.c
@@ -312,6 +312,13 @@ static void dun_pre_sim(struct ofono_modem *modem)
 	ofono_netreg_create(modem, 0, "dunmodem", data);
 }
 =

+static void dun_post_sim(struct ofono_modem *modem)
+{
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+
+	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
+}
+
 static struct ofono_modem_driver dun_driver =3D {
 	.name		=3D "dun",
 	.probe		=3D dun_probe,
@@ -319,6 +326,7 @@ static struct ofono_modem_driver dun_driver =3D {
 	.enable		=3D dun_enable,
 	.disable	=3D dun_disable,
 	.pre_sim	=3D dun_pre_sim,
+	.post_sim	=3D dun_post_sim,
 };
 =

 static struct bluetooth_profile dun_profile =3D {
-- =

1.7.3


--===============7914409925416935919==--

