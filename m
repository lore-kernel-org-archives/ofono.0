Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8350D2F50
	for <ofono@lists.linux.dev>; Mon,  8 Apr 2024 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712616027; cv=none; b=H5VB+i0pVQ019PUt2WWLHD+JMOScb0enoiJH2S5YvBQ1xYRGMSbNRkMH16SLoHxTei+GNP8VaxkeQVUCcFjRxsO193UDMWAei/nl/sxeVdO43xd/zPY7UN2UfZiQ3pXvnkhPC43jLOXDrRaIZa7CYr5r+M9D7rvBIWxDb2YaTmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712616027; c=relaxed/simple;
	bh=+A72kEE+DpPv6XAv/7G+iuaj5jZ3h/QLl4OezxMKoTg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A0jiewTeMxYVqkjYbxS0wG2czR8xsl2hFrm++rNBCVC/zQ8O7JfCdZNlrXbn5znhUeQTp0HBfJz4DtLxTEfwhEO3mJAyJcOt0oBH6Zf8Zqk4Rq4mQPpez89JPRos4CSVzFc+609qiwwRqCv01kuuVeN3QnYKSlOIkieaccl8NGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMEndTcz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMEndTcz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60CCBC43394;
	Mon,  8 Apr 2024 22:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712616027;
	bh=+A72kEE+DpPv6XAv/7G+iuaj5jZ3h/QLl4OezxMKoTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jMEndTczd6o54y+uTRIIa/wCwVPFGLYHF5FdQn4CLICsRTfyQO4de7KDNI8g8r1Xv
	 bBFa1cbgno/GO54NW0j8j1jGv3blWdU+MuMciOSRJLGlrNJRNCOPObd5YGiESlyaEe
	 dhFGlBZfHSy7ZN58dtpIKb0zBfnJxkY3NUmak7keGgZebOS69xjqy0wazAVfyNV8O2
	 LSaOm0qTPc0AG8TwxDP/ZuVkKSekg17mg+00ge1cKZnOwKtaSQ9j30D2Wyg/cjFYvM
	 wxBSOHwQ5685I+kj2t6h6WE57Is2aW8GIbXjKDVZTpSYdYIQ1xwkqu4UrXReSeV2Zm
	 Gul8+FxMSCSSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 541BCC54BD9;
	Mon,  8 Apr 2024 22:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] modem: remove atom entry prior to invoking the watch
 callback
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171261602734.14139.16912092696255016895.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 22:40:27 +0000
References: <20240408200905.2983892-1-denkenz@gmail.com>
In-Reply-To: <20240408200905.2983892-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon,  8 Apr 2024 15:09:03 -0500 you wrote:
> In __ofono_atom_free, the atom is removed from the list prior to
> invoking __ofono_atom_unregister.  This ensures that any invocation of
> __ofono_atom_find or __ofono_modem_find_atom() will fail to find the
> just-removed object when invoked from the atom watch.
> 
> The above does not hold in flush_atoms() implementation, which can lead
> to surprising results.  Make sure that the atom is removed from the
> modem's atom list prior to invoking __ofono_atom_unregister in all
> cases.
> 
> [...]

Here is the summary with links:
  - [1/2] modem: remove atom entry prior to invoking the watch callback
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=a4e8c26e4bfc
  - [2/2] hfp_ag_bluez5: Fix use-after-free
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


