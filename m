Content-Type: multipart/mixed; boundary="===============5138288344357968391=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] avoid stk atom is removed when sim pin is blocked
Date: Wed, 11 Sep 2013 12:41:57 -0500
Message-ID: <5230AB65.2030704@gmail.com>
In-Reply-To: <1378921861-6238-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5138288344357968391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 09/11/2013 12:51 PM, caiwen.zhang(a)intel.com wrote:
> From: Caiwen Zhang <caiwen.zhang@intel.com>
>
> When sim pin is blocked after input wrong pin code three times,
> modem will change to pre-sim status, at this time, STK function
> should be available. stk atoms shouldn't be removed.

Can you please provide a reference to a 3GPP / ETSI document which =

states that this is the case?
> ---
>   src/modem.c |    7 ++++++-
>   src/stk.c   |    4 ++++
>   2 files changed, 10 insertions(+), 1 deletion(-)
>

Regards,
-Denis


--===============5138288344357968391==--

