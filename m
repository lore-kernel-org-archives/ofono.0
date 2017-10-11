Content-Type: multipart/mixed; boundary="===============8253451968679058064=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCHv3 4/7] xmm7xxx: add sim-auth driver to xmm7xxx plugin
Date: Wed, 11 Oct 2017 11:57:45 -0700
Message-ID: <1507748268-4799-4-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1507748268-4799-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8253451968679058064==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/xmm7xxx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 5cb843b..ff0cb4c 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -49,6 +49,7 @@
 #include <ofono/stk.h>
 #include <ofono/lte.h>
 #include <ofono/ims.h>
+#include <ofono/sim-auth.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
@@ -61,6 +62,7 @@ struct xmm7xxx_data {
 	struct ofono_sim *sim;
 	ofono_bool_t have_sim;
 	ofono_bool_t sms_phonebook_added;
+	struct ofono_sim_auth *sim_auth;
 };
 =

 static void xmm7xxx_debug(const char *str, void *user_data)
@@ -286,6 +288,7 @@ static void xmm7xxx_pre_sim(struct ofono_modem *modem)
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


--===============8253451968679058064==--

