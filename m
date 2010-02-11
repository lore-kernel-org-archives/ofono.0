Content-Type: multipart/mixed; boundary="===============4851053688015568298=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 2/3] hfp: avoid crash when hfp is declared on modem.conf
Date: Thu, 11 Feb 2010 20:52:41 -0200
Message-ID: <1265928762-24090-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1265928762-24090-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4851053688015568298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 5e29bba..d2668e0 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -723,6 +723,10 @@ static int hfp_unregister_ofono_handsfree(struct ofono=
_modem *modem)
 static int hfp_probe(struct ofono_modem *modem)
 {
 	const char *obj_path =3D ofono_modem_get_path(modem);
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+
+	if (!data)
+		return -EINVAL;
 =

 	g_dbus_register_interface(connection, obj_path, HFP_AGENT_INTERFACE,
 			agent_methods, NULL, NULL, modem, NULL);
-- =

1.6.4.4


--===============4851053688015568298==--

