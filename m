Content-Type: multipart/mixed; boundary="===============6240010981603049881=="
MIME-Version: 1.0
From: Tomasz Gregorek <tomasz.gregorek@gmail.com>
Subject: [PATCH 2/2] plugins-mbm: Remove data->reopen_source timer before
 setting up new one
Date: Fri, 14 Jan 2011 14:35:15 +0100
Message-ID: <1295012115-11605-1-git-send-email-tomasz.gregorek@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6240010981603049881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Tomasz Gregorek <tomasz.gregorek@stericsson.com>

Check if there is a timer running already and remove it before
creating a new one. This will prevent calling reopen_callback() more
than if mbm_disconnect() is called more than once.
---
 plugins/mbm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index 38583ac..4048f6a 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -351,6 +351,9 @@ static void mbm_disconnect(gpointer user_data)
 	data->data_port =3D NULL;
 =

 	/* Waiting for the +CGEV: ME DEACT might also work */
+	if (data->reopen_source > 0)
+		g_source_remove(data->reopen_source);
+
 	data->reopen_source =3D g_timeout_add_seconds(1, reopen_callback, modem);
 }
 =

-- =

1.7.1


--===============6240010981603049881==--

