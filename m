Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D1938B
	for <ofono@lists.linux.dev>; Tue, 29 Jul 2025 05:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753766512; cv=none; b=q+wVKnNhuoEmhxR7YfP79/4QEWGQWKaYzYvwKUO8dC0L7WJ/djbmKeEDUa9c4ks3Fj/jFp9MVHqdKT+vhpZGiatrH6wp7QzoulAhYqJpof/4FTXgGQaajmhlMwdL1cyBhBAA0QKh9bUTBwFj+eW1mo42fIrfLcbp+/pOkt0QIGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753766512; c=relaxed/simple;
	bh=yrXixVjJwYC3hEmCdyIvc5COebNeVjACuVKxHgqACrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q9MwXmgnS261W4slTdHTjdZJVezU+C6Z4V1wGU0KvhebfTg2TKCH7UxhQx76Ij7GEeHZXeBYNOVqw8jNmgp0pRKHbgK48m+hWjhN1yiby7Fl/dboy2yG/fV2YiUT65tKNYu1JTYadJwhO7Lasm2uWGv4kWcAnkNP26KHXb6Ff0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6vA0UMX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6vA0UMX"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae36e88a5daso1068630466b.1
        for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 22:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753766509; x=1754371309; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yrXixVjJwYC3hEmCdyIvc5COebNeVjACuVKxHgqACrE=;
        b=Y6vA0UMXsImvZ6pfx6mV/EKgdhGYLaMdp0fP87/HUK2CjfDvLvSXPp1gyVIO4XUP7J
         rA4rWMUfd0N2wecaiVfuE6/gN6hAoFEKq6kAUmPpk8UCNwMwOngM9Ca7IFZwHLQfIe9C
         mhjcjKvLAPargyVeXAzJ3spazd7s2qlFxW4/JVlCzEdJndmsIV0WQUH+NsJ53dMtVvgx
         PJiUKiYgzryxMpxNyOE4tNluo9GRbfkwwDihAWhLGKvvqYd3r8TbWrRviLp9atVJpALP
         xKbwJzHTyhk+DSxub4Ii1Ev+Z7BpDD2FXRPXIP7aY9RuwV4/oht6T3J1OmN+bokXLz7x
         xlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753766509; x=1754371309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrXixVjJwYC3hEmCdyIvc5COebNeVjACuVKxHgqACrE=;
        b=fa/3XrpG9zgldlg3FANQqJEKaj5LBpKDdggHp7hPWzFvH6x/rZ1iqzMCWFkA64iwAc
         PxDaNc8mao7Du6NLlqOShnUUPNdmEH7xkVV2NJXvQPhfhfiCrTP3pd2LBfERnS+wea3f
         wxWW2gE0FADdelGgwT6D7hwN5DZl7KlGKU5tY2qS3anMFWKeD18J0M40EWT3ZGxKY1JO
         HAKu3m8Z0R86GHvf0n1lVDn6qPWiezV+vWM6BDSCqPYVaHIYeX3mOtFST16SZCQ5kgrT
         23045dp5xJtA+Bvfglqhf4N/L7c3pG/W31V4sJovy78ER73V+iAcwx6iPWiMb5I8O/wu
         AdCA==
X-Gm-Message-State: AOJu0YwNtwM4QHLjQzG9zfcq5T3AfNJ0ZHUGyoeOXVpYW6QD5S91qK9v
	MJs8kbxCHTbt8ABWt3r9V8Sl5h/z11km1LHAFYcVTuMzdGYJjZl6VTv2/Q97bQ==
X-Gm-Gg: ASbGnctIiOmmeoG92VMymZWauHahd5720iFHBEuIDIcOKAgit+m/OlHzV46t8RcePSk
	sRu6cihD3jl9CFcfUP5qgZ4KhVMPkwVToqybBK/vhtC9DHh6DYePOKe8cPDXS0Sea+SVl4+MFWc
	aWWpfZYOqmaigifhGGVkd1qJ/TM7k9B+giyJl1gRXKD1Y7hriclS1XFFuboSzM60Zf0pVyZ/LGU
	hfo73Py8Os5Owrpar0I/NK0Uk8Sy8PkL64LynMTHkdcEdDhthdLwQLS4rD/EGC8EnDwsRE6E7x9
	Ygd4YpPzb81cmYVKInB0XnL7f07PEqRwy0T+rB9Bo9s+GLsD4tmRoa6PYw1AYrcxNPCd25yN2Qp
	+4+4Ylw35qm74u2HqvvKJAu5D002uRlhpDzLDiMefp0DLHAyBQitGptw=
X-Google-Smtp-Source: AGHT+IFLwbOiJxbE+h/XZrF7KZpvYt+6tgXV8e4yee69/torp/sKEHq07+RB/SXCxwevy1p6hF+V+g==
X-Received: by 2002:a17:907:1b09:b0:ae4:a17:e6d2 with SMTP id a640c23a62f3a-af61730b987mr1366071266b.24.1753766508840;
        Mon, 28 Jul 2025 22:21:48 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63589cab0sm525110266b.38.2025.07.28.22.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 22:21:48 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org
Subject: [PATCH v2 0/3] droid: migrate to gobi QMI driver
Date: Tue, 29 Jul 2025 08:21:29 +0300
Message-Id: <20250729052132.779994-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[PATCH 1/3] gobi: do not assume LTE is supported, detect it
[PATCH 2/3] gobi: Add "OfflineOperatingMode" property
[PATCH 3/3] plugins: drop droid and use gobi for droid4 modem instead

