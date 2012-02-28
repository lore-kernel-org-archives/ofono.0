Content-Type: multipart/mixed; boundary="===============5688473891058667521=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] sim900: Add support for SIMCOM SMS delivery reports
Date: Mon, 27 Feb 2012 20:32:55 -0600
Message-ID: <4F4C3CD7.7040206@gmail.com>
In-Reply-To: <1330327184-1497-1-git-send-email-r.r.zaripov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5688473891058667521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Renat,

On 02/27/2012 01:19 AM, r.r.zaripov(a)gmail.com wrote:
> From: Renat Zaripov <r.r.zaripov@gmail.com>
> =

> ---
>  plugins/sim900.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> =

> diff --git a/plugins/sim900.c b/plugins/sim900.c
> index f7b1642..b2d1b46 100644
> --- a/plugins/sim900.c
> +++ b/plugins/sim900.c
> @@ -224,7 +224,8 @@ static void sim900_post_sim(struct ofono_modem *modem)
>  	DBG("%p", modem);
>  =

>  	ofono_phonebook_create(modem, 0, "atmodem", data->modem);
> -	ofono_sms_create(modem, 0, "atmodem", data->modem);
> +	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", =


I had to fix up a trailing whitespace error at the end of this line.  It
might be a good idea to configure your editor to show these, or use
checkpatch.pl from the Linux kernel to check the patches before submission.

> +				data->modem);
>  }
>  =

>  static void sim900_post_online(struct ofono_modem *modem)

Patch has been applied, thanks.

Regards,
-Denis

--===============5688473891058667521==--

