Content-Type: multipart/mixed; boundary="===============6036887376439050814=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] Add CDMA/EVDO tasks in TODO
Date: Wed, 27 Oct 2010 23:03:44 -0500
Message-ID: <4CC8F620.3080306@gmail.com>
In-Reply-To: <1288228358-17225-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6036887376439050814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 10/27/2010 08:12 PM, Zhang Caiwen wrote:
> ---
>  TODO |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 52 insertions(+), 0 deletions(-)
> =

> diff --git a/TODO b/TODO
> index 239bab0..e368070 100644
> --- a/TODO
> +++ b/TODO
> @@ -543,3 +543,55 @@ Miscellaneous
>  =

>    Priority: Low
>    Complexity: C4
> +
> +
> +CDMA/EVDO
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +- Extend modem interface with a 'Mode' property to indicate the modem ty=
pe.
> +
> +  Priority: High
> +  Complexity: C1
> +
> +- Extend radio setting,add CDMA radio access technology support. The CDM=
A modem

Can we watch that punctuation is done properly? Space after the comma,
preferably two spaces after each period.

> +  preferred technology can be CDMA, HDR or CDMA/HDR hybrid.
> +
> +  Priority: Medium
> +  Complexity: C1
> +  Owner: Zhang Caiwen <caiwen.zhang@windriver.com>
> +
> +- Add CDMA Network registration support. CDMA device will register to ne=
twork
> +  automaticlly. Unlike GSM,generally,it don't support manually register =
to

Can you check the spelling as well?  And again, the punctuation.

> +  network.So its mainly function is to get CDMA network information. The
> +  information include: registration status, service domain, CDMA 1x sign=
al
> +  strength, HDR signal strength, MCC, MNC, SID, NID etc.
> +
> +  Priority: Medium
> +  Complexity: C1
> +  Owner: Zhang Caiwen <caiwen.zhang@windriver.com>
> +
> +- Add UIM support. UIM support change pin, enter pin, reset pin, set pin=
 lock,
> +  get pin lock setting, get pin remain retry time, and get information t=
hat
> +  stored in UIM, include MCC/MNC, ruimid, IMSI,MDN, PRL version etc.
> +
> +  Priority: High
> +  Complexity: C4
> +  Owner: Zhang Caiwen <caiwen.zhang@windriver.com>
> +
> +- Add CDMA voice call support. CDMA voice call will support originate/en=
d/hold
> +  a call,transfer a call, 3WC(three-way calling), conference call and DT=
MF. For
> +  a voice call, can get its status, CLI and ending result(if it is end).
> +
> +  Priority: High
> +  Complexity: C8
> +  Owner: Zhang Zhengguang <zhengguang.Zhang@windriver.com>
> +
> +- Add CDMA Data connection support. CDMA data connection manager support
> +  start/end a data connect according to the settings from other module(u=
pper
> +  layer or ConnMan).
> +
> +  Priority: High
> +  Complexity: C4
> +  Owner: Zhang Caiwen <caiwen.zhang@windriver.com>
> +
> +

As a general comment, please try to stick to the wording that the rest
of the TODO uses.  E.g.: Foo Support.  'Add foo property...' or 'Extend
foo to support foo...'

The TODO should be accessible to non-telephony geeks. Think of it as a
high level design and roadmap document, with the same level of importance.

Regards,
-Denis

--===============6036887376439050814==--

