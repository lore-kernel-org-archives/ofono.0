Content-Type: multipart/mixed; boundary="===============7556606452423653159=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 6/6] Fix common misspelling in source files
Date: Tue, 14 Sep 2010 00:06:05 -0300
Message-ID: <1284433565-26126-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <4C8EDFF9.4060006@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7556606452423653159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix common misspellings by using the list available at
http://en.wikipedia.org/wiki/Wikipedia:Lists_of_common_misspellings/For_mac=
hines.

From the list cited above, the substitution script found the following
misspelling:

reponsible->responsible
---
 src/util.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/util.c b/src/util.c
index bb90f6c..391bbb2 100644
--- a/src/util.c
+++ b/src/util.c
@@ -535,7 +535,7 @@ static unsigned short unicode_single_shift_lookup(unsig=
ned short k,
  * GSM encoded string in items_read (if not NULL), not including the
  * terminator character. Returns the number of bytes written into the UTF8
  * encoded string in items_written (if not NULL) not including the terminal
- * '\0' character.  The caller is reponsible for freeing the returned valu=
e.
+ * '\0' character.  The caller is responsible for freeing the returned val=
ue.
  */
 char *convert_gsm_to_utf8_with_lang(const unsigned char *text, long len,
 					long *items_read, long *items_written,
-- =

1.7.2.3


--===============7556606452423653159==--

