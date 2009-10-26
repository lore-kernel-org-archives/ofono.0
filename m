Content-Type: multipart/mixed; boundary="===============7753336755061721020=="
MIME-Version: 1.0
From: Naveen Verma <ernaveenverma@gmail.com>
Subject: Re: [PATCH 1/1] Create network registration driver for hfpmodem
Date: Mon, 26 Oct 2009 12:01:06 +0300
Message-ID: <9d71b7f00910260201p2024241cw6546e962a18002c6@mail.gmail.com>
In-Reply-To: <1256333771-10572-2-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7753336755061721020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> @@ -0,0 +1,172 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2009 ProFUSION embedded systems. All rights reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
>  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +
> +#include <glib.h>
> +
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/netreg.h>
> +
> +#include "gatchat.h"
> +#include "gatresult.h"
> +
> +#include "hfpmodem.h"
> +
> +#define OFONO_MAX_HFP_OPERATOR_NAME_LENGTH 16
> +
> +static const char *cops_prefix[] =3D { "+COPS:", NULL };
> +
> +struct netreg_data {
> +       GAtChat *chat;
> +       unsigned char cind_pos[HFP_INDICATOR_LAST];
> +       int cind_val[HFP_INDICATOR_LAST];
> +       char operator[16];
>

-- Should we use above #define for operator name length?
 -Br
Naveen

--===============7753336755061721020==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0iYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7
IG1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7IHBhZGRpbmctbGVmdDogMWV4OyI+PGJyPgpAQCAt
MCwwICsxLDE3MiBAQDxicj4KKy8qPGJyPgorICo8YnI+CisgKiCgb0Zvbm8gLSBPcGVuIFNvdXJj
ZSBUZWxlcGhvbnk8YnI+CisgKjxicj4KKyAqIKBDb3B5cmlnaHQgKEMpIDIwMDgtMjAwOSCgSW50
ZWwgQ29ycG9yYXRpb24uIEFsbCByaWdodHMgcmVzZXJ2ZWQuPGJyPgorICogoENvcHlyaWdodCAo
QykgMjAwOSBQcm9GVVNJT04gZW1iZWRkZWQgc3lzdGVtcy4gQWxsIHJpZ2h0cyByZXNlcnZlZC48
YnI+CisgKjxicj4KKyAqIKBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiBy
ZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeTxicj4KKyAqIKBpdCB1bmRlciB0aGUgdGVybXMg
b2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhczxicj4KKyAqIKBw
dWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi48YnI+CisgKjxicj4KKyAq
IKBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJl
IHVzZWZ1bCw8YnI+CisgKiCgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4g
dGhlIGltcGxpZWQgd2FycmFudHkgb2Y8YnI+CisgKiCgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5F
U1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiCgU2VlIHRoZTxicj4KKyAqIKBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLjxicj4KKyAqPGJyPgorICogoFlvdSBz
aG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlPGJyPgorICogoGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRo
ZSBGcmVlIFNvZnR3YXJlPGJyPgorICogoEZvdW5kYXRpb24sIEluYy4sIDUxIEZyYW5rbGluIFN0
LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQSCgMDIxMTAtMTMwMSCgVVNBPGJyPgorICo8YnI+Cisg
Ki88YnI+Cis8YnI+CisjaWZkZWYgSEFWRV9DT05GSUdfSDxicj4KKyNpbmNsdWRlICZsdDtjb25m
aWcuaCZndDs8YnI+CisjZW5kaWY8YnI+Cis8YnI+CisjZGVmaW5lIF9HTlVfU09VUkNFPGJyPgor
I2luY2x1ZGUgJmx0O3N0cmluZy5oJmd0Ozxicj4KKyNpbmNsdWRlICZsdDtzdGRsaWIuaCZndDs8
YnI+CisjaW5jbHVkZSAmbHQ7c3RkaW8uaCZndDs8YnI+Cis8YnI+CisjaW5jbHVkZSAmbHQ7Z2xp
Yi5oJmd0Ozxicj4KKzxicj4KKyNpbmNsdWRlICZsdDtvZm9uby9sb2cuaCZndDs8YnI+CisjaW5j
bHVkZSAmbHQ7b2Zvbm8vbW9kZW0uaCZndDs8YnI+CisjaW5jbHVkZSAmbHQ7b2Zvbm8vbmV0cmVn
LmgmZ3Q7PGJyPgorPGJyPgorI2luY2x1ZGUgJnF1b3Q7Z2F0Y2hhdC5oJnF1b3Q7PGJyPgorI2lu
Y2x1ZGUgJnF1b3Q7Z2F0cmVzdWx0LmgmcXVvdDs8YnI+Cis8YnI+CisjaW5jbHVkZSAmcXVvdDto
ZnBtb2RlbS5oJnF1b3Q7PGJyPgorPGJyPgorI2RlZmluZSBPRk9OT19NQVhfSEZQX09QRVJBVE9S
X05BTUVfTEVOR1RIIDE2PGJyPgorPGJyPgorc3RhdGljIGNvbnN0IGNoYXIgKmNvcHNfcHJlZml4
W10gPSB7ICZxdW90OytDT1BTOiZxdW90OywgTlVMTCB9Ozxicj4KKzxicj4KK3N0cnVjdCBuZXRy
ZWdfZGF0YSB7PGJyPgorIKAgoCCgIEdBdENoYXQgKmNoYXQ7PGJyPgorIKAgoCCgIHVuc2lnbmVk
IGNoYXIgY2luZF9wb3NbSEZQX0lORElDQVRPUl9MQVNUXTs8YnI+CisgoCCgIKAgaW50IGNpbmRf
dmFsW0hGUF9JTkRJQ0FUT1JfTEFTVF07PGJyPgorIKAgoCCgIGNoYXIgb3BlcmF0b3JbMTZdOzxi
cj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+LS0gU2hvdWxkIHdlIHVzZSBhYm92ZSAjZGVmaW5lIGZv
ciBvcGVyYXRvciBuYW1lIGxlbmd0aD88YnI+oC1Ccjxicj5OYXZlZW48YnI+PGJyPjwvZGl2Pjwv
ZGl2Pjxicj4K

--===============7753336755061721020==--

