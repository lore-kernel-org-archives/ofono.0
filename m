Content-Type: multipart/mixed; boundary="===============5714916877069667704=="
MIME-Version: 1.0
From: Borwankar, Antara <antara.borwankar@intel.com>
Subject: RE: [PATCH] atmodem: fix to populate activated gprs context ip
 settings
Date: Thu, 26 Sep 2019 11:50:51 +0000
Message-ID: <9BCC1739A7EADA4790E1FFF4123FB3268BB655BE@BGSMSX101.gar.corp.intel.com>
In-Reply-To: <1569497007-11249-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5714916877069667704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dennis,

I am facing this issue because for xmm7mode we get default cid as 0. =

In at_cgdcont_read_cb when cids =3D l_uintset_new(activated_cid); is called
It will create  a set with size zero hence the check in at_cgdcont_parse is=
 failing.

Do you think this fix is fine? =

Should I put handling for cid 0 under vendor flag check.

Regards
Antara =


-----Original Message-----
From: Borwankar, Antara =

Sent: Thursday, September 26, 2019 4:53 PM
To: ofono(a)ofono.org
Cc: Borwankar, Antara <antara.borwankar@intel.com>; denkenz(a)gmail.com
Subject: [PATCH] atmodem: fix to populate activated gprs context ip settings

Function to get ipv4 and ipv6 settings for first default activated context =
in LTE was not getting called after pdp activation.
Calling ofono_gprs_cid_activated function for last_auto_context_id.
---
 drivers/atmodem/gprs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c index 16f4927.=
.71a8631 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -194,6 +194,7 @@ static void at_cgdcont_parse(struct ofono_gprs *gprs, G=
AtResult *result,
 				struct l_uintset *cids)
 {
 	GAtResultIter iter;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 =

 	g_at_result_iter_init(&iter, result);
 =

@@ -204,7 +205,8 @@ static void at_cgdcont_parse(struct ofono_gprs *gprs, G=
AtResult *result,
 		if (!g_at_result_iter_next_number(&iter, &read_cid))
 			break;
 =

-		if (!l_uintset_contains(cids, read_cid))
+		if (!l_uintset_contains(cids, read_cid) &&
+			read_cid !=3D gd->last_auto_context_id)
 			continue;
 =

 		/* ignore protocol */
--
1.9.1


--===============5714916877069667704==--

