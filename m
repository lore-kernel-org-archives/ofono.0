Content-Type: multipart/mixed; boundary="===============0846319503925274025=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] Phonesim HACKING updated to refer to phonesim.conf
 instead of modem.conf.
Date: Tue, 01 Feb 2011 10:26:28 +0200
Message-ID: <AANLkTim8SqcBtQXWvcwTW-A2ic_3smvVzh7S0mL8OCUM@mail.gmail.com>
In-Reply-To: <1296545491-474-1-git-send-email-essi.vehmersalo@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0846319503925274025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Essi,

2011/2/1 Essi Vehmersalo <essi.vehmersalo@nokia.com>:
> -automatically includes this option.
> +automatically includes this option. See phonesim.conf sample configurati=
on
> +under ofono/plugins on how to configure oFono to use phonesim.
>
> =C2=A0 Run phonesim in foreground using the following options
> =C2=A0 =C2=A0 # ./src/phonesim -p 12345 -gui src/default.xml
>
> -Check your modem.conf file and enable the phonesim configuration before
> -executing the above command. Argument -p should be followed by the proper
> -port number, in case you have changed the default "12345". Argument -gui
> -will launch the gui once the modem is enabled.
> +Argument -p should be followed by the proper port number, in case you ha=
ve
> +changed the default "12345". Argument -gui will launch the gui once the
> +modem is enabled.

A couple of nits: there are some extra whitespace at the end of the
lines, and also, the commit message header should be below 50
characters.

Cheers,
Aki

--===============0846319503925274025==--

