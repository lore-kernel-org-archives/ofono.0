Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC2563B3
	for <ofono@lists.linux.dev>; Fri,  9 Feb 2024 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707520252; cv=none; b=onAVZcmT/8blIje6Ad5gJ4W8UhYrLMVGjjQFYotK2UvBxTyMItHy+w3+6URpCiOvk+o2+q2i2nVRXFRh6K7MlGeQiIEyU/gAwSrt/QopK0imnmE3YU2VCB4lKRg4m4YaXuNM4MYMfklpynp5nzSCPdbFJSogmfYWwbBls3J26VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707520252; c=relaxed/simple;
	bh=Crn1b2Ohiz2sQI2fio+8o+QIu3tmUwjDiXNxhHXmIGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZWIZVgE2EiMGh4npnOB8dhpRupmaLBobNVCP6nq6t2igtYBhb0gAsCmrxxVqPHAdXzGdfhhMFppY6KQMotQi0M+XpldhjS4nKiqmHEyQS3JKa+iUP8CG5rCCJbmTtE4upT8xzWWeSLKIbr8Q5j6vXiMnj+rSivChWZ/EZW0IJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lssm6odt; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lssm6odt"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2143a96d185so616447fac.3
        for <ofono@lists.linux.dev>; Fri, 09 Feb 2024 15:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707520249; x=1708125049; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7S3jdoxsrLy6E675l+Xz7HYlnkCFMMcIM10mNU7ZfUQ=;
        b=lssm6odtq7nVwShtNJ4m3DGvmGFWcjp6UPpPR+vJmQXRJDRDPB6ky5SVU+XHhMPd5B
         xL9gn6hUTTgCh+6er4VYi43/pIcpX9ApJM1KLJvHo3TTehEEh41roPy5ox/z3spR3izA
         +hxdn2YMaTHth3GZeMpNWJioNt/mrkSDI2YAsHeXNYSVnjfFBhPvC4Sos/Hqu0/MY8g/
         sOaz2GfyjF9Imjq9nmpovXgS3UyE7JMmWcg4eUjOL0HTYCAkCsdZUpaTX/BaRjrKerUI
         NM0OlUdmOu/6z1dsryCxTEccdkFnilLAvF39fPsaE7dMkdnOBZVY5WE17BSBbFMbkiSd
         t8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707520249; x=1708125049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7S3jdoxsrLy6E675l+Xz7HYlnkCFMMcIM10mNU7ZfUQ=;
        b=QS+NVQO5Z3cz1K6QrDS2B+7hDy3rgKlqZr11euT1EcUUN/RGugrCYTl0k/41PDBVD5
         jTU7SCqD+243qz3VdrQvY8BUfNDbIt3rC9ioht6OOjqNxiN1tFFLIyRZ8nWErSzcaJvG
         ZQIfhZnjiLIrzCuZbZijWz4ZVApFVqvc2axXO3LDJm9h5Xg/rPKfhOFWPVrzTXDXG6z9
         R8Hr7nUBU3g0HbT8Ofc4x7mVBPm38c8I3JZyP9QNTXOquhYwQBWtp4ZtYJ0bhpJPt5G2
         gDwwjwYCVlvJfLObCYGbHryaemzblCXFi2ieHbIptWl4KwiPHVa6fNMn9oCr+9BdAdwm
         cn9w==
X-Gm-Message-State: AOJu0YwfPR41lDPuJIqr9T04YWdqUr7hv9/QzhEc39uiQNit/duYwRWA
	TO17yW3Or0HEx3hrmgvhDfNnSEUlB7ZAJ/NTtocx6NnZayjry+xJQIxPhhZ5
X-Google-Smtp-Source: AGHT+IHWyp5eO6ShQxPtAWr8cyYMK+/feJk4ymAj6pp9tdUUQBBPTeSIM0XpwIyPmEoeoKIZTWC+XA==
X-Received: by 2002:a05:6870:355:b0:219:7981:30c0 with SMTP id n21-20020a056870035500b00219798130c0mr778126oaf.19.1707520249409;
        Fri, 09 Feb 2024 15:10:49 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id hi17-20020a056870c99100b002199331d8c9sm115689oab.45.2024.02.09.15.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 15:10:48 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] tools: Don't use f-string syntax
Date: Fri,  9 Feb 2024 17:09:48 -0600
Message-ID: <20240209231001.1041957-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some older Python 3.x versions do not support this syntax.
provisiontool only had a single instance of this syntax use and it is
easy enough to get rid of it.  This makes provisiontool compatible with
older Python3 versions.
---
 tools/provisiontool | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/provisiontool b/tools/provisiontool
index 792732778215..2067a66a9951 100755
--- a/tools/provisiontool
+++ b/tools/provisiontool
@@ -212,7 +212,7 @@ class MobileBroadbandProviderInfo:
                     providers.append(info)
 
         except ET.ParseError as e:
-            print(f"Error parsing XML: {e}")
+            print("Error parsing XML: " + e)
 
         return providers
 
-- 
2.43.0

