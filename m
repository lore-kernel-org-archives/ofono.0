Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13F778B53
	for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649759; cv=none; b=HngycLcSo7erTHwFxf5plF77Y2uIArHqoRQKtWcGxAamswDUOlPurYg+M5g6XDxyVz/IaSDEApL3OT32Q8sHeI70RdHeLcjzpKYp1uT70Ulm8BtKTmPbOtvfab5PE4BNK8owe1QA6EVX9UsonCXXS14x1MfDrNQOH+JPqB6NRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649759; c=relaxed/simple;
	bh=aFANccxePynoAJB7yKTQzGpbqxQl0W1cspHAtif3CN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kr3nWptzmz4v6E0mxDIEqHIyNDQdcfoSrVUswLQPczOVTvJDis07vuJkeh0ANYDdBSe5AqhXCgZuJZgJn/1eYaJC+j8rhF7j8mzxR5r7/JakJZ0gDOr+Cp2epDND7AuUUZQlV2nkyOya9p+z5arJ4T9/NnYtYJ5cl4/XcC5EGRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7yQxETE; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7yQxETE"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3be61123c8fso1375221b6e.0
        for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 13:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649756; x=1707254556; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leoBmhEqct4rNkQA+tsmAqJiN6/EiQ2Jc++bg5qXugk=;
        b=Q7yQxETErBZmN3c1V/rrTMPLLYV0b4FyIU/Cf3PSrqbJY3ECvUwj4AtCslxm0T7M9U
         OuBWK/586JIosjjgxl/sRIyPt0qJkNQ81KUIg9yl4erRKLb+Na4OBYL0fpU+lhhZ43Vf
         RqkyiPP3uywDMui0JLq4RtELgNjljyh38mTt/G4vadanwxFSaezB3MgIpINemT4Jfms2
         ipPZ79eVurpzLXIY8bkoEfOEcQ/v6CK1DqvUHO1jYvV7dByyyPib30ukPnGpT4x2bnat
         +VQwtOoFuB1+8HsGm1NY1YGpwMMXwrUPIe3/lrLwdt9X8wI8N30uf0VLT6+zQLZM8KLn
         TvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649756; x=1707254556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leoBmhEqct4rNkQA+tsmAqJiN6/EiQ2Jc++bg5qXugk=;
        b=QnA+blTzivL/k8nvq1Ta56+VBdZX+XoDzMvgZjS7OJlGmJVTgnsbPGbdHspJjD8rS3
         2EkCbsJqClAM5hCCU7tNnZ8wKt2JdzN/z6t4Blmim1vOEOzabkoDbMDy0aFUg+ytJYuw
         yOgnEASiaO/bVUYzFqS1LS4agRVrLsG/XoTg7vjbz03xwhgpCnlUi4891mhfQT1AfjFO
         dHOTxgTknTx3PiqlOoxFkl9pthFfzZjkIHhhwU8EMsIdlydVL9h3x2LsdLzNOf0wSB9j
         7xTeW+nkxArgyf+zykY2dF+6DSyplQmtKMNxL0E13Rk6EqL2TPZP/Tf+KCVpYgpbWxIQ
         9Hkg==
X-Gm-Message-State: AOJu0YyitTGRXVxT53+0wCFYXRrT88/mNOk8HyHYwTl3zOgB/itObUx8
	dl6fkigFvxDoIuPuhkw4dNJ8NX2HjDl07Wpln24IAc9JVd1WvfBEiHtFJSrf
X-Google-Smtp-Source: AGHT+IExfTKYhSVMUMTgQyok83n43bSIJMprXnWqvUVcjPCA6VUjU5/UqpWftE2stR/rjznz2OpRGw==
X-Received: by 2002:a05:6870:230c:b0:218:b0f4:6c72 with SMTP id w12-20020a056870230c00b00218b0f46c72mr2194356oao.14.1706649754715;
        Tue, 30 Jan 2024 13:22:34 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870a44100b002185412083bsm2105786oal.0.2024.01.30.13.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:22:34 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 16/17] phonesim: Add lte atom
Date: Tue, 30 Jan 2024 15:21:21 -0600
Message-ID: <20240130212137.814082-16-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130212137.814082-1-denkenz@gmail.com>
References: <20240130212137.814082-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 plugins/phonesim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 67cdc605189b..a4fdddc68489 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -864,6 +864,7 @@ static void phonesim_post_sim(struct ofono_modem *modem)
 
 	ofono_radio_settings_create(modem, 0, "phonesim", data->chat);
 	ofono_sim_auth_create(modem);
+	ofono_lte_create(modem, 0, "atmodem", data->chat);
 }
 
 static void phonesim_post_online(struct ofono_modem *modem)
-- 
2.43.0

