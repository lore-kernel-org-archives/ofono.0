Content-Type: multipart/mixed; boundary="===============7388685820408051522=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH 02/18] gisi: modem version detection
Date: Tue, 15 Feb 2011 13:30:56 +0100
Message-ID: <a63d245a2d86e1115243416a02ddb553d0ded7e9.1297772944.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7388685820408051522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 gisi/modem.c |   27 +++++++++++++++++++++++++++
 gisi/modem.h |    6 ++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/gisi/modem.c b/gisi/modem.c
index 7657bd1..734c4f1 100644
--- a/gisi/modem.c
+++ b/gisi/modem.c
@@ -62,6 +62,7 @@ struct _GIsiModem {
 	uint8_t device;
 	GHashTable *services;
 	gboolean subs_source;
+	GIsiVersion version;
 	int req_fd;
 	int ind_fd;
 	guint req_watch;
@@ -539,6 +540,32 @@ guint g_isi_modem_add_to_watch(GIsiModem *modem, int f=
d)
 	return watch;
 }
 =

+gboolean g_isi_modem_set_version(GIsiModem *modem, const GIsiVersion versi=
on)
+{
+	if (modem =3D=3D NULL)
+		return FALSE;
+
+	modem->version =3D version;
+
+	return TRUE;
+}
+
+int g_isi_modem_version_major(const GIsiModem *modem)
+{
+	if (modem =3D=3D NULL)
+		return -1;
+
+	return modem->version.major;
+}
+
+int g_isi_modem_version_minor(const GIsiModem *modem)
+{
+	if (modem =3D=3D NULL)
+		return -1;
+
+	return modem->version.minor;
+}
+
 void *g_isi_modem_set_userdata(GIsiModem *modem, void *data)
 {
 	void *old;
diff --git a/gisi/modem.h b/gisi/modem.h
index 83ba92c..24ca805 100644
--- a/gisi/modem.h
+++ b/gisi/modem.h
@@ -58,6 +58,12 @@ int g_isi_modem_set_device(GIsiModem *modem, uint8_t dev=
);
 void g_isi_modem_set_trace(GIsiModem *modem, GIsiNotifyFunc notify);
 void g_isi_modem_set_debug(GIsiModem *modem, GIsiDebugFunc debug);
 =

+	gboolean g_isi_modem_set_version(GIsiModem *modem,
+						const GIsiVersion version);
+
+int g_isi_modem_version_major(const GIsiModem *modem);
+int g_isi_modem_version_minor(const GIsiModem *modem);
+
 void *g_isi_modem_set_userdata(GIsiModem *modem, void *data);
 void *g_isi_modem_get_userdata(GIsiModem *modem);
 =

-- =

1.7.3.5


--===============7388685820408051522==--

