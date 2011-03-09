Content-Type: multipart/mixed; boundary="===============1067473171911372525=="
MIME-Version: 1.0
From: Paavo Leinonen <paavo.leinonen@tieto.com>
Subject: [PATCH] gatchat: fix to number parsing when number is omitted
Date: Wed, 09 Mar 2011 09:27:30 +0200
Message-ID: <1299655650-7929-1-git-send-email-paavo.leinonen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1067473171911372525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Line position index must be updated the number field is empty. Otherwise
we will read same field again in subsequent calls.
---

Hi,

While testing SIM Phonebook we noticed that Email addresses stored to SIM PB
were not properly parsed by oFono. Root cause for this was =

g_at_result_iter_next_number which did not update iterator's line_pos
attribute when number was missing. As a result, wrong fields were =

read when parsing email field (among others).

Entry was following:

+CPBR: 1,"12356789*#98#*",129,"Esko M\303\226rk\303\266",,,,,"M\303\266lkky=
","longandhardemailaddress(a)huhhuhjuu.mobi"

Br,
Paavo

 gatchat/gatresult.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gatchat/gatresult.c b/gatchat/gatresult.c
index f992486..fb9f4d5 100644
--- a/gatchat/gatresult.c
+++ b/gatchat/gatresult.c
@@ -281,11 +281,11 @@ gboolean g_at_result_iter_next_number(GAtResultIter *=
iter, gint *number)
 		end +=3D 1;
 	}
 =

+	iter->line_pos =3D skip_to_next_field(line, end, len);
+
 	if (pos =3D=3D end)
 		return FALSE;
 =

-	iter->line_pos =3D skip_to_next_field(line, end, len);
-
 	if (number)
 		*number =3D value;
 =

-- =

1.7.1


--===============1067473171911372525==--

