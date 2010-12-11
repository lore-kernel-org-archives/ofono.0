Content-Type: multipart/mixed; boundary="===============8070272069547781430=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Specify vendor ID for Huawei modem while creating GPRS
 context
Date: Sat, 11 Dec 2010 11:40:31 -0600
Message-ID: <4D03B78F.1090206@gmail.com>
In-Reply-To: <AANLkTikBCc8+4BpCu7=Dmi8BBDgDn9_ThvDzfKa5JTbo@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8070272069547781430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tonny,

On 12/11/2010 10:37 AM, Tonny Tzeng wrote:
> Hi Denis,
> =

>     No, you don't.  You are confusing gprs atom and the gprs-context atom.
>     Grep for VENDOR in drivers/atmodem/gprs-context.c if you do not belie=
ve
>     me.  There is no vendor specific code in the atmodem gprs-context
>     driver.
> =

> =

> Yes, my bad, I misunderstood the program flow...
> So, is huawei_post_online() in plugins/huawei.c the right place to pass
> the vendor ID while calling to ofono_gprs_create()?

Yes, I fixed this now as well.

> =

> Together with the patch to fix parsing of unquoted CGREG, now I can get
> the CGREG status correctly from the Huawei modem.  :)  Thanks!

My earlier patch has been applied, so please test the upstream version
and report back any problems.

Regards,
-Denis

--===============8070272069547781430==--

