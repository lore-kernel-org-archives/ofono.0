Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3026147C6F
	for <ofono@lists.linux.dev>; Wed, 17 Apr 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368431; cv=none; b=lTf0gxV53/aNfXwnlEDnTfHLPDc1GsPrQMRZNwzv7Pzbd6uA1si0Lcvjjr1YrYrF6nYF37gVeS1THjEZcoM00uxLIktIOUSxba7GxxUgJRHmRJ/mC5Ac6JzsV1WPL4+h7vZP/4Ix5AAj4+puMWZN3To05/mHYh6ckyig3QwykS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368431; c=relaxed/simple;
	bh=OalnDdS26un2bc4mNYxa3Z9cmM0CaV9IujAk7eZm94Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SDZwYlGlt3QTbccqMnWqH14xxYIWzh0Gw6yj1dVS3FyCG/ujSKfukbXxLZiXI4xEOfKV482t1VEKuF14SBrYISi0dbh76g0OJVhmHLrDMuO2Y+4diYTQfpAk7F7W690mEyOgF4vZ1ze7Pbefai4sIgkSPOSeXxqu6fG7rcMIGOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVdNeOT1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVdNeOT1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50C3DC2BD11;
	Wed, 17 Apr 2024 15:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713368431;
	bh=OalnDdS26un2bc4mNYxa3Z9cmM0CaV9IujAk7eZm94Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EVdNeOT1yXSxsdjQA/fg5Nl7z2fut9yHCdE94adUPavXjaYMeSpl/TDlYRy87+ZUQ
	 dj5wpxjpK4fw4O2RmcWWmMgN1g6rHaKq9FHn71MZHgPQt6/fGqEQTnaDMWgnsWHBoq
	 UE4hkL+RLr/UYmBQsxVZ8L2uJ4YurHpEUJU4bBg1B+f7Vz8SH/dqJvCZT8LQCFG8o6
	 XSmcoSL06FTyya/VmlQ7WeMW7UCRMS38AsxeJIhUoYhZBMOmtktSPRERkSAVbex9Dc
	 EVmyM6WERfN3w2/UwtoplZeQv4WQo9IVI17wt7+qIwzXu2cFWmhmcmUk86CIiWcL23
	 699i6EDeuoNNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C588C43618;
	Wed, 17 Apr 2024 15:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] gobi: Do not wait for timeout to shutdown
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171336843124.1784.1803522816574193203.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 15:40:31 +0000
References: <20240416221233.404872-1-steve.schrock@getcruise.com>
In-Reply-To: <20240416221233.404872-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 16 Apr 2024 22:12:31 +0000 you wrote:
> Now the qmi_device_shutdown() function can return a failure. It will
> do this if the qmi_device type does not support shutdown. When this
> happens gobi should immediately proceed with shutdown instead of
> waiting until the timeout occurs.
> ---
>  plugins/gobi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [1/3] gobi: Do not wait for timeout to shutdown
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=580a0c22e5cf
  - [2/3] qmi unit: Make test service sends more generic
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c39ddccf761b
  - [3/3] qmi unit: Add notification registration test
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c3313629276f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


