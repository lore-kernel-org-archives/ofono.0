Content-Type: multipart/mixed; boundary="===============0150243414822794618=="
MIME-Version: 1.0
From: Antoine Reversat <a.reversat@gmail.com>
Subject: [PATCH 3/3] Add CNAP debugging ofono voicecall
Date: Fri, 25 Feb 2011 14:23:18 -0500
Message-ID: <1298661798-4059-3-git-send-email-a.reversat@gmail.com>
In-Reply-To: <AANLkTik_2_gbnD3EgGJkAtQj8OBHWXA6nY093LSJDN5V@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0150243414822794618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index d6e8539..ec001c0 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1951,8 +1951,9 @@ void ofono_voicecall_notify(struct ofono_voicecall *v=
c,
 	struct ofono_call *newcall;
 =

 	DBG("Got a voicecall event, status: %d, id: %u, number: %s"
-			" called_number: %s", call->status, call->id,
-			call->phone_number.number, call->called_number.number);
+			" called_number: %s, called_name %s", call->status,
+			call->id, call->phone_number.number,
+			call->called_number.number, call->name);
 =

 	l =3D g_slist_find_custom(vc->call_list, GUINT_TO_POINTER(call->id),
 				call_compare_by_id);
-- =

1.7.1


--===============0150243414822794618==--

