Content-Type: multipart/mixed; boundary="===============7575871098016347497=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] isimodem: use a specific call id when answering
Date: Tue, 03 May 2011 22:10:56 +0300
Message-ID: <BANLkTinKerbiztsMN9LJS49+HQTJV85Q7g@mail.gmail.com>
In-Reply-To: <4DB979A4.8010300@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7575871098016347497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2011/4/28 Denis Kenzior <denkenz@gmail.com>:
'>> + =C2=A0 =C2=A0 for (id =3D 1; id <=3D 7; id++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (ivc->calls[id].statu=
s) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case CALL_STATUS_COMING:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case CALL_STATUS_MT_ALERTING:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case CALL_STATUS_WAITING:
>
> oFono expects answer to only work on 'incoming' calls in the traditional
> sense. =C2=A0Is waiting status equivalent to CCWA here? If so, it might be
> better to leave it out here.

isi_answer() is called by both .answer and .release_all_active
methods, so I included the WAITING state here, too.

Answering a waiting call is a tricky, I'll try to see if it can be
made in a more robust manner.

-- =

Pekka.Pessi mail at nokia.com

--===============7575871098016347497==--

