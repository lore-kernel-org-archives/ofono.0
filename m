Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCF06AB8
	for <ofono@lists.linux.dev>; Wed, 26 Jun 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719361231; cv=none; b=DDFhMgZXAVAsrwa2T/lwAPyQ7UlaiMtKdOaLXxeAcoo0O1xe80dyayXRajLMMvR+pe6WkjftCXRcJ47mXe4l5sEAYqasYltNLUUxILvB7yjLLai7KjbZCN4jjqosO7rkuWuslKmlEiwxGaEH7rngsU23UvchX+9p4ElNttSofyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719361231; c=relaxed/simple;
	bh=4HYbFNeu/lAWyzOEsuGDHmCJ77lJ+0Cmm4ccBhkEjC8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hUTvAGHb6XRmwYs+ELRIL0eN4empjDAYO8IJZY/lNOh/lmwYZT2YcQz8qjIoiQOAr8W54INUJwmL+bZimF64P4R1y46rwuQKOoGoBr1rupUjsTik3+S/sWcZI1qGX7MJD+XvcpkyClypXGT0SpecYNc8PMtUTTOjmAciavKyMPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ8NgUMG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ8NgUMG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4ABEDC4AF07;
	Wed, 26 Jun 2024 00:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719361231;
	bh=4HYbFNeu/lAWyzOEsuGDHmCJ77lJ+0Cmm4ccBhkEjC8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VQ8NgUMGO9fi539uqLgWB8bWs2UzxPmWmKB/cFn9fBa2J0azBorHkgpsAabzMxELe
	 +dabI7CRJV5wOT3CFz6emDyvxsW/IRtb6TFAdd7fChh0FneKWgVjx8dNbU0vblBpKO
	 jZorxhHm9Xb57dwIcqqeZ04xGD+nsolpslCZH4Bi4Qf1ei9Wg/5XwIXwp2Wk3Ksxqm
	 8cGiwhalxArplkq2NjobZR2CeveLyd8+WObP2HFnn6PUrcjmBhaxMgdkhoJdI+oZ39
	 mkJgJpOKNhMjlTyfErWqStcUEQ2Rw3Fx9BNAe1foqOLD+3b4/DQvn7hXOnNuo2cTa6
	 blclKF+EHy8VQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A618DE8DF3;
	Wed, 26 Jun 2024 00:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] udevng: use option driver for Quectel BG96 modem
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171936123123.13477.17673899562242941751.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 00:20:31 +0000
References: <20240624100406.1497226-1-sean@geanix.com>
In-Reply-To: <20240624100406.1497226-1-sean@geanix.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: ofono@lists.linux.dev, denkenz@gmail.com, martin@geanix.com

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 24 Jun 2024 12:04:03 +0200 you wrote:
> After commit cb4f0876 ("udevng: Add "option" module managed ports
> to gobi driver") ofono would choose gobi driver for the Quectel BG96
> modem, as the driver is the match for the option serial devices.
> 
> add_device() is simply throwing away the found modem_driver as the
> serial channels have been created using the gobi option driver.
> 
> [...]

Here is the summary with links:
  - [1/2] udevng: use option driver for Quectel BG96 modem
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=350038bb0b9e
  - [2/2] udevng: use option driver for Quectel EG95 modem
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=9b4c5a22433b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


