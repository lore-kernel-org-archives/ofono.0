Content-Type: multipart/mixed; boundary="===============4083680761226991975=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] stkutil: fix crash issue cause by null length of text
 string
Date: Tue, 07 Dec 2010 23:33:33 +0100
Message-ID: <AANLkTikwmCamhNXwtZyRhqMp94gx-2zzQnB7M+xrR07=@mail.gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802C40DAC@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4083680761226991975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 7 December 2010 22:55,  <Jeevaka.Badrappan@elektrobit.com> wrote:
> Hi Guillaume,
>
>>
>> According to 3GPP TS 31.124 a null length for the text string
>> should be allowed. An empty string must be returned to the
>> user in this case.
>> ---
>> =C2=A0src/stkutil.c | =C2=A0 =C2=A06 ++++--
>> =C2=A01 files changed, 4 insertions(+), 2 deletions(-)
>>
>
> Agree. As per the 3GPP TS 31.124 null text string will be indicated with
> length 0.
> So, in first place if (text =3D=3D NULL) check in handle_command_get_inpu=
t,
> handle_command_get_inkey has to be removed. Removing this check will
> result
> in crash due to the fact that we are not handling this case properly
> neither
> in parse_dataobj_text nor in corresponding stkagent functions.
>
> There are 2ways to solve this issue:
>
> First option - Fix provided in the function parse_dataobj_text( e.g.
> *text =3D "")
> Second option - In all the stk_agent_ function which has this text
> string we
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0need to check for =
NULL and assign it to empty string if
> it is NULL.
>
> First option seems to be right and also better one.

Ah you're right.  I had confused the Text object with Alpha Id (where
"" is different from NULL).

Best regards

--===============4083680761226991975==--

