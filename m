Content-Type: multipart/mixed; boundary="===============0475423598989468763=="
MIME-Version: 1.0
From: caiwen.zhang@intel.com
Subject: [PATCH] fix ofonod crash when pin is blocked
Date: Thu, 12 Sep 2013 01:13:54 +0800
Message-ID: <1378919634-5912-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0475423598989468763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Caiwen Zhang <caiwen.zhang@intel.com>

When is blocked, gprs/network atom is removed, it will
remove the SIM SPN watch which is added when it is created.
If at that time, SIM atom has been removed ofonod will crash
due to "sim->spn_watches" is NULL.

There is the same issue about network registration status watch.
---
 src/watch.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/watch.c b/src/watch.c
index dfb01fb..906c559 100644
--- a/src/watch.c
+++ b/src/watch.c
@@ -53,6 +53,9 @@ gboolean __ofono_watchlist_remove_item(struct ofono_watch=
list *watchlist,
 	GSList *p;
 	GSList *c;
 =

+	if (watchlist =3D=3D NULL)
+		return;
+
 	p =3D NULL;
 	c =3D watchlist->items;
 =

-- =

1.7.9.5


--===============0475423598989468763==--

