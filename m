Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4D14A83
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097065; cv=none; b=qeMvykbtH46RgX9mnbrNx+bj5xkxwyetXG8zSCffzBliAS1iAueag19GczR8vIScELogc5XInLbphlO2UIdZS5ctVvpJuTRHHkZGAJzqD0t6W/w73GvV/5HVhyHrs+AJP3zF5kUVdepneRKaaRhxvYVqAFUz7ELlaNUM3+gNe+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097065; c=relaxed/simple;
	bh=puDK51IZNmptQzOyxED4XtoZxV2LzQQk/y+n2KNzKKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIMnRojM4ZKcJoJMwlAhgi2YXOavRAr53wZZ3A7WM292rAWqVWNt+m8ileYU2Flyg8lNdQzHrl23c9SsAmJDcfev0bxJba4x95od1Dy7c6bOENLj7cHobTyKXCRckcJWASUP4qshYl5T0ei1uNUigYjK1EBCsSVuBv8Fy+p8Hzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SET+VGbX; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SET+VGbX"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a7a4119d02so1952042eaf.1
        for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 15:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712097063; x=1712701863; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA+Vkqwk5ZmbSNd3gdnkiwrGaLPpFx9rEooKDQQTGCM=;
        b=SET+VGbXhcBXGeE6/aFmacW3Hi8wH3ZlrCc97oCRduzKuCxb5Q7Cve6LFxyEs/vl3F
         hXSVup4A0knJPBpaLXrxDkpYhK82IXPNE6vzRtaz6fHg8Ho9s4KwbNS5cPv3pAWIH9gh
         3+u7KVJK/oRfs9UnqyiAhfkzhFY7o3yjLjIHYjUgeltRM0+FTitgu0OdWsJJCVJWSoXQ
         AcXYE/pJ0cm24PZhrPgG1OSiDla/NqarNCY1rFiETCkMWzJbAl7GFaEbMztuPz1XIdOs
         ze7VnkqXOp9JR9hgruIDGwXlzK256TIhV4MACFYXVb+V3nNP73HaKtwlYrwvBi0qAQxC
         O75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712097063; x=1712701863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XA+Vkqwk5ZmbSNd3gdnkiwrGaLPpFx9rEooKDQQTGCM=;
        b=mdGnX9QCp1mJOYuJaFEun68sjtdGFUD1g8gQ65dL/aL06Wa5NW3qNChmCSBfO01GzF
         5pfR8KZR93VwJiRZ94vbXyEKaaNCPq+DEufk4yjIQv7cB+9iJXFmop3P2naOkxgbrUuS
         orcnOIQasA+3N/hK+AcTmFZIMOIoO+HDf5ZQSeQ+DR9cIPBHEfLvtagNL1RH5C2qRxrV
         iVNjkzAin0TdSyqTJWE1pq0JazwGtV1gCeX+RX6ldD/MhyW5jMt7HK3qz04eEQ/I7wCu
         o1vs2dRXNSvSlPGltwjh1OP2DtiZn6kXwYIkfFmLiJ9IhzjEDR2Xpg7PMtpbZkFB9A43
         gvzg==
X-Gm-Message-State: AOJu0Yx/Qo/CNv93i89CE/IKVwUd825Nz7fQSEO/vHZmI1cTb9tKd63d
	2pTyp/JNTgwQAOKqR4W265mESR9SEAn/luDwgiyjJlB3+zkWduBClKte48Ie
X-Google-Smtp-Source: AGHT+IFq3GtPbIdWZ5aw6NkkkZ1LFm3PH82rfYDOgtshh3/XQKQ1H0nxS9PJ+oe4bhEf5P0qVlrnog==
X-Received: by 2002:a05:6820:2108:b0:5a5:639a:2fa0 with SMTP id cd8-20020a056820210800b005a5639a2fa0mr13406319oob.0.1712097062881;
        Tue, 02 Apr 2024 15:31:02 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a58b8e4b1csm2956204oob.7.2024.04.02.15.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 15:31:02 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 09/13] tools: lookup-apn: add support for optional tags filter
Date: Tue,  2 Apr 2024 17:30:34 -0500
Message-ID: <20240402223054.2819526-9-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402223054.2819526-1-denkenz@gmail.com>
References: <20240402223054.2819526-1-denkenz@gmail.com>
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

