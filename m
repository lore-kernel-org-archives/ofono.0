Content-Type: multipart/mixed; boundary="===============5713668085727908342=="
MIME-Version: 1.0
From: Mike <puffy.taco@gmail.com>
Subject: Re: [PATCH] voicecall: send CallRemoved for calls when voicecall atom
 is unregistered
Date: Fri, 20 Apr 2012 08:36:41 -0500
Message-ID: <CAB7rCThudSadVMt67vs73af265VPfUAP=B6usyn8S3hBgCG7DA@mail.gmail.com>
In-Reply-To: <4F901ADA.8010808@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5713668085727908342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Apr 19, 2012 at 9:02 AM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Mike,
>
>>
>> The only reason I added it is 4 hours of debugging my GUI and ofono to
>> figure out why the GUI didn't notice the D-Bus path for the voice call
>> was no longer around. =C2=A0The documentation for CallRemoved says "Sign=
al
>> that is sent when a voice call has been released." =C2=A0This implies it
>> should be sent every time it is released. =C2=A0If you update the
>> documentation to make it clear that this is not always the case, then
>> it's fine by me.
>>
>
> Please check that commit 7f51df4d satisfies your requirements.

Looks good, thanks!

Mike

>
> Regards,
> -Denis

--===============5713668085727908342==--

