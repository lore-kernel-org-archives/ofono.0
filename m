Content-Type: multipart/mixed; boundary="===============2104438506219605948=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 4/7] text-telephony: implement interface/atom
Date: Wed, 24 Nov 2010 15:29:40 -0600
Message-ID: <4CED83C4.7020804@gmail.com>
In-Reply-To: <AANLkTinOgx874zT-gixdYNYVO_-7u3gobscRsv4-4Xxz@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2104438506219605948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

>>> +     tt_set_powered(tt, enable);
>>> +     tt_send_properties_reply(tt);
>>
>> The oFono convention is to reply to the pending D-Bus method call and
>> then signal the property changed signals.
>>
> =

> The examples I found for query methods use exactly the opposite. See,
> cw_ss_query_callback() in call-settings.c and
> radio_fast_dormancy_query_callback() in radio-settings.c.

So we do prefer the reply before the signal.  However, we're still a bit
inconsistent in this area because multi-property queries make this very
hard.  In the single property case it is doable, but I'm fine accepting
this part as is.  So feel free to ignore this feedback.

Regards,
-Denis

--===============2104438506219605948==--

