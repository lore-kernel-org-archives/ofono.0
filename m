Content-Type: multipart/mixed; boundary="===============3371386254161862231=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 10/12] stk: Use new voicecall enums
Date: Thu, 21 Jun 2018 20:20:59 +0300
Message-ID: <1529601661-4856-10-git-send-email-slava.monich@jolla.com>
In-Reply-To: <1529601661-4856-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3371386254161862231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 9cdf2b1..eb27555 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1732,7 +1732,7 @@ static void call_setup_connected(struct ofono_call *c=
all, void *data)
 	static struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE =
};
 	static unsigned char facility_rejected_result[] =3D { 0x9d };
 =

-	if (call =3D=3D NULL || call->status =3D=3D CALL_STATUS_DISCONNECTED) {
+	if (call =3D=3D NULL || call->status =3D=3D OFONO_CALL_STATUS_DISCONNECTE=
D) {
 		memset(&rsp, 0, sizeof(rsp));
 =

 		ADD_ERROR_RESULT(rsp.result,
@@ -1745,7 +1745,7 @@ static void call_setup_connected(struct ofono_call *c=
all, void *data)
 		return;
 	}
 =

-	if (call->status =3D=3D CALL_STATUS_ACTIVE)
+	if (call->status =3D=3D OFONO_CALL_STATUS_ACTIVE)
 		send_simple_response(stk, STK_RESULT_TYPE_SUCCESS);
 	else
 		send_simple_response(stk, STK_RESULT_TYPE_USER_CANCEL);
-- =

1.9.1


--===============3371386254161862231==--

