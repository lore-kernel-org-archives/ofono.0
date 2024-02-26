Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515714A98
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918652; cv=none; b=uywc+Bi722S7FdHieVfkwdC5AztUELggHa/99bSeTlgBmJh6v44y98e6YAgZGVdCcTK81/ZGpDjOs6767YWRMlpL9Gkwi5cO3NxbtOhN1G7/EWxj+GAEhO0Y0fU09BLr5PqjiWAc7p1CAdCAeb56RZJG0B4pCMvYQA8QhCw/uI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918652; c=relaxed/simple;
	bh=5jlb4cx3qFckg/BgWDhKh8kYCi/u1w+u2cmE6jQGUhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEL7quHNUrvSggzxXoeztb2Eg8smqCmwPRwt/VYhbcPD8swEgAg/ZsnhWQcprDMZSty7cuUytkcjEpx3zrtOqpcH+58jkDqqUNalME3X9DLy7VG1rPkTVBN+6FLLbb2D9TAmTjaeM32jFwuxCu2o2Nc0WS9AmRvZIH+eidToLOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkJS+S0u; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkJS+S0u"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e0f43074edso1859641a34.1
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918649; x=1709523449; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vdD9yIKOL3TE8dSsdKe6lPckjCuUF3cIIacHEeqUIg=;
        b=QkJS+S0uBf/Z7rkCNQo+JPUPnr4AL+q5pDtgqEc2zmQZuz2FcG4tktiDJWqkJ+67Q9
         K1mYesma4p6rtxOx/wdynbDTDOmOsJ0NWn/+JnRjKVf2nftVoY5uXi5p525iaEkwrLJj
         f0AO6ij5n/8nvhfAKavwg+6sMt0sgFJthifeEUrCId1S1IzymC3+Hoj54a9ttkqYXJEJ
         alZzm3XHnGqOIF+711fyzstiisdl7auKGAB2qPxfeY3+jzTvxJ/T+0W+pgDhwJBJPexE
         0wCaQWpPLZt5bu7yRXZP8Mjen1HKDozYVEupfCmQie5K8qYD1qLX8WAZ14UMZQ5P6ycL
         0j2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918649; x=1709523449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vdD9yIKOL3TE8dSsdKe6lPckjCuUF3cIIacHEeqUIg=;
        b=WVImpDBanFEyLyltudGwC2Q9g4Ybw2GxpKEsXv4+TUJ5U7k6YDNNfMUPBqqsUHZii+
         i10xZN7s9FlcQeO3ARcukBq78PpZlI1fintpPihmE3NucWJ9tI1L7zoyqtf5f28HRuXO
         k3hTjz/vrcoLQ2AYvEVIGww+adBaBRlMYgo2HzJwBl2D0nsFIge4WE4aL4UjWWDJw9UL
         Gx19jfUPWJtDWeAYGZSYjJQZwxpUzYXGM1UIod0DkWIwxVrg719MDSVCeMH8xlJ0eXlR
         hKthFsk14c7wPGThQOP5t0XT6EYErxST4gZ2Bvn1nuw0aHFjyuX+XVVkNguPfE45Ou4B
         +65Q==
X-Gm-Message-State: AOJu0YzcBtW3DtWTVU2YgGOqRyse5HOlObmgd/LxqszjadsxMWwTRy/e
	bL9y1anGPAQx0Z73mvfy+uC4O+mYPpgKasuZpq0j1Up+R0YYJjNbDNV6tI7D
X-Google-Smtp-Source: AGHT+IFveooqVlnqDIGMgvDJYc2ENwbp9SozRLbwKTzVpoBQF2MZ4eQerPW/liPHA03UGF4xahvnYg==
X-Received: by 2002:a05:6808:188d:b0:3c1:5d8f:5234 with SMTP id bi13-20020a056808188d00b003c15d8f5234mr6600800oib.43.1708918649360;
        Sun, 25 Feb 2024 19:37:29 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:29 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 05/22] main: Remove g_printerr use
Date: Sun, 25 Feb 2024 21:36:48 -0600
Message-ID: <20240226033724.1460079-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226033724.1460079-1-denkenz@gmail.com>
References: <20240226033724.1460079-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace by fprintf(stderr, ...)
---
 src/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/main.c b/src/main.c
index 82157700b6ac..141853eef8ae 100644
--- a/src/main.c
+++ b/src/main.c
@@ -210,19 +210,19 @@ int main(int argc, char **argv)
 
 	if (g_option_context_parse(context, &argc, &argv, &err) == FALSE) {
 		if (err != NULL) {
-			g_printerr("%s\n", err->message);
+			fprintf(stderr, "%s\n", err->message);
 			g_error_free(err);
 			return 1;
 		}
 
-		g_printerr("An unknown error occurred\n");
+		fprintf(stderr, "An unknown error occurred\n");
 		return 1;
 	}
 
 	g_option_context_free(context);
 
 	if (option_version == TRUE) {
-		printf("%s\n", VERSION);
+		fprintf(stdout, "%s\n", VERSION);
 		exit(0);
 	}
 
-- 
2.43.0

