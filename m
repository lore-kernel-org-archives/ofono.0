Content-Type: multipart/mixed; boundary="===============2014068414250595739=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH v2 05/18] gisi: add getter and setter for sim
Date: Wed, 23 Feb 2011 12:43:16 +0100
Message-ID: <451af579bc3cdb2a1e308cdde718a5b7819929b8.1298460572.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1298460572.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2014068414250595739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 gisi/modem.c |   22 ++++++++++++++++++++++
 gisi/modem.h |    3 +++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/gisi/modem.c b/gisi/modem.c
index 7657bd1..2f5e2ae 100644
--- a/gisi/modem.c
+++ b/gisi/modem.c
@@ -70,6 +70,7 @@ struct _GIsiModem {
    GIsiNotifyFunc trace;
    void *opaque;
    unsigned long flags;
+	void *sim;
 };

 struct _GIsiPending {
@@ -560,6 +561,27 @@ void *g_isi_modem_get_userdata(GIsiModem *modem)
    return modem->opaque;
 }

+void *g_isi_modem_set_sim(GIsiModem *modem, void *sim)
+{
+	void *old;
+
+	if (modem =3D=3D NULL)
+		return NULL;
+
+	old =3D modem->sim;
+	modem->sim =3D sim;
+
+	return old;
+}
+
+void *g_isi_modem_get_sim(GIsiModem *modem)
+{
+	if (modem =3D=3D NULL)
+		return NULL;
+
+	return modem->sim;
+}
+
 unsigned long g_isi_modem_flags(GIsiModem *modem)
 {
    if (modem =3D=3D NULL)
diff --git a/gisi/modem.h b/gisi/modem.h
index 83ba92c..b328bf1 100644
--- a/gisi/modem.h
+++ b/gisi/modem.h
@@ -61,6 +61,9 @@ void g_isi_modem_set_debug(GIsiModem *modem, GIsiDebugFun=
c debug);
 void *g_isi_modem_set_userdata(GIsiModem *modem, void *data);
 void *g_isi_modem_get_userdata(GIsiModem *modem);

+void *g_isi_modem_set_sim(GIsiModem *modem, void *sim);
+void *g_isi_modem_get_sim(GIsiModem *modem);
+
 unsigned long g_isi_modem_flags(GIsiModem *modem);
 void g_isi_modem_set_flags(GIsiModem *modem, unsigned long flags);

--
1.7.3.5


--===============2014068414250595739==--

