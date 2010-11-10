Content-Type: multipart/mixed; boundary="===============0462634488982028183=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 2/4] gisi: return NULL instead of asserting
Date: Wed, 10 Nov 2010 14:22:29 +0200
Message-ID: <1289391751-2844-3-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1289391751-2844-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0462634488982028183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gisi/pep.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/gisi/pep.c b/gisi/pep.c
index f1ff589..bea1902 100644
--- a/gisi/pep.c
+++ b/gisi/pep.c
@@ -148,6 +148,8 @@ unsigned g_isi_pep_get_ifindex(const GIsiPEP *pep)
 =

 char *g_isi_pep_get_ifname(const GIsiPEP *pep, char *ifname)
 {
-	unsigned ifi =3D g_isi_pep_get_ifindex(pep);
-	return if_indextoname(ifi, ifname);
+	if (pep->gprs_fd =3D=3D -1)
+		return NULL;
+
+	return if_indextoname(g_isi_pep_get_ifindex(pep), ifname);
 }
-- =

1.7.0.4


--===============0462634488982028183==--

