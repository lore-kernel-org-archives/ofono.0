Content-Type: multipart/mixed; boundary="===============1723878692199845151=="
MIME-Version: 1.0
From: ppessi@gmail.com
Subject: [PATCH 2/7] Return newly-queried barring status.
Date: Thu, 18 Mar 2010 16:44:26 +0200
Message-ID: <1268923471-29059-2-git-send-email-ppessi@gmail.com>
In-Reply-To: <1268923471-29059-1-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1723878692199845151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>


Signed-off-by: Pekka Pessi <Pekka.Pessi@nokia.com>
---
 src/call-barring.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index 13d625e..530d64b 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -148,7 +148,6 @@ static void update_barrings(struct ofono_call_barring *=
cb, int mask)
 =

 	for (i =3D cb->query_start; i <=3D cb->query_end; i++) {
 		cb->cur_locks[i] =3D cb->new_locks[i];
-		cb->new_locks[i] =3D 0;
 	}
 }
 =

@@ -164,7 +163,7 @@ static void cb_ss_property_append(struct ofono_call_bar=
ring *cb,
 		if (!(mask & i))
 			continue;
 =

-		strvalue =3D (cb->cur_locks[lock] & i) ? "enabled" : "disabled";
+		strvalue =3D (cb->new_locks[lock] & i) ? "enabled" : "disabled";
 =

 		snprintf(property_name, sizeof(property_name), "%s%s",
 				bearer_class_to_string(i),
@@ -590,7 +589,7 @@ static inline void cb_append_property(struct ofono_call=
_barring *cb,
 	int i;
 =

 	for (i =3D start; i <=3D end; i++)
-		if (cb->cur_locks[i] & cls)
+		if (cb->new_locks[i] & cls)
 			break;
 =

 	if (i <=3D end)
-- =

1.6.3.3


--===============1723878692199845151==--

