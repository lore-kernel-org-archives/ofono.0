Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579447FBA9
	for <ofono@lists.linux.dev>; Wed, 13 Dec 2023 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5d7VfEy"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3b9de2332e3so5097120b6e.1
        for <ofono@lists.linux.dev>; Wed, 13 Dec 2023 13:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702504342; x=1703109142; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GckDHAAXjIDXvCmCp7SE0lE8M0eR/e2fqstu5GHWGJQ=;
        b=A5d7VfEy3RX1pROmEDheBkFBTH9hb4jS1fDBEdGSczwCRkW0I2KndCVQNeLXr+vTI8
         x3CK6C+kLDDgadEqUH2Bdq3NXA8Sz2XajuFiGlLrNsZKDlTSrM1TpbzAu2D+4mD/AUAc
         9G3YAbxFf/ZqgrxwIUObEmilKEE4USqqQg60u9dsNUct4dBCk1zcPPakrhOQqlugaHyC
         a2eupQaDv13ttHdysveuUcrWkA/LD7tGFbxtaGm1+2Z8Sae8uHHfyauBbZicHCNx5tL1
         OpT1J53TGexQk/HfgLdmJj5F7nkQMrHENwtKxGUaxtrXGqt5VKVdVBH93n9sQyKXpKQl
         P0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702504342; x=1703109142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GckDHAAXjIDXvCmCp7SE0lE8M0eR/e2fqstu5GHWGJQ=;
        b=K5gjfTiZ+JWvUfGDKys9j8xeNRkdZkiMRJ3BZASgomYVyOmCmWVSK5K/i/HZnIq0Tf
         C6m7YcAPAhSADg4vezn8PBv8/8+vH5Wl1Glo7UakGtK2DqhlVC++Fw5B++vYx9+cC1Jf
         Ipo4PSlc6UelPwXr3RfVlaDnaFvtmyWFp3QVLWHaThC06+StcvXFoz7gyLaUuLvsUslj
         5Hm2WJJaQBVk6pPFVuISEs37SCFdvd49s//+WM4hXQxe/fKeFDGAiWtGH4GZvDGiPBnj
         N0cpgk3z6mFHGH+VR7t1BHfUVSZFgGiD2gHsLvnCj8AsWBxlWjS0777OIxToLQVKdMTw
         bX6w==
X-Gm-Message-State: AOJu0YxLhNGN7ukZy1x3qKUagclyZ/fl1805ppXyNEyPWBLigcfV6ENB
	bv9urI328msPbhWDvPcZM52AMHu/Q38=
X-Google-Smtp-Source: AGHT+IH3ObPb118DidIEBLBfAFuyQLX0rEzPIDgmfxtLDIehvKfDe/ICxX2V/Wh6gzAL/pZ5V0E0bQ==
X-Received: by 2002:a05:6830:20cd:b0:6d9:dbe2:5ec2 with SMTP id z13-20020a05683020cd00b006d9dbe25ec2mr8324330otq.69.1702504342115;
        Wed, 13 Dec 2023 13:52:22 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n18-20020a9d7412000000b006ce33ba6474sm2925612otk.4.2023.12.13.13.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 13:52:21 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/6] include: Allow multiple context types
Date: Wed, 13 Dec 2023 15:51:26 -0600
Message-ID: <20231213215132.287577-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213215132.287577-1-denkenz@gmail.com>
References: <20231213215132.287577-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 include/gprs-context.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index 75958284..81055d89 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -33,10 +33,10 @@ struct ofono_modem;
 
 enum ofono_gprs_context_type {
 	OFONO_GPRS_CONTEXT_TYPE_ANY = 0,
-	OFONO_GPRS_CONTEXT_TYPE_INTERNET,
-	OFONO_GPRS_CONTEXT_TYPE_MMS,
-	OFONO_GPRS_CONTEXT_TYPE_WAP,
-	OFONO_GPRS_CONTEXT_TYPE_IMS,
+	OFONO_GPRS_CONTEXT_TYPE_INTERNET	= 0x0001,
+	OFONO_GPRS_CONTEXT_TYPE_MMS		= 0x0002,
+	OFONO_GPRS_CONTEXT_TYPE_WAP		= 0x0004,
+	OFONO_GPRS_CONTEXT_TYPE_IMS		= 0x0008,
 };
 
 struct ofono_gprs_primary_context {
-- 
2.43.0

