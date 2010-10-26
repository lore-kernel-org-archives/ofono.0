Content-Type: multipart/mixed; boundary="===============3260181485369279007=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 1/6] radio settings: fix mode initializion
Date: Tue, 26 Oct 2010 18:31:48 +0300
Message-ID: <1288107113-2740-2-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1288107113-2740-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3260181485369279007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/radio-settings.h |    9 +++++----
 src/radio-settings.c     |    2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/radio-settings.h b/include/radio-settings.h
index d41ec0b..1b133e9 100644
--- a/include/radio-settings.h
+++ b/include/radio-settings.h
@@ -29,10 +29,11 @@ extern "C" {
 #include <ofono/types.h>
 =

 enum ofono_radio_access_mode {
-	OFONO_RADIO_ACCESS_MODE_ANY	=3D 0,
-	OFONO_RADIO_ACCESS_MODE_GSM	=3D 1,
-	OFONO_RADIO_ACCESS_MODE_UMTS	=3D 2,
-	OFONO_RADIO_ACCESS_MODE_LTE	=3D 3,
+	OFONO_RADIO_ACCESS_MODE_UNKNOWN	=3D 0,
+	OFONO_RADIO_ACCESS_MODE_ANY	=3D 1,
+	OFONO_RADIO_ACCESS_MODE_GSM	=3D 2,
+	OFONO_RADIO_ACCESS_MODE_UMTS	=3D 3,
+	OFONO_RADIO_ACCESS_MODE_LTE	=3D 4,
 };
 =

 struct ofono_radio_settings;
diff --git a/src/radio-settings.c b/src/radio-settings.c
index 3306be6..173e5bf 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -321,7 +321,7 @@ struct ofono_radio_settings *ofono_radio_settings_creat=
e(struct ofono_modem *mod
 	if (!rs)
 		return NULL;
 =

-	rs->mode =3D -1;
+	rs->mode =3D OFONO_RADIO_ACCESS_MODE_UNKNOWN;
 =

 	rs->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_RADIO_SETTINGS,
 						radio_settings_remove, rs);
-- =

1.7.0.4


--===============3260181485369279007==--

