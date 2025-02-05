Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAAB1FDA8A
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780807; cv=none; b=rkfTA/tXS53RcjZpWHaeerBVfbKwXqZCTirjRNs62PZUp1A+F1gKkUcrPOJW4cvKYAvvxxOht1/0QqyRTO2S5meTVva5/55re9BPniYE0F3qEs2SgiJZLmwnLA+nox22SgSvnKLs5qQIx3eE0P2gd8y+7blE3GHOWCJ5bPturSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780807; c=relaxed/simple;
	bh=644Zlv9voKwZjUyjaPzTexhhvEK60yu70HMEpK58I7A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GfvkYUUc29fSBi2/2sP++R2NlrB+AFqM29eX1ksTD8w8cfxYDWpbBqelLUeWQ1EuKkyd5iDeM7J8dK1EjOjAa47ExBsWFPXipm0D5T/LSSJQ47Y2oTQidjJSLHp3VKMrzf+Iy9ZiCFlYgM8TJmjZI0mP4TVUZYBrO2ukThcssVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czj0dFKc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czj0dFKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7958BC4CED1;
	Wed,  5 Feb 2025 18:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738780806;
	bh=644Zlv9voKwZjUyjaPzTexhhvEK60yu70HMEpK58I7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=czj0dFKc8eKwZIZ1M3ed41R3Zdk6WuGQqs7n5cPtHSq+Vdby1g5Cz45PL2fvMDSSF
	 zJVkcmIM9eSy6FympdGef4XuNwBanmG/+9FLzjmVa2pGsU99k1qZ+sVbpFqYDeBtDW
	 jccSVjyHqrZAdUBgBaRESZ+R8yZpUsTatUtg3wajSVPg/hpKVaUrlO5mush2bHBR3O
	 5R1mdwALLhRlUS8O2W/opCrwZ06FxBX/Wn5ciQbodUyJZQcrg/Mw3trR6HnU7KoFVZ
	 CoXP9wE2qrVeXrPFsyvCMjaxmBFYifHme1Rm6ZyCX7McW7lxjUhJ53SdTSOcm7ChO5
	 Mvpm2wbCye5xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34151380AAD0;
	Wed,  5 Feb 2025 18:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] voicecall: Fix implicit-function-declaration fatal error with
 GCC-14
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173878083403.865165.2152347460695943462.git-patchwork-notify@kernel.org>
Date: Wed, 05 Feb 2025 18:40:34 +0000
References: <20250122121314.550338-1-saravanan.s@lge.com>
In-Reply-To: <20250122121314.550338-1-saravanan.s@lge.com>
To: saravanan.s <saravanan.s@lge.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed, 22 Jan 2025 17:43:14 +0530 you wrote:
> Address below issue by adding missing header:
> ofono-2.4/drivers/hfpmodem/voicecall.c:1081:17:
> error: implicit declaration of function 'usleep';
> did you mean 'g_usleep'? [-Wimplicit-function-declaration]
> ---
>  drivers/hfpmodem/voicecall.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - voicecall: Fix implicit-function-declaration fatal error with GCC-14
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=1545c21c6162

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


