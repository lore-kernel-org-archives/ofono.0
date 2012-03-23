Content-Type: multipart/mixed; boundary="===============1505360023249729104=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH 3/3] zte: Add support for radio settings
Date: Fri, 23 Mar 2012 12:01:10 +0100
Message-ID: <1332500470-8297-4-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1332500470-8297-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1505360023249729104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/zte.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/zte.c b/plugins/zte.c
index 9a1b9e9..3a83c8b 100644
--- a/plugins/zte.c
+++ b/plugins/zte.c
@@ -41,6 +41,7 @@
 #include <ofono/ussd.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/radio-settings.h>
 #include <ofono/phonebook.h>
 #include <ofono/log.h>
 =

@@ -351,6 +352,8 @@ static void zte_post_sim(struct ofono_modem *modem)
 =

 	ofono_phonebook_create(modem, 0, "atmodem", data->aux);
 =

+	ofono_radio_settings_create(modem, 0, "ztemodem", data->aux);
+
 	ofono_sms_create(modem, OFONO_VENDOR_ZTE, "atmodem", data->aux);
 =

 	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_ZTE, "atmodem", data->aux);
-- =

1.7.5.4

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============1505360023249729104==--

