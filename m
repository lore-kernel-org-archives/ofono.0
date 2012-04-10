Content-Type: multipart/mixed; boundary="===============5139104312891783038=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv4 03/13] call-forwarding: Get rid of extra variable
Date: Tue, 10 Apr 2012 15:17:24 +0300
Message-ID: <1334060254-29547-4-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1334060254-29547-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5139104312891783038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index beae53b..cda54e7 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -116,12 +116,11 @@ static int cf_find_timeout(GSList *cf_list, int cls)
 	return c->time;
 }
 =

-static void cf_cond_list_print(GSList *list)
+static void cf_cond_list_print(GSList *l)
 {
-	GSList *l;
 	struct ofono_call_forwarding_condition *cond;
 =

-	for (l =3D list; l; l =3D l->next) {
+	for (; l ; l =3D l->next) {
 		cond =3D l->data;
 =

 		DBG("CF Condition status: %d, class: %d, number: %s,"
-- =

1.7.5.4


--===============5139104312891783038==--

