Content-Type: multipart/mixed; boundary="===============0279693608423640322=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH v2 4/7] text-telephony: implement interface/atom
Date: Thu, 25 Nov 2010 09:26:43 -0200
Message-ID: <AANLkTikdMYdQyh1zGcBRvKh0VW8EyjSqNUFR6Xv2sX9g@mail.gmail.com>
In-Reply-To: <4CED83C4.7020804@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0279693608423640322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

On Wed, Nov 24, 2010 at 7:29 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Lucas,
>
>>>> + =C2=A0 =C2=A0 tt_set_powered(tt, enable);
>>>> + =C2=A0 =C2=A0 tt_send_properties_reply(tt);
>>>
>>> The oFono convention is to reply to the pending D-Bus method call and
>>> then signal the property changed signals.
>>>
>>
>> The examples I found for query methods use exactly the opposite. See,
>> cw_ss_query_callback() in call-settings.c and
>> radio_fast_dormancy_query_callback() in radio-settings.c.
>
> So we do prefer the reply before the signal. =C2=A0However, we're still a=
 bit
> inconsistent in this area because multi-property queries make this very
> hard. =C2=A0In the single property case it is doable, but I'm fine accept=
ing
> this part as is. =C2=A0So feel free to ignore this feedback.

HUmn... If this is the correct approach, I'm ok with doing it.

regards,
Lucas De Marchi

--===============0279693608423640322==--

