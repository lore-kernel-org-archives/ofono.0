Content-Type: multipart/mixed; boundary="===============5983018114871691742=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 4/9] qmimodem: prevent use of unitialized variable
Date: Fri, 26 Oct 2018 12:13:14 +0200
Message-ID: <20181026101319.27709-5-jonas@norrbonn.se>
In-Reply-To: <20181026101319.27709-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5983018114871691742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jonas Bonn <jonas@southpole.se>

'index' may not be initialized in the error path so don't try to print a
message with it.
---
 drivers/qmimodem/lte.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/qmimodem/lte.c b/drivers/qmimodem/lte.c
index e0333ecf..1337e7f9 100644
--- a/drivers/qmimodem/lte.c
+++ b/drivers/qmimodem/lte.c
@@ -164,7 +164,7 @@ static void get_default_profile_cb(struct qmi_result *r=
esult, void *user_data)
 	qmi_param_free(param);
 =

 error:
-	ofono_error("Failed to reset profile %hhd", index);
+	ofono_error("Failed to reset default profile");
 	ofono_lte_remove(lte);
 }
 =

-- =

2.17.1


--===============5983018114871691742==--

