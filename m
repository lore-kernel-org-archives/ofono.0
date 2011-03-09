Content-Type: multipart/mixed; boundary="===============0228100420975672637=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: [PATCH 3/3] ifx: fix issue with closing of DLC_AUX tty channel
Date: Wed, 09 Mar 2011 16:46:49 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018813A9C5DBB@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0228100420975672637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Guillaume Lucas <guillaumex.lucas@intel.com>

Using kernel mux, a recursive locking is detected. This issue is
due to the fact that the DLC_AUX is not closed by ofono. This is
not done because the shutdown_device() function in charge of it
is called in the context of an AT callback function and for an
AT sent in this same dlc. Calling the real shutdown_device()
function using a timer solved the issue.
---
 plugins/ifx.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/plugins/ifx.c b/plugins/ifx.c
index 9c2a5c1..3581f80 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -93,6 +93,7 @@ struct ifx_data {
 	guint dlc_poll_count;
 	guint dlc_poll_source;
 	guint dlc_init_source;
+	guint shutdown_source;
 	guint mux_init_timeout;
 	guint frame_size;
 	int mux_ldisc;
@@ -190,8 +191,9 @@ static void xsim_notify(GAtResult *result, gpointer use=
r_data)
 	}
 }
 =

-static void shutdown_device(struct ifx_data *data)
+static gboolean shutdown_device_cb(gpointer user_data)
 {
+	struct ifx_data *data =3D user_data;
 	int i, fd;
 =

 	DBG("");
@@ -224,8 +226,18 @@ static void shutdown_device(struct ifx_data *data)
 done:
 	g_io_channel_unref(data->device);
 	data->device =3D NULL;
+	data->shutdown_source =3D 0;
+	return FALSE;
+}
+
+static void shutdown_device(struct ifx_data *data)
+{
+	DBG("");
+	data->shutdown_source =3D g_timeout_add_seconds(0,
+					shutdown_device_cb, data);
 }
 =

+
 static void dlc_disconnect(gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
-- =

1.6.3.3

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============0228100420975672637==--

