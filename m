Content-Type: multipart/mixed; boundary="===============3182703160888327234=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] radio settings: allow for more than one property
Date: Thu, 21 Oct 2010 09:03:53 -0500
Message-ID: <4CC04849.8070703@gmail.com>
In-Reply-To: <C358A26273CF2948B8BCDBA661A581782A7D03A877@NOK-EUMSG-03.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3182703160888327234==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 10/21/2010 03:55 AM, Mika.Liljeberg(a)nokia.com wrote:
> Hi,
> =

>> Please don't mix and match tabs and spaces for indentation
> =

> Oops, will fix. For some reason my checkpatch script did not complain abo=
ut this.
> =

> You must be using a script as well. To avoid unnecessary fuss like this, =
would it be possible to integrate it to the oFono tree so everyone would ch=
eck their patches using the same thing?

Not a script, but Johan's magic vim macro.  I paste it here for reference:
highlight RedundantWhitespace ctermbg=3Dred guibg=3Dred
match RedundantWhitespace /\s\+$\|\t\+\ze \+[^*]\| \+\ze\t/

Between checkpatch, git am and this one we catch most issues.

> =

>> I prefer you keep the current implementation as it is consistent with
>> the rest of ofono core.  The way the rest of the core works =

>> is that you
>> query each in sequence, then set the the CACHED flag (only one is
>> actually required).
>>
>> We use a single cached flag to keep the logic simpler and optimize for
>> the general case (e.g. UI will query the properties first before
>> allowing the user to set them)  While this does lead to us =

>> querying some
>> attributes unnecessarily in certain extremely unlikely corner cases, I
>> believe it is an acceptable compromise.
> =

> This was my intention as well but I did it in a different way, as I didn'=
t realize there was an existing pattern for it.
> =

> My code does actually query all the properties up front but I serialized =
the driver queries in a different way. I.e., I used a separate CACHED flag =
for each property to keep track of whether the value is already valid. Each=
 driver callback attempts to create the pending reply. The attempt to creat=
e the reply either succeeds or triggers a new driver query for another miss=
ing property value. This goes on until all the properties are cached and th=
e pending reply can be sent.
> =

> I now see that the other services use a separate state machine to fetch t=
he properties. That introduces more code than my solution but I guess I can=
 do it that way if you feel it is easier to read.
> =


In the beginning we tried many approaches, including ones similar to the
path you took.  We found that the current approach used in the core,
while while by no means perfect in every situation, was the best
compromise.  It is quite scalable as the number of attributes / queries
grows and it blocks multiple (potentially malicious) applications from
DDoSing the modem when the information is not cached.

So while it might be a bit more code, I think it is the right approach
here as well; both for consistency and code readability reasons.

Regards,
-Denis

--===============3182703160888327234==--

