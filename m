Content-Type: multipart/mixed; boundary="===============3789870760524612817=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 4/6] stkutil.c: Send at least the data currently available
Date: Fri, 08 Apr 2011 18:33:29 +0200
Message-ID: <1302280411-20762-4-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3789870760524612817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 7299fb5..ee59841 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -5655,7 +5655,8 @@ static gboolean build_receive_data(struct stk_tlv_bui=
lder *builder,
 	const struct stk_response_receive_data *receive_data =3D
 		&response->receive_data;
 =

-	if (response->result.type !=3D STK_RESULT_TYPE_SUCCESS)
+	if (response->result.type !=3D STK_RESULT_TYPE_SUCCESS &&
+			response->result.type !=3D STK_RESULT_TYPE_MISSING_INFO)
 		return TRUE;
 =

 	if (receive_data->rx_data.len) {
-- =

1.7.1


--===============3789870760524612817==--

