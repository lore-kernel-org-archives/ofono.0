Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBE713AA32
	for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417832; cv=none; b=iafF6jDuf5TwH1aExNoVnGQKztEE68IdHUv/L3aZ6DPxgTHHILRy3L2/vpjpd5Ksw5rFgvJpYvwcqoqyj3ywMH3BWXHzh7fi+7CTN4C2l58sFrPg6oTG1Xy+EVkm2MuiAL5GtCsQwdt0ja/d6+qA9QdO0y7Q18u3Ggi208PxUAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417832; c=relaxed/simple;
	bh=GPFMo0CWs9tzcFQA/mQ4xxQeh4o5VO7ZDx/CArHHIH4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SeDHSTuA+h5HRIWMECFSmVYYjf/Yt+fwi4ADsXxrEYX3wIvcerBfZ4Sma9qEzeNVyN9JAd1n21621Ul7yvuqM+s66AYgtQY5UOVTFYtteRsqa9YfgdUNBpSSZE/EvGv9NIVa4ep+a51hVz8mSk3kNKMtIjoN7qFUXuuOo4fdMhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZ1AWrbQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZ1AWrbQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A173C4AF18;
	Mon, 29 Apr 2024 19:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714417831;
	bh=GPFMo0CWs9tzcFQA/mQ4xxQeh4o5VO7ZDx/CArHHIH4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sZ1AWrbQSNMm+SMpsPIWJ0Kg7u6HS47bT8CfLUaq/bWP+9Y7nA3Rm6et5dDWMTEoG
	 8yKHYXXep7/05l9sNAt19K1BlFjogTtmPUxvvGjB2PjHKoKZeLUEpRIhE69vw7oHV6
	 px4Hmk1WHBnmqV7SzpOhldWb01nDGeNgrZYBUyfeCqhCU3Hk4fCgZYKcydfvud528x
	 HWYXAmwGF+Gwo6tFgQeJWSz1lQn0I5IlMOP/rI/WjRLdUL+DH7JrtYLHMLF7lQ/pXA
	 DIZrMMAqDg8yAqYpLH3TyDtVZl00BhFhjZpmlJQmQ/eKZi4H7NV8umd8CovUO0ENVU
	 6JQuWQ5+ODEig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 890C0C54BA4;
	Mon, 29 Apr 2024 19:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/6] qmi: lte: Remove magic number use
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171441783155.15158.4319549851895769084.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 19:10:31 +0000
References: <20240429155726.51479-1-denkenz@gmail.com>
In-Reply-To: <20240429155726.51479-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 29 Apr 2024 10:56:53 -0500 you wrote:
> Several commands were invoked using magic numbers, even though they're
> defined inside wds.h.  Remove magic numbers from enumerations by
> introducing appropriate enums to wds.h.  Similarly, use defined
> constants for parameter and result ids.
> ---
>  drivers/qmimodem/lte.c | 29 +++++++++++++++--------------
>  drivers/qmimodem/wds.h | 14 +++++++++++++-
>  2 files changed, 28 insertions(+), 15 deletions(-)

Here is the summary with links:
  - [1/6] qmi: lte: Remove magic number use
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=758a6ea7faed
  - [2/6] qmi: wds: Move enum conversion into wds.c
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=e1756a883d8a
  - [3/6] qmi: lte: Support additional attributes
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=901835d0f265
  - [4/6] qmi: gprs: Query default profile number at init
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=63a6b34de475
  - [5/6] udevng: Add "option" module managed ports to gobi driver
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=cb4f0876de81
  - [6/6] udevng: Support Quectel RM502Q
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=8254e8ff1553

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


