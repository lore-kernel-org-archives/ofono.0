Content-Type: multipart/mixed; boundary="===============4971010509593219723=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 1/4] network: __ofono_netreg_registration_status internal api
Date: Mon, 10 Jan 2011 11:43:40 +0200
Message-ID: <1294652623-17287-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294652623-17287-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4971010509593219723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |    8 ++++++++
 src/ofono.h   |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/network.c b/src/network.c
index eb0f797..640391d 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1864,3 +1864,11 @@ void *ofono_netreg_get_data(struct ofono_netreg *net=
reg)
 {
 	return netreg->driver_data;
 }
+
+int __ofono_netreg_registration_status(struct ofono_netreg *netreg)
+{
+	if (netreg =3D=3D NULL)
+		return NETWORK_REGISTRATION_STATUS_UNKNOWN;
+
+	return netreg->status;
+}
diff --git a/src/ofono.h b/src/ofono.h
index cab70cd..91f737f 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -375,6 +375,8 @@ gboolean __ofono_netreg_remove_status_watch(struct ofon=
o_netreg *netreg,
 void __ofono_netreg_set_base_station_name(struct ofono_netreg *netreg,
 						const char *name);
 =

+int __ofono_netreg_registration_status(struct ofono_netreg *netreg);
+
 #include <ofono/history.h>
 =

 void __ofono_history_probe_drivers(struct ofono_modem *modem);
-- =

1.7.0.4


--===============4971010509593219723==--

