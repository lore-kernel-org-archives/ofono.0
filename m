Content-Type: multipart/mixed; boundary="===============7162170349462059127=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH] modem: add AT+GCAP command
Date: Wed, 23 Mar 2011 17:08:45 +0100
Message-ID: <1300896525-26094-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7162170349462059127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 26468e8..655994b 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1386,6 +1386,12 @@ static void gmr_cb(struct ofono_emulator *em,
 	attr_template(em, req, info->revision);
 }
 =

+static void gcap_cb(struct ofono_emulator *em,
+			struct ofono_emulator_request *req, void *userdata)
+{
+	attr_template(em, req, "+GCAP: +CGSM");
+}
+
 static void dun_watch(struct ofono_atom *atom,
 			enum ofono_atom_watch_condition cond, void *data)
 {
@@ -1397,6 +1403,7 @@ static void dun_watch(struct ofono_atom *atom,
 	ofono_emulator_add_handler(em, "+GMI", gmi_cb, data, NULL);
 	ofono_emulator_add_handler(em, "+GMM", gmm_cb, data, NULL);
 	ofono_emulator_add_handler(em, "+GMR", gmr_cb, data, NULL);
+	ofono_emulator_add_handler(em, "+GCAP", gcap_cb, data, NULL);
 }
 =

 int ofono_devinfo_driver_register(const struct ofono_devinfo_driver *d)
-- =

1.7.1


--===============7162170349462059127==--

