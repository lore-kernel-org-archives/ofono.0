Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5001A1AB6D4
	for <ofono@lists.linux.dev>; Mon, 14 Oct 2024 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921624; cv=none; b=DtGHhYN3h/8N/UKz6/oMCpFakpfqVPXGaunfB69WP9Pd4pSFqK+awI7Pt3cPpJmu3cYtm2gOE/uMCGSPs/3LOADKzz8evglwAOQlQhWQhEn791Cpe0L+Bzs36oPR2TcQoCragtGl3Vq8yzPZt+rzfP3u9igrkrz8Gwfhg7msDP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921624; c=relaxed/simple;
	bh=0XNyou7vXNRlWO9mEMVerxwA6USmjVlUhtaZ/RBj4Y8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JIQrrxly3euq8vUzuZzMDoHJeuW4NksiImJkvVUhP/Y3uhSCNOv7qkbhb/kRDRLfgqZm6Z44B8uBv9CpiXm2/hV+2D24PzclM9jVOUaHgeM32u+R4Pn8F2RzjjXgl/EIQnCh/sYiVNDogxQBe2Brsl+tCNFD4F7MvTEG7lH7uUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mx1ajfTU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mx1ajfTU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0851C4CEC3;
	Mon, 14 Oct 2024 16:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728921623;
	bh=0XNyou7vXNRlWO9mEMVerxwA6USmjVlUhtaZ/RBj4Y8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mx1ajfTUOLjJBJL2NW6eMISf3BbX5/i5XB4NVPH+hiBQp/W1EPWZrJdHqFTmv1X1F
	 yyAIjq5WJG9rM5mFeJOTsiGLmnMuJwPqK52gFFUr5V8/DbSqTi1QSAA8J/hDKmzK9T
	 aNiByHz0oF3tvJWCzMgbIAWra7nPHKhWOUHL8Qg+Q8Dhjo6NXYFMi6EYgFZNjcqK9m
	 iSKVtUiy3bHRD5fpSva7R+JRQJ+jM9/5e1s94ILWXRSvbJFz/o/ZsLKHpoEgO5InVP
	 63zFDtAWG5wuqcNAljUv7kke+nWMWTo4RKxl2WK93QTdgWhj/0fF2ba1HKOcUoLLL8
	 d9rRBnubxLWPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34EE13822E4C;
	Mon, 14 Oct 2024 16:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/3] drivers: simcommodem: create rat to radio_access_mode
 function
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <172892162902.562691.14816638238910904821.git-patchwork-notify@kernel.org>
Date: Mon, 14 Oct 2024 16:00:29 +0000
References: <20241011101839.3646442-1-sean@geanix.com>
In-Reply-To: <20241011101839.3646442-1-sean@geanix.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: ofono@lists.linux.dev, denkenz@gmail.com

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 11 Oct 2024 12:18:34 +0200 you wrote:
> This is done in preparation for querying available rat modes
> ---
> Changes since v1:
>  - fixed function name
>  - changed mode variable to int, to allow negative numbers
> 
>  drivers/simcommodem/radio-settings.c | 47 +++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 19 deletions(-)

Here is the summary with links:
  - [v2,1/3] drivers: simcommodem: create rat to radio_access_mode function
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=fbd6743d1478
  - [v2,2/3] drivers: simcommodem: query modem for available rat modes
    (no matching commit)
  - [v2,3/3] sim7100: create lte atom in post_sim()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


