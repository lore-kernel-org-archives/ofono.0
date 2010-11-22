Content-Type: multipart/mixed; boundary="===============1591533043403525896=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] stemodem: Create network interfaces statically
Date: Mon, 22 Nov 2010 04:34:15 -0600
Message-ID: <4CEA4727.8020506@gmail.com>
In-Reply-To: <AANLkTinFtqvnFFts9uBqSrHbJzrrkToifuqYXbz+pK6Z@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1591533043403525896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

On 11/18/2010 02:03 AM, Sjur Br=C3=A6ndeland wrote:
> Hi Denis & Marcel.
> =

>> From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>
>>
>> Changes:
>> o Restructure code so interfaces are created statically when probe is ca=
lled.
>> o Removed some of the unnecessary initializations at declaration.
>> o No longer reporting "default gateway" on PtP IP Interface.
>> o Bugfix: Handle network initiated deactivation.
>> ---
>>  drivers/stemodem/gprs-context.c |  153 ++++++++++++++++++++++----------=
-------
>>  1 files changed, 85 insertions(+), 68 deletions(-)
>>
>> diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-con=
text.c
>> index 05fec3f..d8db23b 100644
>> --- a/drivers/stemodem/gprs-context.c
>> +++ b/drivers/stemodem/gprs-context.c
> =

> Have you received this patch in readable format?
> I'm sending patches using git send-email over gmail,
> and when I check sent items in gmail, it comes up as base64 encoded.
> Is this garbled for you as well?

They seem to come through fine for me at least.

> =

> BTW are you using patchwork or similar so I could check the patch
> status somewhere?
> =


Nope, but it has been suggested that this might be a good idea.  I'm
open to the idea of trying this out, but don't promise I will like it ;)

> Regards,
> Sjur

Regards,
-Denis

--===============1591533043403525896==--

