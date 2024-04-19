Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36D728F0
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545595; cv=none; b=Duhs9jkQWQW6V6AZn9806DtBNMfMu5jY8TtbOlcl2HfSFu901Jxad0rb4YihRY0SZ8Ujx0vOI9TorNcjivGn29FssnwTsCFVXDa9mg9E7T03QXwJPmG2N2m7+unPSXeE3AxsX7UUqlavVrY2msm2vF1CmDeDUdGXLLGYGtAhT4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545595; c=relaxed/simple;
	bh=VSKRukLiP+F7OVV8pFPZ4uWtYfValbiiW6B09Bmc2f4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QYUhjAA+T83OGxs2SC3tFSGH2waNDZVoJeLOs0zGZ/xdzASWDyc7ubPi+M9znwPOnbGhCKUVCwMj6XsBbFWoWB4TtflOgFASkvAoOkqZJYqFzPXYM+89tXE0g2gh3k2hK5QthwLsfS00Df0IBqusc/TuCXywhjsBblaNDZBdG48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4fefc49c.dip0.t-ipconnect.de [79.239.196.156])
	by mail.holtmann.org (Postfix) with ESMTPSA id 2F98ACED24;
	Fri, 19 Apr 2024 18:53:06 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH 1/8] qmi unit: Link to dl
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20240419164458.36078-1-steve.schrock@getcruise.com>
Date: Fri, 19 Apr 2024 18:52:55 +0200
Cc: ofono@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <F63D5489-0513-4705-A7AC-D5F484AA6E79@holtmann.org>
References: <20240419164458.36078-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hi Steve,

> One of my VMs was getting a linker error when building
> test-qmimodem-qmi in maintainer mode:
> undefined reference to `dladdr'
> 
> Add -ldl to fix this.
> ---
> Makefile.am | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 9a6f82c39552..a4880036eaf5 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -932,7 +932,7 @@ unit_objects += $(unit_test_mbim_OBJECTS)
> unit_test_qmimodem_qmi_SOURCES = unit/test-qmimodem-qmi.c src/common.c \
> src/util.c src/log.c \
> drivers/qmimodem/qmi.c
> -unit_test_qmimodem_qmi_LDADD = @GLIB_LIBS@ $(ell_ldadd)
> +unit_test_qmimodem_qmi_LDADD = @GLIB_LIBS@ $(ell_ldadd) -ldl

this depends on HAVE_BACKTRACE.

Regards

Marcel

