Content-Type: multipart/mixed; boundary="===============0937627890666078744=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: MNC/MCC as string?
Date: Thu, 11 Jun 2009 15:08:08 -0500
Message-ID: <200906111508.08653.denkenz@gmail.com>
In-Reply-To: <cb0e8d6f9acaa0c755e042ab8dda6dbd@localhost>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0937627890666078744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Aki,

On Thursday 11 June 2009 14:38:49 Aki Niemi wrote:
> On Thu, 11 Jun 2009 21:18:02 +0200, Marcel Holtmann <marcel@holtmann.or=
g>
>
> wrote:
> >> However, this wouldn't be the only database ever, so we would still ne=
ed
> >> a
> >> way to reliably identify a specific operator.
> >
> > if we are unclear about the format and the users at this moment,
>
> The format should be 's' in D-Bus and in struct ofono_network_operator:
>
>    char mnc[4];
>    char mcc[4];
>
> And as for users, we need access to both MNC and MCC.
>
> What part of this is unclear?

Please submit a patch to the mailing list reflecting how you think it shoul=
d be =

implemented.  If it looks reasonable then I'll integrate it.

Regards,
-Denis


--===============0937627890666078744==--

