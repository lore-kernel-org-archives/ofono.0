Content-Type: multipart/mixed; boundary="===============8296881168406309583=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@gmail.com>
Subject: Re: [PATCH] handsfree-audio: Fix parsing of Register() CODECs
Date: Mon, 15 Apr 2013 10:16:51 -0300
Message-ID: <CA+A7VXVnBwTy1iAww9BdqwWJ8i=_b3rpYkD6ByouoYcMYqibmQ@mail.gmail.com>
In-Reply-To: <5168DB87.90907@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8296881168406309583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2013 at 1:13 AM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Jo=C3=A3o Paulo,
>
>
> On 04/12/2013 07:06 PM, Jo=C3=A3o Paulo Rechi Vita wrote:
>>
>>
>> On Apr 12, 2013 8:18 PM, "Denis Kenzior" <denkenz@gmail.com
>> <mailto:denkenz@gmail.com>> wrote:
>>  >
>>  > Hi Jo=C3=A3o Paulo,
>>  >
>>  >
>>  > On 04/12/2013 05:25 PM, Jo=C3=A3o Paulo Rechi Vita wrote:
>>  >>
>>  >> Without this patch the mSBC CODEC is always enabled, even when the
>>  >> CODECs array in the Register() message from the agent contains only
>>  >> entry for the CVSD (0x01) CODEC.
>>  >> ---
>>  >>   src/handsfree-audio.c | 5 +++--
>>  >>   1 file changed, 3 insertions(+), 2 deletions(-)
>>  >>
>>  >> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
>>  >> index 1a1cbff..3b0814f 100644
>>  >> --- a/src/handsfree-audio.c
>>  >> +++ b/src/handsfree-audio.c
>>  >> @@ -682,9 +682,10 @@ static DBusMessage
>> *am_agent_register(DBusConnection *conn,
>>  >>                 return __ofono_error_invalid_args(msg);
>>  >>
>>  >>         for (i =3D 0; i<  length; i++) {
>>  >> -               if (codecs[i] =3D=3D HFP_CODEC_CVSD)
>>  >> +               if (codecs[i] =3D=3D HFP_CODEC_CVSD) {
>>  >>                         has_cvsd =3D TRUE;
>>  >> -               else if (codecs[i] !=3D HFP_CODEC_MSBC)
>>  >> +                       continue;
>>  >> +               } else if (codecs[i] !=3D HFP_CODEC_MSBC)
>>  >>                         return __ofono_error_invalid_args(msg);
>>  >>
>>  >>                 if (defer_setup)
>>  >
>>  >
>>  > Good catch.  I'd prefer we fix Patch 7 in Vinicius' series instead of
>> applying this patch though.
>>  >
>>
>> The bug fixed by this patch is not related to what patch 7 of Vinicius'
>> series does and it's present in the upstream master branch. I'm fine if
>> you prefer it stashed with Vinicius' patch, I'm just bringing up that
>> the patches do different things.
>
>
> Are you sure?
>
> Here's upstream:
>
>         for (i =3D 0; i < length; i++) {
>                 if (codecs[i] =3D=3D HFP_CODEC_CVSD)
>                         has_cvsd =3D TRUE;
>                 else if (codecs[i] !=3D HFP_CODEC_MSBC)
>                         return __ofono_error_invalid_args(msg);
>         }
>
>
> I have a bad case of the flu, but that seems alright to me.
>

You're actually right, sorry for the noise.

--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita

--===============8296881168406309583==--

