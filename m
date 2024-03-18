Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5670A58AB6
	for <ofono@lists.linux.dev>; Mon, 18 Mar 2024 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796827; cv=none; b=E+bxoLDWSPmzy5Yfv+E0yFYBh+n+aLEl54/80+MD5bAeztVnNKMAPkeJnFQesH6tlWoauuQWKWEOEYhQ9NbvdjvhPGl3+rUzD5d9CToPv+/910nhT9OyRI0KnwVVxb1FiJojgl7lFG968HEjnel9wryxpm/7cyQjN1B8bUXRmUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796827; c=relaxed/simple;
	bh=mmeIpDM6O6H8ETB5ebqJX/A+SXAgcMKUp8XhlbEaq6o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HmBKWCYfqqtef3Uu/MKVmIzLMKs48vXIt2eyuERhSSVmUqJjFXbmIXvN4P103/lT8PQM9i5LNXPWudfmJXnAP9U9xC3rpyRHWYKNBMV4UK2rMGcKHMtwg5JYfz3XajcYYNlTMeJ44E1FOZzfVp5RDhPFrI3UuKMZW+NOzvVaogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8/lI7gL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8/lI7gL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCE93C433F1;
	Mon, 18 Mar 2024 21:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710796826;
	bh=mmeIpDM6O6H8ETB5ebqJX/A+SXAgcMKUp8XhlbEaq6o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G8/lI7gLrQ60vUE/TeBsmchnsWmBZMuMAMcJwqQOk6RLDhAhHO1niXvj0tEN4QzMz
	 3oyJVAJXqIs62wWAuJ/tzvnTQkTg+2lSLka4Req4JQKfI2xgzY9lUQsIi6Aph7AofB
	 sR2NeKEhhGtkbAA3HFJNgPagbw9G73Fd4n/++nHvfG1/TEPkCMMX//em7F0816xUJN
	 xRAmsAW83dvB92MdZ8Sf1AivD4XR4oGsZig+SMqq60+z9VeAh3BNdahvgQ4TlXvsC0
	 47+X5noxsfiE6F/euc1AhepE3HZvKSKmpMURE814EermvbHe64cqYXE1vFUP3X0gS2
	 9pwt2ryOrEJYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC3DA1469709;
	Mon, 18 Mar 2024 21:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/3] qmi: Discover timeout could cause a crash
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171079682683.31864.11297657489959559403.git-patchwork-notify@kernel.org>
Date: Mon, 18 Mar 2024 21:20:26 +0000
References: <20240318183754.71578-1-steve.schrock@getcruise.com>
In-Reply-To: <20240318183754.71578-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 18 Mar 2024 13:37:46 -0500 you wrote:
> Sometimes the QRTR discover timeout would occur simply because the
> control packets are being processed slowly. Handle this by extending
> the timeout each time a service is discovered. Then ensure the
> discover data on the queue exists before processing it, just in
> case there was an actual timeout.
> ---
>  drivers/qmimodem/qmi.c | 50 ++++++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 19 deletions(-)

Here is the summary with links:
  - [v2,1/3] qmi: Discover timeout could cause a crash
    (no matching commit)
  - [v2,2/3] qmi: Fix printing the wrong type for services
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=85c935720dbd
  - [v2,3/3] qmi: Allow QRTR services to be destroyed
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=a703d1cc8e7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


