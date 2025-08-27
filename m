Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CC62D7395
	for <ofono@lists.linux.dev>; Wed, 27 Aug 2025 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315803; cv=none; b=KNmV/v7628YLGeUXFtAljYoRZg0p8Uz5Qw/oHFkLbnG5v4iIxOWbmnMmavTjyqD7hVUwpPLGnOrboBMCFOl8SRRUMoETOt6TBK+Xo0a2CG14z7MD7LogNNx9HHfthBYSQ5h4okFbTucnnnhwBaXtIDdHSTJiKUfcHCO2pKW7Wbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315803; c=relaxed/simple;
	bh=5QX8HK/MVDj4IUJDp1FPUorr2oqU/VRDc3JTk5UHXs8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bM+zaNXSdu1LybWC9bKTnqAFgBRihggNNQtqlZrcIR9qrpfKOqijZFOR5UjXwtbAZ120a0jyhVUhJ/yOXy7+WLB/8+G/fDJqTnBB/6qCp2rLHC8i+pFdx5msLFNM4XCayRCsAQdUkV+NjVjGmZK+5InL1sQg89uTu+3x1b40lDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ew7MU2KD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ew7MU2KD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B125C4CEEB;
	Wed, 27 Aug 2025 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756315802;
	bh=5QX8HK/MVDj4IUJDp1FPUorr2oqU/VRDc3JTk5UHXs8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ew7MU2KDbS0rRTenSVxQiVXLExaHFQ+5ixva2DR2RwMVzZEVVXrZXdsfj//ooErIh
	 WElCQEakNXoiEPGZLhliiRm8d8iFpm695zatDvx2P4ytjDN+/ahcN4Zmx9GyzQw3e7
	 8HxMLK2/BXso2d736Pu/AmTTJafnbsEHMzlHMjFQy6LbbTWJB0F9MO+fXlDH8A2YIu
	 iUyVSLYXs9lMCcsCzyxeUyzNggkHVnR+Rluaf5FeskDjcESrW7mB181XLZOQzXqATy
	 1tiLMyIGCb1vZ4W3AqPFXpgfImlUfRC1GBnbUYb8CsjfV3Dn38F+S17FJF7bGYTTFN
	 7M/KpaxDZB5lA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC6A6383BF76;
	Wed, 27 Aug 2025 17:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/5] Report technology for SIMCom A76XX modem series
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <175631580975.784123.9655684599085614952.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 17:30:09 +0000
References: <20250821-simcom-v1-0-6c794c5573c3@geanix.com>
In-Reply-To: <20250821-simcom-v1-0-6c794c5573c3@geanix.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: denkenz@gmail.com, ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 21 Aug 2025 13:24:08 +0200 you wrote:
> ---
> Sean Nyekjaer (5):
>       sim7100: Update to handle broader A76XX modem series
>       atmodem: add explicit handling for netreg status in creg_notify()
>       atmodem: also handle EUTRAN networks in creg_notify()
>       atmodem: report cell technology capability for SIMCom A76XX
>       Revert "atmodem: let +COPS: report access technology for SIMCom"
> 
> [...]

Here is the summary with links:
  - [1/5] sim7100: Update to handle broader A76XX modem series
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d81d5ff236c2
  - [2/5] atmodem: add explicit handling for netreg status in creg_notify()
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=5172cc6b39c5
  - [3/5] atmodem: also handle EUTRAN networks in creg_notify()
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=0075ab3f8832
  - [4/5] atmodem: report cell technology capability for SIMCom A76XX
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=f32a8ea3b4bf
  - [5/5] Revert "atmodem: let +COPS: report access technology for SIMCom"
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=526e9a9465d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


