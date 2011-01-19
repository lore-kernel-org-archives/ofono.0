Content-Type: multipart/mixed; boundary="===============0726309214854506582=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] unit: Add a test for applications directory decoding
 utility.
Date: Wed, 19 Jan 2011 09:07:55 +0100
Message-ID: <1295424478-12049-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1295424478-12049-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0726309214854506582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-simutil.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/unit/test-simutil.c b/unit/test-simutil.c
index 7cb5c10..1f350f6 100644
--- a/unit/test-simutil.c
+++ b/unit/test-simutil.c
@@ -444,6 +444,36 @@ static void test_3g_status_data(void)
 	g_free(response);
 }
 =

+static char *at_cuad_response =3D "611B4F10A0000000871002FFFFFFFF890508000=
0"
+	"FFFFFFFFFFFFFFFFFFFFFFFFFF611F4F0CA000000063504B43532D"
+	"313550094D49445066696C657351043F007F80";
+
+static void test_application_entry_decode(void) {
+	unsigned char *ef_dir;
+	long len;
+	GSList *entries;
+	struct ofono_sim_app_record *app[2];
+
+	ef_dir =3D decode_hex(at_cuad_response, -1, &len, 0);
+	entries =3D sim_parse_app_template_entries(ef_dir, len);
+
+	g_assert(g_slist_length(entries) =3D=3D 2);
+
+	app[0] =3D entries->next->data;
+	app[1] =3D entries->data;
+
+	g_assert(app[0]->aid_len =3D=3D 0x10);
+	g_assert(!memcmp(app[0]->aid, &ef_dir[4], 0x10));
+	g_assert(app[0]->label =3D=3D NULL);
+
+	g_assert(app[1]->aid_len =3D=3D 0x0c);
+	g_assert(!memcmp(app[1]->aid, &ef_dir[37], 0x0c));
+	g_assert(app[1]->label !=3D NULL);
+	g_assert(!strcmp(app[1]->label, "MIDPfiles"));
+
+	g_free(ef_dir);
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -458,6 +488,8 @@ int main(int argc, char **argv)
 	g_test_add_func("/testsimutil/EONS Handling", test_eons);
 	g_test_add_func("/testsimutil/Elementary File DB", test_ef_db);
 	g_test_add_func("/testsimutil/3G Status response", test_3g_status_data);
+	g_test_add_func("/testsimutil/Application entries decoding",
+			test_application_entry_decode);
 =

 	return g_test_run();
 }
-- =

1.7.1.86.g0e460.dirty


--===============0726309214854506582==--

