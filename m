Content-Type: multipart/mixed; boundary="===============7420163518146310341=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] isigen: make number of PDP contexts configurable
Date: Thu, 11 Nov 2010 09:36:43 -0600
Message-ID: <4CDC0D8B.4060404@gmail.com>
In-Reply-To: <C358A26273CF2948B8BCDBA661A581782BE95B62A6@NOK-EUMSG-03.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7420163518146310341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 11/11/2010 02:16 AM, Mika.Liljeberg(a)nokia.com wrote:
> Hi Marcel,
> =

>> why to do you bother making this a configurable option? What isthe
>> benefit here?
> =

> The maximum context count is a compile time option for the ISI modem. Hav=
ing this option in oFono makes it possible to optimize the APE side resourc=
e usage instead of overallocating drivers and contexts. Not a huge benefit,=
 I guess, but the cost is not huge either.
> =

> Not a big deal, though. I'll try to see if the context limit could be pro=
bed somehow.
> =


The gprs context structure is about the size of 5 pointers, so there's
not much to be saved here.  If you're worried about space usage of the
isi specific data, you can always allocate it during the activation stage.

>> Personally I think that always enabling 4 context if the hardware
>> supports it should be enough. If you do support more then just enable
>> more all the time. There are no real resources used in context of ISI
>> anyway. The AT command based modems have a different problem since for
>> most of them we need an extra TTY/DLC and an extra GAtChat object, but
>> ISI does not have that problem.
> =

> I don't see the difference. The AT modem resources should be allocated dy=
namically as well, at context activation time. (Maybe that's the case alrea=
dy, I didn't really check.) In any case, I believe oFono has to allow thing=
s like external AT command processors and vendor specific modem tools to ac=
cess the TTY's directly bypassing oFono. This means the mux channels should=
 not be preallocated.

Hah, I know some people who vehemently disagree ;)  Of course I'm not
one of them...  Strictly speaking what you say is possible even with
today's architecture, however almost no AT modem we have supports more
than about 3-4 contexts.  So doing this to save 300-400 bytes / context
is simply not worth it at this point.

Regards,
-Denis

--===============7420163518146310341==--

