Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF935EE98
	for <ofono@lists.linux.dev>; Tue, 13 Feb 2024 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838576; cv=none; b=PuFz1aCj44hSed+EDUijaBtWbooNAb5vy3Oy1lUtaj5ipwUBkgqg7JuvAa/PTpEkrm7Yca8/6cGRPzrLnZjC6xOxc0tobzwKa2L0QCOT8ryTPEG42LAFLPowKbr2KHYbeAun0nXd6dyzAigIffrLQZLV0FNEHlrKj7E6NKBCkkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838576; c=relaxed/simple;
	bh=uYF2A5QkuGe5qWaVBjlbOZP+SXkn8oGryV/1TStSD+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMnMen7USq59R+vBXUwYK1vCVTyPRpFU+wXvA9r145fzgjdMZ9Gpn68yFWgH+HNygiAofqMjzpSvS6iulgdEbZB+/tXP5zLlEPBjJEsMhs66ErW2c5ClcsqYawwX9pekOYlov2hVnZx46JGAJaQCNveIZYVoJL51BJX9EakVPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFH4SRja; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFH4SRja"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-218e3197784so2740520fac.0
        for <ofono@lists.linux.dev>; Tue, 13 Feb 2024 07:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707838574; x=1708443374; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USCgKvrth+Jll5yk+iyO/1iEpkZViw7E+RT05XL2yCA=;
        b=cFH4SRjai/fik5Qso8gFRC4WYHcAdYnUOISAdZ+KwRa9pdsTmxTqwT5wVJ/qEELL/Q
         O1Age6me4hVw72hXnMkr4pWEVKBqAGFU9nwVGCYun2QtscWN5+cN8Ph6zNFrDOqhgJB4
         7WLhyBJc+RJ5qzTPA3rYGoCfiSF6ikpEvkKEO6xg1kkaH/zO34m/nPnveeJZlo+SrzIV
         E87tUdvuY/Lw1Ltq33oZ3fmPU2PSg+p8ExWOBsNVWIZ6/QyXEGCvdpGrukYc/WKTYGi1
         WF5OJYGjs12fB/GX3INpvnD01TAxJN1kjQqsrHs7srwmAy2LYbYBfs8dKuDENBm6pjCL
         duxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707838574; x=1708443374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USCgKvrth+Jll5yk+iyO/1iEpkZViw7E+RT05XL2yCA=;
        b=l8xVyW7ELKp8bUmr4A2om9nD+8D8brps3r4/KkpDMEtCi3SMtzQeJAN8OuVF6tKXI2
         56gJtzPlrkiKP4tgXbpoV9syLG/J7SEEfEeFuVBkd0CXyVsfeymv61mQwB/wE60c6Nlo
         zBcig8tLwJM7h/karNRcM7mHMftR4qlev5AScCA+3rZK1XPIP5XtHmFNvhcWJN0tHzYJ
         0AzmefC/v0SfcY1GU7I/N9m4GrhzOHydMmEYLeyUhtC03SqXTLBmLCyciHQYruz92J95
         TZZ5KLfcXOq+IsgjODl53r2GyoswARG5fz9RTj/fX+aKejyUnWDkFvaQnVfvcHaj52r/
         SF8A==
X-Gm-Message-State: AOJu0YzxP7O58/VoI4u3PqiHhFG2Yaznoz1NVzQle18JwlRjimbjkI28
	/VzAIHd0az2po3cLFXCzzsDvpnztmOoxKXAooIknXmBRKUXzBqM8yGHH5BVZ
X-Google-Smtp-Source: AGHT+IGNzxsjIYjBIC37FvsfmxnXPvbme98gYD26sLYZldCw9Z7FJenybQaB4gbuxHbXu+0/eZ06AQ==
X-Received: by 2002:a05:6871:5316:b0:219:a838:df with SMTP id hx22-20020a056871531600b00219a83800dfmr12943426oac.49.1707838573998;
        Tue, 13 Feb 2024 07:36:13 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id dx19-20020a056870769300b0021a0f032341sm1861999oab.22.2024.02.13.07.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:36:13 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/6] unit: Add unit tests for language list parsers
Date: Tue, 13 Feb 2024 09:35:08 -0600
Message-ID: <20240213153524.1085649-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213153524.1085649-1-denkenz@gmail.com>
References: <20240213153524.1085649-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add unit tests for the newly moved sim_parse_language_list and
sim_parse_eflp functions.
---
 unit/test-simutil.c | 57 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/unit/test-simutil.c b/unit/test-simutil.c
index 8364f200c665..4199991a4d2a 100644
--- a/unit/test-simutil.c
+++ b/unit/test-simutil.c
@@ -695,6 +695,59 @@ static void test_auth_build_parse(void)
 	g_assert(!memcmp(kc_b.data, kc, sizeof(kc)));
 }
 
+static void test_parse_language_list(void)
+{
+	static const unsigned char empty[] = {
+		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+	};
+	static const unsigned char efpl[] = {
+		'e', 'n', 0xff, 0xff, 'd', 'e', 'f', 'r', 0xff, 0xff, 'n', 'l'
+	};
+
+	char **parsed;
+	char *joined;
+
+	parsed = sim_parse_language_list(empty, sizeof(empty));
+	assert(!parsed);
+
+	parsed = sim_parse_language_list(efpl, sizeof(efpl));
+	assert(parsed);
+	joined = l_strjoinv(parsed, ':');
+	assert(!strcmp(joined, "en:de:fr:nl"));
+	l_strfreev(parsed);
+	l_free(joined);
+
+	parsed = sim_parse_language_list(efpl, sizeof(efpl) - 1);
+	assert(parsed);
+	joined = l_strjoinv(parsed, ':');
+	assert(!strcmp(joined, "en:de:fr"));
+	l_strfreev(parsed);
+	l_free(joined);
+}
+
+static void test_parse_eflp(void)
+{
+	static const unsigned char empty[] = {
+		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+	};
+	static const unsigned char eflp[] = {
+		0x00, 0x01, 0x02, 0x03, 0x04, 0x05
+	};
+
+	char **parsed;
+	char *joined;
+
+	parsed = sim_parse_eflp(empty, sizeof(empty));
+	assert(!parsed);
+
+	parsed = sim_parse_eflp(eflp, sizeof(eflp));
+	assert(parsed);
+	joined = l_strjoinv(parsed, ':');
+	assert(!strcmp(joined, "de:en:it:fr:es:nl"));
+	l_strfreev(parsed);
+	l_free(joined);
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -716,5 +769,9 @@ int main(int argc, char **argv)
 	g_test_add_func("/testsimutil/2G path", test_get_2g_path);
 	g_test_add_func("/testsimutil/auth build parse", test_auth_build_parse);
 
+	g_test_add_func("/testsimutil/parse_language_list",
+						test_parse_language_list);
+	g_test_add_func("/testsimutil/parse_efpl", test_parse_eflp);
+
 	return g_test_run();
 }
-- 
2.43.0

