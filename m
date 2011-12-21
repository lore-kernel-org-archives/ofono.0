Content-Type: multipart/mixed; boundary="===============2341564009178007966=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv2 2/3] network: Add CPHS SPN, short-SPN fallbacks
Date: Wed, 21 Dec 2011 10:48:03 +0200
Message-ID: <4EF19D43.60301@intel.com>
In-Reply-To: <4EF0AA9F.1060806@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2341564009178007966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 12/20/2011 05:32 PM, Denis Kenzior wrote:
> Yep, you're right I missed this in the original review.  Your proposed
> approach should work just fine, but I'd still prefer something without
> timeouts if possible.

OK.

> Another, third approach that might work is for the atom to keep track of
> any transactions in progress and cancel them when the refresh is
> detected.  They can then immediately re-initiate the new transaction
> without waiting.
>
> Regardless of which solution we pick, the trickiest part here is to make
> this automatic and easy for all the EFs that we read; and there are
> quite a bit of those.

Thanks for the ideas here! The third approach sounds good. Let me see how t=
o fit it.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki

--===============2341564009178007966==--

