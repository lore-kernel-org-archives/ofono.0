Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E72242D7F
	for <ofono@lists.linux.dev>; Fri, 25 Jul 2025 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446022; cv=none; b=l1CunJW++q8+ghCuDsWTGjYuR9FxduP6g7sEWJCK62VkBYqtK3ULudinpCvmHpfVrRCxdI+8LTfoXM4gtZWwqjt7A8QWB2d4RJk+ebHD7SihYBaAXvDpUfGwL3kebEfF1gWFkVNHfTW2XO8cWoC2CmsMTANFAlJpJuxSdqCnXO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446022; c=relaxed/simple;
	bh=m/8uvNShXCLw/FQufhkUO9/c3jNbl9K/aOePuuPvCjo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DGBOxHtH/mE6rHxzd7nD+7TWhIyuru+LAPPOgcJ1Y6m99WrI9djjVZE+UnVn1DhueH1JPnr+IiNvO0wIOLYhqoZ0CZHGebfTUGSCXmH+bO2zmSaNUZTfngqXdpaAZ0xoZKL45nZ4y101ayFsPngiLKElcrv5d971d2q7UJxzIpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFZ8tQuZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFZ8tQuZ"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-612a338aed8so3296878a12.1
        for <ofono@lists.linux.dev>; Fri, 25 Jul 2025 05:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753446017; x=1754050817; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m/8uvNShXCLw/FQufhkUO9/c3jNbl9K/aOePuuPvCjo=;
        b=gFZ8tQuZVi5TwBoJ+JY9GG4lOwF+7SR7BHFJXwAs03W6NRVf1pXsuOuvzJ+lzwQ1iY
         fqLVHFAHz2U0059JA20PKJq2V0FMAfXJjSgU0T6Lh/5mXejWsS0GhBrhHWJ1jT8gqXun
         1y0THkO4HZuwXivTY9Bs76MKmUZta1PeX7j/vtY6HoFROPOgwlpv5JgHxm6EC86ZHE9r
         339JIlk5lMx8k4CtNhUqpC8p3rxWn6AFWj9j58Hj75jt2GqGSOaiCxXg8YH2rkRhAk4X
         BEZzRLgvhar+O5/pV92Dd/USpX4ctw0Jg5HejiEFa4e8+Hph/y1dXdVqjgeR+1YgOK4v
         i9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753446017; x=1754050817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/8uvNShXCLw/FQufhkUO9/c3jNbl9K/aOePuuPvCjo=;
        b=J+WmJvuzRj2y2ps7rbxvsGvY0GNBk9Mq/45/UY7bs2oZQ3GQg+fravKfi8AwhaBtgE
         ahwAcC5xrdVuQ2KglfU9YvsUB3g/OoVJsA0GZ6XFpNV/4++CjAUd504b5aDTnsD9+PMT
         9YBO0MnAdD62qR5GBlifldEAb7GYd9DV1Ve/xJF7QC9Sq9J3Awvo1CHfL+BdrJRxZ54o
         nNnlUdHYtiz2jrR0vXZvy0SFHQv2PvY4AlV9AhH3F2H1i3oNysdj5czE0Y5Ml27awzer
         M1yXa+tp94x47wC58EhuDUDLsXcmnZqIsacUEkw2wiWR/Hfsdr6PRDoZ03VxS58fjON6
         0s7g==
X-Gm-Message-State: AOJu0YwQqiRFy7DjjQJrt2O2gL7qAad5SC5hyFj29Rz3gfRNHkfO8SBL
	E/IBEy2Pe63/S0FUfdR6xCCbw15L33imQtfSpTG5XTsPA/sbKTzH5IdJmXzI6w==
X-Gm-Gg: ASbGnctMTAnKFt2tA/6yBVF/MII/mk9uM/v1k43OJHjAxmjlBBBLxR9NPlHk3lnmy3S
	0EfWmvkx8MeMkYkXxhIF0QpK5CltotH1BWUD8dmiNLfjSeFIY3U+K8XTCyp3bSdbvxl33hpdTFR
	J5+lsWZy5qhAjaLbjvRLf+DqW1xhmx+dcLRMt5WV3qAL6fvR2ArM3EOS4/STpUI25P8r1xgcT/1
	lk7jkKYZNMFVuVgXTS9d6WQ/FFsB4cAZEDSQzbSG3QZ17mPPaBlaaaq6yjvEHctpwTQYsDNo8ce
	evWXVb1mbzTofXz8O46oQMyw+i/xDhJ4PDSIzSNXUCrRGoKQMG/vw3WcOkZrzq34vvgvn5+1e3x
	r8sk8X3ooz89obeYd/ZLVu5ldv7Ixs5xSVJ3VeMlWFfRt
X-Google-Smtp-Source: AGHT+IGapHL3aZVzYfd+9gt7FVtJ26vVCJM3/4zrfnOoh4ARcfqHkD6zgZJewocJ7YBZIh4GNoXbZA==
X-Received: by 2002:a17:907:7ea5:b0:ae6:a8c1:c633 with SMTP id a640c23a62f3a-af61940ceb1mr204163066b.34.1753446016848;
        Fri, 25 Jul 2025 05:20:16 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6e769sm264898866b.45.2025.07.25.05.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 05:20:16 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org
Subject: [0/6] droid: migrate to gobi QMI driver
Date: Fri, 25 Jul 2025 15:19:48 +0300
Message-Id: <20250725121954.650668-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[PATCH 1/6] gobi: PERSIST_LOW_POWER instead of LOW_POWER when
[PATCH 2/6] gobi: fix start_service_requests() return type
[PATCH 3/6] gobi: request PDS service if supported
[PATCH 4/6] gobi: Do not try to create WDA service if modem does not
[PATCH 5/6] gobi: Introduce "LTE" modem property
[PATCH 6/6] plugins: drop droid and use gobi for droid4 modem instead

