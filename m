Content-Type: multipart/mixed; boundary="===============3226218370564661865=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [RFC online/offline atoms PATCH 1/4] modem: add modem state watch
Date: Thu, 14 Oct 2010 10:21:04 +0300
Message-ID: <AANLkTinFdE1A1UmNzKZTP=b1B+vj8TEtQ_VGWGLLWo6s@mail.gmail.com>
In-Reply-To: <4CB618FD.6050006@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3226218370564661865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2010/10/13 Denis Kenzior <denkenz@gmail.com>:
>> @@ -177,6 +177,21 @@ unsigned int __ofono_modemwatch_add(ofono_modemwatc=
h_cb_t cb, void *user,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_destro=
y_func destroy);
>> =C2=A0gboolean __ofono_modemwatch_remove(unsigned int id);
>>
>> +enum ofono_modem_state {
>> + =C2=A0 =C2=A0 MODEM_STATE_POWER_OFF,
>> + =C2=A0 =C2=A0 MODEM_STATE_PRE_SIM,
>> + =C2=A0 =C2=A0 MODEM_STATE_OFFLINE,
>> + =C2=A0 =C2=A0 MODEM_STATE_ONLINE,
>> +};
>
> Personally I don't see the need for anything besides an online/offline
> watch. =C2=A0Nobody will ever care about the other states.

In principle, this information would be useful for voicecall atom. On
the other hand, it can follow sim state, too. We'll change this (back)
to online/offline unless we can figure other use for the full modem
state.

-- =

Pekka.Pessi mail at nokia.com

--===============3226218370564661865==--

