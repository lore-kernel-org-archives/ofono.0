Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7959511181
	for <ofono@lists.linux.dev>; Thu, 25 Jan 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222428; cv=none; b=g+MdTF1rrN95mt9Ov6q7FAIj8nlSinjde4Kh7LCKguzKTo+H9L5P04sHQSILSXkvGQ46/yIPvbY1lAitPYZG6NT69VIZW+jfXbOrQp0p97uwtHx6qtv+Uwu8x70DP8iKYrdAyjkZu+lREKmL5lDQ6ZQmIvPb+dsHZM/ZJFoy67k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222428; c=relaxed/simple;
	bh=eNCT8HSLc+Vtf/kEU+FiCG9WRrn7LbZ1kv7K1r0OJzI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kfigTpCluWq+G0FYlQ//DWLnE1a81wg9mDCJIi2oomb66RVWXYSMsz2oQe+s4npOwAjm8Gk0tOOY8BNpN1OCweWfkh3wLbz6UHjs2OfCr5sTwpGiBcQCWmq74PT2B80SqWwbglJJWwx+etsYWu2sZ8JS4VE0OMotrA0/AvvHJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhYSzWzS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhYSzWzS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2861DC433F1;
	Thu, 25 Jan 2024 22:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706222428;
	bh=eNCT8HSLc+Vtf/kEU+FiCG9WRrn7LbZ1kv7K1r0OJzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XhYSzWzS8ecfCIzsgx8qwKZiqfwQWRbuY5Vy/KaTN03SZly0j7ryCjWKUNocW2/dG
	 CSvV9niXWxiG6FdHpeWpu+MvT5zVRyTkHTH6mH1qVRNZPZs8z98MKipAVwxdsPxCIA
	 SOL/dW04EFu2xBitiGie8ock93gpg4+oIXlzznDaZ3g6pnghsAksX9PKvgQgB4H9in
	 /Di0Q59v2fY7G1O+xCYvaTCssydiAznRxv0GHyprmHPjvdWC5TTe8di3bW+vlNpLE1
	 PorNvdEJ/wNM8VdBvXL8BINyjolCBRhfg9FVaeBFJ4EpWg1XQsrfQNm8EEGt512J3L
	 oDDj+3qmeYcQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1127CD8C966;
	Thu, 25 Jan 2024 22:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] core: Remove unused declarations from ofono.h
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170622242806.17249.17235002989960001719.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 22:40:28 +0000
References: <20240124211317.611706-1-denkenz@gmail.com>
In-Reply-To: <20240124211317.611706-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed, 24 Jan 2024 15:12:59 -0600 you wrote:
> Fixes: 36a11599 ("gprs-provision: Remove no longer used atom/driver")
> ---
>  src/ofono.h | 8 --------
>  1 file changed, 8 deletions(-)

Here is the summary with links:
  - [1/4] core: Remove unused declarations from ofono.h
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=aaff4978a495
  - [2/4] provision: Remove use of ofono_gprs_provision_data
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b4cf3298dea2
  - [3/4] gprs: Add some additional context types
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=e6a08a1098b0
  - [4/4] unit: Add provisioning database tests
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=f1999cff1c7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


