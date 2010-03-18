Content-Type: multipart/mixed; boundary="===============1061197682848020149=="
MIME-Version: 1.0
From: ppessi@gmail.com
Subject: [PATCH 5/7] Interrogation of a barring does not require password.
Date: Thu, 18 Mar 2010 16:44:29 +0200
Message-ID: <1268923471-29059-5-git-send-email-ppessi@gmail.com>
In-Reply-To: <1268923471-29059-4-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1061197682848020149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>


Signed-off-by: Pekka Pessi <Pekka.Pessi@nokia.com>
---
 src/call-barring.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index f3252e1..a0f961e 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -409,7 +409,7 @@ static gboolean cb_ss_control(int type, const char *sc,
 	if (strlen(dn) > 0)
 		goto bad_format;
 =

-	if (!is_valid_password(sia))
+	if (type !=3D SS_CONTROL_TYPE_QUERY && !is_valid_password(sia))
 		goto bad_format;
 =

 	switch (type) {
-- =

1.6.3.3


--===============1061197682848020149==--

