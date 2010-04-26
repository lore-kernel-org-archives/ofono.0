Content-Type: multipart/mixed; boundary="===============4614630274628500413=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] stkutil: Use struct to represent frame id
Date: Mon, 26 Apr 2010 11:41:35 -0500
Message-ID: <201004261141.35220.denkenz@gmail.com>
In-Reply-To: <1272277766-25432-3-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4614630274628500413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> Use a field has_id to indicate if we have frame id or not. Originally we
>  use 0xFF to indicate we don't have frame id. But in that way, we have to
>  initialize each test case of proactive command when it doesn't have this
>  comprehension tlv to be 0xFF. To use has_id will save this effort, and
>  keep consistency with other implementations.
> ---
>  src/stkutil.c |   13 +++----------
>  src/stkutil.h |   12 +++++++++---
>  2 files changed, 12 insertions(+), 13 deletions(-)

I'm fine with this one, can you rework #2 and resubmit along with this one?

Regards,
-Denis

--===============4614630274628500413==--

