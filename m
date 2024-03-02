Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4C518E
	for <ofono@lists.linux.dev>; Sat,  2 Mar 2024 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709338232; cv=none; b=RfdA9C9oJgHNeRVMHGt3so8h//RsFmCw3uHa26gQWYhy/44+TlRTlk3zzbla1jOrLpSKjK2nWhT2jYqZXaqP+OHpN266VSUR9IB7FaEfk+ydydZeTtZF6F01WfXcb9VXqw0usZN1pIj2AnualxwjNi8CpwKXGPYAq5/s8BsLOzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709338232; c=relaxed/simple;
	bh=fqASdEp9OBq1pZEE87ISapjaPlNUx/Y5bsRN1WJH2C0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DLin3sE0mLNJpO95z0j6k4Cq9QqCcU3lEQhX+ENjyQDG3E4RauJafkMBUytGj8l2qg50+j9PF9c/MjfAfLFIriToriW+xHl7QWbWJKv+rKNZf5BTRX70wMon9sWu1WTWLY2nBy10I+JtzVQDR8p8SojsgJGjhh7SGKyQhmF6bzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opTFIQ5W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opTFIQ5W"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1384EC433F1;
	Sat,  2 Mar 2024 00:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709338232;
	bh=fqASdEp9OBq1pZEE87ISapjaPlNUx/Y5bsRN1WJH2C0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=opTFIQ5Wss+7bRCzyf8zO5FMFU4sMW6hX5JPcGyeW6fO3WX2isZlGi4M8vL/k0tHe
	 40fHDif82fKYH59dzOIxf6b2F6Y3biuQSUHOYCYgVbvfZlZlx6EL/GL7uoWUuRsVSL
	 73eNVR3gKgEo6ZY2QrvJ4MGY/PIKbrCvFjoXa4vT0vBAbu5IKqTtOu6J4TGkKprre5
	 wBRD474n9xtyDWZpJPA5De9LWWiXAqJGWHjWvMlPFNgcUQOssRJUNywKuj3Ke+9emA
	 heP3aDejYV3u9EE53yXVLOgyoJB+ZEKf8m2yMkAbLumg/+IjuOmZBuaAa+OaG+Ktdw
	 jpdBQLzhG7ItQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0045C595C4;
	Sat,  2 Mar 2024 00:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/4] qmi: Add an abstract group id to services and requests
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170933823197.22988.17254293661546481499.git-patchwork-notify@kernel.org>
Date: Sat, 02 Mar 2024 00:10:31 +0000
References: <20240301234539.1581017-1-steve.schrock@getcruise.com>
In-Reply-To: <20240301234539.1581017-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri,  1 Mar 2024 17:45:32 -0600 you wrote:
> This will allow services and requests to be matched without using
> the QMUX client id which does not exist in QRTR.
> ---
>  drivers/qmimodem/qmi.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)

Here is the summary with links:
  - [v4,1/4] qmi: Add an abstract group id to services and requests
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=0a4591e439ba
  - [v4,2/4] qmi: Store the service info in the request
    (no matching commit)
  - [v4,3/4] qmi: Clean up the __debug_msg function
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=afa96ae4fa99
  - [v4,4/4] qmi: Enable QRTR service writes and reads
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b7cd8fc2b15d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


