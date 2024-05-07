Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7437A44C6F
	for <ofono@lists.linux.dev>; Tue,  7 May 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101228; cv=none; b=ecUUd5hJyGMih8Oe6dJliVmYyFqKgZP17ipwwYPRpW8ffDFMICIZK5Rbv7ON5r7q4U1fgmHHZlaiKVZ9Dtpd2zj5ODILsFHfaAi5I1cNwPgmDjMcWI7JHOe/XRIYwr239ReufEJ+u7xWkmEYiIl0L3r0OzSHjakLaC8x3Mm0v4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101228; c=relaxed/simple;
	bh=mbwkHCLKhZeCy5/eAY20/g/+aDXTZpbzJBus5xeY3us=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NQhieKGKMKw+gHKaMz04TkuIu2kHLgzWroXS96e0zZhZch3dmPcK8h9FX6Zm4CVYCK9658KlRSxd0Am5vtHYNXU0v4Kbm4Tr9Hg1oeDZJdEp32EB9TqEwBn38pN+OIY0eLL5Su8OSXCalvq8i4uBMeXkDiVb+8fqkkOcMV2jwis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUtcKW7k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUtcKW7k"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11999C2BBFC;
	Tue,  7 May 2024 17:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715101228;
	bh=mbwkHCLKhZeCy5/eAY20/g/+aDXTZpbzJBus5xeY3us=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TUtcKW7kJ01dp/bnEzvFmtNSYaAYmMfNUptOG7IrpOqTINcLFI9p94Z9dFcJk4ARx
	 mS7lV1fAYXlRf/BklYnpBYtxjDaycjoqzc9/KI9/AKKotZT1ljV8zEqyMr6lEVo6WS
	 KvGpNeEYb+gvemWhbkMHNbnXuuz4bzHT7VHzGQiRCj+0SVjbqVL+Kv5XC2GjPT2Zs4
	 1OGKYxqC+ZlNrKEIrVu57yleW6tdg2AHB42WX4T6QcFJyqJPZjdxahWqeYD+hICx89
	 UnC8SoVvaD5bdEOzTjNho2Dxl/8rxA8FxHu4UdmzwL9xqeVLAuB4D4EO2NTcONOPXL
	 l8BvzC4eq1heA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0C2AC43330;
	Tue,  7 May 2024 17:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] qmi: Separate the pending family creation queues
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171510122798.14353.9080094163650157369.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 17:00:27 +0000
References: <20240507160353.683868-1-steve.schrock@getcruise.com>
In-Reply-To: <20240507160353.683868-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue,  7 May 2024 11:03:47 -0500 you wrote:
> The family_list hashmap is keyed by the client ID and service type,
> unless qmux is creating the first client for a service type. In that
> case the high bytes are 0x8000 instead of the client ID, and the
> value is a queue of clients waiting for that service instead of the
> service_family.
> 
> This commit moves the pending clients into thir own hashmap to ensure
> that each hashmap contains a consistent type and eliminates the need
> for marking pending keys with 0x80000000.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] qmi: Separate the pending family creation queues
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2f11471e0dd7
  - [v3,2/2] qmi: Move the pending queues into qmi_device_qmux
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=309b7b263d1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


