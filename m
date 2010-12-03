Content-Type: multipart/mixed; boundary="===============4957904943243221802=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] TODO: Add task for GSMA name list support
Date: Fri, 03 Dec 2010 12:48:48 -0600
Message-ID: <4CF93B90.3070705@gmail.com>
In-Reply-To: <1291384946-417-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4957904943243221802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 12/03/2010 08:02 AM, Aki Niemi wrote:
> ---
>  TODO |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> =

> diff --git a/TODO b/TODO
> index 457c9a1..b63b834 100644
> --- a/TODO
> +++ b/TODO
> @@ -507,3 +507,12 @@ Miscellaneous
>    Priority: Medium
>    Complexity: C1
>    Owner: Aki Niemi <aki.niemi@nokia.com>
> +
> +- Add GSM Association (GSMA) name list support.  The GSMA publishes peri=
odically
> +  a spread sheet including all of the world's mobile operators and their=
 so
> +  called hard coded names.  This task adds machinery to use that list as=
 basis
> +  of a database that the network registration atom uses in its display n=
ame
> +  logic.
> +
> +  Priority: Low
> +  Complexity: C2

Can you modify the description to mention that oFono should no longer
request alphanumeric name from the modem and rely on the MCC and MNC of
the operator only?

This task also depends on the NITZ task btw.

Regards,
-Denis

--===============4957904943243221802==--

