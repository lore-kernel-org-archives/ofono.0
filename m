Content-Type: multipart/mixed; boundary="===============0436021676742838756=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: [PATCH] ste: enable multiple oFono runs without restarting the oFono
Date: Thu, 03 Mar 2011 13:45:12 +0200
Message-ID: <1299152712-21252-1-git-send-email-jussi.kangas@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0436021676742838756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
Hi,

This enables SIM detection in workstation after disabling and enabling the =

modem without rebooting the oFono.

Br,
Jussi


 plugins/ste.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index b786571..d2a6cc1 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -184,6 +184,7 @@ static gboolean init_sim_reporting(gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct ste_data *data =3D ofono_modem_get_data(modem);
+	data->have_sim =3D FALSE;
 =

 	g_at_chat_send(data->chat, "AT*ESIMSR=3D1;*ESIMSR?", NULL,
 			handle_sim_state,
-- =

1.7.1


--===============0436021676742838756==--

