Content-Type: multipart/mixed; boundary="===============4829006753846207750=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv4] voicecall: fix dial result handling
Date: Fri, 03 Dec 2010 13:23:16 -0600
Message-ID: <4CF943A4.60707@gmail.com>
In-Reply-To: <1290784489-20426-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4829006753846207750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 11/26/2010 09:14 AM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> The existing call will be automatically put on hold if there is an
> existing active call when dialing. On some modems the dial request
> returns only after the dialed call is active and the existing call has
> been put on hold.
> =

> However, on isimodem driver the dial request returns immediately before
> the existing call has changed its status. With isimodem driver the
> dial_handle_result() selected the existing call from the list when it
> should have created a new one.
> =

> The dial result handling now guards againt returning a previously dialed
> active call as result.
> ---
>  src/voicecall.c |   19 ++++++++++++++++---
>  1 files changed, 16 insertions(+), 3 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============4829006753846207750==--

