Content-Type: multipart/mixed; boundary="===============7125539535518156994=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/1] qmi: use right slot and application during SIM detection
Date: Thu, 19 Apr 2018 10:31:46 +0200
Message-ID: <1524126706-16730-2-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <1524126706-16730-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7125539535518156994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use right slot and application to get card status, PIN status and PIN
retries. Without this patch, SIMs where selected application and slot
numbers are different are not detected.
---
 drivers/qmimodem/sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 9aa943b..1ac5068 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -564,7 +564,7 @@ static enum get_card_status_result handle_get_card_stat=
us_result(
 =

 			index =3D GUINT16_FROM_LE(status->index_gw_pri);
 =

-			if ((index & 0xff) =3D=3D i && (index >> 8) =3D=3D n) {
+			if ((index & 0xff) =3D=3D n && (index >> 8) =3D=3D i) {
 				if (get_card_status(slot, info1, info2,
 								sim_stat))
 					res =3D GET_CARD_STATUS_RESULT_TEMP_ERROR;
-- =

2.7.4


--===============7125539535518156994==--

