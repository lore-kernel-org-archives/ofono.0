Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD846AA
	for <ofono@lists.linux.dev>; Wed, 24 Jan 2024 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114975; cv=none; b=K9/Su0K2GFbgcWrCya9EVCxmbLm8RTZ5DnB1oq0jRPE53kyn6zMljdg88K1hN73grah06P3lWjfCLdHQowkqGmbGVydRuzqA95zY6K7y9zbp6NC7X0Uo5Dk2aQH4yNd5NdUc+Mjb124TqS97hbVEedznf/RVPWwiLNpIqjHSqJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114975; c=relaxed/simple;
	bh=dofIU4cDqW+jS3Np3JpcxpkZuCWtsHx+TYsLrXlbIc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyBUpWMGXrMTWBoyDRoFzIqj9sqhFby5UcdqeOt7SXp4mL7LVTItQpzZTcmE3GCxgoSfoxtnMD5H4UzylBI7HEN+Honsha+2Da59w4QD0x2A26vQtTaNyU8CbuqHAR8GX0z3H2D8QAx6rayopgRDzke0t981pG+/m+93A/t+8Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2l7fJxh; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2l7fJxh"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e0df9aa43dso4388011a34.0
        for <ofono@lists.linux.dev>; Wed, 24 Jan 2024 08:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706114972; x=1706719772; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qq9nwFXVWjDJunmGFQtOohFn1ptNlecpUzg+heywv4g=;
        b=U2l7fJxhMeFwwZ3N3zyD4yuHQ5w8PcUMNJCVfRQeGTxQvvbdtJrBQdjuMV1zXfsMu0
         QRSym/ACdaCzeywqyo/z4pMj+kYeN7sIy1wdDZG/ZQtWSBwJgLp3/RLVRPzgQ77WsCr0
         J7X2zmaTbw+2z6yEsMRLRe7WQmItlH+HFp1A7kfpjYJsZ1+GHe2tcg8kYKKqlqVDcVJ0
         KXnSQccUcwUvISFOfk4na3/3+uJ2kmeRSNrPGMPAT3YRJ5zTkYkEbGI9pA1I5lPG9M1d
         MmErjSkkjMQmUPw8m8GZqj+pFafU3EfU7TAPoPujVENI+QP0Y0UounJA4T2vB0IAFSh+
         AwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706114972; x=1706719772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qq9nwFXVWjDJunmGFQtOohFn1ptNlecpUzg+heywv4g=;
        b=FnImIYurafpbkVmydST3qVT4rWz0cnPMLCxlG/yXSLwqRw48UdwNx91m9dFMr+SsSV
         1eQ1I2WNu7l4Fe6nCwwqB7FsYDJIJdp/4VpQUnLsrdeyeGinyRyplQF+3l38HmFPLRBZ
         NiUTiCjkSLbjChxN9Xf2yspiqv0ItFhy36OxsakjnI67nDCdR8vy3ISK/cAPr6T3yCq5
         lhRH818I74+qsi329Fxfgqla2q6m3sfLieW4gxog40+iOH1RiMIlSzByG9wGCXQniayP
         ZJoEndKM9JaBEro2FI78lZDchplH3TtZMMNEEqWhXKhecxUVDWW4aeNZNrd3xYFlrnqA
         AFUw==
X-Gm-Message-State: AOJu0YwGNj6sxtATaCz+K1Iy7QWJFjm5fqwNOBQVjjodQMKz4q14w33g
	+dtLR4DTX/X7dt+xAdLierO//c7876A7yEbOZjVjewC+okbCRlhDRez+4UlN
X-Google-Smtp-Source: AGHT+IFTeXMMR6gLSYTN1oYKAPCaASXwkHJLsIpwQVjDGTcz229aovHbda3A1uKIjwTMge2+LCTxYw==
X-Received: by 2002:a05:6870:9a06:b0:204:991:a15 with SMTP id fo6-20020a0568709a0600b0020409910a15mr4068663oab.105.1706114972170;
        Wed, 24 Jan 2024 08:49:32 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id dx8-20020a056870768800b00214881081cfsm905821oab.7.2024.01.24.08.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 08:49:31 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Maxim Lyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH v3] gatchat: fix g_at_chat_unref in notify handler
Date: Wed, 24 Jan 2024 10:47:07 -0600
Message-ID: <20240124164838.605025-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123150035.1477546-1-m.lyubimov@aqsi.ru>
References: <20240123150035.1477546-1-m.lyubimov@aqsi.ru>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Lyubimov <m.lyubimov@aqsi.ru>

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
 gatchat/gatchat.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 9e777107..dd910915 100644
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
@@ -780,8 +786,10 @@ static void new_bytes(struct ring_buffer *rbuf, gpointer user_data)
 
 	p->in_read_handler = FALSE;
 
-	if (p->destroyed)
+	if (p->destroyed) {
+		chat_cleanup(p);
 		g_free(p);
+	}
 }
 
 static void wakeup_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -958,6 +966,16 @@ static void at_chat_resume(struct at_chat *chat)
 		chat_wakeup_writer(chat);
 }
 
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
 static void at_chat_unref(struct at_chat *chat)
 {
 	gboolean is_zero;
@@ -971,13 +989,14 @@ static void at_chat_unref(struct at_chat *chat)
 		at_chat_suspend(chat);
 		g_at_io_unref(chat->io);
 		chat->io = NULL;
-		chat_cleanup(chat);
 	}
 
 	if (chat->in_read_handler)
 		chat->destroyed = TRUE;
-	else
+	else {
+		chat_cleanup(chat);
 		g_free(chat);
+	}
 }
 
 static gboolean at_chat_set_disconnect_function(struct at_chat *chat,
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
2.43.0

