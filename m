Content-Type: multipart/mixed; boundary="===============6799186188047876759=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] radio settings: allow for more than one property
Date: Fri, 22 Oct 2010 08:49:06 -0500
Message-ID: <4CC19652.1060208@gmail.com>
In-Reply-To: <C358A26273CF2948B8BCDBA661A581782A7D092E75@NOK-EUMSG-03.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6799186188047876759==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 10/22/2010 02:08 AM, Mika.Liljeberg(a)nokia.com wrote:
> Hi Denis, =

> =

>>> Oops, will fix. For some reason my checkpatch script did =

>> not complain about this.
>>>
>>> You must be using a script as well. To avoid unnecessary =

>> fuss like this, would it be possible to integrate it to the =

>> oFono tree so everyone would check their patches using the same thing?
>>
>> Not a script, but Johan's magic vim macro.  I paste it here =

>> for reference:
>> highlight RedundantWhitespace ctermbg=3Dred guibg=3Dred
>> match RedundantWhitespace /\s\+$\|\t\+\ze \+[^*]\| \+\ze\t/
>>
>> Between checkpatch, git am and this one we catch most issues.
> =

> Thanks. Still, I'd vote for a common checkpatch script in the oFono tree.=
 ;)
>

Are you volunteering to maintain such a beast and make sure it is up to
date with the kernel upstream version?

>> In the beginning we tried many approaches, including ones =

>> similar to the
>> path you took.  We found that the current approach used in the core,
>> while while by no means perfect in every situation, was the best
>> compromise.  It is quite scalable as the number of attributes =

>> / queries
>> grows and it blocks multiple (potentially malicious) applications from
>> DDoSing the modem when the information is not cached.
> =

> Well, my solution does exactly what you're asking, only with less code. Y=
ou seem to think that it allows parallel property queries from multiple cli=
ents. That is not the case. See here:

Yes, so let me give you a case where your approach breaks:

Set the RAT property, then run two GetProperties at the same time.  You
end up querying FastDormancy twice.

The current convention has also been proven to work in situations way
crazier than what radio settings has right now.  If it ain't broke,
please don't try to fix it.

However, all of this is besides the point.

> =

> static DBusMessage *radio_get_properties(DBusConnection *conn, DBusMessag=
e *msg,
>                                         void *data)
> {
>         struct ofono_radio_settings *rs =3D data;
> =

>         if (rs->pending)
>                 return __ofono_error_busy(msg);
> =

>         return radio_get_properties_reply(msg, rs);
> }
> =

> A busy error is returned if a previous query is in progress.
> =

> I don't mind rewriting the stuff if need be but I'd like it to be for the=
 right reason.
> =


So let me try to make it pretty clear.  I maintain all of the core and I
review just about every single patch.  For me code readability and
consistency of implementation is very important.  This is also the case
for anyone new starting with the codebase.  If I allow every atom to do
things just a little bit differently for the sake of saving 20 lines of
code or because the original author likes his approach better, I will go
crazy and the code will become unmaintainable.

I'd like to keep my sanity for a while longer ;)  So please modify your
patch to follow the oFono conventions.

Regards,
-Denis

--===============6799186188047876759==--

