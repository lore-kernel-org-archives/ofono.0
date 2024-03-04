Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5171F60A
	for <ofono@lists.linux.dev>; Mon,  4 Mar 2024 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589628; cv=none; b=g2TAphNtYl3lLVW7PPp/ZedClYUVK4uD6+TJhxZ2H0zHlrcmXRVSIlVj1abyVnQbM210h37P6VacL0Pqbf0LPcxWJAXAZj5kODDiiioj9JtbWrMifBgbRkBNZq9Fogx6rSU/hRyFoqkQgJ4+tsfqN/oi38d4t6h9xXSjeEvQF4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589628; c=relaxed/simple;
	bh=LjFf+OBbCF4hCKrYDwXK0MPftWhzYzzPUsMdO0VYYl8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=URnZoLQ5KDaW7EI97ONGRlK/GJ4Z0CjDulv88M6nDS7EaRty8UTzlAt3o3moLKIydBC2TYb5p0OoA0CxoarPMg4YksF3UH4BQ1NvtyZ7PH/57e+YLVpjXUT5jCOst69TBphz8Db10xdZoudbuqb5aYJZisEyOT1O3agiF+Ez0Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clcSLCgy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clcSLCgy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 500ECC433C7;
	Mon,  4 Mar 2024 22:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709589628;
	bh=LjFf+OBbCF4hCKrYDwXK0MPftWhzYzzPUsMdO0VYYl8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=clcSLCgycWJJQmp3Ym4ys01l0NIQvc7Sa/ri1FBUy4+AX+I2SucBqnTheHHjYv6MH
	 F4PoJ4T815XPbvBFk/58EaT89IZgXcz5pwPxJCShyps3tkZq6e9KRCrGyNAKogU0bs
	 LWycR+jV1UVy1f2IbXKZTwsHsuoODs0qmqkRThPeUfBwUKgamSx7X5vjL7rxNMfwNJ
	 nCvCLKvPruaCO4LTO5AskEVqCVZ9BhKerEZLH3z+A/na82hSGi7FI+ucMmYDl+vVVC
	 E9qWmDnimfYgONbmR4qf/B6wmwJOvKqTK+tgvCcovJ9aZqDZ2K5z4+iLzu0oJBmrRN
	 c1TVUh4NnNQVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35488D9A4BB;
	Mon,  4 Mar 2024 22:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/5] qmimodem: Use stdbool instead of gboolean
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170958962821.15573.6387931665851343691.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 22:00:28 +0000
References: <20240304203506.1725220-1-denkenz@gmail.com>
In-Reply-To: <20240304203506.1725220-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon,  4 Mar 2024 14:34:49 -0600 you wrote:
> ---
>  drivers/qmimodem/sim-legacy.c |  4 ++--
>  drivers/qmimodem/sim.c        | 16 ++++++++--------
>  2 files changed, 10 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [1/5] qmimodem: Use stdbool instead of gboolean
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2e707f79d546
  - [2/5] qmimodem: Use ell endianness converter helpers
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=f4b626316d3e
  - [3/5] qmimodem: Use l_new / l_free
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=588ea1013417
  - [4/5] gobi: Replace g_try_new0 / g_free with ell equivalents
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=9eb530b94110
  - [5/5] qmimodem: Remove glib use from util.[ch]
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=5f669d82f73c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


