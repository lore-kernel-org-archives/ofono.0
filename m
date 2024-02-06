Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509231373
	for <ofono@lists.linux.dev>; Tue,  6 Feb 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237029; cv=none; b=rsfz2f2fxUpMNlmQiQnLJ3PW8fx/vu/vR7VKHo/5YxwCFD4z43NuzBOeKwm10/zS6jisr6Gmn/RoN9SdfoZn4N2dmQ/aDlO0CawPa7eV8q/ZaVdn7Q2BDybBJAyczsgNXMxH2LMm1/KpRE2I0evI7Dc8NODlrZTpZA7mSJTQJII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237029; c=relaxed/simple;
	bh=ftH3anb/wHorp/1iETkt+XyiWz+60g2tVcwlAR9Gbwc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P9ABH8hfoCI3rExuB3ZC0vSsRhP3i7AHDgJMUIZZxfmFVJHMPFTDqmLBibFTqlCyycWXT/xBpyHUgkepTBTflPxCMNTeqH1K7DNNRjp1klX8ksFP61PxEodbgnFiJk21xDPhN8toOGz/+Yvs7Xn+yTqWHc8EMgUR/voE3mcD6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZUg66o6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZUg66o6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD265C43390;
	Tue,  6 Feb 2024 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707237028;
	bh=ftH3anb/wHorp/1iETkt+XyiWz+60g2tVcwlAR9Gbwc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rZUg66o62HEQzhqr1zAcIzkKkYwrNcFsU2dhqWBgsSLdfuO361z1w4p05PfspLi3x
	 3hDo/57yfwxpoobAka9eTZbiGk8vUHVX51QxPycoC3pSx5s4K2jmTFf3MgWby1vpCJ
	 TXP+gyLmjzT64Hxh5CjRrzCKshtvXEk2SaysiaQOvgHFZ8JT18eDwZRYV21jaywo2p
	 EbULv2wPz1oxzLcZNu7LJU9LtI8zOY+MWuVCAYTFnAg/ODt35HbqESzFs3jpNR4wV2
	 yZBI2klvLM7kJjTZL10XHXijf34IoCJ7K2ew3ugXE59BQ56jKbcKlt8tbTeVNdh0k9
	 Ltz67zhQ0igqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B38D2E2F2ED;
	Tue,  6 Feb 2024 16:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/6] stkagent: Use l_utf8_get_codepoint
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170723702872.363.12796756081058858167.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 16:30:28 +0000
References: <20240205213150.1001245-1-denkenz@gmail.com>
In-Reply-To: <20240205213150.1001245-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon,  5 Feb 2024 15:31:22 -0600 you wrote:
> The GetKey() validation path ensures that the agent returns a single
> UTF8 character.  It performs g_utf8_strlen with a maximum size of 10
> bytes in order to minimize unnecessary processing.  Convert this code
> to use the more fitting l_utf8_get_codepoint function, which will read
> a single UTF8 character from the stream.
> ---
>  src/stkagent.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [1/6] stkagent: Use l_utf8_get_codepoint
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=f5e6f0f6fddd
  - [2/6] core: Remove g_utf8_strlen use
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=fdd0c0fca72b
  - [3/6] unit: Remove g_utf8_strlen use
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c814b1f9b9b6
  - [4/6] qmimodem: Drop use of g_utf8_validate
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=39e2707386fd
  - [5/6] simutil: Drop use of g_utf8_validate_len
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=bce36de2f98e
  - [6/6] unit: Update to the new API
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=98a0809de309

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


