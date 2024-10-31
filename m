Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E791CDA09
	for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412410; cv=none; b=iigrx1Oi17Hbo8ygW358CpmGuhES69vhuUM9FhHAhZ+LFDe0h+iO2DgTs8LoRTOSXd6yqEBz0OwU6NlQiGqraCxjADSIjqp33Qlfu0ytxf+eyWSaanJ+t0cBz5424raVGd2DHQL3aMw//OelJyr06CsA+ON1XgEm7kymxUsH7/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412410; c=relaxed/simple;
	bh=uDe06164osw9CYJb6V1iemGNHKns6Qcn22xEhdN8t1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzvt+U23D3udU3Twg7gao3QCpIkGqj1nnSXdzLzmabXRYLcwxlitXupfOEZx6TMf6sUwGsooMqswdLDp1y2PB5T40JhgPxS2OWkveEFHbEwj0t0y7mJIWBgaZ9S3jMVOCwzHi4WSONQhOEJ/RdUFCL9QxZICA4j3nIOkKtnzXGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlddOOE4; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlddOOE4"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-718998df806so685183a34.1
        for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730412403; x=1731017203; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3qofAtWOyRgEnqgVCcOgCIpCuNkP2HLFxPh3ZhjXXs=;
        b=QlddOOE4UxGiJRGFyZPytetRtGstzUsN3inKPF6ga+i/mTWNVzQUF78MBwsmfOgC80
         sT16cwPd0B/a8tF9XRbfDrpnXUkEaWCKGGSLpSS6q5WzPS9F6XlSidymOO12kkMspatY
         9ew8NJKbqKItDi+8hjlwwpKK7EQYRO4LhP/qGyKL/W7qBOkDSXW6kkit+d8JR6a0ARB8
         QqPOmdpRq+Hd8Qpd9gCYPqFiY5FZpdCE14EGREZ++SRSG6cdKNi9sqL7IJ1HrmBryGr6
         v/ET1kIVgyyO1HQ2SCAbSrz5cIuHgb2oCRLwb70kwrLt8dXQ+FiGJ2e0rtumAHvRij2S
         I0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412403; x=1731017203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3qofAtWOyRgEnqgVCcOgCIpCuNkP2HLFxPh3ZhjXXs=;
        b=sJs58HI6INeZxbKXun6xKVWiiqW+3UrNAkdzis04GLZxB/F8l7X5KBj2gieegg8iwQ
         sgl9oxrUYgs11TkPFMrHqAr7d4RHyMnck7y9L4vEqOLE+SKBKmiBeB7SKrgUnwKSdgTa
         WIQDqxJrRfcFQ0qfjGpzvTw4C3INHSIMZW8s9Byd6LpKi5NVnibpCV7GWZKi5MbakfKj
         8KRZRiYlJu3WwpSfZd++OaFqKp1om0tt/2mpm076Gz8kKqkc+ods5WJfua5rXZUDy8cb
         ovmDgGGRyq3kS5IRY4Yb40jQKeL1nh3T7KylXOl1G9oVBzVpwBo6e6VIJ8BVGacejrh1
         9ZRQ==
X-Gm-Message-State: AOJu0YxlmrnnP22/bN0xuuuecQDF++rWkHVTJRN4aS+VYQc1pyCnMakX
	I8upASXlZA7Ah8qjxQBcXV7pgfIp9kT7GHriKFJunjTs0BHric8OCy9FHA==
X-Google-Smtp-Source: AGHT+IHkWx3UeyDHAK3XZjvxDkLRcITWstzQPzneufNe2zabpNb1i6tHVMZKGx/sAjNiSVVwaRpt9g==
X-Received: by 2002:a05:6830:4186:b0:718:d7c:2ef0 with SMTP id 46e09a7af769-719ca1d5640mr1680670a34.18.1730412403469;
        Thu, 31 Oct 2024 15:06:43 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cccf4a7sm507577a34.73.2024.10.31.15.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:06:43 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 06/13] gprs: Default CID range to 1..NUM_CONTEXTS -1
Date: Thu, 31 Oct 2024 17:06:13 -0500
Message-ID: <20241031220638.1582166-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031220638.1582166-1-denkenz@gmail.com>
References: <20241031220638.1582166-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For those drivers where CIDs have no meaning (such as non-AT command
based modems), set a default range between 1 and NUM_CONTEXTS - 1 (255).
This allows the driver to omit this method invocation.
---
 src/gprs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/gprs.c b/src/gprs.c
index 3c71f8084417..c5287661b9d9 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -3082,6 +3082,7 @@ OFONO_DEFINE_ATOM_CREATE(gprs, OFONO_ATOM_TYPE_GPRS, {
 	atom->status = NETWORK_REGISTRATION_STATUS_UNKNOWN;
 	atom->netreg_status = -1;
 	atom->used_pids = l_uintset_new(MAX_CONTEXTS);
+	atom->used_cids = l_uintset_new_from_range(1, MAX_CONTEXTS - 1);
 })
 
 static void netreg_watch(struct ofono_atom *atom,
-- 
2.45.2

