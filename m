Content-Type: multipart/mixed; boundary="===============6590482358311559877=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [RFC patches 04/13] sms_assembly_add_fragment_backup: clarify how
 insertion spot is found
Date: Wed, 26 May 2010 12:49:18 -0700
Message-ID: <8068e20eb9e130e16487497fe6098c2f44f273e0.1274903142.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6590482358311559877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

---
 src/smsutil.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 17e0e0e..c57fe8b 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2480,6 +2480,11 @@ static GSList *sms_assembly_add_fragment_backup(stru=
ct sms_assembly *assembly,
 		if (node->bitmap[offset] & bit)
 			return NULL;
 =

+		/* Iterate over the bitmap to find in which position
+		 * should the fragment be inserted -- basically we
+		 * walk each bit in the bitmap until the bit we care
+		 * about (offset:bit) and count which are stored --
+		 * that gives us in which position we have to insert. */
 		position =3D 0;
 		for (i =3D 0; i < offset; i++)
 			for (j =3D 0; j < 32; j++)
-- =

1.6.6.1


--===============6590482358311559877==--

