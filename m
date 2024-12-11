Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784541BBBE5
	for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 05:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733893214; cv=none; b=CM9mjUOpXEWBISZgwSJAx70x+ojxd5SFFHttdp/csubXENHHLKv08+092Za/JGBRr+XQ1TleFSzNOLBqGEVCF9Hi+lYGAqNtQZPg1pA4nZjYAurWGAxWGtHCvV72EAsic4ppl0LoZnwijEgAprN8TGNe5/ia6St7X+1axICpkhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733893214; c=relaxed/simple;
	bh=/TbJftIiHUAfoMOwbkT2SyVx1jYRMUdX3fgsjqq5nyY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XYMYYqoHeI7lc0998VfHjA9gIFUYuCo7tFT9ihIW//38Su0Wx1DGDsDJVUeGbmnT1v11Q/57lhNfeJSTyNJ9/oUOEGNK4hZu24eoJNKYzuCWlzqSua3yIb6JJ0lFfgZbM0IX6qvkVQMGvg805GUcfnWC+JS02Q33TBXYsSkXE0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfU6Na0l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfU6Na0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C302C4CED2;
	Wed, 11 Dec 2024 05:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733893214;
	bh=/TbJftIiHUAfoMOwbkT2SyVx1jYRMUdX3fgsjqq5nyY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SfU6Na0l4Mraucp2CQzZJzsShTDVnJFUZ32WD5tUilit3s2/+Zulut9jC4P0ND+4T
	 ix7D84MMERtznOXYWUKQVH6qvO8Q7RUCThteq8d/ZmhqlMtOTz3RPrhzIM15ElkRQ2
	 lpYBW5qSLLGV4edsr4iCu2SlqbniXWWd/Z7hjdMPSFJXwj+uv5u1qDP8vuDUnto1MC
	 yALK5W2RV9oueEQxSY0KBhqoBXeFBc6Kzh4CNX9pJFZP1UaM1u5LYxAt4Rya+ING9x
	 44e7npdYrKMld6r9Ob2LkqRlDDbwWsGR8/bKKziYYVea5u8EildIwGhG2e4SeIsRGS
	 C6M1m7qBMLC/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF0380A959;
	Wed, 11 Dec 2024 05:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] smsutil: Use size_t for lengths and offsets
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173389323002.1440892.15884295537852491417.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 05:00:30 +0000
References: <20241204183434.251701-1-denkenz@gmail.com>
In-Reply-To: <20241204183434.251701-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed,  4 Dec 2024 12:34:25 -0600 you wrote:
> For some unknown reason 'int' was used as the data type for length and
> offset values, which can never be negative.  Fix that.
> ---
>  src/message-waiting.c |   6 ++-
>  src/smsutil.c         | 120 +++++++++++++++++++++---------------------
>  src/smsutil.h         |  22 ++++----
>  src/stkutil.c         |   4 +-
>  4 files changed, 78 insertions(+), 74 deletions(-)

Here is the summary with links:
  - smsutil: Use size_t for lengths and offsets
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2bdee9065f64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


