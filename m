Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB9B3FE5F
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124431; cv=none; b=dfTqZYJVRdqXiRcaDLURJ7q+zD6EFNFgHNnx9/+AcmYW7f4Q4JxScavX5AAGlx6vYEXlLTjZEHHZ7xlnA5yFfT2/9x0yrUG2kb9omPLkE2SLaHY8znKxJpU5sJENhEFyy0HTKWCScxhiyaL5KVmD4rrr/UYDHn4pMF8hJWVK5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124431; c=relaxed/simple;
	bh=mCAuXSVRQhPeOE/pWLxKkLS4ymzD+mKnnTygOfsiCBM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F6FUnLFYthitwj1N0Y9YIKHsxjRjXZALZuPzOmBpGMsN033FK1A/lxm73zOcKIUJxeRU10yTuu3qmh0Pwj87z/u0Ox+5brMggLzr7oQMx6Q+599LPY9b9t4lcdvphYcM/UGqpMzncD3+y9m+sp+kxLUZ1N+2zxOmal6mZ4T27Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHNPgmgG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHNPgmgG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9C7BC433C7;
	Fri, 22 Mar 2024 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711124430;
	bh=mCAuXSVRQhPeOE/pWLxKkLS4ymzD+mKnnTygOfsiCBM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WHNPgmgG/D5LrcVXeN854LToOfUpUOCpNDVseethH+B6aojXSbSa7PRz017sRdSM5
	 FElbpx7g4ie1ARiB0sGszGeRSzv629oAZKOXQqWM7K6aeHvbOO+rwDwT1rmI+tokMy
	 zD5dccQ958U01F2pG6xLLslZDCLVKQcZnlM45DXV6DdHHmYDQwYuKlIEvM0OOD+oeV
	 TyjvNEILcggLwgSCnaNAQ2YUKjMt2x4Sa+wvihJ/KEyUnRJlVp+H7N5cORGGPSRCcr
	 hF4bpUMinkmTJSQ2xC49tuiSIABcNaHj0W0ISADuIJwVq9S76lwL3qa/ABuVAP+JMV
	 muEMancOHkX9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A87FBD9505B;
	Fri, 22 Mar 2024 16:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 01/11] phonesim: Allow phonesim to work with
 Multiplexer=internal
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171112443068.3965.1187313355842697529.git-patchwork-notify@kernel.org>
Date: Fri, 22 Mar 2024 16:20:30 +0000
References: <20240322154234.2720542-1-denkenz@gmail.com>
In-Reply-To: <20240322154234.2720542-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 22 Mar 2024 10:42:14 -0500 you wrote:
> If use_mux code path was used, certain commands (like querying of the
> SIM status) were not sent, resulting in incomplete modem initialization.
> Fix that.
> ---
>  plugins/phonesim.c | 102 +++++++++++++++++++++++++--------------------
>  1 file changed, 56 insertions(+), 46 deletions(-)

Here is the summary with links:
  - [v2,01/11] phonesim: Allow phonesim to work with Multiplexer=internal
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=7670bc2b6bdb
  - [v2,02/11] modem: commonize feature string list generation
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=1f65007294ac
  - [v2,03/11] modem: commonize interface string list generation
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=864466ac2d9e
  - [v2,04/11] doc: Add new Modem.Capabilities property
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=3dbaed76ff2d
  - [v2,05/11] modem: add implementation for the Capabilities property
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=811b646ed723
  - [v2,06/11] phonesim: Set modem lte capable
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=35ae347f6eeb
  - [v2,07/11] gemalto: Set modem lte capable
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=54765d17ea79
  - [v2,08/11] xmm7xxx: Set modem as lte capable
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=1da1169537fc
  - [v2,09/11] ublox: Set modem lte capable
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=9c45043f652b
  - [v2,10/11] gobi: Set modem lte capable
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=765a32ea0da2
  - [v2,11/11] quectel: Set modem lte capable
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=eea2814c492c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


