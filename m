Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF268149C48
	for <ofono@lists.linux.dev>; Wed,  3 Apr 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160368; cv=none; b=ix342dNGpwGD8n8ztGVAvH9a9/Nqhw+EVLim9aG4aIaIJnCAcwSFm/Z5hHBuFvT1uAoS6Da4S8Plz7ozAjpsIA7ZfUPSbpfCJo+ZauzyfQJ7gufj21eXdE2BNTWYnOHQq692YiBoNkSueQhf2fFdWaAYNyZEy4DTRumtD99slZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160368; c=relaxed/simple;
	bh=puDK51IZNmptQzOyxED4XtoZxV2LzQQk/y+n2KNzKKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9VXsCGN3TPd0DlUdCnWxv5g2tILJSd20kCB5Iiy1tD0+t5FryRNWDeLO1cViEdmjMDqOs/1WlrrtuFRbENFVz42KF7i8VDB8Shky6O9p2QAKdGDX0G/k+i5Iam5jpYdZa4edpUWW1pwbRchKoq5IWubR0ZcwhgMn/KOLXjvNpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIbAr2q6; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIbAr2q6"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e695b7391dso5003a34.1
        for <ofono@lists.linux.dev>; Wed, 03 Apr 2024 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712160365; x=1712765165; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA+Vkqwk5ZmbSNd3gdnkiwrGaLPpFx9rEooKDQQTGCM=;
        b=WIbAr2q65TBTqbr6Ws2HDJ6ovl12saXqiclSkZ6qEDv1XfMvup5z0MmRI9HbIhw4eY
         8gkdxSMPbkjBRklH87mIgVDmi9uK10j8F7o2w6JaXkmfo1tYhXEw6WgNiu9Iz7DF4iaa
         yXpaS6yjAku7bdyPzIjH5htJvxdkYZ7Lmeo1TfgXelsNa4tXh0ogn4QSsUU4nZCXgh3s
         RG8cIA00yG3qi0GsoIXDZBr6pPi9hBek63feMeHbqoWaNr+6Un9roN1SN1A2BMGqqTnB
         tPI49xldyHweroD1nqhYgYBGbj4T0oFtUofnNNU3Obi4hQwSiveHaVH55mGYH/cVfxkA
         8MNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160365; x=1712765165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XA+Vkqwk5ZmbSNd3gdnkiwrGaLPpFx9rEooKDQQTGCM=;
        b=O5XdLoY7oaO91SomZN3ZfqDJYFf+R3YmwuY9l5ONypkjVKmzSXjOI8sPX9y/2zZdNi
         k/COntSk4uBhYPnw/nmJKlTvi+7sqph3Fo5FdqYqx1upo9Nqe787H+ZBbzsKVE8y/x0J
         gni9Mw+vDsj9h9EHDXzXlhEXj9RHeTOT+0njGS9dJIK5VzYC/mFcJAHcu5KPEIKbvpZL
         ue5csWU0pUjBEuzxL+0bBC0utJpsKd3iZSw5nUdzQzFqfqwPPVFbW9vge3Css9hZkN8g
         7iV6ekxEpOHYVeAV/vB9XG5nSsCCbkBvmYp6afyyGkMOKeljExFt4rzxV/VTzw4tRLSs
         8Y0g==
X-Gm-Message-State: AOJu0Yw/8hCrG2GQIBe3BJJyjFeqSGQY0HPME6QWXdgVPDoZKPdzT7JP
	atmjBD8XA+1A0pxtwB2HxqkSwNkNSiPwTqGG6ybHOcr0Es5MTE+9lNTS/AtV
X-Google-Smtp-Source: AGHT+IEeibc2qm+DaltVWf1Mpa5tD17jXmYkoj9+C95bH+CxkxtcM04vZAxIjBgYG9SWzKt+qjedHA==
X-Received: by 2002:a9d:7603:0:b0:6e6:6d42:c61 with SMTP id k3-20020a9d7603000000b006e66d420c61mr3347207otl.16.1712160365561;
        Wed, 03 Apr 2024 09:06:05 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id a15-20020a056830100f00b006e6b018a703sm2653635otp.79.2024.04.03.09.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:06:05 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 09/14] tools: lookup-apn: add support for optional tags filter
Date: Wed,  3 Apr 2024 11:05:32 -0500
Message-ID: <20240403160557.2828145-9-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403160557.2828145-1-denkenz@gmail.com>
References: <20240403160557.2828145-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 tools/lookup-apn.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
index abb95f38f470..e4fc79cd7819 100644
--- a/tools/lookup-apn.c
+++ b/tools/lookup-apn.c
@@ -26,7 +26,7 @@
 static const char *option_file;
 
 static int lookup_apn(const char *match_mcc, const char *match_mnc,
-							const char *match_spn)
+			const char *match_spn, char **tags_filter)
 {
 	struct provision_db *pdb;
 	struct provision_db_entry *contexts;
@@ -50,7 +50,8 @@ static int lookup_apn(const char *match_mcc, const char *match_mnc,
 	fprintf(stdout, "Searching for info for network: %s%s, spn: %s\n",
 			match_mcc, match_mnc, match_spn ? match_spn : "<None>");
 
-	r = provision_db_lookup(pdb, match_mcc, match_mnc, match_spn, NULL,
+	r = provision_db_lookup(pdb, match_mcc, match_mnc,
+					match_spn, tags_filter,
 					&contexts, &n_contexts);
 	if (r < 0) {
 		fprintf(stderr, "Unable to lookup: %s\n", strerror(-r));
@@ -78,6 +79,8 @@ static int lookup_apn(const char *match_mcc, const char *match_mnc,
 			fprintf(stdout, "Message Center: %s\n",
 							ap->message_center);
 		}
+
+		fprintf(stdout, "Tags: %s\n", ap->tags);
 	}
 
 	l_free(contexts);
@@ -92,22 +95,26 @@ static void usage(void)
 	printf("lookup-apn\nUsage:\n");
 	printf("lookup-apn [options] <mcc> <mnc> [spn]\n");
 	printf("Options:\n"
-			"\t-v, --version	Show version\n"
-			"\t-f, --file		Provision DB file to use\n"
-			"\t-h, --help		Show help options\n");
+		"\t-v, --version	Show version\n"
+		"\t-f, --file		Provision DB file to use\n"
+		"\t-t, --tags		Comma separated tag filter\n"
+		"\t-h, --help		Show help options\n");
 }
 
 static const struct option options[] = {
 	{ "version",	no_argument,		NULL, 'v' },
 	{ "help",	no_argument,		NULL, 'h' },
 	{ "file",	required_argument,	NULL, 'f' },
+	{ "tags",	required_argument,	NULL, 't' },
 	{ },
 };
 
 int main(int argc, char **argv)
 {
+	_auto_(l_strv_free) char **tags_filter = NULL;
+
 	for (;;) {
-		int opt = getopt_long(argc, argv, "f:vh", options, NULL);
+		int opt = getopt_long(argc, argv, "f:t:vh", options, NULL);
 
 		if (opt < 0)
 			break;
@@ -116,6 +123,9 @@ int main(int argc, char **argv)
 		case 'f':
 			option_file = optarg;
 			break;
+		case 't':
+			tags_filter = l_strsplit(optarg, ',');
+			break;
 		case 'v':
 			printf("%s\n", VERSION);
 			return EXIT_SUCCESS;
@@ -138,5 +148,6 @@ int main(int argc, char **argv)
 	}
 
 	return lookup_apn(argv[optind], argv[optind + 1],
-			argc - optind == 3 ? argv[optind + 2] : NULL);
+				argc - optind == 3 ? argv[optind + 2] : NULL,
+				tags_filter);
 }
-- 
2.43.0

