Content-Type: multipart/mixed; boundary="===============1837111306884264982=="
MIME-Version: 1.0
From: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
Subject: [PATCH] gdbus: Fix crash error when calling g_dbus_remove_all_watches
Date: Fri, 24 Aug 2012 13:16:05 +0300
Message-ID: <1345803365-11861-1-git-send-email-tomasz.bursztyka@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1837111306884264982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
Hi,

While using gdbus on some other code, I found out that bug around g_dbus_re=
move_all_watches() usage.

Tomasz

 gdbus/watch.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index d749176..968a38a 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -298,6 +298,9 @@ static void filter_data_call_and_free(struct filter_dat=
a *data)
 		g_free(cb);
 	}
 =

+	g_slist_free(data->callbacks);
+	data->callbacks =3D NULL;
+
 	filter_data_free(data);
 }
 =

-- =

1.7.8.6


--===============1837111306884264982==--

