Received: from smtp38.i.mail.ru (smtp38.i.mail.ru [95.163.41.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43FB3D39F
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="OUr41yg6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=wy+XjKmyVx2zdeoEvCNM1j4ts/RW+ZYGY3epC5mS3ME=; t=1697539806; x=1697629806; 
	b=OUr41yg64VI94Cd+J+4ysyLEdJvGu2zMJmWPtvYgJX6JGHO5oQy5evB6k4h0jAOuUZSmJ+jDZmV
	quDfXRGuuEaC6B10mKCVVZ4Ql2xr9dbMAV/Mdds+XCYigsgFAiIBLBUmsL2159WfW2s4F1Ei9oaxr
	vAtG6pB6CBHbMlQkSYA=;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsheE-00Ab9o-1q; Tue, 17 Oct 2023 13:50:03 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 14/15] gatchat: added command completion by timeout
Date: Tue, 17 Oct 2023 15:49:01 +0500
Message-Id: <20231017104902.717947-14-m.lyubimov@aqsi.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp38.i.mail.ru; auth=pass smtp.auth=m.lyubimov@aqsi.ru smtp.mailfrom=m.lyubimov@aqsi.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CF067259BE5129BC25732DC641AEA930A1182A05F538085040CAD9C5D7F111D01F5A75BD6C2E4F08FCB7D1EFB6C8AEBFAFC33C19420CA7686C
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72F22E6DC541F75D9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637D08ED87D5614270A8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D838680464A123790C81EED3E8E7969DE6117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC60CDF180582EB8FBA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751FF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CB6617C399FBFD4B42D242C3BD2E3F4C64AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3B67BC1D69F43B15FBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFECBEDCEC3CCF9A281DD303D21008E298D5E8D9A59859A8B6D082881546D9349175ECD9A6C639B01B78DA827A17800CE7149DEC19AE061930731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5C8E41BB2D51B1E8A65C29474C6E1BB28FCBBFCA02305D5F3F87CCE6106E1FC07E67D4AC08A07B9B0A6C7FFFE744CA7FB9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A09062BEEFFB5F8EA3ECB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF2003971C18C3FE7B205952AAB3D7CD6DE5413959BC42B7B321F4D16AE684970942A4A3B3B141354EEBFDF7752E1FC337649D391C11AF1C481EEEAC10E81008F140B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJAlDhniIDfd9w==
X-Mailru-Sender: 0E9E14D9EC491FBAD2A03FC26A0EF746C727EA809B277B85A0702D06D97054972D849A27F4FF34975D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
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

