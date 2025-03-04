Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C5920A5CC
	for <ofono@lists.linux.dev>; Tue,  4 Mar 2025 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101006; cv=none; b=VqD8WGQfr21te1dRR4LdTKuuYUZUa/MZRkylk6WiCd6k18c02+Fdol0GidZE9YkXFcuKiYVPjX61yhyeniZM4oKHEIVz/Uop2uDsJj//2YngjPjb//YgYUbe/tihL0mzseYAMiAWTyweVxn/piGzdhsS6kltqwT//wbPqe63dXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101006; c=relaxed/simple;
	bh=iGj1Y5BzyQ6OX3bimkWnz36xs8FykNnsHlPoEPRVzRw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DhN8vJff/FXIN5XkuKry+EsgZp1jFE86LgwJHR9SAnTxKByDy8IGzPpNAggpt2REXZnRE3QwA2iVTSXswB7UBrAY54SRSbL075s+/AU1D8otHXJXHkWXi3FASLbJ1YxKc7DCtng+q0aQ3NGyPVSX6d965AQmQtWzwH8B59+sIWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/1yT4Ea; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/1yT4Ea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E92AC4CEE5;
	Tue,  4 Mar 2025 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741101006;
	bh=iGj1Y5BzyQ6OX3bimkWnz36xs8FykNnsHlPoEPRVzRw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o/1yT4Eao2pbPUiGMKi1yDcbJcJYAfRZOJ2tSPRc5oa0xzX3mLv5Y8Mphg2vgrY3+
	 9AkJiAZ2uwguMbesFouFUw6AQyE9iMa23UB+K7J3Skr40JOScZE8WEduivSNnJh1bo
	 VzhPAP6TTWPvl5SL6RqwHKIboP5TnzX6ZHqnvCkYmBCKEAmNiQYzrZv6JOcknqGhsz
	 dkeSGcNGcZAdbVm9Eu3TkGp7tBYPPklE7RavSzF3eIeUnHnajhKSrNJecZy+vqQ0Kb
	 lxissLUz0uU6GdCyzRdmt76VzwHc3Y/W9EB/Dl+anIJwjA5ryXmvcQ1cUpjr6AuSqQ
	 I+PGWeca414TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D3C380AA7F;
	Tue,  4 Mar 2025 15:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] hfp:Update for new HFP 1.8
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <174110103898.178640.18142519539891473926.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 15:10:38 +0000
References: <20250303033646.21816-1-quic_rbujala@quicinc.com>
In-Reply-To: <20250303033646.21816-1-quic_rbujala@quicinc.com>
To: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
Cc: ofono@lists.linux.dev, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon,  3 Mar 2025 09:06:46 +0530 you wrote:
> Existing 1.7 version is outdated/withdrawn to
> do certification, so updating it to 1.8 .
> 
> Signed-off-by: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
> ---
>  plugins/hfp_hf_bluez5.c | 2 +-
>  src/hfp.h               | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [v1] hfp:Update for new HFP 1.8
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c9514c749c32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


