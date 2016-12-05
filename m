Content-Type: multipart/mixed; boundary="===============1631290460542412912=="
MIME-Version: 1.0
From: Djalal Harouni <djalal@endocode.com>
Subject: Re: [PATCH v3 4/7] ubloxmodem: add the netmon driver
Date: Mon, 05 Dec 2016 15:28:29 +0100
Message-ID: <CAH562EReJXt4g2Ltpb_VJt5Q1DaDz85i3GYcTkOcBeADqSJeFA@mail.gmail.com>
In-Reply-To: <58405B48.5050003@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1631290460542412912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 1 December 2016 at 18:18, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Djalal,
>
>>
>>
>> OK thank you for the explanation. I did go with ref counting since
>> they are easy to use and I will follow up later with +UCGED which has
>> different behaviour depending on firmware version...
>
>
> Sounds good.
[...]
>> Hmm so now maybe the leak may happen in this small window between:
>> cbd =3D req_cb_data_ref(cbd);
>> and
>> g_at_chat_send() and before registering the GDestroyNotify
>> parameter... in case hardware removal happens or anything... I'm not
>> sure and I also don't know how to fix it.
>
>
> This is not possible.  The hardware removal notification still comes over=
 a
> socket, so regular event loop rules apply.  The function invocation won't=
 be
> interrupted mid-stream.
I see, thanks for the explanation.

> What we're worried about is us allocating memory, queuing the command into
> GAtChat, but at some point later, the GAtChat object is destroyed before =
the
> command callback was executed.
Ok will follow same rules for next patches.


> Regards,
> -Denis

--===============1631290460542412912==--

