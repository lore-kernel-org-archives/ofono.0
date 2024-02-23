Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7424E28DBD
	for <ofono@lists.linux.dev>; Fri, 23 Feb 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707630; cv=none; b=tmG2MBXO1YfQynBzGfqp4n1jD5n097vUbTHZ/tWBqRF/6khNSxA+1Mh9rPU2aFrJfTvN1HmkN6fdlLw0+B4vrHrSCK6dCslHprlZDlf13y7KbOEhjwmoyyt/Kqxigbl+B7R3ADM5HS58ANvYNYqRM7Wfm9tgThgJEwY/in2sA2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707630; c=relaxed/simple;
	bh=OEC9P+0G2EVGZJflwSt/V5t3XjbLyLltdkjwZcIp1w4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VRwaA34ach8PfmI6lVLwZvV2nUeTBZLK5UHjZAXr/g9k8GWBfnnYQ+kQYSX5unHQqmPk15pdZuLYR0NFRSY3Eb/pN8t0Cf1l+iC6UwSn11TXEP1QlD1lCweCEReJ9uVqcQyhClbo43EMcDuskpVEEHDxAsrOrd32GZXN0lIQmFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACDJA/jW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACDJA/jW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E27A5C43399;
	Fri, 23 Feb 2024 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708707629;
	bh=OEC9P+0G2EVGZJflwSt/V5t3XjbLyLltdkjwZcIp1w4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ACDJA/jWxjNIIN9DSFxgOpj0J0ooUDoDPNkGfJXIfSyDQoL5HNtlPgITSjsO9or9l
	 dCRJXgJNetwDAIYXo7Kg28gFjtO+Gol1+umrxMG9BvJlfkI0Rm9v8sdz2G06tg/D4A
	 EnaAU8Z1VeYaInMiK+E88FGqgPlZKkH12+AIo4bgMpPyxOhAJShG7EFF53gEVICSKp
	 k3ozUgx/b+V7KGx2POrmS8ER9MwXWlbadk6JLebtyTDNzD5lNeI6f7zvwjE2Tw/d1R
	 GXprnhZPnOSy2zItuVHGW7tOth11GtXg87BPEif0siZjaVT2mZPiYCjY/zXg4nkdlU
	 PO2NCODhPRcQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA883C59A4C;
	Fri, 23 Feb 2024 17:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qmimodem: Use l_queue instead of GList for pending service
 creation
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170870762982.14033.15719827031181739909.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 17:00:29 +0000
References: <20240223165256.9541-1-steve.schrock@getcruise.com>
In-Reply-To: <20240223165256.9541-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 23 Feb 2024 16:52:56 +0000 you wrote:
> ---
>  drivers/qmimodem/qmi.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)

Here is the summary with links:
  - qmimodem: Use l_queue instead of GList for pending service creation
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=e6e58815c174

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


