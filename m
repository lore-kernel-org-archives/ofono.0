Content-Type: multipart/mixed; boundary="===============0094622622318614362=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] huawei: fix SIM state notification when locked
Date: Tue, 21 Dec 2010 13:37:58 -0600
Message-ID: <4D110216.4050607@gmail.com>
In-Reply-To: <1292959630-23211-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0094622622318614362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 12/21/2010 01:27 PM, Lucas De Marchi wrote:
> When SIM is locked, huawei modem does not send any notification about
> SIM state change because it does not differentiate 'invalid' from
> 'locked'.
> =

> In order to be able to unlock the sim, this patch forces a notification
> of a valid state after a timeout.
> ---
>  plugins/huawei.c |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
> =


Looks good to me.  Patch has been applied, thanks.

Regards,
-Denis

--===============0094622622318614362==--

