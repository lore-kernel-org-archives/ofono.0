Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D73137C4E
	for <ofono@lists.linux.dev>; Thu,  2 May 2024 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657834; cv=none; b=NvBSBq3vORMqrRQooI9La2siOsJYNrdN/9B9ZcLXn5JhYIWKp3zA6xXJsVbWcsTmLz3fWXdYIhP2U4MOMTy/0wDfhrTKv3ikRLKtiHh32OAIC9fMP077/WgqrWn/8b9gzXFAGQhgeCiUPf4+cx0MQzC2oxC5dOSd2R/34M34ZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657834; c=relaxed/simple;
	bh=eKsBLlOnFMb8vF1C9wVRo4TVKXUf5RVPokuMWSmBBlM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OyfXQhGtuZy0NCdanwiaWbWK0Kgd6qL0xiLx1go0Lq7a6xGnl8fpxqOS/rf67ic+7KiGYUx/2OzIGkgjwtz++052clSf5jFTT7x6s5LFp8M47HcCT+xfB0hAWVroqg3xnrtAlRX4DmmpfsxsaMOKVEgkNSYQvfm9Nb8pyI72nT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvX8XQ6S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvX8XQ6S"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90309C4AF14;
	Thu,  2 May 2024 13:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714657833;
	bh=eKsBLlOnFMb8vF1C9wVRo4TVKXUf5RVPokuMWSmBBlM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LvX8XQ6Sq0a8fa+l45uB1KTKZKNYx+pIvPGBv9J5qOfzrYeMQjSMH+3Y3m5JpWiAK
	 Cd1PW+RAvkoCso5mOvn4xVoBp2rCBAnW6fZAgiYJMqfBl/7RmNF9SyQRKgUqe6ibzy
	 atQSHna/g9mIiO/FZ5g2jgLl6h80w4NIvzrdD2QVb4GceJRxtMQQedFanmFn5vjVfi
	 M823KKK53MGyJnfxbELtbxq1JjIHMH1eB9I4QpFe3entzHt5rF1vOPbB85PDOa5l2/
	 kzotAGqCAs783A5URaT2Js3gqs9TZNnMmlaB+95mXzjjN5Kw71HyEu+Kgkuov6ksKd
	 U1M00xA2Hjoew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C823C4333C;
	Thu,  2 May 2024 13:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/6] qmi: gprs: register to NAS indications earlier
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171465783350.10698.11672890778916453878.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 13:50:33 +0000
References: <20240501232144.14025-1-denkenz@gmail.com>
In-Reply-To: <20240501232144.14025-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed,  1 May 2024 18:21:28 -0500 you wrote:
> We can register to NAS indications much earlier, as soon as the NAS
> service handle is created.  Since the handle is now a 'lightweight'
> handle, all service registrations are automatically unregistered when
> the handle is destroyed.  There's no need to track the registered
> indication id and to remove it separately.
> ---
>  drivers/qmimodem/gprs.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [v2,1/6] qmi: gprs: register to NAS indications earlier
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d61fe2752b1f
  - [v2,2/6] qmi: gprs: Split out GET_DEFAULT_PROFILE_NUMBER request
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=5c6fc832ce25
  - [v2,3/6] qmi: gprs: register and listen to event reports
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=9a0deedcdefb
  - [v2,4/6] qmi: gprs: Register for other notifications
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=92a122de4a05
  - [v2,5/6] qmi: wds: add utility to parse Data System Status tlv
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=e075175baff2
  - [v2,6/6] qmi: gprs: Obtain LTE attach parameters after indication
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c12a6251b1fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


