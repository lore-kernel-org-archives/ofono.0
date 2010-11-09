Content-Type: multipart/mixed; boundary="===============8778654521836708902=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 7/8] gprs: Prevent crash due to a NULL pid_map
Date: Tue, 09 Nov 2010 02:43:00 -0200
Message-ID: <1289277781-6378-8-git-send-email-gustavo@padovan.org>
In-Reply-To: <1289277781-6378-7-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8778654521836708902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

gprs_drv->probe() may use pid_map, so we set it before call probe()
---
 src/gprs.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 0f6fb0c..76a4d5f 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2221,6 +2221,10 @@ struct ofono_gprs *ofono_gprs_create(struct ofono_mo=
dem *modem,
 	gprs->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_GPRS,
 						gprs_remove, gprs);
 =

+	gprs->status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
+	gprs->netreg_status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
+	gprs->pid_map =3D idmap_new(MAX_CONTEXTS);
+
 	for (l =3D g_drivers; l; l =3D l->next) {
 		const struct ofono_gprs_driver *drv =3D l->data;
 =

@@ -2234,10 +2238,6 @@ struct ofono_gprs *ofono_gprs_create(struct ofono_mo=
dem *modem,
 		break;
 	}
 =

-	gprs->status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
-	gprs->netreg_status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
-	gprs->pid_map =3D idmap_new(MAX_CONTEXTS);
-
 	return gprs;
 }
 =

-- =

1.7.3


--===============8778654521836708902==--

