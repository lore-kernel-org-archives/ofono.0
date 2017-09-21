Content-Type: multipart/mixed; boundary="===============5340663801975461309=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 4/7] xmm7xxx: add sim-auth driver to xmm7xxx plugin
Date: Thu, 21 Sep 2017 11:11:57 -0700
Message-ID: <1506017520-22482-4-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1506017520-22482-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5340663801975461309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/xmm7xxx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 4443d4c..50ec3e3 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -48,6 +48,7 @@
 #include <ofono/gprs-context.h>
 #include <ofono/stk.h>
 #include <ofono/lte.h>
+#include <ofono/sim-auth.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
@@ -60,6 +61,7 @@ struct xmm7xxx_data {
 	struct ofono_sim *sim;
 	ofono_bool_t have_sim;
 	ofono_bool_t sms_phonebook_added;
+	struct ofono_sim_auth *sim_auth;
 };
 =

 static void xmm7xxx_debug(const char *str, void *user_data)
@@ -285,6 +287,7 @@ static void xmm7xxx_pre_sim(struct ofono_modem *modem)
 	ofono_devinfo_create(modem, OFONO_VENDOR_IFX, "atmodem", data->chat);
 	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_IFX, "atmodem",
 					data->chat);
+	data->sim_auth =3D ofono_sim_auth_create(modem, 0, "atmodem", data->chat);
 }
 =

 static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
-- =

2.7.4


--===============5340663801975461309==--

