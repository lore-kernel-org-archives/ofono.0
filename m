Content-Type: multipart/mixed; boundary="===============6540957598912936132=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 09/27] stk: Adjust the sequence of dataobj
Date: Thu, 13 May 2010 18:48:26 +0800
Message-ID: <1273747724-28019-9-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6540957598912936132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/stkutil.h b/src/stkutil.h
index d017dc9..0c9fd50 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -872,10 +872,10 @@ struct stk_command {
 		struct stk_command_get_inkey get_inkey;
 		struct stk_command_get_input get_input;
 		struct stk_command_play_tone play_tone;
-		struct stk_command_select_item select_item;
-		struct stk_command_send_sms send_sms;
 		struct stk_command_poll_interval poll_interval;
 		struct stk_command_setup_menu setup_menu;
+		struct stk_command_select_item select_item;
+		struct stk_command_send_sms send_sms;
 	};
 =

 	void (*destructor)(struct stk_command *command);
-- =

1.7.0.4


--===============6540957598912936132==--

