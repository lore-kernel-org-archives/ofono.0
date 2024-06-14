Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6721AB504
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377836; cv=none; b=aG7XeH2NamVl2BxA26Z41NNupIItzIvwovuo0Z8HLxemFqpPIhAJurFNXvCr2G4TzyClK0+N66ic6sYLOse6Hy8D/YnibIYS0D4XRxT1L0P9ETZJ9fiRKV4U3MViKNMY1rek7UsPJBBBcwyc1BBlKiHovPQ3y44+adV3vRArbiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377836; c=relaxed/simple;
	bh=sZP55Zce5gVugzTt0BcRNkkCEFTf0/Znbr/P4QT2P2o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dm/H2a2WygXS8FjpwvKkRaEruj/EYXHDQbRPa3Nm0AAp5HVhsk9MonyKuEqPnDwg4uN+x5tkPDkDjHFR7f4Tgu2Xi8bEGbtb6Z1opaFfTnsOWOaHuMVG1e5XMX6A5uphSIt2+zbAmU1IpDcDXRNIPwa/60ACrJvWsuQBiyj2CRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwPWIg9A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwPWIg9A"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 913B7C4AF1A;
	Fri, 14 Jun 2024 15:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718377835;
	bh=sZP55Zce5gVugzTt0BcRNkkCEFTf0/Znbr/P4QT2P2o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TwPWIg9Agyki1DARjCigZRu2e+xFgNgKjgv9b7eoLzgSmHCGBzkQm9c1QPvWaa8pF
	 c+s0CokJSeuuaVFBCG3SVEqARr3/8jaDP1cc+FlEFAIweNZLmCkQxS/PszUwjlhn7x
	 C8jKPoqAGYOypd7jwE8y6GiIq9qx4lnQwEzFB4fTRyfP8tD7kv5XFSKdRhg0wWfHMM
	 vViZrJGN+rU+dWkeetA63LDI/5I1BW4zklFzDWjMJdDd2sNhbwjyP7bHRIp2NyfTN1
	 otljProUS0IJa7LhCrWsrF3Rj2G/Ny4Db1ZL/+yehe8drh160jSj574JcCvtI9Chsh
	 voW9hRrYIGPsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E385C43612;
	Fri, 14 Jun 2024 15:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 01/23] gobi: Remove phonebook and stk atom creation
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171837783550.28406.5528756557893028203.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jun 2024 15:10:35 +0000
References: <20240613214134.1056517-1-denkenz@gmail.com>
In-Reply-To: <20240613214134.1056517-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 13 Jun 2024 16:41:10 -0500 you wrote:
> These atoms do not exist in the current qmimodem driver.  Remove them
> until they're added back in.
> ---
>  plugins/gobi.c | 26 +++-----------------------
>  1 file changed, 3 insertions(+), 23 deletions(-)

Here is the summary with links:
  - [v2,01/23] gobi: Remove phonebook and stk atom creation
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=540689ac89b5
  - [v2,02/23] qmi: lookup shared family directly by type
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=eda7b48d5737
  - [v2,03/23] core: allow multiple args in atom constructors
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=27c8b1d178c3
  - [v2,04/23] unit: Update unit tests to the new API
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c7ece29ab1f5
  - [v2,05/23] core: Support register on probe flag
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=063856a2ba93
  - [v2,06/23] qmi: introduce qmi_service_clone
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c6226a486eb1
  - [v2,07/23] gobi: request needed services at .enable()
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=67a899089ac8
  - [v2,08/23] qmi: devinfo: Drop use of qmi_service_create_shared
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=97dd4a15230d
  - [v2,09/23] qmi: sim-legacy: Drop use of qmi_service_create_shared
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=ab6c6d22a7b9
  - [v2,10/23] qmi: voicecall: Drop use of qmi_service_create_shared
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b4d86ddb4bb1
  - [v2,11/23] qmi: call-barring: Drop use of qmi_service_create_shared
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=5ce6c2a31ed3
  - [v2,12/23] qmi: call-forwarding: Drop use of qmi_service_create_shared
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=bb9f9390831b
  - [v2,13/23] qmi: call-settings: Drop use of qmi_service_create_shared
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c43de054332a
  - [v2,14/23] qmi: ussd: Drop use of qmi_service_create_shared
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d627f3d6b991
  - [v2,15/23] qmi: location-reporting: Drop use of qmi_service_create_shared
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=0f2341fe9753
  - [v2,16/23] qmi: sms: Drop use of qmi_service_create_shared
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b5c96dee90f6
  - [v2,17/23] qmi: netreg: Drop use of qmi_service_create_shared
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2af37b3a96c3
  - [v2,18/23] qmi: netmon: Drop use of qmi_service_create_shared
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=75dd97480610
  - [v2,19/23] qmi: lte: Drop use of qmi_service_create_shared
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=48230640815e
  - [v2,20/23] qmi: gprs-context: Drop use of qmi_service_create_shared
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=841b2e5d3f8d
  - [v2,21/23] qmi: sim: Drop use of qmi_service_create_shared
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c571d73dc1c7
  - [v2,22/23] qmi: gprs: Drop use of qmi_service_create_shared
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=607e7ef2f89e
  - [v2,23/23] qmi: radio-settings: Drop use of qmi_service_create_shared
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=1e4b61884a6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


