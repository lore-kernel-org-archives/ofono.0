Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C38165FA5
	for <ofono@lists.linux.dev>; Wed,  1 May 2024 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714597232; cv=none; b=XwZlwrDXIFvKPS2zNZJnOCC84U5FA0vRJYCWoLDoLui/sT1KxpGkK1LhT5wFixZzTZhW6RFhgsSQsby7BZGeuLiro58r8yADZwVvghoP7pczLtkpohiPaaHHmsKwnnQ7ZwX3sehJcoG4+orTSNLc+YbS5Kk2o8ishbY1BKR2g/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714597232; c=relaxed/simple;
	bh=gmRAfAG+tvLji/EWWu9NI7l/huRFc8QBZsoxEBvod1E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EtuXV0tTvCWZJXPW6ddfmXkMsFMpYcNwqx23u1eQUQWxgX7PxCwgjxtGi3DNVHE4u4LfJ2qoRi0nRj3tU+Y7mfYGdPHcrHv5J+EwLWNICK/kYjHVECvvqOGRjgVUjOCjbBNv8jvbpoBvsSmS3VTyoCoh2RiOwZBWCbg/r9mRZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2D6b7Xy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2D6b7Xy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98216C4AF19;
	Wed,  1 May 2024 21:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714597230;
	bh=gmRAfAG+tvLji/EWWu9NI7l/huRFc8QBZsoxEBvod1E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A2D6b7XyhIwqZJjYdQavbmO6sFD1u0T5WhHXjbRAFpL6OvFKWsvxYKHlzWikjsWcJ
	 SF0HGvGxScLhHEcPTuDXfYp/Fcbp7oUJ3i4CQixpVSDFEJCCEaKDxZOWOrDZM61Amx
	 ZtcXaaSH6ZIBuL9WdX6liBQn6USjd3XFkJc/ANPwiD1vXZ1AhH7AZnSsht2b8CjwSz
	 k1CMDOBUoHxWHnzZrIHjdL6dnoCKwcwcarvq9xnGzUOfapL8+FRiScytJDcmyzfze8
	 8s4WJgHdc7Kfq9b33I6J6lmVr8IuaAADuaKxhAk41LftLyusrrfhELH9WyYlomOQVE
	 VuQwQPrpZPA8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 879D7C43440;
	Wed,  1 May 2024 21:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] gobi: Use LOW_POWER instead of PERSIST_LOW_POWER
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171459723055.6893.639227779055771107.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 21:00:30 +0000
References: <20240430173817.3044-1-denkenz@gmail.com>
In-Reply-To: <20240430173817.3044-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 30 Apr 2024 12:37:34 -0500 you wrote:
> PERSIST_LOW_POWER setting is supposed to tell the device that it should
> not enter online state at the next bootup.  Unfortunately, no USB
> devices tested seem to honor this setting.
> 
> Telit devices in particular will turn off the SIM and become unusable
> until set back into online mode.  Use low-power instead of persistent
> low power state instead.  AlwaysOnline support is now no longer needed.
> 
> [...]

Here is the summary with links:
  - [1/2] gobi: Use LOW_POWER instead of PERSIST_LOW_POWER
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=75ba0c33e3e3
  - [2/2] udevng: Add support for Telit FN990
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=e41785fbd397

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


