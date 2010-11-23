Content-Type: multipart/mixed; boundary="===============4955702101628649053=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] Add Lockdown property to Modem interface
Date: Tue, 23 Nov 2010 07:50:18 -0600
Message-ID: <4CEBC69A.3010505@gmail.com>
In-Reply-To: <1290202629-23235-3-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4955702101628649053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On 11/19/2010 03:37 PM, Gustavo F. Padovan wrote:
> Setting Lockdown to TRUE means power down the modem and hold a lock that
> only permits the lock's owner power up the modem back. When released
> it restores the last state of the modem before holding the lock.
> ---
>  doc/modem-api.txt |   10 +++++
>  src/modem.c       |  114 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 124 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/modem-api.txt b/doc/modem-api.txt
> index c48375e..3dd6dde 100644
> --- a/doc/modem-api.txt
> +++ b/doc/modem-api.txt
> @@ -37,6 +37,16 @@ Properties	boolean Powered [readwrite]
>  			Boolean representing the rf state of the modem.
>  			Online is false in flight mode.
>  =

> +		boolean Lockdown [readwrite]
> +
> +			Boolean representing the lock state of the modem.
> +			Setting it to true, makes the calling application hold
> +			the modem lock and power it down. Setting to false
> +			makes the it restore the modem state before the
> +			lockdown and release the modem lock. Only the
> +			application that holds the lock can power up the modem.
> +			If the the application exits Lockdown is set to false.
> +

So me and Marcel discussed this briefly and I think we want to modify
the behavior slightly.  When Lockdown is set to True, the modem should
be brought down to Powered=3DOff state, and setting the Powered property
should return an error.

When Lockdown is set to False from True, only the lock is lifted.
Powered state still has to be triggered manually.  This should make the
implementation a little simpler.

Regards,
-Denis

--===============4955702101628649053==--

