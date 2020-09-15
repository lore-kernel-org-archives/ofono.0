Content-Type: multipart/mixed; boundary="===============7201138209625007833=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 2/3] droid 4: special handling for SMSes
Date: Tue, 15 Sep 2020 15:23:13 +0200
Message-ID: <20200915132313.GA13286@duo.ucw.cz>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7201138209625007833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Droid 4	 modem is "special" (aka broken) so and getting incoming SMSes
to work is quite tricky. This should get it right.
---
 drivers/atmodem/sms.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index d502da72..f08f2fb1 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -463,7 +463,8 @@ static void at_cmt_notify(GAtResult *result, gpointer u=
ser_data)
 	decode_hex_own_buf(hexpdu, -1, &pdu_len, 0, pdu);
 	ofono_sms_deliver_notify(sms, pdu, pdu_len, tpdu_len);
 =

-	if (data->vendor !=3D OFONO_VENDOR_SIMCOM)
+	if ((data->vendor !=3D OFONO_VENDOR_SIMCOM) &&
+	    (data->vendor !=3D OFONO_VENDOR_DROID))
 		at_ack_delivery(sms);
 	return;
 =

@@ -845,6 +846,7 @@ static gboolean build_cnmi_string(char *buf, int *cnmi_=
opts,
 	case OFONO_VENDOR_ZTE:
 	case OFONO_VENDOR_SIMCOM:
 	case OFONO_VENDOR_QUECTEL:
+	case OFONO_VENDOR_DROID:
 		/* MSM devices advertise support for mode 2, but return an
 		 * error if we attempt to actually use it. */
 		mode =3D "1";
@@ -858,9 +860,14 @@ static gboolean build_cnmi_string(char *buf, int *cnmi=
_opts,
 	if (!append_cnmi_element(buf, &len, cnmi_opts[0], mode, FALSE))
 		return FALSE;
 =

+	mode =3D "21";
+	if (!data->cnma_enabled)
+		mode =3D "1";
+	if (data->vendor =3D=3D OFONO_VENDOR_DROID)
+		mode =3D "2";
+
 	/* Prefer to deliver SMS via +CMT if CNMA is supported */
-	if (!append_cnmi_element(buf, &len, cnmi_opts[1],
-					data->cnma_enabled ? "21" : "1", FALSE))
+	if (!append_cnmi_element(buf, &len, cnmi_opts[1], mode, FALSE))
 		return FALSE;
 =

 	switch (data->vendor) {
@@ -1290,6 +1297,8 @@ static void at_csms_query_cb(gboolean ok, GAtResult *=
result,
 		goto out;
 =

 	switch (data->vendor) {
+	case OFONO_VENDOR_DROID:
+		break;
 	case OFONO_VENDOR_QUECTEL_SERIAL:
 		g_at_result_iter_next_number(&iter, &status_min);
 		g_at_result_iter_next_number(&iter, &status_max);
-- =

2.11.0


-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============7201138209625007833==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlGMEVBQkVDQUIwV0lRUlBmUE83cjBlQWhr
MDEwdjB3NS9CcWxkdjY4Z1VDWDJEQVFRQUtDUkF3NS9CcWxkdjYKOHMrOUFKNDRqSlF1OWxFNjVz
RFhNcHVIdC9ubjZjcjNTd0Nnd3h5bUxZVTdPeXR0UjNZeEFaZCt5WlB3Z3o4PQo9TW1EMwotLS0t
LUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============7201138209625007833==--

