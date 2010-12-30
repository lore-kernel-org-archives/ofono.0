Content-Type: multipart/mixed; boundary="===============0552360376929673109=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH] gatchat: support for unsolicited multiline result
Date: Thu, 30 Dec 2010 18:55:55 +0200
Message-ID: <1293728155-1781-2-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1293728155-1781-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0552360376929673109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatchat.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 96da657..200294c 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -418,6 +418,10 @@ static gboolean at_chat_match_notify(struct at_chat *c=
hat, char *line)

        chat->in_notify =3D FALSE;

+       if (chat->syntax->set_hint)
+               chat->syntax->set_hint(chat->syntax,
+                                       G_AT_SYNTAX_EXPECT_MULTILINE);
+
        if (ret) {
                g_slist_free(result.lines);
                g_free(line);
--
1.7.0.4

-- See us at Mobile World Congress, 14-17 February 2011, in Barcelona, Spai=
n. Visit the Ixonos booth Hall 1, # 1E19.


--===============0552360376929673109==--

