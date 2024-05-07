Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2015916D9CD
	for <ofono@lists.linux.dev>; Tue,  7 May 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100028; cv=none; b=XbrwTliDUsI/zGBfgG+qWAm7F4F2P3iSjWIhPwUfqTmiHLwRDYUeWFbPUNpJoGnySSjteFxAMwR2eplaneULCocac2txt6VZv3yvsqol3rxHrc46IdTKy6vaFs5GDyS3/uNsmvQpKPzxcaK3Cgdj0rw9Dj9w9q8D45UISiNWtkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100028; c=relaxed/simple;
	bh=JrP1M4Xak/w1SiDUEuuuprNmJbH1rueX/zILFhFdAaQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AoJzBEFSVgxFhr90X12DPgA+AXj4aQ4UPSWoSK/VpWpd6rwSrX+fpG+1E9/xLDFmFHbFxFyFIXkg4N+lubM1kbs+ojzkd/fyB4ZNoHw0t+MU2+KhMUYy0Nh8k1yMmZ25ZILrU5APEQHQ8F6t2xNMLnmoROQvwUkcHIWTRqcXWoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVSl1Kpn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVSl1Kpn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4034C4AF18;
	Tue,  7 May 2024 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715100027;
	bh=JrP1M4Xak/w1SiDUEuuuprNmJbH1rueX/zILFhFdAaQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QVSl1KpngZ/hZt9oc5+wVbH6E0vya/GszBHeDlz8HSJL4FDNj6jgxmrP8gc6YW6iw
	 1xJngRAQNfWC+xr7lT72hVBNeI51XtScAtWlAt2kb1YmF4Ky5CZFFHZSUFfGnVYgJU
	 TfRq5aF4XkT5OKgvseDwmOXhyXGVsjcUcTDDfhStn92X7giitJxr6s4UW5SubS1nIg
	 JUX+UbDx49pjeeth2/w2VgBQqtFsysMW06tAS+urivtpyIvYLY2KaCnhlYg1qurmwd
	 My1G1rHREOf+++fB2agPG4SDlsSsv7qQokcy5ePrAOKzOToNHY/crmsppbjOp3hWEr
	 p476iw/4FU7Qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9ABD0C43330;
	Tue,  7 May 2024 16:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/1] atmodem: sim: when reading sim files,
 avoid incomplete result lines
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171510002763.982.5301935839763059040.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 16:40:27 +0000
References: <20240507144618.33676-1-c.ronco@kerlink.fr>
In-Reply-To: <20240507144618.33676-1-c.ronco@kerlink.fr>
To: Christophe Ronco <c.ronco@kerlink.fr>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue,  7 May 2024 16:46:17 +0200 you wrote:
> Hi Denis,
> 
> Here is the second version of the patch.
> 
> Sorry for the delay,
> 
> Christophe
> 
> [...]

Here is the summary with links:
  - [1/1] atmodem: sim: when reading sim files, avoid incomplete result lines
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=7802d80a9619

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


