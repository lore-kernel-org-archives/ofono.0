Content-Type: multipart/mixed; boundary="===============8378635181001633066=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spiekerdoyle@gmail.com>
Subject: [PATCH v2] cdma-voicecall: Fix for crash when unregistering atom
Date: Mon, 13 Jun 2011 16:01:31 -0700
Message-ID: <1308006091-8312-1-git-send-email-dara.spiekerdoyle@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8378635181001633066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-voicecall.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/src/cdma-voicecall.c b/src/cdma-voicecall.c
index a590063..183433d 100644
--- a/src/cdma-voicecall.c
+++ b/src/cdma-voicecall.c
@@ -335,6 +335,18 @@ void ofono_cdma_voicecall_driver_unregister(
 	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
 }
 =

+static void cdma_voicecall_unregister(struct ofono_atom *atom)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
+	const char *path =3D __ofono_atom_get_path(atom);
+
+	g_dbus_unregister_interface(conn, path,
+				OFONO_CDMA_VOICECALL_MANAGER_INTERFACE);
+	ofono_modem_remove_interface(modem,
+				OFONO_CDMA_VOICECALL_MANAGER_INTERFACE);
+}
+
 static void voicecall_manager_remove(struct ofono_atom *atom)
 {
 	struct ofono_cdma_voicecall *vc =3D __ofono_atom_get_data(atom);
@@ -405,6 +417,8 @@ void ofono_cdma_voicecall_register(struct ofono_cdma_vo=
icecall *vc)
 =

 	ofono_modem_add_interface(modem,
 				OFONO_CDMA_VOICECALL_MANAGER_INTERFACE);
+
+	__ofono_atom_register(vc->atom, cdma_voicecall_unregister);
 }
 =

 void ofono_cdma_voicecall_remove(struct ofono_cdma_voicecall *vc)
-- =

1.7.4.1


--===============8378635181001633066==--

