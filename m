Content-Type: multipart/mixed; boundary="===============7422066728825996216=="
MIME-Version: 1.0
From: Marko Saukko <marko.saukko@gmail.com>
Subject: [PATCH] Fix g_isi_client_destroy segfault
Date: Thu, 09 Jul 2009 15:37:48 +0300
Message-ID: <4A55E49C.6020006@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7422066728825996216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If null pointer is given to g_isi_client_destroy it segfaults. Currently
this is happening when signal 15 is sent to ofonod.

---

diff --git a/gisi/client.c b/gisi/client.c
index b12dc85..a12640d 100644
--- a/gisi/client.c
+++ b/gisi/client.c
@@ -143,6 +143,8 @@ void g_isi_client_destroy(GIsiClient *client)
 {
        unsigned id;

+       if (!client)
+               return;
        g_source_remove(client->source);
        for (id =3D 0; id < 256; id++)
                if (client->timeout[id] > 0)

--===============7422066728825996216==--

