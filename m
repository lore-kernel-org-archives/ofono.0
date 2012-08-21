Content-Type: multipart/mixed; boundary="===============9118433066942400161=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [RFC] HFP support into oFono and BlueZ
Date: Tue, 21 Aug 2012 19:46:04 -0300
Message-ID: <CAMOw1v7Jtv0H0ZqWO=1sH+QnG78gcu8VO4pR2PE+q3XLDqWOHQ@mail.gmail.com>
In-Reply-To: <ac8af0be1001202354i7f1a98dbw55c56fc65f878358@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9118433066942400161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhao,

On Thu, Jan 21, 2010 at 5:54 AM, Zhao Forrest <forrest.zhao@gmail.com> wr=
ote:
> Your patch removes many DBus APIs provided by audio/gateway.c, which
> was originally designed to provide a set of DBus functions/signals for
> ease of application development. In other words, your patch is too
> oFono-specific, and is not a general support for HFP HF unit role in
> BlueZ IMO. The DBus interface provided by your patch is not easy to
> develop the application because the application developer has to parse
> the AT commands by himself. I know that oFono could parse AT commands.
> But I don't think it a common case for other application developers.
> Why not extend audio/gateway.c instead of removing its DBus APIs or
> create a new file to support HFP for oFono in blueZ?
>
> I think maybe Marcel would have more comments on this to give a clear dir=
ection.

First of all, please don't top-post to this list.

Applications developers don't have to parse the AT commands by
themselves but rather use a telephony stack that implements the DBus
APIs.

This is kind of an agent (as in the pairing process)  that anyone
could implement. oFono implements it, so it's 1 option.


Lucas De Marchi

--===============9118433066942400161==--

