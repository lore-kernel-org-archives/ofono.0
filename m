Content-Type: multipart/mixed; boundary="===============4226828793322793960=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: [PATCH] Handle right bracket in g_at_result_iter_next_unquoted_string
Date: Thu, 22 Oct 2009 10:58:24 +0800
Message-ID: <0463F45F3606F4428ED35AC8C709F92E089B872473@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4226828793322793960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow g_at_result_iter_next_unquoted_string to handle the bracket when pars=
ing
string like chld (1, 2). Original, it returns '1' and '2)'. Now it returns =
'1'
and '2'. g_at_result_iter_close_list handles the right bracket later.
---
 gatchat/gatresult.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gatchat/gatresult.c b/gatchat/gatresult.c
index 1436ae3..3d07e13 100644
--- a/gatchat/gatresult.c
+++ b/gatchat/gatresult.c
@@ -131,12 +131,12 @@ gboolean g_at_result_iter_next_unquoted_string(GAtRes=
ultIter *iter,
 		goto out;
 	}
 =

-	if (line[pos] =3D=3D '"')
+	if (line[pos] =3D=3D '"' || line[pos] =3D=3D ')')
 		return FALSE;
 =

 	end =3D pos;
 =

-	while (end < len && line[end] !=3D ',')
+	while (end < len && line[end] !=3D ',' && line[end] !=3D ')')
 		end +=3D 1;
 =

 	iter->buf[end] =3D '\0';

Regards,
Zhenhua
=20

--===============4226828793322793960==--

