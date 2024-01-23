Received: from fallback25.i.mail.ru (fallback25.i.mail.ru [79.137.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDAA12E5F
	for <ofono@lists.linux.dev>; Tue, 23 Jan 2024 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022065; cv=none; b=WgtJJXsqHzrHGlKAJaet3Xezt39lenwSsJ1AL7ZEQISJ7skTD9iN1wKWo+uUUtg3uj+bKPZASbFlvYodySv6cOTXYnhoFVHVan7gMxK1LzGPUDaDUtKSNtIa1r5UWNKGHCdrezjRorLPSbuUdQTvf/YqJ6EPk3zS4aB305deGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022065; c=relaxed/simple;
	bh=ET3I9/IHUvIvQWQGRsluJ1Fbj+a4/1A6JrwEHi+Z0DY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nd5QhPxffpvP+pz7BCDMDLlmRIfM7r843M4cAf+2ieT84QxaXULfTtbtVt2WDwexox2S2fPZtHkmAoeyOjSLuxT1Ox+d0Nxs7D5fxj8HLKjnS0Rx1fWk6Hz3DE17ng+KWEFORP0/XbgwA4eaBg887aVY8xeKyB7pI/0aQAvRTTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru; spf=pass smtp.mailfrom=aqsi.ru; dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b=c9AsWX6L; dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b=mGGuw+nQ; arc=none smtp.client-ip=79.137.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="c9AsWX6L";
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="mGGuw+nQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=KGPkHKtIK1LKoCTDFmoQrIwWsppSbAJwwo7iNkDVupk=;
	t=1706022060;x=1706112060; 
	b=c9AsWX6LUSnSDALDY03lNPwfiWf4a1k5aFMJm+oYRwY15DWxnxIMwQei6o4srQ+0pI2zdGxysTlwJNtGWKSkalF8ZYPwo62Vo0sh4sLZXVezmdUxzWTAvz7Ub/xBfRZba4CMiZ7bPQTOHoxfdVZmwEi9dsAkISKM7IZmEIDovQE=;
Received: from [10.12.4.29] (port=35864 helo=smtp51.i.mail.ru)
	by fallback25.i.mail.ru with esmtp (envelope-from <m.lyubimov@aqsi.ru>)
	id 1rSIGh-007yH4-0R
	for ofono@lists.linux.dev; Tue, 23 Jan 2024 18:00:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=KGPkHKtIK1LKoCTDFmoQrIwWsppSbAJwwo7iNkDVupk=; t=1706022051; x=1706112051; 
	b=mGGuw+nQWS1w6YVUAQLl/K7prKWbsMTfRkSQo1QLDfY8gOm4DeTdYul9RmypkYOmeCiHEm1AsdR
	Ony2m0OI06nam3gV9EUFAkjJM0QcgJOKLpu7iCId7oNJ27C0pYo3W9ngkg3GqPu7e4Jfb0O39McYa
	AQjNSrN0QL965ciKrtQ=;
Received: by smtp51.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1rSIGX-007HZZ-0X; Tue, 23 Jan 2024 18:00:41 +0300
From: Maxim Lyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: Maxim Lyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH] gatchat: fix g_at_chat_unref in notify handler
Date: Tue, 23 Jan 2024 20:00:35 +0500
Message-Id: <20240123150035.1477546-1-m.lyubimov@aqsi.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD936B5060B5AFFD5314FC64B4F3DF4614E040740DF0A7BE107182A05F5380850401846D4AE92777AD3A9BE62267BD71C2C3D88F540FDCB5DD44E3F286DE25E5D9E
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7CE4525FFB91B9BBCEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637EFACF7FB96444C4B8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8FB11805E7BD881B9AA9ECD2F9318D423117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC63AF70AF8205D7DCA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520140C956E756FBB7ACB629EEF1311BF91D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEC65AC60A1F0286FE287C8E22D4AE2A51D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3AC7A5202D916A59B302FCEF25BFAB345C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB861051D4BA689FC2E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F6736582285900E615E1C53F199C2BB95B5C8C57E37DE458BEDA766A37F9254B7
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A592D19B0995A7B561D8137DE04B509698C82122E601244C1BF87CCE6106E1FC07E67D4AC08A07B9B05E3BF8C76DC23F749C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF9F24F6B28100799378B0ADB768C0446CEC949531B2DD5225D5CAFC40B61DB137F09515A9A3E4BB8D4BEAD515961AA0A7B064D462B9C04556C0A3ABBA8C11D53140B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXiSUn5yyEez2nD0pmSYP73C
X-Mailru-Sender: EDB4C0346D2A14CA3E455BD2096CF75D9ABF694BD6EEF967D956384B43A6DA3930ECE8C8C1FAA08EDAC8EF1A532907D1530F9FFEEE0568ABC1F4E7FBC0B5F8D4EF296D69FCA1F5EF369F6103AFA1761B2CDDAC3485C1FF9A0DA7A0AF5A3A8387
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B45562A35114C4D62A428494A6AB631861D68B7E21D3EB49F6049FFFDB7839CE9E935078DE41EB476BF7D82FEDE0099B10726C9925ACAD1C6B1AAE833FE3754B36
X-7FA49CB5: 0D63561A33F958A532C7A64AB843CB16F1C884D3704FCDD2F67CFB7BB8BF5BA88941B15DA834481FA18204E546F3947C5D2C5C0A547CD2CBF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006379CB0AA5F2FC3A5BC389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C360C233830BDED4CB35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojGSQVxX8i/5V7UDpCAx2p/A==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

If the new_bytes handler processes a modem shutdown URC, it results in
a call to the g_at_chat_unref function, which includes a call to the
chat_cleanup function, which clears the list of URC handlers that
continue to be traversed after the current handler has completed, and
may lead to errors. To correct the situation, the chat_cleanup function
is not called in the at_chat_unref function if the in_read_handler flag
is set. In the new_bytes function, if the destroyed flag is set, the
chat_cleanup function is called before calling g_free. Additional
checks have been added to the chat_cleanup function.
---
 gatchat/gatchat.c | 102 +++++++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 42 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 9e777107..50f8ba57 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -319,19 +319,25 @@ static void chat_cleanup(struct at_chat *chat)
 	struct at_command *c;
 
 	/* Cleanup pending commands */
-	while ((c = g_queue_pop_head(chat->command_queue)))
-		at_command_destroy(c);
+	if (chat->command_queue) {
+		while ((c = g_queue_pop_head(chat->command_queue)))
+			at_command_destroy(c);
 
-	g_queue_free(chat->command_queue);
-	chat->command_queue = NULL;
+		g_queue_free(chat->command_queue);
+		chat->command_queue = NULL;
+	}
 
 	/* Cleanup any response lines we have pending */
-	g_slist_free_full(chat->response_lines, g_free);
-	chat->response_lines = NULL;
+	if (chat->response_lines) {
+		g_slist_free_full(chat->response_lines, g_free);
+		chat->response_lines = NULL;
+	}
 
 	/* Cleanup registered notifications */
-	g_hash_table_destroy(chat->notify_list);
-	chat->notify_list = NULL;
+	if (chat->notify_list) {
+		g_hash_table_destroy(chat->notify_list);
+		chat->notify_list = NULL;
+	}
 
 	if (chat->pdu_notify) {
 		g_free(chat->pdu_notify);
@@ -727,6 +733,48 @@ static char *extract_line(struct at_chat *p, struct ring_buffer *rbuf)
 	return line;
 }
 
+static void at_chat_suspend(struct at_chat *chat)
+{
+	chat->suspended = TRUE;
+
+	g_at_io_set_write_handler(chat->io, NULL, NULL);
+	g_at_io_set_read_handler(chat->io, NULL, NULL);
+	g_at_io_set_debug(chat->io, NULL, NULL);
+}
+
+static struct at_chat *at_chat_ref(struct at_chat *chat)
+{
+	if (chat == NULL)
+		return NULL;
+
+	g_atomic_int_inc(&chat->ref_count);
+
+	return chat;
+}
+
+static void at_chat_unref(struct at_chat *chat)
+{
+	gboolean is_zero;
+
+	is_zero = g_atomic_int_dec_and_test(&chat->ref_count);
+
+	if (is_zero == FALSE)
+		return;
+
+	if (chat->io) {
+		at_chat_suspend(chat);
+		g_at_io_unref(chat->io);
+		chat->io = NULL;
+	}
+
+	if (chat->in_read_handler)
+		chat->destroyed = TRUE;
+	else {
+		chat_cleanup(chat);
+		g_free(chat);
+	}
+}
+
 static void new_bytes(struct ring_buffer *rbuf, gpointer user_data)
 {
 	struct at_chat *p = user_data;
@@ -780,8 +828,10 @@ static void new_bytes(struct ring_buffer *rbuf, gpointer user_data)
 
 	p->in_read_handler = FALSE;
 
-	if (p->destroyed)
+	if (p->destroyed) {
+		chat_cleanup(p);
 		g_free(p);
+	}
 }
 
 static void wakeup_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -931,15 +981,6 @@ static void chat_wakeup_writer(struct at_chat *chat)
 	g_at_io_set_write_handler(chat->io, can_write_data, chat);
 }
 
-static void at_chat_suspend(struct at_chat *chat)
-{
-	chat->suspended = TRUE;
-
-	g_at_io_set_write_handler(chat->io, NULL, NULL);
-	g_at_io_set_read_handler(chat->io, NULL, NULL);
-	g_at_io_set_debug(chat->io, NULL, NULL);
-}
-
 static void at_chat_resume(struct at_chat *chat)
 {
 	chat->suspended = FALSE;
@@ -958,28 +999,6 @@ static void at_chat_resume(struct at_chat *chat)
 		chat_wakeup_writer(chat);
 }
 
-static void at_chat_unref(struct at_chat *chat)
-{
-	gboolean is_zero;
-
-	is_zero = g_atomic_int_dec_and_test(&chat->ref_count);
-
-	if (is_zero == FALSE)
-		return;
-
-	if (chat->io) {
-		at_chat_suspend(chat);
-		g_at_io_unref(chat->io);
-		chat->io = NULL;
-		chat_cleanup(chat);
-	}
-
-	if (chat->in_read_handler)
-		chat->destroyed = TRUE;
-	else
-		g_free(chat);
-}
-
 static gboolean at_chat_set_disconnect_function(struct at_chat *chat,
 						GAtDisconnectFunc disconnect,
 						gpointer user_data)
@@ -1372,10 +1391,9 @@ GAtChat *g_at_chat_clone(GAtChat *clone)
 	if (chat == NULL)
 		return NULL;
 
-	chat->parent = clone->parent;
+	chat->parent = at_chat_ref(clone->parent);
 	chat->group = chat->parent->next_gid++;
 	chat->ref_count = 1;
-	g_atomic_int_inc(&chat->parent->ref_count);
 
 	if (clone->slave != NULL)
 		chat->slave = g_at_chat_clone(clone->slave);
-- 
2.28.0

