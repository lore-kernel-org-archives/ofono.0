Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD62152170
	for <ofono@lists.linux.dev>; Wed,  3 Apr 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163633; cv=none; b=kYeT8JS1w7JAA4NWONfMtrHUWR0RHMdjCwSFQiq0k/ZcCf45x39PjH7MO0du1Zmt7jXA3GmHFMwnhUsvyuCARz+glhfCcMHD4Id5WLkhjlJ8X0yhoc3bxIEcQU0ZIRcNF7Zg1J3fVSAvtRh1I6UNfSKk22HlhRp1YxVyxVcSKMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163633; c=relaxed/simple;
	bh=S7ed7YkOVSWFsy7BctgXZUaQgZ+UgHE9MDycZhyq3Cc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K1damzHnHOhfNCS0lKacfFfN7qmdCNqc+gCDxddPEL/9yGGrCXmd6sE8LBYI9W0lr1JRoV3uYyoLi1NiUeRQ5s0fdlwIYsAdHtjWQSGx0K1wyhStWiyuzJolh1ZoGSrjvgZmnGkbKozIT6KKPl4q/K+8zGdmiSuIFQY1eqhP0VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pj9cQxmT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pj9cQxmT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F095DC43390;
	Wed,  3 Apr 2024 17:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712163632;
	bh=S7ed7YkOVSWFsy7BctgXZUaQgZ+UgHE9MDycZhyq3Cc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pj9cQxmTct+xIAv7fcoD9UNDzoKr1Y0gNwXk0+p9uEqHVtToQwBF78ESzAwT40huc
	 VAFobJRZrPt2R6O2/AoPkF7LLHO0eLESnWkuSSJM4IpZLIbvfR+xl8Q8Rq5pJolfaE
	 BV6RBjGJmAAyh2etR6R/wGZ+V3qCShRj/UqawdJnJZjmPQFZvaNGZ4kkfw7s9czhst
	 QioLqD+4kM82zCgZIJkrFo0dXVpqs/IwfceCHPB9rrH7GedyHlZmgmpw1Jc9v8Zr9S
	 CTN4DM1assWjpbx/49Q1Zniidf47p6b2N53ACAogeeOn9IcAXzu59joJUwMTQeINZQ
	 z7duQgahjDnzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1539C43168;
	Wed,  3 Apr 2024 17:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 01/14] simutil: Convert eons APIs to use ell
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171216363191.7392.7638547471100992928.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 17:00:31 +0000
References: <20240403160557.2828145-1-denkenz@gmail.com>
In-Reply-To: <20240403160557.2828145-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed,  3 Apr 2024 11:05:24 -0500 you wrote:
> While here, also remove sim_eons_optimize() as it is no longer needed.
> The ell queue implementation natively supports pushing to the back of a
> linked list.  Also tighten up some length checks and make 'length'
> arguments unsigned.
> ---
>  src/network.c       |   2 -
>  src/simutil.c       | 116 +++++++++++++++++++++-----------------------
>  src/simutil.h       |  15 +++---
>  unit/test-simutil.c |   1 -
>  4 files changed, 63 insertions(+), 71 deletions(-)

Here is the summary with links:
  - [v2,01/14] simutil: Convert eons APIs to use ell
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=9850e63ef1da
  - [v2,02/14] sim: Simplify SPN management logic
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4a6c0786bea2
  - [v2,03/14] data: Remove AweSIM entry
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=ec4946390408
  - [v2,04/14] data: Mark some MVNOs via the "spn" attribute
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b37e70242b4e
  - [v2,05/14] data: Remove outdated T-mobile settings
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=5594561c1f4f
  - [v2,06/14] data: Remove RESELLER settings from AT&T
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c496380af19e
  - [v2,07/14] provisiontool: Add support for context tags
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=407309cf47f0
  - [v2,08/14] provisiondb: Add tags_filter support
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=61fbfea7e46d
  - [v2,09/14] tools: lookup-apn: add support for optional tags filter
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=bf76c826774f
  - [v2,10/14] data: Add tags for AT&T and T-Mobile contexts
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=5072741ab979
  - [v2,11/14] ofono: Add support for ofono main.conf settings
    (no matching commit)
  - [v2,12/14] provision: Add support for provision filter tags
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=00cc10773680
  - [v2,13/14] examples: Fix use after free and resource leaks
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=64e2380f4b37
  - [v2,14/14] unit: Add test cases with tags_filter provided
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=393b6cc3dcbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


