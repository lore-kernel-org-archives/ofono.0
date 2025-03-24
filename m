Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4821425D1E1
	for <ofono@lists.linux.dev>; Mon, 24 Mar 2025 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742839801; cv=none; b=sgm/ELhSmvZGMet3Kbwz+6dEUQPiG8d8aDAKF7JkrBCA5zfCW86sJIJRpYn+HNi+Nxx35jCQKEk0lWHQ634M7IJeHQOOGQ7YmruQnjPi+YDbZxO5qSPR1qbIxth2pAwogHcJnEVxQTe/TJ/cLLUmGK3rOHwrSsTHw7gbzmGuzXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742839801; c=relaxed/simple;
	bh=yZTFpZNcgvBEfbxXxJkD8zNn5/uA0FUtwqt7ilFRLm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=meKUPNxvx/STivv8qNk7DPmPUfvyO7N/bpJ61bzyFPJ9RP1v7Sx3HHneFJM2DC3AzA0XvD1pjvdOEuWp+TaNxG1SRM38D+zAx5UNe8NdO90N6eLvd2gNF2wKxNgeRT7RWVOpBGgWYRnRIpkZMyMF8P9zv0i9KCPvyRhBEzX/4qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjlGiV73; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjlGiV73"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC090C4CEDD;
	Mon, 24 Mar 2025 18:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742839800;
	bh=yZTFpZNcgvBEfbxXxJkD8zNn5/uA0FUtwqt7ilFRLm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TjlGiV73QUrzXASaWWKRWfc6U0YjHotv7M7Si11ihg/gHUIJL10meb8Ht9LZrWzyo
	 +46zAW89vpKNvY4Onq2LhIiADKH7qChk49bVqBB7cVOsgDtHOpuqAvUvb3AFTuusni
	 xCTxNE3Mw0NJB3jqw/jKmGpF2doKnrs4Q4QizBpB+aWpU86QYXRZAC8jfclM9piLJd
	 8KeAMprHp3h7dbUuZdRghlpjvIIPqPCB6ka15d74KLRFtaS9DM7P2AvUlkhS1m0OpZ
	 B3pbPl5WBUXyziH1msxdaNykaCAbR3xsH3ds6HwgHcsBv43cRVgfPGKJtlwK7N3JEN
	 eaFet7wvG0OQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FE8380664D;
	Mon, 24 Mar 2025 18:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/7] Add QMI Device Service Request Rate-limit Option
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <174283983702.4120358.14720643842556294418.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 18:10:37 +0000
References: <cover.1742411889.git.gerickson@nuovations.com>
In-Reply-To: <cover.1742411889.git.gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed, 19 Mar 2025 12:22:27 -0700 you wrote:
> Certain modems, among them the Quectel Wireless Solutions Co.,
> Ltd. (2c7c) BG96 CAT-M1/NB-IoT modem (0296), have a firmware issue
> where they can lock up and hang (not responding to subsequent
> commands) due to high QMI service request arrival rates.
> 
> QMI service request rate limiting is achieved by:
> 
> [...]

Here is the summary with links:
  - [v6,1/7] qmi: Added enumeration for device quirk flags.
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=3a096f6fc033
  - [v6,2/7] qmi: Added structure for device options.
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=869db3348c6b
  - [v6,3/7] qmi: Added device options parameter to 'qmi_qmux_device_new'.
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c4b04bbc64e0
  - [v6,4/7] qmi: Implement QMI service request rate limiting in 'can_write_data'.
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=fd68bb5082dd
  - [v6,5/7] qmi: Handle request rate limit option in 'qmi_qmux_device_new'.
    (no matching commit)
  - [v6,6/7] udevng: Set the QMI minimum service request period for Quectel BG96 modems.
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=e546475a1816
  - [v6,7/7] gobi: Pass QMI qmux device options to 'qmi_qmux_device_new'.
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


