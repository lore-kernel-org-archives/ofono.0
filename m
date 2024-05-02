Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAB9C8F3
	for <ofono@lists.linux.dev>; Thu,  2 May 2024 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714658434; cv=none; b=DaEhL6EwhbLEgcH4laqAErP0me5hn+rmkCzxZxuhoHIwmpHCtuXxULAbmRx0/cZH9iLYzmqSyxdqnfdypRyJlXKjHpv7zznB/xb6wzGq3P+r696oT0KBCnL55UQsW5p3Ro5WyIFQ/HrteDcwt90u66kaCjMIZ14T+sMZFo08HR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714658434; c=relaxed/simple;
	bh=mrcK9CqP+IuJeS1RSxSwhBpyUKZqSs8jcpljk1g2UiM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iOj/DIZPXot0OuIfqe7Uzkk7pbn1ri7XM5PEUex2WFaJA3XWfy7Jwlsus6sBT9Hwhc+BEOknGM3wFcebGvBtcmVItRcpww/V3HeRbI5BQMuFgUxmcFqjxUzpF5r5UUV/MlMUks7hKPui0il5NDA8whZCGmhQnGlAQodj88y4Z7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4NjJM7x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4NjJM7x"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBA91C32789;
	Thu,  2 May 2024 14:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714658433;
	bh=mrcK9CqP+IuJeS1RSxSwhBpyUKZqSs8jcpljk1g2UiM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r4NjJM7xPlZ7XkhTUcrcAj2YrFk3LL4xyStUVLW13imDq7UjNwNsCaoZUMqq1CjUr
	 lEwehsxA4PUedSSsQ8xmac8nPAq5CxpWBHJoQpbeD6XDFHDZv+y23GBftBMLlA4tXS
	 ZWB+8T5XbPRLK0+Og8PqjYkDDmgVvWIlGk9Yb1cAgluflqPsrW3vdGwP6KbWmbg++K
	 MHhsj18hjN6S1fNgyeqdto3sjRZYt/g/ZlS1T3YmDiRjxA+4nWAft1eoIsuXFZUffA
	 Ae08YAKYL9gwvr025iYG0zopOwFE8qZ2RaGOLzXkTc/+6OHPKYwV+wiRguOLAI8DfT
	 YEA8h9Z5AfoNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFA29C4333C;
	Thu,  2 May 2024 14:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/10] sim7100: simplify serial device opening
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171465843371.15983.12515867581917021658.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 14:00:33 +0000
References: <20240430115234.180185-1-martin@geanix.com>
In-Reply-To: <20240430115234.180185-1-martin@geanix.com>
To: =?utf-8?q?Martin_Hundeb=C3=B8ll_=3Cmartin=40geanix=2Ecom=3E?=@ci.codeaurora.org
Cc: ofono@lists.linux.dev, m.lyubimov@aqsi.ru

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 30 Apr 2024 13:52:24 +0200 you wrote:
> Replace the g_at_{tty,syntax,chat} dance with a single call to
> g_at_util_open_device().
> ---
>  plugins/sim7100.c | 31 +++++--------------------------
>  1 file changed, 5 insertions(+), 26 deletions(-)

Here is the summary with links:
  - [01/10] sim7100: simplify serial device opening
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4e161031a92b
  - [02/10] sim7100: wait for modem to start while enabling
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4b98bea96881
  - [03/10] sim7100: query device model during enable
    (no matching commit)
  - [04/10] sim7100: implement set_online()
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=960aefa86ca1
  - [05/10] sim7100: fix going offline for A76XX modems
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=cbafc2eaf6de
  - [06/10] atmodem: introduce SIMCom A76XX vendor quirks
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4ef41eecf675
  - [07/10] sim7100: enable A76XX simcom vendor quirks for relevant atoms
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=734689fde230
  - [08/10] udevng: register support for SIMCom A76XX USB serial modem
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=9631b1208561
  - [09/10] Makefile: enable build of simcommodem radiosettings
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=1957fab23f4b
  - [10/10] sim7100: create radio-settings atom for A76XX modems
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2f94a6c1dc42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


