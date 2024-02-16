Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098F7C0B4
	for <ofono@lists.linux.dev>; Fri, 16 Feb 2024 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101534; cv=none; b=VgQPyYXDEyTAEoij86BbgX+0VIGl8iTMu86YqEMQD1czmZFcfLeRlkrak874iO6PwXb8VLa6hJw/V+7kJNXNGxfLmP3j7jiGElWIfyN5keIlIG1YRGOR9x9e61tLPfnf2IQtm6ieUheC34fWLor/unLteVFNoKXg6xOgF6GLNsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101534; c=relaxed/simple;
	bh=PvE6lv0+vNPfsxKglutqc8wZRUhomVV6XdV9KAlGyTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BeKj1rVlU2o/mgvYc5cMV0be3x9muwqhLpQ8Azf10j4SVEdrMujYXLv2slNeEFkGrTm3CCG2L19qHs5TGfgKjsv0SoN4XfS8qCSPzIF2EBqfF6EeBn5Oyg4WWnISFNzxElGWDWB0a3/rq9ZPRhfS//r/214+Vm3+/5LLDrh6rMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbFCXc/d; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbFCXc/d"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-21e7c3e3cf3so228009fac.0
        for <ofono@lists.linux.dev>; Fri, 16 Feb 2024 08:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708101531; x=1708706331; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uVRzuFMrS5aFRqY8aQ8tsZmCkOdILJNQj55SzEui1no=;
        b=UbFCXc/dpFcU07wk875TOoh4wxKya7TA/r/Pwfsw2xzJuPLYQyLFte4L84fvXz7qbt
         Y54KfnBTMEsCxU8xWHMbJNYIMmLCj2fdMWRxdqgOLKpDORBPWRC6HyoqMyE1SqRxDgpH
         PIrjn50A2pJzMLktaD9QsLIAaCVZjaQLTgzalQHvU7N6SyB12UAllNVO4jD3setLDS8M
         xxBbM6c1b5v1Hx4+42MlzzwxLOi/1CkDNv/yMpb32y6MmyQI2TlM8SJai2FNg3pR+TpJ
         HZitpvIw4D1s9o31z6pELMisPWuGuL6MeWggwWQtFAE/pq78zkLZY5uIQdCNcdiBt4Fe
         7xPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708101531; x=1708706331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVRzuFMrS5aFRqY8aQ8tsZmCkOdILJNQj55SzEui1no=;
        b=CyBPKeALqg1eMoEvf5Oi4pT5gEOE04uKIEXW356n2WV9UbRtPS8N7C3Ied5gbL1gZI
         grV14vHH3xOB8s/C0IsJmIXErdQZcHbSur+wk3OBotod8XgAFA9eXDR8SL1Ty7Fh/JlT
         S625bYiUzxXkrCL9XDmV/lz3ztRctnFIQrAOAbPk5BMrMO5Zry+PfDDdU3ipijqOvUda
         TXEyKmoAR9R+oLArnuItUdclEZmb2Dp8+SV4/redQsKzs0Rv+Ci1Yp0fzkNVi6H+pEax
         LuMteskqjYWL1ZxiGx1Z85Magq4oPZkEpX7Mo/AzxzNFKR7ztpQ+2+MVFd8OtdpVGM6V
         Ij7g==
X-Gm-Message-State: AOJu0YyBWqniVaTPKajKyhU2kxMfwqsyN7npMWIVq/PHeAYt7ccwZsH2
	zCXiM1XI75KX2zVvvHNbFJeMzeiJe+cAO40cYIb5XiHIsxSo4NF8iETUXHYC
X-Google-Smtp-Source: AGHT+IFgvwu3KD73PdUqwcP2bV4pL1O7M3HcpkNy2O+azaclkjOjQgDF/VUK6Iuv9pmO7fj6uP2aSg==
X-Received: by 2002:a05:6871:510:b0:21e:3cf8:38ae with SMTP id s16-20020a056871051000b0021e3cf838aemr5154623oal.38.1708101531436;
        Fri, 16 Feb 2024 08:38:51 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id h7-20020a9d5547000000b006e2e971f525sm43165oti.45.2024.02.16.08.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 08:38:51 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/2] smsutil: Remove g_string_* use
Date: Fri, 16 Feb 2024 10:38:01 -0600
Message-ID: <20240216163804.1206023-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace with l_string instead
---
 src/smsutil.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index d4f28c01bd79..05942d6fe56b 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2223,7 +2223,7 @@ static inline int sms_text_capacity_gsm(int max, int offset)
 char *sms_decode_text(GSList *sms_list)
 {
 	GSList *l;
-	GString *str;
+	struct l_string *str;
 	const struct sms *sms;
 	int guess_size = g_slist_length(sms_list);
 	char *utf8;
@@ -2235,7 +2235,7 @@ char *sms_decode_text(GSList *sms_list)
 	else
 		guess_size = (guess_size - 1) * 160;
 
-	str = g_string_sized_new(guess_size);
+	str = l_string_new(guess_size);
 
 	for (l = sms_list; l; l = l->next) {
 		guint8 taken = 0;
@@ -2301,7 +2301,7 @@ char *sms_decode_text(GSList *sms_list)
 								locking_shift,
 								single_shift);
 			if (converted) {
-				g_string_append(str, converted);
+				l_string_append(str, converted);
 				l_free(converted);
 			}
 		} else {
@@ -2344,14 +2344,14 @@ char *sms_decode_text(GSList *sms_list)
 
 		converted = l_utf8_from_utf16(utf16, utf16_size);
 		if (converted) {
-			g_string_append(str, converted);
+			l_string_append(str, converted);
 			l_free(converted);
 		}
 
 		l_free(utf16);
 	}
 
-	utf8 = g_string_free(str, FALSE);
+	utf8 = l_string_unwrap(str);
 
 	return utf8;
 }
-- 
2.43.0

