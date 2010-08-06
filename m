Content-Type: multipart/mixed; boundary="===============4529598936318513285=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] calypsomodem: Add a Calypso STK driver.
Date: Fri, 06 Aug 2010 12:19:25 -0500
Message-ID: <4C5C441D.1040907@gmail.com>
In-Reply-To: <1281029457-9048-3-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4529598936318513285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> diff --git a/drivers/calypsomodem/calypsomodem.h b/drivers/calypsomodem/c=
alypsomodem.h
> index 80af134..2afc6c3 100644
> --- a/drivers/calypsomodem/calypsomodem.h
> +++ b/drivers/calypsomodem/calypsomodem.h
> @@ -20,6 +20,11 @@
>   */
>  =

>  #include <drivers/atmodem/atutil.h>
> +#include <modem.h>
> +#include <stk.h>

I removed these includes in a later commit as they didn't seem necessary.

Regards,
-Denis

--===============4529598936318513285==--

