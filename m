Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C5C181332
	for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425629; cv=none; b=KarzzTQslBO6BF5D8GDDE2fNGdaspUDD9ea62BKgtgzlDhPMfKK2LkQ1YSko23xUx4POpq0FR7hTV03WwE2+bVDc5i/GWc6SNvo7eoq7UbO8GwLrntvapatcWZqi52nmFxWq+j15Im2hI1M7G9qBRoklK6GaXEKUnk8qhIt4oPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425629; c=relaxed/simple;
	bh=6ZzwSYsmWtVK0BwHGNKT2ATdNiu7WiHbrxnSoRrpO8c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FYMpdRhHotF15TKCWtQnlKFwXbHEmr1QGLAtgvgUKLPLzvsY7qXXfh8BDy8+bF3bp8lb18Do6Ikvz6TLkF6gw2y2sLb13eiemLEaG85gzAyG0FrzpgmKlnanWusl+bMh3wL8dx6wAigGPMeRHyoXxlHKh70plCe1vJLAXzXHq3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMovcTPv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMovcTPv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E77BC4AF18;
	Mon, 29 Apr 2024 21:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714425628;
	bh=6ZzwSYsmWtVK0BwHGNKT2ATdNiu7WiHbrxnSoRrpO8c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IMovcTPvBouQUqjRo1GQ4KNBvi80A6qcCl020q3x66jMW7yvXCLgGV75OqsC6Y5TO
	 Rz/3ppFErTvp/kZCM90TwWXrbd3UJcRJ3LnCkPP4Vijw5FJY0M1kE/TzXPhsuhuBHj
	 lyq2PDh1d0Z7giKoTfXITnzPpsw7Mcuet3hcjMI6ILXQ7wffgMugPbxlmi5BO9Sh7f
	 E4GNx+KhBGpvErmBVn2rwn4SGI1/6XreJczwiqXl5fCockQ201UWx4vKxtJ4VzWUy5
	 SpuNud8dNjEXbHDTjUC9s7GcwVLUI7ABd1UonfJJbBOjDJ3Y7E2GKLaEgYjrXRX95X
	 ZlhoNZZ5cT+wA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DD2DC54BAA;
	Mon, 29 Apr 2024 21:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6] qmimodem: voicecall: Implement DTMF tones
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171442562844.1063.13340335685023307335.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 21:20:28 +0000
References: <20240426212235.2627-1-adam@piggz.co.uk>
In-Reply-To: <20240426212235.2627-1-adam@piggz.co.uk>
To: Adam Pigg <adam@piggz.co.uk>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 26 Apr 2024 22:22:03 +0100 you wrote:
> The send_dtmf function sets up a call to send_one_dtmf, which will call
> the QMI_VOICE_START_CONTINUOUS_DTMF service function.  The parameters to
> this call are a hard coded call-id and the DTMF character to send.
> start_cont_dtmf_cb will then be called which will set up a call to
> QMI_VOICE_STOP_CONTINUOUS_DTMF to stop the tone.  Finally,
> stop_cont_dtmf_cb will check the final status.
> 
> [...]

Here is the summary with links:
  - [v6] qmimodem: voicecall: Implement DTMF tones
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2da052747738

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


