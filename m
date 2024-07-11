Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEA61607A8
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720415; cv=none; b=awhNyPS+E1tkoQBMe4/hj5hPVhdNmHjQasDTYf0mCg5F8vHvORoa7yT20rO8BLRUjlRQLOKqyJVXbSm/VWcod603rlGv7tPo/XqI8xHtn7Oqx7IpuPR7EXDDbmk0TTR/5F1rWf7WUJniq1pkdjxt5oP5l8yaRK0x5XCmpqfCjQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720415; c=relaxed/simple;
	bh=9AmnsKA3OY5FpZOm3+Fo3WXERuGmm2rzBIvJ+AMaV4A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UsLkwIpDfRSqMT9RtRCzHicJJndGc4V0KbucxwWd7mTR4Dmn8daJthM4qWjJHjdsTeF8/jDaBcY0RniJMIU3Xhp5JfuujlxGJN0O5O63y7v7kdiUCL//F0bgdJb0Fh3LQe8kvgRFAHFln3eA8hR39/kWqcUN9M24JFGgqHHoWFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alFbs5vS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alFbs5vS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6194CC32786;
	Thu, 11 Jul 2024 17:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720720415;
	bh=9AmnsKA3OY5FpZOm3+Fo3WXERuGmm2rzBIvJ+AMaV4A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=alFbs5vSa0/9/2qgcNTOvtHH5cYcEkhdq5BC2GZgT7ueXv3sf/nwcvpdFkM8CTIYM
	 F7LXI+uUROo8tOCJjyIWeB/CWq/FrJgCBUmGYkW/2vwL2EkpNzs9iND8uqelm/G+x8
	 i+Dtg9E5MqzFVozgdDxpzt5B7Y/BApMTS+fS2dtRg7KHUdV22263YNXYBbs1+Ay5+d
	 0HkUfS3vO5SZugc7U1TfhsfpVZiBiKSgBv8ktWWYp2hqk30g0s9vJ6MaVO6GONp8i7
	 2ZGvr5MccJkWpY6y2HiDUQEJ0p4OICJcstn3Fj9SaTeBAKX4qSAqhUt+OYMhiwlATi
	 RlgGLOWHC6Bvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 575F1C43468;
	Thu, 11 Jul 2024 17:53:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/11] gobi: Limit number of premultiplexed contexts to 4
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <172072041535.1229.9085785535052786582.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 17:53:35 +0000
References: <20240709225047.1427626-1-denkenz@gmail.com>
In-Reply-To: <20240709225047.1427626-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue,  9 Jul 2024 17:50:20 -0500 you wrote:
> 4 was chosen somewhat arbitrarily, but it is the maximum that the
> qmi_wwan_q driver can support out of the box.  The only limit is the
> number of clients under QMI.  Two WDS clients are typically required for
> each active context, one for IPv4 and one for IPv6.  The total number of
> clients cannot exceed 255 (uint8).
> ---
>  plugins/gobi.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [01/11] gobi: Limit number of premultiplexed contexts to 4
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=3076113d2867
  - [02/11] gobi: Request dedicated WDS services for contexts
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=a47296c79b10
  - [03/11] qmi: Enable _auto_ use for some classes
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b46004b53763
  - [04/11] qmi: gprs-context: Declare qmi_service objects using _auto_
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=766aa0ac819d
  - [05/11] qmi: Pass two dedicated WDS services to gprs-context
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=151823bdc330
  - [06/11] qmi: gprs-context: Remove parsing of unused TLVs
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4921cfec9723
  - [07/11] qmi: gprs-context: Treat IP family TLV as mandatory
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=90db5ebd6aef
  - [08/11] qmi: gprs-context: Set up WDS service for IPv6
    (no matching commit)
  - [09/11] qmi: gprs-context: refactor detach_shutdown path
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d617baf9e089
  - [10/11] qmi: gprs-context: refactor deactivate_primary
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=f25f481d45e8
  - [11/11] qmi: gprs-context: Dual-Stack context activation support
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=3ee784aa9d9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


