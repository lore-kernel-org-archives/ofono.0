Content-Type: multipart/mixed; boundary="===============2835817020533277153=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 2/2] smsutil: style fix
Date: Wed, 01 Sep 2010 18:59:32 +0300
Message-ID: <1283356772-18015-3-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1283356772-18015-2-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2835817020533277153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index c8f6a4a..0de420b 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2532,7 +2532,8 @@ static GSList *sms_assembly_add_fragment_backup(struc=
t sms_assembly *assembly,
 		if (ref !=3D node->ref)
 			continue;
 =

-		/* Message Reference and address the same, but max is not
+		/*
+		 * Message Reference and address the same, but max is not
 		 * ignore the SMS completely
 		 */
 		if (max !=3D node->max_fragments)
-- =

1.6.3.3



--===============2835817020533277153==--

