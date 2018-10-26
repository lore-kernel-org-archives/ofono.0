Content-Type: multipart/mixed; boundary="===============6460989691016980905=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 9/9] modem: global data is pre-zeroed
Date: Fri, 26 Oct 2018 12:13:19 +0200
Message-ID: <20181026101319.27709-10-jonas@norrbonn.se>
In-Reply-To: <20181026101319.27709-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6460989691016980905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Module-local and global data are BSS symbols and don't require
zero-initialization.
---
 src/modem.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 838967bf..bc462751 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -36,15 +36,15 @@
 =

 #define DEFAULT_POWERED_TIMEOUT (20)
 =

-static GSList *g_devinfo_drivers =3D NULL;
-static GSList *g_driver_list =3D NULL;
-static GSList *g_modem_list =3D NULL;
+static GSList *g_devinfo_drivers;
+static GSList *g_driver_list;
+static GSList *g_modem_list;
 =

-static int next_modem_id =3D 0;
-static gboolean powering_down =3D FALSE;
-static int modems_remaining =3D 0;
+static int next_modem_id;
+static gboolean powering_down;
+static int modems_remaining;
 =

-static struct ofono_watchlist *g_modemwatches =3D NULL;
+static struct ofono_watchlist *g_modemwatches;
 =

 enum property_type {
 	PROPERTY_TYPE_INVALID =3D 0,
-- =

2.17.1


--===============6460989691016980905==--

