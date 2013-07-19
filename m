Content-Type: multipart/mixed; boundary="===============3197715695784368476=="
MIME-Version: 1.0
From: Anthony Viallard <viallard@syscom-instruments.com>
Subject: [PATCH 2/6] SIMCOM: add a quirk for AT+CNMI command building.
Date: Fri, 19 Jul 2013 15:35:36 +0200
Message-ID: <1374240940-30892-2-git-send-email-viallard@syscom-instruments.com>
In-Reply-To: <1374240940-30892-1-git-send-email-viallard@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3197715695784368476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use mode=3D1 otherwise it fails (ref. "SIM5215_SIM5216_ATC_V1.18.pdf - =C2=
=A76.9")
---
 drivers/atmodem/sms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index fde90ba..f93dd23 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -805,6 +805,7 @@ static gboolean build_cnmi_string(char *buf, int *cnmi_=
opts,
 	case OFONO_VENDOR_NOVATEL:
 	case OFONO_VENDOR_HUAWEI:
 	case OFONO_VENDOR_ZTE:
+	case OFONO_VENDOR_SIMCOM:
 		/* MSM devices advertise support for mode 2, but return an
 		 * error if we attempt to actually use it. */
 		mode =3D "1";
-- =

1.8.3.1


--===============3197715695784368476==--

