Content-Type: multipart/mixed; boundary="===============8490395223212526015=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 3/9] atmodem: enlarge command buffer
Date: Fri, 26 Oct 2018 12:13:13 +0200
Message-ID: <20181026101319.27709-4-jonas@norrbonn.se>
In-Reply-To: <20181026101319.27709-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8490395223212526015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ofono phone number max length is 80 so a buffer size of 64 is
obviously insufficient.  Expanding the buffer to 128 prevents a
potential failure and suppresses the folowing compiler warning:

../drivers/atmodem/sms.c: In function =E2=80=98at_csca_set=E2=80=99:
../drivers/atmodem/sms.c:108:40: warning: =E2=80=98%s=E2=80=99 directive ou=
tput may be truncated writing up to 80 bytes into a region of size 55 [-Wfo=
rmat-truncation=3D]
  snprintf(buf, sizeof(buf), "AT+CSCA=3D\"%s\",%d", sca->number, sca->type);
                                        ^~
../drivers/atmodem/sms.c:108:2: note: =E2=80=98snprintf=E2=80=99 output bet=
ween 13 and 103 bytes into a destination of size 64
  snprintf(buf, sizeof(buf), "AT+CSCA=3D\"%s\",%d", sca->number, sca->type);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
---
 drivers/atmodem/sms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 380cd763..277d6517 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -103,7 +103,7 @@ static void at_csca_set(struct ofono_sms *sms,
 {
 	struct sms_data *data =3D ofono_sms_get_data(sms);
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
-	char buf[64];
+	char buf[128];
 =

 	snprintf(buf, sizeof(buf), "AT+CSCA=3D\"%s\",%d", sca->number, sca->type);
 =

-- =

2.17.1


--===============8490395223212526015==--

