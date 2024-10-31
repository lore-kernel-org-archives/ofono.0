Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562DE1CEADC
	for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 22:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412413; cv=none; b=pCDb2NVWl3I4H9TNImOlA3cKSLo6Afsr6NOGSvy5MBiS8DF4j8jjz7no0Cs935vsEluQp0RYfgqiomceHMPztLmHLIIav+ww+sa5JWfxQrKrGUDA9sfJUgla1lSzMb7dBAObaFPBKkeKHEg1AMunP8IxBgZLIfTzTwQ1QrhDgII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412413; c=relaxed/simple;
	bh=q1ElaM9ga80dhqToMeINhHvbxqiB5Y7FTOTZpWd7Stk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1JHf8RRBqzAFieeeCE95OxK9pEqIY7ctOGsGEtrDdUDekuXSxhgZnCk8FGvYXGGEAjSJRic3DaOg8JMnHLdke59bk3zZICoio2dLlUyCJthaEPhjrAT8395yzVt4SDqfz0wjPRpKdyDG9JA7rEbf/p43GqXT7MDu82UQjSTZik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+3MnHE2; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+3MnHE2"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7180f2f5fb0so740667a34.1
        for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730412407; x=1731017207; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drE4Ha64HpCwbs1I+ZTZp805PWc17XK54HE643nuQ0o=;
        b=D+3MnHE2VlyDGX60CQstr8zwNCgwj7fKRs4XArY1d4CbPtYVCRmU39K1BpR6jtBEDI
         gXz5O+E19Y0mHIIhG8OmD2VkrIfvl9iEWT+aHJIjQO+g4A8BECqugsHEXHaGSmiYBXLo
         EMZ58aj914HdBZy9Q8dVRi75lVdB1YrBan+EnBXy8zV5whuhQrBhFdhxGtKEya4ew7mT
         5LE3iGN4CtqMZce35nn5MjGn8QJ29LM6ggQvEff0QT9FSzihsZld4B3QSUEBzwyJNbXN
         JLfIBSqOBocTiwZzi1Pk2ePljq93RyzWmP0vcTSJzUG0brR4Z0bF1nvFkMK7cHJS91IM
         euAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412407; x=1731017207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drE4Ha64HpCwbs1I+ZTZp805PWc17XK54HE643nuQ0o=;
        b=ceOQODUdDhFtYKCDBe3ZJkqmkyKc7Z3crgUmGueRJnKWcBs1hQN0gDQlhwdeNsFvoW
         RwVRddkEhYWxdo8EUTtaxs4ojlxhDRB8sWrAC+rzQdDIZl9YIwksU+CPeJGoD3T/797R
         moYdbtE7WZRwNzJ7EOtDgRE4Ru+lQqgs+fqeaetbNqwGk/af+xyQHb4QM4Mwo0UFZvlk
         t6p9QojeordHD0uzoVZbwbsk2XWJjfEl7NHTgz1voLwFeH0S2ehMyLiCt7aphEwysiV/
         hvNFRwg5VWNzcRycwrHqVaMdPsFdgib+gPdPniVt2MNwZZC80QPh64IQBAe2onQ3K5Tg
         56OQ==
X-Gm-Message-State: AOJu0YzsNJSMMXo2ZAAfGanBvPrZe0REhMuSE+SypL7qfTgQE8ShWynw
	RdxnHZNnEoMwQ6e+MnwQJHx3a4OgBJ/tmD85+bQ8oXe8Re+1ls3AfyYWQg==
X-Google-Smtp-Source: AGHT+IF7s4MrYBGuNfRt+HmiFWtqn+baOnCU00p2yFpZM/bDn08ztUjq+RL2HxpRs4mOIJR7LO582A==
X-Received: by 2002:a05:6830:310c:b0:718:2eb7:4ebe with SMTP id 46e09a7af769-7189b55cfbdmr4261154a34.27.1730412407202;
        Thu, 31 Oct 2024 15:06:47 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cccf4a7sm507577a34.73.2024.10.31.15.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:06:46 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 11/13] gobi: Support only "usb" Bus values
Date: Thu, 31 Oct 2024 17:06:18 -0500
Message-ID: <20241031220638.1582166-11-denkenz@gmail.com>
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

This may change in the future, but for now the gobi driver will only
support devices using the qmi_wwan network interface driver.  This
driver is limited to USB.
---
 plugins/gobi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index e75a0312f6d0..6ad8a4b7f923 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -120,7 +120,7 @@ static void gobi_io_debug(const char *str, void *user_data)
  *   'qmi_wwan' is supported.
  *
  * Bus
- *   The bus of the modem.  Values can be "usb", "embedded", or "pci"
+ *   The bus of the modem.  Values can be "usb"
  */
 static int gobi_probe(struct ofono_modem *modem)
 {
@@ -146,6 +146,9 @@ static int gobi_probe(struct ofono_modem *modem)
 	if (!L_IN_STRSET(if_driver, "qmi_wwan"))
 		return -ENOTSUP;
 
+	if (!L_IN_STRSET(bus, "usb"))
+		return -ENOTSUP;
+
 	data = l_new(struct gobi_data, 1);
 	data->main_net_ifindex =
 		ofono_modem_get_integer(modem, "NetworkInterfaceIndex");
-- 
2.45.2

