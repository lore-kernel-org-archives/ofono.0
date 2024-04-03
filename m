Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD0614D6F3
	for <ofono@lists.linux.dev>; Wed,  3 Apr 2024 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160371; cv=none; b=FKIDEe5GsMejiar67NB7+H9+PcLWXCBwfTZ11oZxEyr+plnEvCZW7rD/4VZZRGFqv5NjODyIcJmGZgkgbFRoO9/B1zr6nj2BZv7O6/EyYkUm98fCOnNXmhjr8wvtSXJfOvfg30D5CaVn//w7CHJQejr2nLmmWY8WRFExOKmOYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160371; c=relaxed/simple;
	bh=Ni2eKAPrhadS+t2eupfN/yqehpuQqsHi06brvXa562g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvkbmKPaO8gfEQp3c4YqzFsLYJe732B/zoxNhz1Qm2PR/hWYYO1S5CaWns1X/Kz/NCTAnW4+KayCsGCZjuG0BMdSonDddU3U/Ma8FJawVNd9ZHD8wCcBWc4WUpUDma8tIFGPY8W0ENJwtmCFcQNJTgAHr7YCGzFO+TJ4waKrpQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MR9hxlXd; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MR9hxlXd"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e9de355513so3074a34.1
        for <ofono@lists.linux.dev>; Wed, 03 Apr 2024 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712160369; x=1712765169; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cz2HF2DC/Rfz2rRCK3lbTYsSKMT3bB6AMNf8f4S96wE=;
        b=MR9hxlXdOlx9g29CwhXYv9gKUKvWzaoGzfti0Exh5anIDB9CksltRzx7NjEaGMGi7i
         XEIjBug2q0p04pt4JB6g9AHVdutxcy0odKgOXCabxRQhFT9PjCfIOu6FBVaTAPqIv4iA
         GOFGL3HjoPTWjaj0X70SnGkthkvZz8eAO4n1Hn5quoMMwasjpUMZ0oVx8xv8708CZCy/
         xhiTStx5LoE0vuwUiZ+kUo1FjC4oaTqUukxOOsfPcx/L3iLqKE3gU63L8UBMiGtCztFN
         lyhH2+fELDVP5EekbLgeVf5H/qeNS9oP18lqOMd0gasc4jfwl6PjVEYBVRmdGKP/rz2S
         SEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160369; x=1712765169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cz2HF2DC/Rfz2rRCK3lbTYsSKMT3bB6AMNf8f4S96wE=;
        b=uHn9WEqVfQ1iVFZ2BZjkAhKKbSbEyRkLCKnpDO98HOSOR6yRn0IXgj6nlse6ZwOnyk
         J7xImDjaQm7fzDO1aL1niIJDD1PuHAD8SKk+Rz06/wfWU+2bbp3XUKrikGJs2aSwANfq
         ol5JFPhDJQA8tepwX6kBOkJOtIWVxCVWwx+aOdP9BpldOAVmh3xWzh1zeZcNzaqLmVlj
         R3F1a6XIgiqhEa8SCEfsqONa27FrqB5GgzgYTEXgwvimOy6cqQA6z9/vcEWG7MybZM/M
         un7Au6xrirSEd5x5Sj7GYKG8+9upQ2zdCDE4A4ci8ojRefVteWodhzbmbBRYa4bQFw4R
         j1GA==
X-Gm-Message-State: AOJu0YyI1qAKxI4m/5LcEwxnBHbfkcR3xQ7+aNEiQloIYI5/QyekHCAE
	MstPk4un5fx0OsOJTlSlwvUUsdi5jJc0FTGSeG6x5qVKq5itckysJ6XYBDd/
X-Google-Smtp-Source: AGHT+IFUiVXr9QHyao/oS4CIeRKGblx9CItOoMjmp4sdCYwA6zMnOBmqgj1VxqKGd6ZOXntn+ENKmQ==
X-Received: by 2002:a05:6830:32a8:b0:6e7:6ac:2442 with SMTP id m40-20020a05683032a800b006e706ac2442mr16901588ott.24.1712160368728;
        Wed, 03 Apr 2024 09:06:08 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id a15-20020a056830100f00b006e6b018a703sm2653635otp.79.2024.04.03.09.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:06:08 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 14/14] unit: Add test cases with tags_filter provided
Date: Wed,  3 Apr 2024 11:05:37 -0500
Message-ID: <20240403160557.2828145-14-denkenz@gmail.com>
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

Replace the XYZ operator contexts with a set of two.  One tagged as
'lte' and one tagged as '5g'.  Add logic to the provision unit test to
support filter tags.
---
 unit/test-provision.c    | 37 +++++++++++++++++++++++++++++++------
 unit/test-provision.json | 10 +++++++++-
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/unit/test-provision.c b/unit/test-provision.c
index b80f4d80fa0e..d251f31b148c 100644
--- a/unit/test-provision.c
+++ b/unit/test-provision.c
@@ -57,6 +57,7 @@ struct provision_test {
 	const char *mcc;
 	const char *mnc;
 	const char *spn;
+	const char *tags;
 	int result;
 	size_t n_items;
 	const struct provision_db_entry *items;
@@ -114,7 +115,7 @@ static const struct provision_db_entry charlie_contexts[] = {
 	},
 };
 
-static const struct provision_db_entry xyz_contexts[] = {
+static const struct provision_db_entry xyz_lte_contexts[] = {
 	{
 		.type = OFONO_GPRS_CONTEXT_TYPE_INTERNET |
 			OFONO_GPRS_CONTEXT_TYPE_IA,
@@ -124,6 +125,16 @@ static const struct provision_db_entry xyz_contexts[] = {
 	}
 };
 
+static const struct provision_db_entry xyz_5g_contexts[] = {
+	{
+		.type = OFONO_GPRS_CONTEXT_TYPE_INTERNET |
+			OFONO_GPRS_CONTEXT_TYPE_IA,
+		.proto = OFONO_GPRS_PROTO_IPV4V6,
+		.apn = "xyz.5g",
+		.auth_method = OFONO_GPRS_AUTH_METHOD_CHAP,
+	}
+};
+
 /* Make sure mccmnc not in the database isn't found */
 static const struct provision_test unknown_mcc_mnc = {
 	.mcc = "994",
@@ -204,13 +215,25 @@ static const struct provision_test lookup_charlie = {
 };
 
 /* Successful lookup of XYZ (MVNO on Charlie) */
-static const struct provision_test lookup_xyz = {
+static const struct provision_test lookup_lte_xyz = {
+	.mcc = "999",
+	.mnc = "11",
+	.spn = "XYZ",
+	.tags = "lte,unused",
+	.result = 0,
+	.n_items = L_ARRAY_SIZE(xyz_lte_contexts),
+	.items = xyz_lte_contexts,
+};
+
+/* Successful lookup of XYZ (MVNO on Charlie) */
+static const struct provision_test lookup_5g_xyz = {
 	.mcc = "999",
 	.mnc = "11",
 	.spn = "XYZ",
+	.tags = "5g",
 	.result = 0,
-	.n_items = L_ARRAY_SIZE(xyz_contexts),
-	.items = xyz_contexts,
+	.n_items = L_ARRAY_SIZE(xyz_5g_contexts),
+	.items = xyz_5g_contexts,
 };
 
 /* No match with for an MCC/MNC present in the DB, but no wildcard entry */
@@ -224,11 +247,12 @@ static void provision_lookup(const void *data)
 {
 	const struct provision_test *test = data;
 	struct provision_db_entry *items;
+	_auto_(l_strv_free) char **tags = l_strsplit(test->tags, ',');
 	size_t n_items;
 	size_t i;
 	int r;
 
-	r = provision_db_lookup(pdb, test->mcc, test->mnc, test->spn, NULL,
+	r = provision_db_lookup(pdb, test->mcc, test->mnc, test->spn, tags,
 					&items, &n_items);
 	assert(r == test->result);
 
@@ -270,7 +294,8 @@ int main(int argc, char **argv)
 	l_test_add("Successful lookup (Alpha)", provision_lookup, &lookup_alpha);
 	l_test_add("Successful lookup (ZYX)", provision_lookup, &lookup_zyx);
 	l_test_add("Exact match (Charlie)", provision_lookup, &lookup_charlie);
-	l_test_add("Exact match (XYZ)", provision_lookup, &lookup_xyz);
+	l_test_add("Exact match (XYZ)", provision_lookup, &lookup_lte_xyz);
+	l_test_add("Exact match (XYZ 5G)", provision_lookup, &lookup_5g_xyz);
 	l_test_add("Exact math (no match)", provision_lookup, &lookup_no_match);
 
 	pdb = provision_db_new(UNITDIR "test-provision.db");
diff --git a/unit/test-provision.json b/unit/test-provision.json
index 61d060ad4def..fcf82a67bb67 100644
--- a/unit/test-provision.json
+++ b/unit/test-provision.json
@@ -85,7 +85,15 @@
         "apn": "xyz",
         "type": [
           "internet", "ia"
-        ]
+        ],
+	"tags": "lte"
+      },
+      {
+        "apn": "xyz.5g",
+        "type": [
+          "internet", "ia"
+        ],
+	"tags": "5g"
       }
     ]
   }
-- 
2.43.0

