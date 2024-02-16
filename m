Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5359512F39F
	for <ofono@lists.linux.dev>; Fri, 16 Feb 2024 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101535; cv=none; b=heVIWZqxqFj0UWcGadYWNL9Dmt38T+AZxrteyU8lin0zjNsMtLB9uvkfjmmfXvUyjV4kHrDMt9uwXBvQMR8xkneorewA3zbFSyVfjWchFHXzyV6PZYdP14F4hcIyG/sGoE65qTwrlsuBkgA7kYXur3JPNU1gCRqZFbtEYk1iAVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101535; c=relaxed/simple;
	bh=ORD8i5b/eRu4mch9vIw8on1OAPNLhXvLuJ4PkpZrvgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ni/ZDISnuJww0I7FMrwS9VNalD69eNFKjsrUKSfFdr16hIJad6IYrvNHP79ASqopogBaFrVtUfv0FM9NQlZ5ycTLkLNE7Hs/C3KRtybIGMcfIldbDn+ULoGqdePIeJtAOhHdGSZ8ZRaXSCyiR3PmoAienieMN9v7CYywlIxMPEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iP6yrRab; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP6yrRab"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21e11a89e76so959892fac.1
        for <ofono@lists.linux.dev>; Fri, 16 Feb 2024 08:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708101532; x=1708706332; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUE6uR/UV4vPj+nQqqrvGjqhAoYA0x0aZ9GFm9QY6lQ=;
        b=iP6yrRab8KdIuQ2HnHp6qnsrqmnDO3OPjoy8z52UDobjboW9X5iR2+ZADgenh+Iijz
         2shLutkC6WTQR3A4rg09FaVwzWYQwQFohJFVeuSM66S+F3pLJHQmUeMotW92Oj4y4zun
         FZu/JD1HVyoMafrrGCSbQQpHgm6F8RG76IYZnr7pJT/eDAWV8AJhZHunZpUZmNc6QLxM
         TfknIAndoY3KFFokhbXYEO+PPkxNYl/wZLvDDw7MdIu8P55Fr0kFyfwfrVOofK1r8Gpq
         4lQHYgoAl7DMHJkCxpfx85AAeoJEi+FYA8LB1STTbCVnUaEtXEsnpBrPDmApIXdMk1uS
         S6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708101532; x=1708706332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUE6uR/UV4vPj+nQqqrvGjqhAoYA0x0aZ9GFm9QY6lQ=;
        b=dJNTf5LckKhyqc/IN+nt0dcqeTA9lCuQgxfb7QNaRV8tb6L0SVBvWNvMAENPaWnBAm
         fJjIk+hpAT72P3iMf6ctlMe8VJM2yzQPhQ5LH/Drz7aTwrZMMevdiv5LL+rHFDMvhBq6
         UqRPpL1YQ4OqGKNUL3f5/P5B+cgpaJ2JXCndma3cNyy6rf22GF2saZycqswhqJSkZvKQ
         ljbS6je9Fd8sjYz77G2tErLe7lUL8BVEYDaRUOS9YFbrMHogXL8+DOdbek3sU0gE7KAc
         fVCBp+HcwDDZOeq1AIoU/3Xymsqj0GtR4g72rcCj7iW4yAkzsZQTvxR+MD1hZ0gPHSvp
         npdw==
X-Gm-Message-State: AOJu0YzAPkuM0xH5SywXrEJj8S8id/sdQVZQphgXk8JYyIsxNuqkIoQE
	+0AResiCVago8ZUDgc7a/D7YjyzAnYeM3npsGeKTqftvvPtelkp7TDG/wkXH
X-Google-Smtp-Source: AGHT+IHMinaOztIljoqihn4683ka+QfxWxXpsBZGW3V0O14I90ZqCQDcYNDzE/Edysh7v9zvWZqSLg==
X-Received: by 2002:a05:6870:3326:b0:219:1dc6:fdff with SMTP id x38-20020a056870332600b002191dc6fdffmr5727580oae.55.1708101532185;
        Fri, 16 Feb 2024 08:38:52 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id h7-20020a9d5547000000b006e2e971f525sm43165oti.45.2024.02.16.08.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 08:38:51 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/2] phonebook: Remove g_string_* use
Date: Fri, 16 Feb 2024 10:38:02 -0600
Message-ID: <20240216163804.1206023-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216163804.1206023-1-denkenz@gmail.com>
References: <20240216163804.1206023-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace all uses of g_string_* APIs with ell's equivalents.  While here,
fix a long-standing bug where dbus_message_iter_append_basic inside
generate_export_entries_reply was called with the g_string object
instead of the address of the string itself.  This somehow worked, maybe
due to the layout of GString structure, but could lead to crashes or
invalid behavior if the underlying GString implementation changed.
---
 src/phonebook.c | 92 ++++++++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/src/phonebook.c b/src/phonebook.c
index 8c7e5f100bd3..122ba83c066e 100644
--- a/src/phonebook.c
+++ b/src/phonebook.c
@@ -53,7 +53,8 @@ struct ofono_phonebook {
 	DBusMessage *pending;
 	int storage_index; /* go through all supported storage */
 	int flags;
-	GString *vcards; /* entries with vcard 3.0 format */
+	struct l_string *vcards_builder; /* entries with vcard 3.0 format */
+	char *cached_vcards;
 	GSList *merge_list; /* cache the entries that may need a merge */
 	const struct ofono_phonebook_driver *driver;
 	void *driver_data;
@@ -79,27 +80,29 @@ static const char *storage_support[] = { "SM", "ME", NULL };
 static void export_phonebook(struct ofono_phonebook *pb);
 
 /* according to RFC 2425, the output string may need folding */
-static void vcard_printf(GString *str, const char *fmt, ...)
+static void vcard_printf(struct l_string *str, const char *fmt, ...)
 {
 	char buf[1024];
 	va_list ap;
 	int len_temp, line_number, i;
 	unsigned int line_delimit = 75;
+	size_t buflen;
 
 	va_start(ap, fmt);
 	vsnprintf(buf, sizeof(buf), fmt, ap);
 	va_end(ap);
 
+	buflen = strlen(buf);
 	line_number = strlen(buf) / line_delimit + 1;
 
 	for (i = 0; i < line_number; i++) {
-		len_temp = MIN(line_delimit, strlen(buf) - line_delimit * i);
-		g_string_append_len(str,  buf + line_delimit * i, len_temp);
+		len_temp = MIN(line_delimit, buflen - line_delimit * i);
+		l_string_append_fixed(str,  buf + line_delimit * i, len_temp);
 		if (i != line_number - 1)
-			g_string_append(str, "\r\n ");
+			l_string_append(str, "\r\n ");
 	}
 
-	g_string_append(str, "\r\n");
+	l_string_append(str, "\r\n");
 }
 
 /*
@@ -134,20 +137,21 @@ static void add_slash(char *dest, const char *src, int len_max, int len)
 	return;
 }
 
-static void vcard_printf_begin(GString *vcards)
+static void vcard_printf_begin(struct l_string *vcards)
 {
 	vcard_printf(vcards, "BEGIN:VCARD");
 	vcard_printf(vcards, "VERSION:3.0");
 }
 
-static void vcard_printf_text(GString *vcards, const char *text)
+static void vcard_printf_text(struct l_string *vcards, const char *text)
 {
 	char field[LEN_MAX];
 	add_slash(field, text, LEN_MAX, strlen(text));
 	vcard_printf(vcards, "FN:%s", field);
 }
 
-static void vcard_printf_number(GString *vcards, const char *number, int type,
+static void vcard_printf_number(struct l_string *vcards,
+					const char *number, int type,
 					enum phonebook_number_type category)
 {
 	char *pref = "", *intl = "", *category_string = "";
@@ -182,7 +186,7 @@ static void vcard_printf_number(GString *vcards, const char *number, int type,
 	vcard_printf(vcards, buf, number);
 }
 
-static void vcard_printf_group(GString *vcards,	const char *group)
+static void vcard_printf_group(struct l_string *vcards, const char *group)
 {
 	int len = 0;
 
@@ -196,7 +200,7 @@ static void vcard_printf_group(GString *vcards,	const char *group)
 	}
 }
 
-static void vcard_printf_email(GString *vcards, const char *email)
+static void vcard_printf_email(struct l_string *vcards, const char *email)
 {
 	int len = 0;
 
@@ -211,7 +215,7 @@ static void vcard_printf_email(GString *vcards, const char *email)
 	}
 }
 
-static void vcard_printf_sip_uri(GString *vcards, const char *sip_uri)
+static void vcard_printf_sip_uri(struct l_string *vcards, const char *sip_uri)
 {
 	int len = 0;
 
@@ -225,7 +229,7 @@ static void vcard_printf_sip_uri(GString *vcards, const char *sip_uri)
 	}
 }
 
-static void vcard_printf_end(GString *vcards)
+static void vcard_printf_end(struct l_string *vcards)
 {
 	vcard_printf(vcards, "END:VCARD");
 	vcard_printf(vcards, "");
@@ -234,7 +238,7 @@ static void vcard_printf_end(GString *vcards)
 static void print_number(gpointer pointer, gpointer user_data)
 {
 	struct phonebook_number *pn = pointer;
-	GString *vcards = user_data;
+	struct l_string *vcards = user_data;
 	vcard_printf_number(vcards, pn->number, pn->type, pn->category);
 }
 
@@ -248,7 +252,7 @@ static void destroy_number(gpointer pointer)
 static void print_merged_entry(gpointer pointer, gpointer user_data)
 {
 	struct phonebook_person *person = pointer;
-	GString *vcards = user_data;
+	struct l_string *vcards = user_data;
 	vcard_printf_begin(vcards);
 	vcard_printf_text(vcards, person->text);
 
@@ -284,7 +288,8 @@ static DBusMessage *generate_export_entries_reply(struct ofono_phonebook *pb,
 		return NULL;
 
 	dbus_message_iter_init_append(reply, &iter);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, pb->vcards);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
+							&pb->cached_vcards);
 
 	return reply;
 }
@@ -396,20 +401,21 @@ void ofono_phonebook_entry(struct ofono_phonebook *phonebook, int index,
 		return;
 	}
 
-	vcard_printf_begin(phonebook->vcards);
+	vcard_printf_begin(phonebook->vcards_builder);
 
 	if (text == NULL || text[0] == '\0')
-		vcard_printf_text(phonebook->vcards, number);
+		vcard_printf_text(phonebook->vcards_builder, number);
 	else
-		vcard_printf_text(phonebook->vcards, text);
+		vcard_printf_text(phonebook->vcards_builder, text);
 
-	vcard_printf_number(phonebook->vcards, number, type, TEL_TYPE_OTHER);
-	vcard_printf_number(phonebook->vcards, adnumber, adtype,
+	vcard_printf_number(phonebook->vcards_builder, number, type,
 				TEL_TYPE_OTHER);
-	vcard_printf_group(phonebook->vcards, group);
-	vcard_printf_email(phonebook->vcards, email);
-	vcard_printf_sip_uri(phonebook->vcards, sip_uri);
-	vcard_printf_end(phonebook->vcards);
+	vcard_printf_number(phonebook->vcards_builder, adnumber, adtype,
+				TEL_TYPE_OTHER);
+	vcard_printf_group(phonebook->vcards_builder, group);
+	vcard_printf_email(phonebook->vcards_builder, email);
+	vcard_printf_sip_uri(phonebook->vcards_builder, sip_uri);
+	vcard_printf_end(phonebook->vcards_builder);
 }
 
 static void export_phonebook_cb(const struct ofono_error *error, void *data)
@@ -423,13 +429,12 @@ static void export_phonebook_cb(const struct ofono_error *error, void *data)
 	/* convert the collected entries that are already merged to vcard */
 	phonebook->merge_list = g_slist_reverse(phonebook->merge_list);
 	g_slist_foreach(phonebook->merge_list, print_merged_entry,
-				phonebook->vcards);
+				phonebook->vcards_builder);
 	g_slist_free_full(phonebook->merge_list, destroy_merged_entry);
 	phonebook->merge_list = NULL;
 
 	phonebook->storage_index++;
 	export_phonebook(phonebook);
-	return;
 }
 
 static void export_phonebook(struct ofono_phonebook *phonebook)
@@ -443,6 +448,10 @@ static void export_phonebook(struct ofono_phonebook *phonebook)
 		return;
 	}
 
+	phonebook->cached_vcards = l_string_unwrap(phonebook->vcards_builder);
+	phonebook->vcards_builder = NULL;
+	phonebook->flags |= PHONEBOOK_FLAG_CACHED;
+
 	reply = generate_export_entries_reply(phonebook, phonebook->pending);
 	if (reply == NULL) {
 		dbus_message_unref(phonebook->pending);
@@ -450,31 +459,23 @@ static void export_phonebook(struct ofono_phonebook *phonebook)
 	}
 
 	__ofono_dbus_pending_reply(&phonebook->pending, reply);
-	phonebook->flags |= PHONEBOOK_FLAG_CACHED;
 }
 
 static DBusMessage *import_entries(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
 	struct ofono_phonebook *phonebook = data;
-	DBusMessage *reply;
-
-	if (phonebook->pending) {
-		reply = __ofono_error_busy(phonebook->pending);
-		g_dbus_send_message(conn, reply);
-		return NULL;
-	}
 
-	if (phonebook->flags & PHONEBOOK_FLAG_CACHED) {
-		reply = generate_export_entries_reply(phonebook, msg);
-		g_dbus_send_message(conn, reply);
-		return NULL;
-	}
+	if (phonebook->pending)
+		return  __ofono_error_busy(phonebook->pending);
 
-	g_string_set_size(phonebook->vcards, 0);
-	phonebook->storage_index = 0;
+	if (phonebook->flags & PHONEBOOK_FLAG_CACHED)
+		return generate_export_entries_reply(phonebook, msg);
 
 	phonebook->pending = dbus_message_ref(msg);
+
+	phonebook->vcards_builder = l_string_new(0);
+	phonebook->storage_index = 0;
 	export_phonebook(phonebook);
 
 	return NULL;
@@ -514,13 +515,12 @@ static void phonebook_remove(struct ofono_atom *atom)
 	if (pb->driver && pb->driver->remove)
 		pb->driver->remove(pb);
 
-	g_string_free(pb->vcards, TRUE);
+	l_string_free(pb->vcards_builder);
+	l_free(pb->cached_vcards);
 	g_free(pb);
 }
 
-OFONO_DEFINE_ATOM_CREATE(phonebook, OFONO_ATOM_TYPE_PHONEBOOK, {
-	atom->vcards = g_string_new(NULL);
-})
+OFONO_DEFINE_ATOM_CREATE(phonebook, OFONO_ATOM_TYPE_PHONEBOOK)
 
 void ofono_phonebook_register(struct ofono_phonebook *pb)
 {
-- 
2.43.0

