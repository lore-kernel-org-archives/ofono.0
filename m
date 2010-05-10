Content-Type: multipart/mixed; boundary="===============1224348058798363020=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 01/19] stkutil: Free default text for get input parser
Date: Mon, 10 May 2010 18:38:44 +0800
Message-ID: <1273487942-27213-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1224348058798363020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 50fa4c1..09fbec9 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2149,6 +2149,7 @@ static gboolean parse_get_inkey(struct stk_command *c=
ommand,
 static void destroy_get_input(struct stk_command *command)
 {
 	g_free(command->get_input.text);
+	g_free(command->get_input.default_text);
 }
 =

 static gboolean parse_get_input(struct stk_command *command,
-- =

1.7.0.4


--===============1224348058798363020==--

