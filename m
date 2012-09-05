Content-Type: multipart/mixed; boundary="===============2573812897135969292=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 2/4] common: Accept pause character in the dialing number
Date: Wed, 05 Sep 2012 19:19:37 +0200
Message-ID: <1346865579-24794-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346865579-24794-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2573812897135969292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common.c b/src/common.c
index 94d70dd..de1ad26 100644
--- a/src/common.c
+++ b/src/common.c
@@ -257,7 +257,7 @@ gboolean valid_number_format(const char *number, int le=
ngth)
 		if (number[i] >=3D '0' && number[i] <=3D '9')
 			continue;
 =

-		if (number[i] =3D=3D '*' || number[i] =3D=3D '#')
+		if (number[i] =3D=3D '*' || number[i] =3D=3D '#' || number[i] =3D=3D 'p')
 			continue;
 =

 		return FALSE;
-- =

1.7.9.5


--===============2573812897135969292==--

