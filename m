Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FF31FF1B8
	for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941815; cv=none; b=DbPdHG4BK9T92+A8idR7wD7SvcE2MV+WR1KGx43z+rbfh95XxNaqGgIMiDSIfheDvBgF8hSBTxaeLHjTxGQoX8cKZ0Y2Rk6zrQF6mTDNlP4bauwULEmROJAe2HBZDB3HAYF9RZrkeZF7GQwczZlJ76I37Gh3OSuOydgw1iKzxCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941815; c=relaxed/simple;
	bh=HjNjengZPe1bCtNW5Xgz5CiSmSlasn/J+W9j8s4RG/U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GKLRU/vx3H/ggUxN3zaztMoW0v/r7BjA0wi/F3oSjlZY8eNQcL5RJb0PyZ84G5cW7nHD73vm4itm3WTasEhw3Z4EpetjtAKUp+WeZxsjdmAkwTl/s8ECeZLo/FADSYGw8Fmz6gEDR+DJJGGczWRK6m6O09wRavwLzHEWEk/3Dww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXazDVuf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXazDVuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B534C4CED2;
	Wed, 11 Dec 2024 18:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733941815;
	bh=HjNjengZPe1bCtNW5Xgz5CiSmSlasn/J+W9j8s4RG/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YXazDVufUxLxhin7BCrm9/KwNWh3qr+odYvLwriq/wi2jXWXjR7MT6rzTs9vL4T4/
	 PB97E7S7NezcIVnpQv/a4BeHGUUH4SKWI2hd+uQFnoL/0LLqpl/HrmzBQ1qRK0xKZk
	 1ALComfFRVzKD2sFl6WyJyXLJwcRBc1cSKv5/BBzFrbXx4SrcNEiLLO1YOf7Qo/Tm4
	 wVuEkxnf436ebZahQt+C1eHTOrE3PgUY6zVQkRVyY0IMmOkqeXLM3NypI6Ts7tdbFK
	 bjFcRPQmtCkMO9Cg9rcDdM89UY/If9cgjssHakegrYSi3JolPDDqIVQuj2lZKKyb65
	 CLycFdD7hx49g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE20B380A962;
	Wed, 11 Dec 2024 18:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] qmi: call-forwarding: fallback to basic forwarding info if
 no extended
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173394183149.1671235.3508407473609403879.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 18:30:31 +0000
References: <20241211165443.500978-1-ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20241211165443.500978-1-ivo.g.dimitrov.75@gmail.com>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: ofono@lists.linux.dev, denkenz@gmail.com, absicsz@gmail.com,
 merlijn@wizzup.org

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed, 11 Dec 2024 18:54:43 +0200 you wrote:
> At least Motorola Droid 4 does not support extended call forward info, so
> fallback to basic
> ---
>  drivers/qmimodem/call-forwarding.c | 80 ++++++++++++++++++------------
>  1 file changed, 49 insertions(+), 31 deletions(-)

Here is the summary with links:
  - [v3] qmi: call-forwarding: fallback to basic forwarding info if no extended
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=37f7aea74270

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


