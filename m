Content-Type: multipart/mixed; boundary="===============6436506426782888627=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 3/5 v3] nettime: DBUS and compilation configuration
Date: Tue, 18 Jan 2011 09:36:12 +0200
Message-ID: <AANLkTin-1_VfU2MRTbfb7JDDRByWQVwxOn+X9Uuu69su@mail.gmail.com>
In-Reply-To: <4D348C50.4070409@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6436506426782888627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2011/1/17 Denis Kenzior <denkenz@gmail.com>:
>> So these are redundant, unless the whole thing is rewritten as:
>>
>> =C2=A0 =C2=A0 =C2=A0 <allow send_destination=3D"org.ofono" send_interfac=
e=3D"org.ofono.SimToolkitAgent"/>
>> =C2=A0 =C2=A0 =C2=A0 <allow send_destination=3D"org.ofono" send_interfac=
e=3D"org.ofono.PushNotificationAgent"/>
>> =C2=A0 =C2=A0 =C2=A0 <allow send_destination=3D"org.ofono" send_interfac=
e=3D"org.ofono.SmartMessagingAgent"/>
>>
>
> The agents are registered by the application, not ofono. =C2=A0So the
> destination is in fact not org.ofono but a system bus connection owned
> by the application. =C2=A0Hence the need to punch holes here.

This means we also need punch a hole for org.ofono.NetworkTime. The
only difference there to the above agent interfaces is that it's a
singleton and comes with no registration API on oFono side. Instead,
there is a custom plugin per agent implementation, like the one for
timed.

Cheers,
Aki

--===============6436506426782888627==--

