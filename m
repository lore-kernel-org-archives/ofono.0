Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E26C58AC4
	for <ofono@lists.linux.dev>; Mon,  5 Feb 2024 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707168764; cv=none; b=X22P6CDd+wmJB4nr9BwjzBlhzsOvMtpVQKsgT0ssa6h7UjDfiZykgKLCDMsudjuBckWfoB9wHJoX3fCYPLE76lDh70FJA6A0dom2xrzOkDmMqcmyyV6GxeiBJaUT03uf5HEm6kywhtcGvmTL6S3c03tmJJsa+kAuS8AuA6rXL48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707168764; c=relaxed/simple;
	bh=JMnzRuTJezsH/7/RYqCJAFnR7jnR8Ye0QGdlSVHdcJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEVBXF4C4t3y0aA/irEsUTLK/DDu8o/XHODW9tFVlVxomnKWbYzaJGotdtuqMzk00khLgxNiDyPlTmWvznuXRqwCfXliXsWXBi1DgOwxtdbFTTzp5Z7RgtioOSzFFql9yWEB+Otd4LptImOxGlfpwY9RDZVSmz6n4LDeMZhKc5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cuvc4nVA; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cuvc4nVA"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-21959151f4fso1128867fac.1
        for <ofono@lists.linux.dev>; Mon, 05 Feb 2024 13:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707168761; x=1707773561; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uo9zQdK9futrJ0TNHQ6eCpfSt3EFGzFP36Jk6j0umNI=;
        b=Cuvc4nVAdHffh5ICo76WCZEQ0TqCwZvShSfhCemdpp03Nn20yNpXnUB+zTTVL71/CL
         eT33ZJpTzbfIv4pTk7lApPxTMOsGg35pORwInDvC62R3hrLyBrBm8sAmLGaqBaXfK4OQ
         /Aoiz4iowJBku6j+A64YAevonboEjogcWN/fKAyo40SqD7gAFBHogEbW9TQv4XqBRfew
         U3/b/tPB7GQx8JBiTXjlSc1QQoqqYV1E0aMkRwPYppzP+93L8l4xDiLePTz3ff4Iu93z
         a3HjrHa4HNrmz1JZDU0yXFQOoJ8dzyJap64HrJ2O3LuEv1ySjpeAjic0iuI08znklwlZ
         kzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707168761; x=1707773561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uo9zQdK9futrJ0TNHQ6eCpfSt3EFGzFP36Jk6j0umNI=;
        b=tNslPDP+7wXyMfMxDtUJTFESh5cd2vSzIgXMfH2MqSPWNzXUYtTMrbNUeh7rJPLyOh
         0CHi0Sor1upLl7D9Jjde+NmOHznFxacR688rAlPz3KCssJjpujCt+OscLskGcLPc9S4D
         rT+iesyYwDmBxgUHX+5nnSAUVn6OoamVfVt7Xm7rT72hbO9mDzDTF1UwTAWy9CKzptNy
         t+a+f2TsgF1h1mkwm6wiYteB0khNsKifJoXoLaxPPyenrbCRWFpODCF7jYje6Qy9npE/
         3a9m5Onpglh6CCuNjjYBbenwzP+RwQOrIlkdIBy2OQqA8qXl5tp53crMPEwIOFmuQhZY
         ih2g==
X-Gm-Message-State: AOJu0YyVfGr2eTzWkEuv4CiqF8FQrabk/bl5h1gxaR7uSavfThQqylNT
	L8KBgq8DRmCFD1A1OAJqRcNK2C9zHOKghBwSXWXNu424Bjdftjugq9fiyhan
X-Google-Smtp-Source: AGHT+IFAhEknW39H1jRJ1zsjXoFxveTx+n6PKzRZJ+/gKmb17Y9qvuckprxxhfvsdeHEWPJW2DbFKw==
X-Received: by 2002:a05:6870:1d18:b0:219:abb4:ec1c with SMTP id pa24-20020a0568701d1800b00219abb4ec1cmr431614oab.39.1707168761521;
        Mon, 05 Feb 2024 13:32:41 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id mk10-20020a0568700d0a00b002190606a99esm153722oab.53.2024.02.05.13.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:32:41 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/6] simutil: Drop use of g_utf8_validate_len
Date: Mon,  5 Feb 2024 15:31:26 -0600
Message-ID: <20240205213150.1001245-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205213150.1001245-1-denkenz@gmail.com>
References: <20240205213150.1001245-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use l_utf8_validate instead.
---
 src/simutil.c | 4 ++--
 src/simutil.h | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index 59d8d5dd9c2d..0354cafd087f 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -766,7 +766,7 @@ unsigned char *comprehension_tlv_builder_get_data(
 	return tlv + tag_size + len_size;
 }
 
-gboolean validate_utf8_tlv(const unsigned char *tlv)
+bool validate_utf8_tlv(const unsigned char *tlv)
 {
 	int len = tlv[1];
 
@@ -777,7 +777,7 @@ gboolean validate_utf8_tlv(const unsigned char *tlv)
 	if (tlv[len + 1] == '\0')
 		len -= 1;
 
-	return g_utf8_validate_len((const char *)tlv + 2, len, NULL);
+	return l_utf8_validate((const char *)tlv + 2, len, NULL);
 }
 
 static char *sim_network_name_parse(const unsigned char *buffer, int length,
diff --git a/src/simutil.h b/src/simutil.h
index f908bbb44d15..fd3967ffd336 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -19,6 +19,8 @@
  *
  */
 
+#include <stdbool.h>
+
 #define SIM_EFSPN_DC_HOME_PLMN_BIT 0x1
 #define SIM_EFSPN_DC_ROAMING_SPN_BIT 0x2
 
@@ -408,7 +410,7 @@ gboolean comprehension_tlv_builder_set_length(
 				unsigned int len);
 unsigned char *comprehension_tlv_builder_get_data(
 				struct comprehension_tlv_builder *builder);
-gboolean validate_utf8_tlv(const unsigned char *data);
+bool validate_utf8_tlv(const unsigned char *data);
 
 void ber_tlv_iter_init(struct ber_tlv_iter *iter, const unsigned char *pdu,
 			unsigned int len);
-- 
2.43.0

