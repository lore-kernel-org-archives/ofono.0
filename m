Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46234C9C
	for <ofono@lists.linux.dev>; Fri,  1 Mar 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313631; cv=none; b=SPQpwsxcW0XhhyVjVC2AGwJEDZ7rgl9JYPM4r0CiP1WqDc1x2pnh7TqFS2E9GkjROFDxkwuJfKgGe4EB+Oj0ulYCta46wwlc7cJzUPwUuK5qIENkA7dWGsVTTaHjHiD+fItmlgVilaTkCBguugMmnIVlb0So4DE7lkxFVLtbomI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313631; c=relaxed/simple;
	bh=f6DjsyPc13x4wWh1i1bdnyg9jEMdbVj7FDWDVxxykJI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k8YhtrGLujw0p/8pPF39spBdgwYgEFewdi7mToGkfFcyWQA8LKY8YRtzm4hG77SVkGtPrViXBUUlEG/lJ1KiPxJtqwdIBREwPtai75omR5CQLatcc1dqOB6R2q+AoEo/t6FHpdchDVGCcW30SWQmze49niXCSryrHXIul8RApKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1Z4NyFG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1Z4NyFG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 380BAC43390;
	Fri,  1 Mar 2024 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709313631;
	bh=f6DjsyPc13x4wWh1i1bdnyg9jEMdbVj7FDWDVxxykJI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R1Z4NyFG4ZFTCp0xBYRCXvfpfEabtGiSNnVFipf1Xw0JNbTdBAIsuYY8B0q1NHwbq
	 yrMt99IBEXVhEVp5QJ/CeT7yLcgeSsCz7nqjWgjHofPRKQ8+6vVICy0/VpMAqPyo5Y
	 7nSdDCOiuzkkkrhanUl8WGSCzqlwCa0T/eIG4w2UPGmn3OmXtSx3+wntOiuxY4BX3w
	 SzTlLyUYafmUYO7qNOVLrOkTOxlKALB9+KeagMTO8IChrZPO5CoxfcHJXQ0K/lQkLJ
	 KPj2saqC6IfKCwQ+Mwn/L0BQMJ0STJHoZ01PZfPVyAofeSEIHLiniaXeLdLRkpcSo7
	 Rf9OjQVoaUDTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19D36D990AF;
	Fri,  1 Mar 2024 17:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] smsutil: Use a safer strlcpy
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170931363110.17795.7805052649802744525.git-patchwork-notify@kernel.org>
Date: Fri, 01 Mar 2024 17:20:31 +0000
References: <20240229235658.1703008-1-denkenz@gmail.com>
In-Reply-To: <20240229235658.1703008-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 29 Feb 2024 17:56:41 -0600 you wrote:
> sms_address_from_string is meant as private API, to be used with string
> form addresses that have already been sanitized.  However, to be safe,
> use a safe version of strcpy to avoid overflowing the buffer in case the
> input was not sanitized properly.  While here, add a '__' prefix to the
> function name to help make it clearer that this API is private and
> should be used with more care.
> 
> [...]

Here is the summary with links:
  - [1/2] smsutil: Use a safer strlcpy
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=8fa1fdfcb54e
  - [2/2] voicecall: Refactor string_to_phone_number
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=1ff99673d693

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


