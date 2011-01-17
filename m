Content-Type: multipart/mixed; boundary="===============6288815650051724817=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH 1/2] Add sim driver call for applications discovery.
Date: Mon, 17 Jan 2011 16:42:24 +0200
Message-ID: <AANLkTim0HRN9t740=Jig2U6RVgAj0PsYudSK=tnh+yY3@mail.gmail.com>
In-Reply-To: <4D2F2AAD.8030208@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6288815650051724817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis and Andrzej,

2011/1/13 Denis Kenzior <denkenz@gmail.com>:
>> + =C2=A0 =C2=A0 void (*list_apps)(struct ofono_sim *sim, ofono_sim_apps_=
cb_t cb,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
void *data);
>> =C2=A0};
>
> Do you think this belongs on a separate atom? =C2=A0E.g. something like
> Pekka's SimAuthentication ?

I think the applications here are things like USIM and ISIMs. For
authentication, we need the list of applications in order to find out
that there is USIM (so we can use AKA), and if there are ISIMs, which
one to use. (That is my understanding, but I'm no smart card
expert...).

-- =

Pekka.Pessi mail at nokia.com

--===============6288815650051724817==--

