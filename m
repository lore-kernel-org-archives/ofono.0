Content-Type: multipart/mixed; boundary="===============7936792116225838870=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 1/2] rilmodem: restore SET_SMSC_ADDRESS number format
Date: Fri, 04 Dec 2015 16:16:57 -0500
Message-ID: <1449263818-14263-2-git-send-email-espy@canonical.com>
In-Reply-To: <1449263818-14263-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7936792116225838870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Restore quoting of SMSC number string, as it's
required by at least one rild implementation (mako).
---
 drivers/rilmodem/sms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rilmodem/sms.c b/drivers/rilmodem/sms.c
index 3eedadd..ea57b84 100644
--- a/drivers/rilmodem/sms.c
+++ b/drivers/rilmodem/sms.c
@@ -73,7 +73,9 @@ static void ril_csca_set(struct ofono_sms *sms,
 	struct sms_data *sd =3D ofono_sms_get_data(sms);
 	struct cb_data *cbd =3D cb_data_new(cb, user_data, sd);
 	struct parcel rilp;
-	const char *number =3D phone_number_to_string(sca);
+	char number[OFONO_MAX_PHONE_NUMBER_LENGTH + 4];
+
+	snprintf(number, sizeof(number), "\"%s\"", phone_number_to_string(sca));
 =

 	parcel_init(&rilp);
 	parcel_w_string(&rilp, number);
-- =

2.1.4


--===============7936792116225838870==--

