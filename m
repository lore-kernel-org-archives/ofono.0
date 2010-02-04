Content-Type: multipart/mixed; boundary="===============7328629960252768037=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 2/2] Remove unneeded declaration of hfp_remove()
Date: Thu, 04 Feb 2010 02:41:35 -0200
Message-ID: <1265258495-31719-1-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1265258238-30559-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7328629960252768037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 122a336..7c3ba8e 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -66,8 +66,6 @@ static const char *chld_prefix[] =3D { "+CHLD:", NULL };
 =

 static DBusConnection *connection;
 =

-static void hfp_remove(struct ofono_modem *modem);
-
 static void hfp_debug(const char *str, void *user_data)
 {
 	ofono_info("%s", str);
-- =

1.6.4.4


--===============7328629960252768037==--

