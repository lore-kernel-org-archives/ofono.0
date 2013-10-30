Content-Type: multipart/mixed; boundary="===============5536265739941766625=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Voicecall while context is activate
Date: Wed, 30 Oct 2013 13:55:11 -0500
Message-ID: <5271560F.6060007@gmail.com>
In-Reply-To: <CAHtt_wkiBZgFZDZzyH8vi_7X1-da9XVWJAhDaScg-2915-tAoQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5536265739941766625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 > root(a)g2:~# /usr/lib/ofono/test/dial-number XXXXXXXXXX
> Using modem /hso_0
> /hso_0/voicecall01
>
> the test case shows it had been created in voicecall01, but when I list
> the phone call
> root(a)g2:~# /usr/lib/ofono/test/list-calls
> [ /hso_0 ]
>      [ /hso_0/voicecall02 ]
>          Name =3D
>          LineIdentification =3D 9496796229
>          Multiparty =3D 0
>          Emergency =3D 0
>          RemoteHeld =3D 0
>          State =3D alerting
>          RemoteMultiparty =3D 0
>
> the voicecall which supposed to be at the first
> interface(/hso_0/voicecall01) will be created at second
> interface(/hso_0/voicecall02).
>
> Does anyone have any clue for this problem?

Hard to tell without AT command logs, but likely the voicecall atom =

driver you're using is not handling your modem correctly or your modem =

firmware is not following standards.

Regards,
-Denis

--===============5536265739941766625==--

