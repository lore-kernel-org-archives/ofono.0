Content-Type: multipart/mixed; boundary="===============7368006426106987760=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 09/12] Add Send USSD terminal response data structures
Date: Thu, 09 Sep 2010 05:31:53 -0700
Message-ID: <1284035516-21359-10-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1284035516-21359-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7368006426106987760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.h b/src/stkutil.h
index 00cb264..c7665e3 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1376,6 +1376,12 @@ struct stk_answer_text {
 	 */
 };
 =

+struct stk_ussd_text {
+	const unsigned char *text;
+	int dcs;
+	int len;
+};
+
 struct stk_response_get_inkey {
 	struct stk_answer_text text;
 	struct stk_duration duration;
@@ -1447,6 +1453,10 @@ struct stk_response_run_at_command {
 	const char *at_response;
 };
 =

+struct stk_response_send_ussd {
+	struct stk_ussd_text text;
+};
+
 struct stk_response {
 	unsigned char number;
 	unsigned char type;
@@ -1476,6 +1486,7 @@ struct stk_response {
 		struct stk_response_generic send_dtmf;
 		struct stk_response_generic language_notification;
 		struct stk_response_generic launch_browser;
+		struct stk_response_send_ussd send_ussd;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.0.4


--===============7368006426106987760==--

