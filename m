Content-Type: multipart/mixed; boundary="===============7709940703371887267=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Add CDMA/EVDO tasks in TODO
Date: Wed, 27 Oct 2010 10:02:11 -0500
Message-ID: <4CC83EF3.90808@gmail.com>
In-Reply-To: <1288178195-16493-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7709940703371887267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 10/27/2010 06:16 AM, Zhang Caiwen wrote:
> ---
>  TODO |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 57 insertions(+), 0 deletions(-)
> =

> diff --git a/TODO b/TODO
> index 239bab0..efb2bff 100644
> --- a/TODO
> +++ b/TODO
> @@ -543,3 +543,60 @@ Miscellaneous
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
> +  preferred technology can be CDMA, HDR or CDMA/HDR hybrid.
> +
> +  Priority: Medium
> +  Complexity: C1
> +  Owner: Zhang Caiwen <caiwen.zhang@windriver.com>
> +
> +- Add CDMA Network registration support. CDMA device will register to ne=
twork
> +  automaticlly. Unlike GSM,it don't support manually register to network=
.So its
> +  mainly function is to get CDMA network information. The information in=
clude:
> +  registration status, service domain, CDMA 1x signal strength, HDR sign=
al
> +  strength, MCC, MNC, SID, NID etc.
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
> +  Complexity: C6

Please don't invent new complexity types.  If it is higher than a C4,
mark it as a C8.

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
> +- Add SIM/UIM data access support. Add a card atom, it will support read=
/update/
> +  delete/add conatact add SMS in SIM/UIM card.
> +

You do realize oFono doesn't really work this way.  Certainly
update/delete/add contacts is not going to be accepted as a task.  And
definitely a big no for SMS to the SIM/UIM.

> +  Priority: High
> +  Complexity: C6

Same comment as above.

> +

Regards,
-Denis

--===============7709940703371887267==--

