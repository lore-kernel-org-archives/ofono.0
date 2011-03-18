Content-Type: multipart/mixed; boundary="===============4235452232169486649=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v2 1/1] atmodem: fix issue in time reporting with ifx
Date: Fri, 18 Mar 2011 09:48:48 -0700
Message-ID: <1300466928-10794-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1300466928-10794-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4235452232169486649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/network-registration.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 4913611..b3aa511 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -58,6 +58,7 @@ struct netreg_data {
 	int signal_max; /* max strength reported via CIND */
 	int tech;
 	struct ofono_network_time time;
+	guint nitz_timeout;
 	unsigned int vendor;
 };
 =

@@ -691,6 +692,18 @@ static void ctzv_notify(GAtResult *result, gpointer us=
er_data)
 	ofono_netreg_time_notify(netreg, &nd->time);
 }
 =

+static gboolean notify_time(gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+
+	nd->nitz_timeout =3D 0;
+
+	ofono_netreg_time_notify(netreg, &nd->time);
+
+	return FALSE;
+}
+
 static void ifx_ctzv_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
@@ -722,6 +735,11 @@ static void ifx_ctzv_notify(GAtResult *result, gpointe=
r user_data)
 	nd->time.mday =3D mday;
 	nd->time.mon =3D mon;
 	nd->time.year =3D 2000 + year;
+
+	if (nd->nitz_timeout > 0)
+		g_source_remove(nd->nitz_timeout);
+
+	nd->nitz_timeout =3D g_timeout_add_seconds(1, notify_time, user_data);
 }
 =

 static void ifx_ctzdst_notify(GAtResult *result, gpointer user_data)
@@ -743,6 +761,11 @@ static void ifx_ctzdst_notify(GAtResult *result, gpoin=
ter user_data)
 =

 	nd->time.dst =3D dst;
 =

+	if (nd->nitz_timeout > 0) {
+		g_source_remove(nd->nitz_timeout);
+		nd->nitz_timeout =3D 0;
+	}
+
 	ofono_netreg_time_notify(netreg, &nd->time);
 }
 =

@@ -1367,6 +1390,9 @@ static void at_netreg_remove(struct ofono_netreg *net=
reg)
 {
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 =

+	if (nd->nitz_timeout)
+		g_source_remove(nd->nitz_timeout);
+
 	ofono_netreg_set_data(netreg, NULL);
 =

 	g_at_chat_unref(nd->chat);
-- =

1.7.0.4


--===============4235452232169486649==--

