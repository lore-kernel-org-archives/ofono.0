Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1680046
	for <ofono@lists.linux.dev>; Fri, 31 May 2024 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183832; cv=none; b=dlvtq/bDWf7hxSuOfN99MwiNaXlhUigHAVS3s0Cdy1n3ir508YV5CBpjKC+18kNz0jcO6CT2/1OqoxHEu6Y9ioP6z6liQRokNxCq4p+2YwvCNCcY+yJj26jzu9+8yAgXrXZ6ORfEBqTLEJzlEAMVqdTmqUJHV+UwiTwOeYpklSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183832; c=relaxed/simple;
	bh=cbFsJdezxDRi8S7nI4iIqADtzqfy1GSJxfEpbIELDz4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LHm+ry1vSaFcAGvbU4aCW4PblzChKL/nYuDmgWBPshri/IUq89mTtGe0WJud01Ngoc6EfaX4V9Yz1scr90eUmgJlHBJ45ZU1GdKNa33z42rTssR74vKpvdzH93OA+WCyx/LI7Uu50UTHcidpbxKLYQSm2bRGN9fVCtFJFzpFfUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbThFGCx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbThFGCx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2907CC32786;
	Fri, 31 May 2024 19:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717183832;
	bh=cbFsJdezxDRi8S7nI4iIqADtzqfy1GSJxfEpbIELDz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lbThFGCxMbPzmNahA+CbOOAUvWeZx86uY0nHDGpeySA10W/8HcuXk3VHpLe9UD/lL
	 jgJywg1LbYFkVkSuKFmcF/wSDE6S8ZpikOt+bhwbdzuS72XqIuQfd0eIiCFGRmYNuU
	 x0USm1T5KYwJ4nucuWK1uOXdWPySsNX9+3ahjvLT0lMtHWt4HFfHJaRmsC4T/z8LDA
	 qSfNUnOS1ACHb88b/tVwyfotz17UGM9bpogN7UcAiU3lM+ysZIAq6CyreWR3P3jea6
	 lm0fRW/ItfBnW6cgHXiWhYp8FaA4W6FG5dwhFwBBKEbcyfwp1Be31XK3CfE3hPDrxJ
	 9Vro6IXAQsXuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17079DEA713;
	Fri, 31 May 2024 19:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] udevng: Don't crash for non-QMI devices
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171718383208.26653.10116219006138198496.git-patchwork-notify@kernel.org>
Date: Fri, 31 May 2024 19:30:32 +0000
References: <20240530152513.279243-1-denkenz@gmail.com>
In-Reply-To: <20240530152513.279243-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 30 May 2024 10:25:02 -0500 you wrote:
> In cases where the modem detected isn't QMI, do not crash when trying to
> print the qmi devnode.
> 
> ofonod[278551]: Aborting (signal 11) [src/ofonod]
> ofonod[278551]: ++++++++ backtrace ++++++++
> ofonod[278551]: #0  0x7a779c5cbe20 in /usr/lib/libc.so.6
> ofonod[278551]: #1  0x413470 in setup_sierra() at plugins/udevng.c:497
> ofonod[278551]: #2  0x410a67 in create_modem() at plugins/udevng.c:2557
> ofonod[278551]: #3  0x7a779c80b551 in /usr/lib/libglib-2.0.so.0
> ofonod[278551]: #4  0x41955f in check_modem_list() at plugins/udevng.c:2626
> ofonod[278551]: #5  0x7a779c81f43e in /usr/lib/libglib-2.0.so.0
> ofonod[278551]: #6  0x7a779c81e199 in /usr/lib/libglib-2.0.so.0
> ofonod[278551]: #7  0x7a779c87d3bf in /usr/lib/libglib-2.0.so.0
> ofonod[278551]: #8  0x7a779c81edc7 in /usr/lib/libglib-2.0.so.0
> ofonod[278551]: #9  0x5291e6 in main() at src/main.c:316
> ofonod[278551]: #10 0x7a779c5b4d4a in /usr/lib/libc.so.6
> ofonod[278551]: #11 0x7a779c5b4e0c in /usr/lib/libc.so.6
> ofonod[278551]: +++++++++++++++++++++++++++
> 
> [...]

Here is the summary with links:
  - [1/2] udevng: Don't crash for non-QMI devices
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d5daaeda9d19
  - [2/2] udevng: Fix detection of USB attached tty devices
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=ddb637fb784a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


