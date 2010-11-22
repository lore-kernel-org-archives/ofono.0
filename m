Content-Type: multipart/mixed; boundary="===============0044225127057990434=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Simulate provide local info command
Date: Mon, 22 Nov 2010 08:31:51 -0600
Message-ID: <4CEA7ED7.2080008@gmail.com>
In-Reply-To: <1290076999-27809-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0044225127057990434==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On 11/18/2010 04:43 AM, Yang Gu wrote:
> ---
>  src/simapplication.cpp |  263 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/simapplication.h   |    2 +
>  2 files changed, 265 insertions(+), 0 deletions(-)
> =

> +#define LocalInfoMenu_Loc               1
> +#define LocalInfoMenu_IMEI              2
> +#define LocalInfoMenu_NMR               3
> +#define LocalInfoMenu_Time              4
> +#define LocalInfoMenu_Lang              5
> +#define LocalInfoMenu_TimingAdvance     6
> +#define LocalInfoMenu_Tech              7
> +#define LocalInfoMenu_ESN               8
> +#define LocalInfoMenu_IMEISV            9
> +#define LocalInfoMenu_SearchMode        10
> +#define LocalInfoMenu_Battery           11
> +#define LocalInfoMenu_MEID              12
> +#define LocalInfoMenu_WSID              13
> +#define LocalInfoMenu_Broadcast         14
> +#define LocalInfoMenu_Techs             15
> +#define LocalInfoMenu_Locs              16
> +#define LocalInfoMenu_NMRs              17
> +

We should really only support Time and Lang, the others are actually
better handled by the modem firmware.

Regards,
-Denis

--===============0044225127057990434==--

