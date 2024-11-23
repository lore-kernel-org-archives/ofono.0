Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDFE257D
	for <ofono@lists.linux.dev>; Sat, 23 Nov 2024 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732352751; cv=none; b=ETG2/X9XxILnc/mw1XJ0cRX/kP9Ot78PYFq5HB+W3knpNlWp7Ub/iu+uUInVjVeoN/nAX8uTTRFEhFhmm8CMUDnWl+6Lwg222dB0eBvEwBMbeQN0k2jZ9oL5oEzvfLqip4MVnMfPIpPUx01npISzj6l0ouwU+eZUeqR5o6yee0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732352751; c=relaxed/simple;
	bh=ZfzRFN4nM3lHFXXoODP3ieX0ROG4R9482i2yNOzUXnQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DngjZrjgFgHAknzY502fRn/ogBsHy1N351dvOocIowSvsIXtYUBm+HIL7aK3Ms8zyOA8hunijIrgEERZiG37nPCsEEJI/zMyA/Dh6VoQ9vLqXNAYfxdTW2r/t0wYWYAa1kh2U4UYH/j0uZnD3299dn0iMyci0OtpoLb+atd6rRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=af1NaoWc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="af1NaoWc"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-382378f359dso1965665f8f.1
        for <ofono@lists.linux.dev>; Sat, 23 Nov 2024 01:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732352748; x=1732957548; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfzRFN4nM3lHFXXoODP3ieX0ROG4R9482i2yNOzUXnQ=;
        b=af1NaoWcuTSjPTacdo+6KahU5WDRnN6gUVLsDIiU/D4+LyXkEuHBGL7ZAb2IIWf9Qr
         crrJyg5DjFL5OiUtMWlehcINs+I6hoj1kgbkq3tHJx5TWMm1ZHyn3O8G2Yq7b5Ly8mIh
         FAnQGz4MQdU/S3vJ2RsMoPRrheFbKbLvoWTmSOhqU7O7bh/mSh+LmxJDMle2Sf/Tzr3b
         8FU5ziV/hyclMycvLQrnTqWsIPWBlTp++wLpZwOSIkshKqWzaFuDldGNQjLyv8hmetEl
         JcTgzMeYPB9jF0fXzHhcm94t52Wqzao43rNq2X+RBTWnaapswz550oT7KmhmkoFBaelq
         MlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732352748; x=1732957548;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfzRFN4nM3lHFXXoODP3ieX0ROG4R9482i2yNOzUXnQ=;
        b=jE7ANI2p55GavognKAXbiw5ygH/Ir6jVksPV67kIsZ+UkJGMexiY7n+qoyP3Abki4u
         DxiytmiwCStPtztt5O5pEcadjeX5KjDkZXD2x9oz4Z2hT09gb3QHQRwFAf9pU8CF3seZ
         MfVx7xFsQh7bz5xxAbFBEn/ZXCFl9CNgvi6V7OmWukDUm/WjAkKW1BAWrKOAPRd6FpSn
         uu7W4FbbbVxY1QRiubCTqDqp0HIlwiYQA9cJEVkhUBNgxd1zEL2CY+DZ9lVpj3gljEKK
         I2B7ujmPLMkaVsFLXwVO6o4g+nlNFWXa69cEpTmFDv2ks/US/k7aZZlvlFHQetE5u0WL
         Tjwg==
X-Gm-Message-State: AOJu0YyQ0y80u2lcZ00fllbbBJdUEpiARb5LJZiBr5JpyKT/8xUBEz5l
	wi10Rk6nHL4CnuOL9a4NakkGCcIoz+OkY2jgKvvBRx/+8Lquz1Erj7z5Cw==
X-Gm-Gg: ASbGncuJMOoUJXXXxHZLkdjPz/3tKXCK8v29urn6yQ3aUv8zS2VnX13nB3UAQ6hG7uP
	HedYuvC5MWXFJZknq+Ly332q6gC+9PFfpSkTFg4TaBRADZWSLUnKB8ck4IwHiZeYplChuNgQ0Q9
	awI//PWlk06LRmG1iwy9yzdIA4mYIhJTLZAe/3wJF1I2YQdZxcmIloZ11aK6goXHctKrRCmh0Xs
	X2x/JKFWoOqFy4q/OA+jgZHsOzQQGTngmrHGoO1zQbwWTvnCcu8+0unocsu6SiD9OjC
X-Google-Smtp-Source: AGHT+IERebuQL9NA6GYBHkEV3d6AQ1IJnay6YVbrfhjAWU9jye5qifON5yE1ZnBiAlkUto+6e4p0DQ==
X-Received: by 2002:a5d:6c6c:0:b0:382:4b5c:4199 with SMTP id ffacd0b85a97d-38260b73edcmr4621743f8f.23.1732352748053;
        Sat, 23 Nov 2024 01:05:48 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad658esm4782814f8f.8.2024.11.23.01.05.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2024 01:05:47 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org
Subject: [0/4] qmi: implement missing pin functions
Date: Sat, 23 Nov 2024 11:05:31 +0200
Message-Id: <1732352735-31944-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

This series implements the missing QMI modems SIM pin functions. It also does
a minor code cleanup.

