Content-Type: multipart/mixed; boundary="===============8181673277762649275=="
MIME-Version: 1.0
From: Tonny Tzeng <tonny.tzeng@gmail.com>
Subject: Re: [PATCH] Skip unsolicited CREG/CGREG correctly
Date: Fri, 03 Dec 2010 17:34:07 +0800
Message-ID: <AANLkTimat+w4-U-aoTRpZmdfu0zt0BQ4vWX31zfoKKef@mail.gmail.com>
In-Reply-To: <4CF80E0D.6010901@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8181673277762649275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thanks for reviewing.

On Fri, Dec 3, 2010 at 5:22 AM, Denis Kenzior <denkenz@gmail.com> wrote:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Some firmware will r=
eport bogus lac/ci when unregistered */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* in this case, we should s=
kip it =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0*/
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s !=3D 1 && s !=3D =
5)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
goto out;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
continue;
>
> And this fix is wrong. =C2=A0what this is doing is skipping the parsing of
> the lac/ci values if we're not registered / roaming. =C2=A0Using continue
> here will cause the parser to fail for those cases.

But if we jump to label 'out', this routine will return the wrong
status code parsed from a unsolicited CREG/CGREG.  For example, in my
case, the real status value goes to the mode argument, and the status
argument got lac value.

Since huawei modems send these strings without quotes, I think we need
different logic to parse these values, for example, we may need a new
function for testing whether there are more codes left?

> What you probably meant was continuing if the status was not between 1
> and 5. =C2=A0But even that won't really help you if an lac of 1..5 is
> encountered ;)

Yes, you got my point, I will propose another way to avoid this.  Thanks.

Best Regards,
Tonny

--===============8181673277762649275==--

