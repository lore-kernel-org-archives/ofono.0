Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8AE155CB3
	for <ofono@lists.linux.dev>; Tue, 30 Jul 2024 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358232; cv=none; b=T/0g0QAs2Ozbd2yIWxsORahgqZpyS/iQ6KsYClBcATsDdhcw99VN4qnXJgNbOI7WNgqwjjAhPbiZMo8gXR4PwohT+5eblAiMtW8eeWkNrr+cUNV4/7AWPQk6LsCpOEG8v5PYNKNgDwoskqHb7lNgNL93QpoexBKyTV3FaUd7yBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358232; c=relaxed/simple;
	bh=+KIK+rO9FokaugsZy222fv0r/ZkTNHXdNiG22cc9fUQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=teu+01uZfNsQ+q5HV5iD5xXwtlkfh95i+T7DoUJQ0uuXfHD53YsJaN7WIS67EnyDqmvpwpToRBuhtjlGnWju94XREIKYRgNfAAeUQovmJ6wM3hHDjtMtiPGhmgd9uiiF6d3ZQLv7DTZh0aflgRTuWiDdh5AxQK4SMpB0sKg1lWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVnoMhV+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVnoMhV+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A553CC4AF0F;
	Tue, 30 Jul 2024 16:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722358232;
	bh=+KIK+rO9FokaugsZy222fv0r/ZkTNHXdNiG22cc9fUQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nVnoMhV+cBErsvADiD7gVWRFHjKHeEnJhhczqpYxQjT416fQB3dCaImB7SMyzoMuD
	 Qyn/Ho7wDbl84fDCvYtTW5NfeTU1rQX9xCU3LoaYOwXQ/pNvpDNmA1VjlGAAE7yH5X
	 lcGD28fzi8QgJ7TDouOEWCnp4U44lSI62DOxISqHMqCKCAvxLRyuyt1d4Bq9Gz2dm/
	 0kLe5KoqnpQjETZwfUWBcxoUNx7hY93E0TbgjWe0ARfegLdC9jHpXhx5XRu43u4EPO
	 W+wKTSYjjKF3jIr4RMjtmT0elY/AnvTJNmfBOJozmUQP/dSWK1QF0RVhqmRg1g+9r0
	 QNJYeA7clQdTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95E01C6E398;
	Tue, 30 Jul 2024 16:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qmi: Allow qmi_qmux_device_discover be called from callback
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <172235823260.23339.4016099413210300489.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jul 2024 16:50:32 +0000
References: <20240730034738.222227-1-denkenz@gmail.com>
In-Reply-To: <20240730034738.222227-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev, piggz1@gmail.com

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 29 Jul 2024 22:47:12 -0500 you wrote:
> When the gobi modem plugin performs discovery, it checks whether the WMS
> service is present in the callback function provided to
> qmi_qmux_device_discover().  If the WMS service isn't present (likely
> due to a timeout from the modem firmware), device discovery is
> re-attempted from within the callback.  This functionality was broken
> since the qmux->discover.tid was not set to 0 until after the callback
> function returned.  Allow such re-entrant behavior by making a copy of
> device discovery func/user_data/destroy members and de-initializing the
> discovery structure prior to invoking the callbacks.
> 
> [...]

Here is the summary with links:
  - qmi: Allow qmi_qmux_device_discover be called from callback
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=ea91f966e36d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


