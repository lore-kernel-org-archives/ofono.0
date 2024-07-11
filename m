Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAA22BD0D
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716419; cv=none; b=WqfPisdWYITjMcaOBm30MdAHVQw/A9Ni2uXqxr7ngk4JwuphGE0b60Rje0yPK8CsN3l7sWh2eU100/cSGI+71tOC8L+gLD4saJ7T+d8EAxH8PsmQ7YDsURxU5wC3uuK+o4pd6i0qqSuwn2hVeewNFw9m0yDRFAlxmziIMhN4DHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716419; c=relaxed/simple;
	bh=wfPyMVc1no48+4NSXQvYmejdCnpmG5oYN9pZDboeeWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3Sl6D7IUEenGlV7eCA28/rANtvnP2EOhUzP6Gq1xBZcvKezC3inPTDjQVEVBwjwIL3bhBQLcZbaezvZB8y5NUyftNJj/bmf+TyAMPwEtVf47bIBL7ld8OoCDkPSoh9F4ZJkov1vgXfnPOYEvRgDwqCPhYkHfj7bmfLwEKV33Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9mLTYrL; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9mLTYrL"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7f684710ff5so39260539f.1
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716416; x=1721321216; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LO6WYGzE8exszVB8f0IkjMEpM9McoNa/R/qKXAw7geU=;
        b=i9mLTYrLG+zxMV/I7S1/VXQbjrDNv0Ky/BZf1hkUJmVYSaFsV2qXxBGB7mV2cgq0yt
         1wA5TyyRPvdRKEw2auv+V3v8L7370Oe3glZqK908In2QyROwWfmdLc1ouz7aQ8LtScH2
         QUlU1G0a07gkiYokdvfbgrhy+AUirBw2jmnJAk+g0hcQyLGhZgUkt8N4rQHm8Qp6h9OY
         AYLLdMLTwS5Q43CcyDp29MQGJ3ArR3OMZj46N9or/GUn0k0LH7SgvyV+pdyB4l+ru1G+
         00X7OFma2TIB2NkYlRjDglg36mYS07jYdWTyX6cwkOCWnLCPDwOY3vPuzCgF2KNVXx58
         zHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716416; x=1721321216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LO6WYGzE8exszVB8f0IkjMEpM9McoNa/R/qKXAw7geU=;
        b=crkk6toUI4BjArAjT4XA/uBHuC1t1K/IlvFKBBjPASNtsKu8HDurJ/iDksreKcvUh5
         a4jsFDS8U1ql7Oi5/NE0iBtTr2aY+dSDI00VurB+L8YIbADHUQuwXWLu/e63QnNHBZuc
         kqmhIY9hq3VEv6GYWBT9R6iBEDl76NiT+79nTyFdnt1ExPsq4JiX1eCo7UhYsxf7jS3D
         HgjMUKFCBOtsXnSdHsHXhAuxK03aeW59bdkNWtYA8oVYQp1WwM3zIBdSOTfDCf0VSApP
         7ReoytNi/86zFw1YdY+mZXxc61UrlyMEoBGonoWGMOlarnw+lIUr1n/zzsdNIoS+HE8i
         vt2w==
X-Gm-Message-State: AOJu0YxbRLsh1+5HDoB4N/zT16uLMtIZrWe8kqRVfPvWlJhOOopOT87T
	uhCRxV5w5ob1I72gZLtNyYwzQjlhPKwfyQv6Ja8YWTRAGW5RMZWcaI6D0g==
X-Google-Smtp-Source: AGHT+IEl9HkABgofm5L+vuQBvrfzw0J4ZnbP6fQkiqhQGOkQfJgyDfma1rv7H0xgnTOxPx6FMROuyg==
X-Received: by 2002:a6b:cf08:0:b0:7f9:510b:6078 with SMTP id ca18e2360f4ac-8098d903444mr12819339f.4.1720716416547;
        Thu, 11 Jul 2024 09:46:56 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffed680fa4sm194096039f.46.2024.07.11.09.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:46:56 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH v2 02/11] build: Require at least version 0.67 when building with external ELL
Date: Thu, 11 Jul 2024 11:46:19 -0500
Message-ID: <20240711164654.1688558-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711164654.1688558-1-denkenz@gmail.com>
References: <20240711164654.1688558-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcel Holtmann <marcel@holtmann.org>

---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index b14ed9e99c56..c0053df840ae 100644
--- a/configure.ac
+++ b/configure.ac
@@ -247,8 +247,8 @@ AC_ARG_ENABLE([external_ell], AS_HELP_STRING([--enable-external-ell],
 				[enable external Embedded Linux library]),
 					[enable_external_ell=${enableval}])
 if (test "${enable_external_ell}" = "yes"); then
-	PKG_CHECK_MODULES(ELL, ell >= 0.66, dummy=yes,
-		AC_MSG_ERROR(Embedded Linux library >= 0.66 is required))
+	PKG_CHECK_MODULES(ELL, ell >= 0.67, dummy=yes,
+		AC_MSG_ERROR(Embedded Linux library >= 0.67 is required))
 	AC_SUBST(ELL_CFLAGS)
 	AC_SUBST(ELL_LIBS)
 fi
-- 
2.45.2

