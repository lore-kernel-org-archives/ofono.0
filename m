Received: from smtp63.i.mail.ru (smtp63.i.mail.ru [95.163.41.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7854D1CAAF
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="lAb03XwA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=wy+XjKmyVx2zdeoEvCNM1j4ts/RW+ZYGY3epC5mS3ME=; t=1697528159; x=1697618159; 
	b=lAb03XwASPoox9Hikxsm8YDtSnVBlPEK9pGUaYR4WeRFZT1A5FFuzCb/dL6X75PucjKQPIEgvVB
	xBx/cxewrfvQC9/lIrTDP/82szXsytQx3iR/u+b8/4FtnFJM4OiYLidTKhRgAG51/vL5tRr3NpQN8
	zUJw9H9dItQPqlfrbxU=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsecO-004oe4-0W; Tue, 17 Oct 2023 10:35:56 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 17/18] gatchat: added command completion by timeout
Date: Tue, 17 Oct 2023 12:33:41 +0500
Message-Id: <20231017073342.673160-17-m.lyubimov@aqsi.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231017073342.673160-1-m.lyubimov@aqsi.ru>
References: <20231017073342.673160-1-m.lyubimov@aqsi.ru>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp63.i.mail.ru; auth=pass smtp.auth=m.lyubimov@aqsi.ru smtp.mailfrom=m.lyubimov@aqsi.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CFF026BA05CDB6F6D46C5D78B698F2A6AC182A05F538085040B4A14C2757B7FFC0D20578184EC6D24800607F8DD0B53522CFA46C49F87DD794
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7BC08626EA5717D14EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006377E3992E1815AFF058638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8E364679717FF161476A2CDE75760E247117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCF80095D1E57F4578A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751FC26CFBAC0749D213D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE437C869540D2AB0F28F6BDBBAB179F4ED8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE308214CF94FAA95E0C0837EA9F3D19764C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C034D30FDF2F620DB2E808ACE2090B5E1725E5C173C3A84C317B107DEF921CE79089D37D7C0E48F6C8AA50765F79006376AF51E29830FD4F1EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A50B88C0FDDFB733C2DC415D92B1A1BB05D0D457DF1C33BD57F87CCE6106E1FC07E67D4AC08A07B9B0A6C7FFFE744CA7FB9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A09D2DCF9CF1F528DBCCB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF2C82AE6580B26ADD7C493E836116294822ADB3DBD6B674F2B5BE7CEC13C73DAF1D17C9D1E1925344EBFDF7752E1FC33763762E5A587F58C3C21E18E471B68A5840B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJCrp0rpJcFQOg==
X-Mailru-Sender: 0E9E14D9EC491FBAA6F07D099F7E1BA9124E54E1829AE69DC64BA6A2DABABD931CEEFA1C7950CE115D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

---
 gatchat/gatchat.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 9e777107..f4249406 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -38,11 +38,16 @@
 
 /* #define WRITE_SCHEDULER_DEBUG 1 */
 
+#define COMMAND_RESPONSE_TIMEOUT_SEC 20
+
 #define COMMAND_FLAG_EXPECT_PDU			0x1
 #define COMMAND_FLAG_EXPECT_SHORT_PROMPT	0x2
 
 struct at_chat;
 static void chat_wakeup_writer(struct at_chat *chat);
+static void set_response_timeout(struct at_chat *chat);
+static void delete_response_timeout(struct at_chat *chat);
+static void refresh_response_timeout(struct at_chat *chat);
 
 static const char *none_prefix[] = { NULL };
 
@@ -92,6 +97,8 @@ struct at_chat {
 	gpointer debug_data;			/* Data to pass to debug func */
 	char *pdu_notify;			/* Unsolicited Resp w/ PDU */
 	GSList *response_lines;			/* char * lines of the response */
+	guint response_timeout_source;
+	guint response_timeout_counter;
 	char *wakeup;				/* command sent to wakeup modem */
 	gint timeout_source;
 	gdouble inactivity_time;		/* Period of inactivity */
@@ -360,6 +367,9 @@ static void chat_cleanup(struct at_chat *chat)
 		g_slist_free_full(chat->terminator_list, free_terminator);
 		chat->terminator_list = NULL;
 	}
+
+	delete_response_timeout(chat);
+	chat->response_timeout_counter = 0;
 }
 
 static void io_disconnect(gpointer user_data)
@@ -431,11 +441,14 @@ static gboolean at_chat_match_notify(struct at_chat *chat, char *line)
 	return ret;
 }
 
+
 static void at_chat_finish_command(struct at_chat *p, gboolean ok, char *final)
 {
 	struct at_command *cmd = g_queue_pop_head(p->command_queue);
 	GSList *response_lines;
 
+	refresh_response_timeout(p);
+
 	/* Cannot happen, but lets be paranoid */
 	if (cmd == NULL)
 		return;
@@ -938,6 +951,8 @@ static void at_chat_suspend(struct at_chat *chat)
 	g_at_io_set_write_handler(chat->io, NULL, NULL);
 	g_at_io_set_read_handler(chat->io, NULL, NULL);
 	g_at_io_set_debug(chat->io, NULL, NULL);
+
+	delete_response_timeout(chat);
 }
 
 static void at_chat_resume(struct at_chat *chat)
@@ -956,6 +971,8 @@ static void at_chat_resume(struct at_chat *chat)
 
 	if (g_queue_get_length(chat->command_queue) > 0)
 		chat_wakeup_writer(chat);
+
+	refresh_response_timeout(chat);
 }
 
 static void at_chat_unref(struct at_chat *chat)
@@ -1044,6 +1061,8 @@ static guint at_chat_send_common(struct at_chat *chat, guint gid,
 	if (g_queue_get_length(chat->command_queue) == 1)
 		chat_wakeup_writer(chat);
 
+	set_response_timeout(chat);
+
 	return c->id;
 }
 
@@ -1125,6 +1144,8 @@ static gboolean at_chat_cancel(struct at_chat *chat, guint group, guint id)
 		g_queue_remove(chat->command_queue, c);
 	}
 
+	refresh_response_timeout(chat);
+
 	return TRUE;
 }
 
@@ -1152,6 +1173,8 @@ static gboolean at_chat_cancel_group(struct at_chat *chat, guint group)
 		g_queue_remove(chat->command_queue, c);
 	}
 
+	refresh_response_timeout(chat);
+
 	return TRUE;
 }
 
@@ -1314,6 +1337,8 @@ static struct at_chat *create_chat(GIOChannel *channel, GIOFlags flags,
 	g_at_io_set_read_handler(chat->io, new_bytes, chat);
 
 	chat->syntax = g_at_syntax_ref(syntax);
+	chat->response_timeout_source = 0;
+	chat->response_timeout_counter = 0;
 
 	return chat;
 
@@ -1351,6 +1376,63 @@ static GAtChat *g_at_chat_new_common(GIOChannel *channel, GIOFlags flags,
 	return chat;
 }
 
+static gboolean response_timeout_cb(gpointer user_data)
+{
+	struct at_chat *chat = user_data;
+	char* error_str;
+	char* line;
+
+	if (chat->suspended) {
+		chat->response_timeout_source = 0;
+		return FALSE;
+	}
+
+	if (chat->response_timeout_counter < COMMAND_RESPONSE_TIMEOUT_SEC) {
+		chat->response_timeout_counter++;
+		return TRUE;
+	}
+	chat->response_timeout_counter = 0;
+
+	if (g_queue_peek_head(chat->command_queue)) {
+		if (chat->debugf)
+			chat->debugf(": Command response timeout\n", chat->debug_data);
+		error_str = "+CME ERROR: 100";
+		line = g_try_new(char, strlen(error_str) + 1);
+		if (line) {
+			strcpy(line, error_str);
+		}
+		at_chat_finish_command(chat, FALSE, line);
+	}
+	else {
+		chat->response_timeout_source = 0;
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static void set_response_timeout(struct at_chat *chat) {
+	if (!chat->suspended && !chat->response_timeout_source) {
+		chat->response_timeout_source = g_timeout_add(1000, response_timeout_cb, chat);
+		chat->response_timeout_counter = 0;
+	}
+}
+
+static void delete_response_timeout(struct at_chat *chat) {
+	if (chat->response_timeout_source) {
+		g_source_remove(chat->response_timeout_source);
+		chat->response_timeout_source = 0;
+		chat->response_timeout_counter = 0;
+	}
+}
+
+static void refresh_response_timeout(struct at_chat *chat) {
+	chat->response_timeout_counter = 0;
+	if (g_queue_peek_head(chat->command_queue) && !chat->suspended && !chat->response_timeout_source) {
+		chat->response_timeout_source = g_timeout_add(1000, response_timeout_cb, chat);
+	}
+}
+
 GAtChat *g_at_chat_new(GIOChannel *channel, GAtSyntax *syntax)
 {
 	return g_at_chat_new_common(channel, G_IO_FLAG_NONBLOCK, syntax);
-- 
2.25.1

