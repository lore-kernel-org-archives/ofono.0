Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB4126F2E
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914509; cv=none; b=gw4FCmokPmAgvw/gKI5bGDEE7QwXV0mLc7OeznyAR4M17N9JNwt6cEh1AHDWxip4CUbdNleEYTF8awho402lghGi1Gjv1MLUdrBPU+1/AhG8PJCoxRAZq6Y7ji1mEZYx8vKg750/5gM6OGycoWGURaZp0kBWY6EmtK3RzkH+RNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914509; c=relaxed/simple;
	bh=aFANccxePynoAJB7yKTQzGpbqxQl0W1cspHAtif3CN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwkngUx7IOClen/ZGuHRJMbqeo7JgqbHTghFuJKWuoJ6hoPfuOcvojx8QUHG/R3ewhC1BhHhe8DnKQgfMGU0MvtHLxNdba0sQ5SPsi/3X9csas+QJzGfqSCJt1bBzczEOUPdN2xc0gcQfpqVKaPo1Dxsi1ODED7D84OWCuTJiHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdXugbu+; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdXugbu+"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e125818649so1426202a34.1
        for <ofono@lists.linux.dev>; Fri, 02 Feb 2024 14:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706914507; x=1707519307; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leoBmhEqct4rNkQA+tsmAqJiN6/EiQ2Jc++bg5qXugk=;
        b=SdXugbu+FWvToTD9xMCZy9LJ9Ho68PxAK5g6qKhAevpL9rVbjKm+1zSh2nwVxpXlNo
         Qi4R8CKvs3Hc+5Oz3ob84bgKGm0EOPF/zbKnv7+mg3yVo2WGJuKAmb3TkC23tWhkm/7z
         +h8hIctqN0lfNgzJjJnhq/nzJq1wLxugUoOihSCsY7FBWk0663IuYzgN1whHzlipAhqO
         LEAiYECYcbjfglIPhDJYqPWCthtvq2VSDGI3FD2penxL7PeC9rYf3FXB4R1aytn0NyFM
         LXQ7GlboYrw5HOC8fRt52x77XjB35u5T91lI0Nxe8k7k6cP7A7QXXTdHFfseUxK8C3p+
         MrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914507; x=1707519307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leoBmhEqct4rNkQA+tsmAqJiN6/EiQ2Jc++bg5qXugk=;
        b=icx3uA2sQND14wS19lNV8HWvZHFCNST5rYcG/9tkQwkUdwDQA5y0JEj83i5/hx8m7v
         oXXyw7PvyOaOoOIbFTNImeJ8TSfGFbL2D4GoJ4leKTZMVvMUCsIumRSY7gd91LbcL0WJ
         h0mvy6Cn047w5HCEhGY8mT03tCmJA6E2LOQfbuek3L6J+ZR3K8Zzrk9a8eZ+gobOfYqA
         Zjq/edNNIADpQPxsGiQN0y5ueD8J1sELI2+xEkzg99VzUJJObhPbH2n04susHHeiwi0f
         5PVzSbO2xl9H9tUdnW7t68Mdqcb6x6IuiVFuHU2I921+iLGuAZ8xjRWVcQ4laYEZt2w0
         psGw==
X-Gm-Message-State: AOJu0YyBd1/KGGySyGxapI5/xHAAD/wyYVdvaPmMNyD5xCrsFnxRb6uD
	+QR7xcK1EPE0jhrahYiVGU49tsQOuZd7NBZhsVSCC0mkSS7HPP6dMbjbeC5t
X-Google-Smtp-Source: AGHT+IG92Q/3GzzOfsXiAyltyFYVUYZA2cz9+AEbPBCN2lvTnzXDzEEW1xb8b+EtF0amcPQYUnjkRg==
X-Received: by 2002:a05:6830:1410:b0:6e0:fd9d:69e9 with SMTP id v16-20020a056830141000b006e0fd9d69e9mr3733707otp.1.1706914506803;
        Fri, 02 Feb 2024 14:55:06 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j20-20020a9d7d94000000b006e1424847d2sm563485otn.12.2024.02.02.14.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:55:06 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 17/18] phonesim: Add lte atom
Date: Fri,  2 Feb 2024 16:53:49 -0600
Message-ID: <20240202225405.993792-17-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202225405.993792-1-denkenz@gmail.com>
References: <20240202225405.993792-1-denkenz@gmail.com>
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

