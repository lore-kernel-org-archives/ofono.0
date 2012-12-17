Content-Type: multipart/mixed; boundary="===============3051892324444984035=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: return from cpin when sim ready for telit
Date: Mon, 17 Dec 2012 09:51:12 -0600
Message-ID: <50CF3F70.7040700@gmail.com>
In-Reply-To: <1355494782-31572-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3051892324444984035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

On 12/14/2012 08:19 AM, christopher.vogl(a)hale.at wrote:
> From: Christopher Vogl<christopher.vogl@hale.at>
>
> Especially for Telit HE910 it is not enough to wait for
> entering a PIN code.
> If we do not wait for #QSS: 3, subsequent commands,
> like +CMER will report SIM BUSY and the network registration
> atom will be removed as a consequence.
> ---
>   drivers/atmodem/sim.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>

Patch has been applied, thanks.

Regards,
-Denis

--===============3051892324444984035==--

