Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F8C13DBA8
	for <ofono@lists.linux.dev>; Fri, 23 Feb 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712429; cv=none; b=YCFu1tzaCco5IOICcVHhiXUUBUz4xOUjebJroSChDCrLxAvb2/w9oN0FrR1xWBtASFqHxbL0oupbmu1tYaCVMEejrPNTYD7cKHL+L3JrmNIve8F3Q92hhNthf60tNTspat8WI3Nou5/+DsWT/rXJebnBxZ0iJmEG2/nrNCt7tus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712429; c=relaxed/simple;
	bh=je893GMZHdJsW8NOnPGYIMLpzOlTXMPFD3aVk+JhLmw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tiQ+spmEzMEHLX6Y+7Py+qZLk02MSMbNuO0HuJ03xs+iAmnJ3iWRR6vUrlJdUchs77GE0hSj+rcRs/DY6oz/bB35dDXsQmgHEal6uKEwh4nJKPrPCDgrpQscYoBYxCxsHT+4VNBOS3hxwqDlI+0aU57ebZISsuenTx3Q/A7WOrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2guKOPZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2guKOPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 755E9C43390;
	Fri, 23 Feb 2024 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708712428;
	bh=je893GMZHdJsW8NOnPGYIMLpzOlTXMPFD3aVk+JhLmw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I2guKOPZu6vfn2gZXhcsJTdxs58ZBXYCfHDScGsb9bwkd8tT0HqMP7lWWFdIxR3/f
	 Nfn1M/RVEDM9xBezeN9BBYKQ6scxCQ4WBiLryBzMkkMrU3VBzW+cft4sSuqdwRM1Jt
	 xwNY5+t3xJoA/yN2G7J25vyyd/u/3CkikbSiIUyhXFFiklMeKfe+ms/6b1c5KZ4iMj
	 xLBAEN7m+8o5uLvViGYQyWmJ6xEf/iVqU2MESyzlxuAgoZzfG13Az/Bm//oV/9YW85
	 5eP/Mx4HffNuAaE8aWH+wq+OiGXmcPz01dn8oVu+cPqNP+/sRhm5ee5RZIjHi5MZ3Q
	 5gAAWFuIVvI/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CC23C39563;
	Fri, 23 Feb 2024 18:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] qmimodem: Use l_io instead of GIOChannel
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170871242837.10157.2157490856546474414.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 18:20:28 +0000
References: <20240223173552.31622-1-steve.schrock@getcruise.com>
In-Reply-To: <20240223173552.31622-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 23 Feb 2024 17:35:51 +0000 you wrote:
> ---
>  drivers/qmimodem/qmi.c | 79 ++++++++++++++----------------------------
>  1 file changed, 26 insertions(+), 53 deletions(-)

Here is the summary with links:
  - [1/2] qmimodem: Use l_io instead of GIOChannel
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=5d05b1806442
  - [2/2] qmimodem: Remove the final bits of glib
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=f2fa9547c4a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


