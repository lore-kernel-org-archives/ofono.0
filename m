Content-Type: multipart/mixed; boundary="===============4640920707205647741=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [P-CSCF PATCH 5/8] isi: add p-cscf parameters into context_up cb
Date: Wed, 27 Oct 2010 18:39:11 +0300
Message-ID: <1288193954-18402-5-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1288193954-18402-4-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4640920707205647741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/isimodem/gprs-context.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/isimodem/gprs-context.c b/drivers/isimodem/gprs-contex=
t.c
index 47e858a..febf299 100644
--- a/drivers/isimodem/gprs-context.c
+++ b/drivers/isimodem/gprs-context.c
@@ -132,7 +132,7 @@ static gboolean gprs_up_fail(struct context_data *cd)
 	struct ofono_gprs_context *gc =3D cd->driver;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 =

-	CALLBACK_WITH_FAILURE(cd->up_cb, NULL, 0, NULL, NULL, NULL, NULL,
+	CALLBACK_WITH_FAILURE(cd->up_cb, NULL, 0, NULL, NULL, NULL, NULL, NULL,
 				cd->data);
 =

 	gcd->contexts =3D g_slist_remove(gcd->contexts, cd);
@@ -276,7 +276,7 @@ static void activate_ind_cb(GIsiClient *client,
 =

 	CALLBACK_WITH_SUCCESS(cd->up_cb, ifname, TRUE, (const char *)ip,
 					STATIC_IP_NETMASK, NULL,
-					dns, cd->data);
+					dns, NULL, cd->data);
 	return;
 =

 error:
-- =

1.7.1


--===============4640920707205647741==--

