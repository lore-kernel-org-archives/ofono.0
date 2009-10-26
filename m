Content-Type: multipart/mixed; boundary="===============2140585268388335926=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: Re: [PATCH 1/1] Create network registration driver for hfpmodem
Date: Mon, 26 Oct 2009 12:27:23 -0200
Message-ID: <6b53b1990910260727g442163b8jdb0aff2a7acc582c@mail.gmail.com>
In-Reply-To: <9d71b7f00910260201p2024241cw6546e962a18002c6@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2140585268388335926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2009 at 7:01 AM, Naveen Verma <ernaveenverma@gmail.com> w=
rote:
>
>
>>
>> @@ -0,0 +1,172 @@
>> +/*
>> + *
>> + * =C2=A0oFono - Open Source Telephony
>> + *
>> + * =C2=A0Copyright (C) 2008-2009 =C2=A0Intel Corporation. All rights re=
served.
>> + * =C2=A0Copyright (C) 2009 ProFUSION embedded systems. All rights rese=
rved.
>> + *
>> + * =C2=A0This program is free software; you can redistribute it and/or =
modify
>> + * =C2=A0it under the terms of the GNU General Public License version 2=
 as
>> + * =C2=A0published by the Free Software Foundation.
>> + *
>> + * =C2=A0This program is distributed in the hope that it will be useful,
>> + * =C2=A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * =C2=A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See=
 the
>> + * =C2=A0GNU General Public License for more details.
>> + *
>> + * =C2=A0You should have received a copy of the GNU General Public Lice=
nse
>> + * =C2=A0along with this program; if not, write to the Free Software
>> + * =C2=A0Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA =C2=
=A002110-1301
>> =C2=A0USA
>> + *
>> + */
>> +
>> +#ifdef HAVE_CONFIG_H
>> +#include <config.h>
>> +#endif
>> +
>> +#define _GNU_SOURCE
>> +#include <string.h>
>> +#include <stdlib.h>
>> +#include <stdio.h>
>> +
>> +#include <glib.h>
>> +
>> +#include <ofono/log.h>
>> +#include <ofono/modem.h>
>> +#include <ofono/netreg.h>
>> +
>> +#include "gatchat.h"
>> +#include "gatresult.h"
>> +
>> +#include "hfpmodem.h"
>> +
>> +#define OFONO_MAX_HFP_OPERATOR_NAME_LENGTH 16
>> +
>> +static const char *cops_prefix[] =3D { "+COPS:", NULL };
>> +
>> +struct netreg_data {
>> + =C2=A0 =C2=A0 =C2=A0 GAtChat *chat;
>> + =C2=A0 =C2=A0 =C2=A0 unsigned char cind_pos[HFP_INDICATOR_LAST];
>> + =C2=A0 =C2=A0 =C2=A0 int cind_val[HFP_INDICATOR_LAST];
>> + =C2=A0 =C2=A0 =C2=A0 char operator[16];
>
> -- Should we use above #define for operator name length?

Yes, I missed that. Thanks.

> =C2=A0-Br
> Naveen
>
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>
>



-- =

Gustavo F. Padovan
http://padovan.org

--===============2140585268388335926==--

