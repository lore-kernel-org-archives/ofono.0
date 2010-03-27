Content-Type: multipart/mixed; boundary="===============1279642533455834216=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/2] ppp: send PPP_FAIL when authentication fails
Date: Fri, 26 Mar 2010 21:36:50 -0700
Message-ID: <1269664610-31900-3-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1269664610-31900-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1279642533455834216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/ppp_auth.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gatchat/ppp_auth.c b/gatchat/ppp_auth.c
index 95b2f96..fe3c501 100644
--- a/gatchat/ppp_auth.c
+++ b/gatchat/ppp_auth.c
@@ -128,7 +128,8 @@ static void chap_process_failure(struct auth_data *data=
, guint8 *packet)
 {
 	struct chap_header *header =3D (struct chap_header *) packet;
 =

-	g_print("Failed to authenticate, message %s\n", header->data);
+	ppp_generate_event(data->ppp, PPP_FAIL);
+	g_printerr("Failed to authenticate, message %s\n", header->data);
 }
 =

 /*
-- =

1.6.6.1


--===============1279642533455834216==--

