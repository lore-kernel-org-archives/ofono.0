Content-Type: multipart/mixed; boundary="===============5077968812328606767=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH QMI LTE v2 05/13] gprs: set driver_attached when activating
 automatic contexts
Date: Fri, 14 Apr 2017 23:36:38 +0200
Message-ID: <20170414213646.32066-6-jonas@southpole.se>
In-Reply-To: <20170414213646.32066-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5077968812328606767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ofono_gprs_cid_activated attachment machinery cannot go through
ofono_gprs_status_notify for getting the attached property set because
that would result in the automatic contexts that were just set up
being released.  As such, it needs to call gprs_set_attached_property
manually.  Doing so, however, means that the driver_attached property
never gets set, resulting in all contexts being released when the
network transitions between registered states (roaming/non-roaming).
---
 src/gprs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/gprs.c b/src/gprs.c
index 0da9c32..091305a 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1009,6 +1009,7 @@ static void pri_read_settings_callback(const struct o=
fono_error *error,
 =

 	gprs->flags &=3D !GPRS_FLAG_ATTACHING;
 =

+	gprs->driver_attached =3D TRUE;
 	gprs_set_attached_property(gprs, TRUE);
 =

 	ofono_dbus_signal_property_changed(conn, pri_ctx->path,
-- =

2.9.3


--===============5077968812328606767==--

