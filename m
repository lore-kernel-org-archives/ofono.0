Content-Type: multipart/mixed; boundary="===============7340870839863187120=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: problem sim status
Date: Fri, 28 Mar 2014 15:54:23 -0500
Message-ID: <5335E17F.6040006@gmail.com>
In-Reply-To: <lh4bcu$p02$1@ger.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7340870839863187120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Eric,

> is it normal that pre_sim function is called before ofono get modem
> manufacturer and model ?
> =


Yes.  If you note, the devinfo atom is added in pre-sim.

> i would like to get model in presim to make a better patch using modem
> model with a new enum in vendor list (like simcom)
> how i can make pre_sim to wait for theses information available ?

Simply query the model/whichever numbers as part of your initialization
procedure.  e.g. run AT+FOO for the information that you need.  See how
the huawei plugin uses AT+ATI for example.

Regards,
-Denis

--===============7340870839863187120==--

