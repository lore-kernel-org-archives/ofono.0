Content-Type: multipart/mixed; boundary="===============8200396396441984226=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 2/4] ifxmodem: add handling of XCOLP notification
Date: Mon, 07 Feb 2011 17:06:58 -0600
Message-ID: <4D507B12.3030602@gmail.com>
In-Reply-To: <1297112858-12002-3-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8200396396441984226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 02/07/2011 03:07 PM, Jeevaka Badrappan wrote:
> ---
>  drivers/ifxmodem/voicecall.c |   51 ++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 51 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
> index 21e1944..772280a 100644
> --- a/drivers/ifxmodem/voicecall.c
> +++ b/drivers/ifxmodem/voicecall.c
> @@ -688,6 +688,55 @@ static void ccwa_notify(GAtResult *result, gpointer =
user_data)
>  		ofono_voicecall_notify(vc, call);
>  }
>  =


Patch has been applied, thanks.

Regards,
-Denis

--===============8200396396441984226==--

