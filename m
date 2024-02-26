Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EF114008
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918656; cv=none; b=oRiaEjz5al+LaNX71qyV7XSnIfs242GV4OkjVWjc2JCUkaHuhX9432IV1H5t+yt1M0UAXRH5p0XyW2MXfDK7bUBmhE2q1EA8QkCyK/gyEiuNJUi5TeKJKvxb412Ywo1T9BLXorq/UZt9flhvrHDihBjWTtYKmEYQbJqSg2caLCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918656; c=relaxed/simple;
	bh=wWcRXRU7+5u3yQX38wbFbVhhKAAhyFZPcWbpS3FQx8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GY+FE2IlPXxG+9UgYP2rzZHXwCOxwBb5YvVtHinEHxl9CFFVlYRRQDdRNVsSrAmCkd5BCV/u8SwcBANWviwU+o/WIMN4sXNsoP6quEySPLRFaT6lbaw2tCKBiHf80/pzP5+UFecxKu2vvCApApCT7znC4wiioHBUzG/0K1tPRsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwuZhtT+; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwuZhtT+"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c19e18470aso620267b6e.1
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918654; x=1709523454; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDRa1wgBsx+6j2ObcGJQP1tFuniTb2yF2lLbgkDYPwI=;
        b=EwuZhtT+Tsa8Fz92dvNnAjotj5Vx7EXLr7Q7Jt/Bo1HMRmQbYx8VSoHgaJ5U891ZNG
         ZDjBpxNw7qTm4tf43pR2J8v/TccPxvdgIUfrOepj4ZHRVZvViydtT/bkz4TWQCjeU31R
         ObvEmJ4+LRi8UTAIQXCWpOFrqzqibh1k/lRJYZNihULqr0UODJ2W+3eL4fFYMAtbHBeR
         sWdBGPoWh6w+hNA86MNo6qXaadLicR9XyNjr4X8b+8Wklgl/O10qfw90FQo2gbiP9XMd
         CINdp0daLsPaVwruYRvfQHo2guxZ+goXV7LuXg/sg3jD2FzCXTGuNMiRJ4OCBKN/Mbyz
         lGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918654; x=1709523454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDRa1wgBsx+6j2ObcGJQP1tFuniTb2yF2lLbgkDYPwI=;
        b=IEZPvVU/x/4eEq3JcwFN8e3lmrZUgdxSegK/RAw3tRXmbCY4ViGI4oyF5xOz+vyncm
         K2ABQU11mEh4uEeya57h6ctboPF/o8wQBdHTjL5KuWShn6sh5Ap0gUFcrid/q0yWh7MD
         +lvAiXb+P5736gtcZ7pZ6w+PM0ZNlkkWCmEOCUfbKgblaF2I+czfbqSN+/0jpLzuqg19
         xSNEa5Ij3i9pp47L6bnowFGqDcM6tnNAs7U3NkISzO56703/5eSUKVkwprw2pvRCL89N
         cZWpP5kOckoKq/N0CQNmaa14IpbUYGl9O0wEcPuAB3pLb8GrHO+6pqD9jtc0iyONqq8F
         7rwg==
X-Gm-Message-State: AOJu0YzMX45kTlRQzx8pd9FB8SI8QJXeF5IU172lPAfoIjhbGV4cmELF
	qOyeOrydhOnsRR3CeObTST8IG5D1aqfLLfSTe30cbOOy85kqpDEavdLtnNlT
X-Google-Smtp-Source: AGHT+IHmws7nOEhkqdGNJ9U9KrR8LJR729Nhqve6jgTAvL9+ucv3OcRjInTqU3yed501vx3cuVzA9w==
X-Received: by 2002:a05:6808:15aa:b0:3c1:944d:429e with SMTP id t42-20020a05680815aa00b003c1944d429emr6649458oiw.7.1708918653976;
        Sun, 25 Feb 2024 19:37:33 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:33 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 12/22] phonebook: Replace g_strndup use with l_strndup
Date: Sun, 25 Feb 2024 21:36:55 -0600
Message-ID: <20240226033724.1460079-12-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226033724.1460079-1-denkenz@gmail.com>
References: <20240226033724.1460079-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/phonebook.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/phonebook.c b/src/phonebook.c
index 122ba83c066e..eb48980e7a3b 100644
--- a/src/phonebook.c
+++ b/src/phonebook.c
@@ -267,7 +267,7 @@ static void print_merged_entry(gpointer pointer, gpointer user_data)
 static void destroy_merged_entry(gpointer pointer)
 {
 	struct phonebook_person *person = pointer;
-	g_free(person->text);
+	l_free(person->text);
 	g_free(person->group);
 	g_free(person->email);
 	g_free(person->sip_uri);
@@ -386,7 +386,7 @@ void ofono_phonebook_entry(struct ofono_phonebook *phonebook, int index,
 			person = g_new0(struct phonebook_person, 1);
 			phonebook->merge_list =
 				g_slist_prepend(phonebook->merge_list, person);
-			person->text = g_strndup(text, len_text);
+			person->text = l_strndup(text, len_text);
 		}
 
 		merge_field_number(&(person->number_list), number, type,
-- 
2.43.0

