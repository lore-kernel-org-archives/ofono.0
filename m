Content-Type: multipart/mixed; boundary="===============7613483988156111970=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH] stk: add support of next action for menu
Date: Fri, 10 Dec 2010 10:59:55 -0600
Message-ID: <4D025C8B.1000707@gmail.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D40188136D961EA@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7613483988156111970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 12/09/2010 07:00 AM, Lucas, GuillaumeX wrote:
> From: Guillaume Lucas <guillaumex.lucas@intel.com>
> =

> According to the 3GPP 31.124 the support of next action
> in SIM toolkit menus is mandatory.
> ---
>  doc/stk-api.txt    |    5 +++--
>  src/stk.c          |    6 ++++++
>  src/stkagent.c     |    6 ++++--
>  src/stkagent.h     |    1 +
>  test/test-stk-menu |    6 +++---
>  5 files changed, 17 insertions(+), 7 deletions(-)
> =

> diff --git a/doc/stk-api.txt b/doc/stk-api.txt
> index 79daee6..f5bcae4 100644
> --- a/doc/stk-api.txt
> +++ b/doc/stk-api.txt
> @@ -66,13 +66,14 @@ Properties	string IdleModeText [readonly]
>  			Contains the identifier of the icon accompanying
>  			the idle mode text.
>  =

> -		array{struct{string, byte}} MainMenu [readonly]
> +		array{struct{string, byte, byte}} MainMenu [readonly]

Can you tell me exactly what this can be used for?  What is the usecase
for the application to know this information?

Regards,
-Denis

--===============7613483988156111970==--

