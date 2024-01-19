Received: from fallback17.i.mail.ru (fallback17.i.mail.ru [79.137.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BBE4C639
	for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662676; cv=none; b=QW+JAdj+pONVmYWCPWbXNBVwlg3VfJ5l4+fanqKBG7FkSLSqs3A6oFb46Ge/yMFeseROL5B8jIPoW76w0eCiVPlciasV1oTkSoe1eHXmJiM/ehFe1qZRwTw/Fmhk9fwqAgFZw/ZigzmhXqnjZRbpK1sHALSMQsj7IKz0wZsDQ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662676; c=relaxed/simple;
	bh=oxxEqSMTbm5s1AmXxH6Lyy+mnivS7xr0h0j0kDpF0t8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ebo19YYdWPfQ81nmUffE32gTs1eAcsiAsKiDnbT04f5VJiib6G/RyjYD+eUP4CvcFjgkFxcF/4eTLpd9+dQsAekWdBDfRsRYpGb6aUxORrgjbkEvRkeQJByrd+uqrSdCZKy0OJMq2dJTcvhazJ22EQxVO5UpgZPAcpaz5KqRKXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru; spf=pass smtp.mailfrom=aqsi.ru; dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b=a231MSJ6; dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b=HTir55YB; arc=none smtp.client-ip=79.137.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="a231MSJ6";
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="HTir55YB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=h0pcAsgKhqzGjs5I6eF205RzlsVL7ZRqN3s2ju+NVB0=;
	t=1705662671;x=1705752671; 
	b=a231MSJ6Nw46bUn6jrIaJMAckQBYYkx62dAiXOSE7e+ljjlbH7hOL8AEWOV941AyqHc6l9Kv45LvCAVLyOCClVIHiY8ZwoHVXURMusmw3aAFRhbJDoECuc25ih6wW2MFWSDWNKY67ddAQol5VnpKTVI8YySEaZhYelMVYHXJc+I=;
Received: from [10.12.4.14] (port=39010 helo=smtp39.i.mail.ru)
	by fallback17.i.mail.ru with esmtp (envelope-from <m.lyubimov@aqsi.ru>)
	id 1rQmm7-003ncs-Cf
	for ofono@lists.linux.dev; Fri, 19 Jan 2024 14:11:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=h0pcAsgKhqzGjs5I6eF205RzlsVL7ZRqN3s2ju+NVB0=; t=1705662663; x=1705752663; 
	b=HTir55YBcwirJXw3QNBGEcv83C2mYID4ZXOMSl00zy8rnPjzp/OZkeZxLB/wwVRiPnXLpqFt7uC
	wJFzfWLFEDjyuF6Tf24h++ijct4ZtiT+/tbsU0srYb7fpsMz2+pHQ+YRBs+XghWorB4cf6J5+AjEE
	pFm0pSCKEe3QcAIg3zg=;
Received: by smtp39.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1rQmlw-000ea9-0B; Fri, 19 Jan 2024 14:10:54 +0300
From: Maxim Lyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: Maxim Lyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH] gatchat: fix unref
Date: Fri, 19 Jan 2024 16:10:17 +0500
Message-Id: <20240119111017.1407534-1-m.lyubimov@aqsi.ru>
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
X-77F55803: 4F1203BC0FB41BD9AE5B4AFB3AE2A59052EF7646443290C180CE518C4D069C91182A05F53808504086AC15AC34FAB8F27745A17A37AF5E30DA4380768A0A1A96F355C79A1336E493
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7081BBE264C6D7F42EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063707C4856229E8E7E48638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D80A6D2F61A94A5900E62DD0EAB6D2E237117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC081CF0AE924DC023A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520B1593CA6EC85F86D2CC0D3CB04F14752D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE9647ADFADE5905B149AF716F719AB83ED8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE34AB4081B6A6C2E079735652A29929C6CC4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CD2DCF9CF1F528DBC2E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F1C26F9D97AE30D3AA91E23F1B6B78B78B5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A572B47CC7DB6B17DA73C1A571522C4BF2891F63FD86D96750F87CCE6106E1FC07E67D4AC08A07B9B0CE135D2742255B359C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFDCDB3E12482AA16AAA61A1F94E59C37A3356E0CE8D0105724F93DF032765E2599B332213384B53536197189FEE4B1C7A1C9414840EA527E9CC91BED3E18FBFEA40B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXgwYD5Zrs0KTziL7ZclgSWU
X-Mailru-Sender: 0E9E14D9EC491FBAA1E2AD97965BD1CDB05CEE452034809F4282297163989799AF2C50DC7E177C325D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B400464DA02507E70B2F0F7BC7D98F7827D8FFD02A6B438DAA049FFFDB7839CE9E4AF99E840D2BFE858A22FBB664D8AC31B01DB62F838FFCDD0E81113D41D563B6
X-7FA49CB5: 0D63561A33F958A529F9143E2FA86ED9C45AEAE0B251EF23B10EAFC853C6AD2A8941B15DA834481FA18204E546F3947C4A7E03851CBA2956F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637EAC5C7182FB0D3F7389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C36ADCAF2B3623536B35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojJsr4kcGAUCOq1TV9Jp9pnQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

If the new_bytes handler processes a modem shutdown URC, it results in
a call to the g_at_chat_unref function, which includes a call to the
chat_cleanup function, which clears the list of URC handlers that
continue to be traversed after the current handler has completed, and
may lead to errors. To correct the situation, the at_chat_ref function
has been added, which is called at the beginning of the new_bytes
handler. Added a call to the at_chat_unref function at the end of the
new_bytes handler. Added at_chat_ref function call to g_at_chat_clone.
The previous partial solution to this problem has been removed.
---
 gatchat/gatchat.c | 84 +++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 43 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 9e777107..a1c7773c 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -98,8 +98,6 @@ struct at_chat {
 	guint wakeup_timeout;			/* How long to wait for resp */
 	GTimer *wakeup_timer;			/* Keep track of elapsed time */
 	GAtSyntax *syntax;
-	gboolean destroyed;			/* Re-entrancy guard */
-	gboolean in_read_handler;		/* Re-entrancy guard */
 	gboolean in_notify;
 	GSList *terminator_list;		/* Non-standard terminator */
 	guint16 terminator_blacklist;		/* Blacklisted terinators */
@@ -727,17 +725,52 @@ static char *extract_line(struct at_chat *p, struct ring_buffer *rbuf)
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
+		chat_cleanup(chat);
+	}
+
+	g_free(chat);
+}
+
 static void new_bytes(struct ring_buffer *rbuf, gpointer user_data)
 {
-	struct at_chat *p = user_data;
+	struct at_chat *p = at_chat_ref(user_data);
 	unsigned int len = ring_buffer_len(rbuf);
 	unsigned int wrap = ring_buffer_len_no_wrap(rbuf);
 	unsigned char *buf = ring_buffer_read_ptr(rbuf, p->read_so_far);
-
 	GAtSyntaxResult result;
 
-	p->in_read_handler = TRUE;
-
 	while (p->suspended == FALSE && (p->read_so_far < len)) {
 		gsize rbytes = MIN(len - p->read_so_far, wrap - p->read_so_far);
 		result = p->syntax->feed(p->syntax, (char *)buf, &rbytes);
@@ -778,10 +811,7 @@ static void new_bytes(struct ring_buffer *rbuf, gpointer user_data)
 		p->read_so_far = 0;
 	}
 
-	p->in_read_handler = FALSE;
-
-	if (p->destroyed)
-		g_free(p);
+	at_chat_unref(p);
 }
 
 static void wakeup_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -931,15 +961,6 @@ static void chat_wakeup_writer(struct at_chat *chat)
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
@@ -958,28 +979,6 @@ static void at_chat_resume(struct at_chat *chat)
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
@@ -1372,10 +1371,9 @@ GAtChat *g_at_chat_clone(GAtChat *clone)
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

