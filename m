Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94F96A8D2
	for <ofono@lists.linux.dev>; Thu, 21 Aug 2025 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775471; cv=none; b=GfClJdjBzrbOB0i6ZcRbsgarbFPcZzU4pzjqxKBpz8hh11kOLA0jlGhtuY07uZCjd0T2dKhbLb/N/dUkqV6MRk+bDB9PrWvc1IwBfJc2yWvrDB6XegTVmLPK6XD92fWa2Rc23t/qvznYm5Mnlr3P1yLfFSrZWR3Xw++1bW6MdW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775471; c=relaxed/simple;
	bh=6RcKkC+5w+gL7nTuEqup8PXOBTrTj47L+sCTN/3VZVQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=UoPsiUHHxJ7Bumc09LQCJ0YusP+o17tj7ow9T7kVXKYj3KlZOznrXD899fJtRfpC7FJKJJv0ApO8QLKshSyn3xJjCQk35t49sAzZw7Lvzq9hb/YPkfgZW1jfNCAQXo7z7HnIkl0G3yrq5gevdVWQUFAwjzR/DI+V+Nes32my8Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=bKktX3WZ; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="bKktX3WZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1755775458; x=1756034658;
	bh=RTYr11JUzN3ZzMCeVe4iFHJjccklsdxujuS/komtvjs=;
	h=From:Subject:Date:Message-Id:To:From:To:Cc:Date:Subject:Reply-To:
	 Feedback-ID:Message-ID:BIMI-Selector;
	b=bKktX3WZ74G/Ikguzj9axJ5Xbn7PsQsUBlvd4EduXribP7Av6TNUYAIVsc5CRObWU
	 MM1OVbiuFvH85FKOqTGjESDSR5vB5855mdkr0YX4daj3lwQaZafFZQbkM2u3k2wo0A
	 U5Wubws+SAvfrMmScd2rGF3m1WSMpYKMBClejrF2UJGtNa0cGb2x0XdqRHyA6XHdSL
	 DXmOdkkl8ZQd7m8uJX4VbImk25weufnDj5k+CTgAM/Jw1qvGmSA9mL9AJR9t1t9zDn
	 7ueEyfZ0Nsyf47uLipG6KlXwEc1koLlcKPn9GEGOHlrbhbw3jGpyKOsR9E/wE6l/OM
	 2mlx+9unxHo6w==
X-Pm-Submission-Id: 4c71Df0HPxz1DDs0
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 0/5] Report technology for SIMCom A76XX modem series
Date: Thu, 21 Aug 2025 13:24:08 +0200
Message-Id: <20250821-simcom-v1-0-6c794c5573c3@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANgBp2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyND3eLM3OT8XN0US/NkoxTTZAvjFBMloOKCotS0zAqwQdGxtbUAEwf
 LDlgAAAA=
X-Change-ID: 20250821-simcom-d97c2d5c83d4
To: denkenz@gmail.com, ofono@lists.linux.dev
X-Mailer: b4 0.14.2


---
Sean Nyekjaer (5):
      sim7100: Update to handle broader A76XX modem series
      atmodem: add explicit handling for netreg status in creg_notify()
      atmodem: also handle EUTRAN networks in creg_notify()
      atmodem: report cell technology capability for SIMCom A76XX
      Revert "atmodem: let +COPS: report access technology for SIMCom"

 drivers/atmodem/network-registration.c | 99 ++++++++++++++++++++++++++++++----
 plugins/sim7100.c                      |  2 +-
 2 files changed, 91 insertions(+), 10 deletions(-)
---
base-commit: d3a70b22ee370fc80de81d5f66be6084cf734036
change-id: 20250821-simcom-d97c2d5c83d4

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>

