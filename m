Content-Type: multipart/mixed; boundary="===============1117732977860473703=="
MIME-Version: 1.0
From: Anthony Viallard <viallard@syscom-instruments.com>
Subject: [PATCH 2/4] SIMCOM AT+CNMI quirk
Date: Fri, 22 Mar 2013 11:36:16 +0100
Message-ID: <1363948578-24128-2-git-send-email-viallard@syscom-instruments.com>
In-Reply-To: <1363948578-24128-1-git-send-email-viallard@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1117732977860473703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a quirk for AT+CNMI command building.

Use mode=3D1 otherwise it fails (ref. SIM5215_SIM5216_ATC_V1.18.pdf - =EF=
=BF=BD=EF=BF=BD6.9)

--- ofono-1.12.orig/drivers/atmodem/sms.c	2012-04-20 21:06:29.000000000 +02=
00
+++ ofono-1.12/drivers/atmodem/sms.c	2013-01-21 16:48:44.460627485 +0100
@@ -805,6 +807,7 @@ static gboolean build_cnmi_string(char *
 	case OFONO_VENDOR_NOVATEL:
 	case OFONO_VENDOR_HUAWEI:
 	case OFONO_VENDOR_ZTE:
+	case OFONO_VENDOR_SIMCOM:
 		/* MSM devices advertise support for mode 2, but return an
 		 * error if we attempt to actually use it. */
 		mode =3D "1";

--===============1117732977860473703==--

