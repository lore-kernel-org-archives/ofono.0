Content-Type: multipart/mixed; boundary="===============5010315462500926780=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v3] huaweicdma: Create first draft for plugin huaweicdma
Date: Tue, 12 Jul 2011 14:36:09 +0200
Message-ID: <4E1C3FB9.70401@linux.intel.com>
In-Reply-To: <1310472386.21109.94.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5010315462500926780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 12/07/2011 14:06, Marcel Holtmann wrote:
> Hi Guillaume,
>
>> 	- Remove Nokia copyright.
>> 	- Remove cdma voicecall for the moment.
>> 	- Add debug print into post_sim pre_sim.
>> 	- use GSM permissive synthax for the moment.
> the nokiacdma.c was actually the worst example to derive this one from.
> I fixed this all up for you now and applied the patch.

Sorry this was the only cdma plugin smple I had.
Thanks for fixing the issues.

>> +/*
>> + * This file is part of oFono - Open Source Telephony
> I missed this part, but all the Nokia copyright headers are wrongly
> formatted. They should have been fixed a long time ago.
>
>> +#include<stdlib.h>
>> +#include<errno.h>
>> +#include<termios.h>
>> +#include<string.h>
>> +#include<unistd.h>
>> +#include<sys/types.h>
>> +#include<sys/stat.h>
>> +#include<fcntl.h>
> This list of includes is useless. Big copy and paste around.
>

You got me :)

>> +#include<glib.h>
>> +#include<gatchat.h>
>> +#include<gattty.h>
>> +
>> +#define OFONO_API_SUBJECT_TO_CHANGE
>> +#include<ofono/plugin.h>
>> +#include<ofono/log.h>
>> +#include<ofono/modem.h>
>> +
>> +#include<drivers/atmodem/atutil.h>
>> +#include<ofono/devinfo.h>
>> +#include<ofono/cdma-connman.h>
>> +
>> +#include "common.h"
> What is this for?
>
>> +	/*
>> +	 * TODO: Will need a CDMA AT syntax parser later.
>> +	 * Using GSM permissive for now.
>> +	 */
>> +	syntax =3D g_at_syntax_new_gsm_permissive();
> The comment is rather pointless until we really know what is going with
> CDMA modems. So I removed it.
>
> However you have to keep in mind that you need to turn echo support off
> before you can use the permissive syntax parser.
>

Ok, thanks for the info.

Kind regards,
Guillaume

--===============5010315462500926780==--

