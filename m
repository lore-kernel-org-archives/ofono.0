Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8698658AB0
	for <ofono@lists.linux.dev>; Mon,  5 Feb 2024 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707168761; cv=none; b=L8X2BaIDuOY4ogcjttX5ijb1qJ3DOKJcBibJP2sarY4XncAMIwvtLU82kXs4SPn1n/ji5zqk+lrk5w/rpskTtVzig3lrrVS0yaZZwJ91pPIKJX/SphlEJ77KPpLnuhEtLDZaUoSajanpUxkqp9Yv9IGE77SgrhPFLKzmm9OREp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707168761; c=relaxed/simple;
	bh=oyCRt/9a3kpe5f3MF/I7sogtVI3zJMPGEkTpZ9BJwRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tj5qlneJP720vSQAgBU/2zrKQJaaAVOP5QXVHYr40zNDcNOkpJXgfVKf+/tD94nHBfYYvX2AIrOHMu62jvLYzfb/jIGosUbZ+8EdDm3iBgtrN4kThn15BVMM+Ss53jGTiryBFPg92vEwBWni7SNlBxvpq5eDmRksetBd+J8boDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWBAJOr6; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWBAJOr6"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e12b917df2so3066006a34.1
        for <ofono@lists.linux.dev>; Mon, 05 Feb 2024 13:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707168758; x=1707773558; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vN+g0mQaIr55/KWG0yQr5dXbCrZ8VlFSxnhARmeMi60=;
        b=bWBAJOr6N3ftUnREzOhcZKLaqUAnahACSZKa0vbtBuN1Sk/geM7Humu7HuoHzs0TMc
         uVECS8XS3aI5prAe7CJzvQEueAELd/o8SvLTfjJtwS1KzInWg8xu7yjwal2M1n4Q4iGA
         oLbH4RJibziroN+dv6mSuoUJoGqzwBDfSwjCIay7rK6t/h15OCevtXMEGjKjfrIGi/Ya
         yQuvf6cCE3PGGtfwvSVMrxipVnu9bEbOxK8eaD0FCcUY1YFg9n8cJP3a6DHKY8kkMLPw
         8TV12erdMCtQl/+2W9YjbgnpDCqFNtTRMMUdEPm2KtNSJ6GGZcg7/zFfs2/s9F4WqHWz
         3yIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707168758; x=1707773558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vN+g0mQaIr55/KWG0yQr5dXbCrZ8VlFSxnhARmeMi60=;
        b=IHZDi1Jm+g7PNp1sHmJvs+46J/Du3Zq4q8/6zaJn5Pl97C8b50Im4AuYVgdq6BWIOQ
         +bbJOrIMIi3Yfi/ZIifrLqNZrnSwIy7pN+CP6UT78+D7HUPFmhBhKyyEyWroe0ddotE/
         1AsWwvHCSPzbJ3TacKoXXrZVKUZ/HCxycs1S2ROo6SsKTE+B3zXBxVB71ASm1F1rG4uS
         87Tu7mbRewVyC+OQS4VGkMEIpzMGe2ig5oG2HI/jWsZ7IjNiXCbJr2CCrQnw0k9bbWQ1
         GYCNgrVWP4BUhfZjyeiptww4BKwi9D1J0QhCJ2D1QX8mjGCxHInB96R1O8RxUi3jslT8
         Kcpw==
X-Gm-Message-State: AOJu0Yz1+3LbKr5H5TgqO7MGE3L6J8oT/47HIlOVT+/JuOCP2Ok08mKm
	xdXEapwlwMTQj9ELxd2HsXV78EhMmTxo6b4ZDOs4x+ZsyqRH/mO+SxwMxFDr
X-Google-Smtp-Source: AGHT+IG83+AVV1yDiS4SLdIbYenX86dHqw9GOQO6qnF7yFATMJZZeeu2H3DXUebh9oz8lliiubYr+A==
X-Received: by 2002:a05:6870:41ce:b0:215:68:65c7 with SMTP id z14-20020a05687041ce00b00215006865c7mr510593oac.12.1707168758353;
        Mon, 05 Feb 2024 13:32:38 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id mk10-20020a0568700d0a00b002190606a99esm153722oab.53.2024.02.05.13.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:32:37 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/6] stkagent: Use l_utf8_get_codepoint
Date: Mon,  5 Feb 2024 15:31:22 -0600
Message-ID: <20240205213150.1001245-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GetKey() validation path ensures that the agent returns a single
UTF8 character.  It performs g_utf8_strlen with a maximum size of 10
bytes in order to minimize unnecessary processing.  Convert this code
to use the more fitting l_utf8_get_codepoint function, which will read
a single UTF8 character from the stream.
---
 src/stkagent.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/stkagent.c b/src/stkagent.c
index a002fe9c716c..6c1f6d57093f 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -639,6 +639,8 @@ static void get_key_cb(DBusPendingCall *call, void *data)
 	enum stk_agent_result result;
 	bool remove_agent;
 	char *key;
+	int len;
+	wchar_t cp;
 
 	if (check_error(agent, reply,
 			ALLOWED_ERROR_GO_BACK | ALLOWED_ERROR_TERMINATE,
@@ -654,13 +656,19 @@ static void get_key_cb(DBusPendingCall *call, void *data)
 
 	if (dbus_message_get_args(reply, NULL,
 					DBUS_TYPE_STRING, &key,
-					DBUS_TYPE_INVALID) == FALSE ||
-			g_utf8_strlen(key, 10) != 1) {
+					DBUS_TYPE_INVALID) == FALSE) {
 		ofono_error("Can't parse the reply to GetKey()");
 		remove_agent = true;
 		goto error;
 	}
 
+	len = strlen(key);
+	if (l_utf8_get_codepoint(key, len, &cp) != len) {
+		ofono_error("GetKey() return expected a single character");
+		remove_agent = true;
+		goto error;
+	}
+
 	cb(result, key, agent->user_data);
 
 	CALLBACK_END();
-- 
2.43.0

