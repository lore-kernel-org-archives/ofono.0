Content-Type: multipart/mixed; boundary="===============6640635493679157674=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: Patch on unsupported AT command
Date: Tue, 17 Nov 2009 11:40:46 +0100
Message-ID: <1258454446.2003.6.camel@violet>
In-Reply-To: <38D9F46DFF92C54980D2F2C1E8EE313001B4C0170D@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6640635493679157674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> >> > > I think this might need a GAtChat quirk function where we can add =
extra
> >> > > terminator responses that will be recognized. And maybe even trans=
lated
> >> > > into something meaningful.
> >> >
> >> > Originally I had the terminators freely definable on the GAtChat + s=
ome
> >> > hardcoded ones, but abandoned that approach since it didn't seem use=
ful.
> >> > Perhaps this needs to be resurrected.
> >> >
> >> > > Denis, or do you want this quirked in every plugin or modem driver?
> >> >
> >> > I do prefer non-standard terminators to be setup in the plugin/drive=
r.
> >>
> >> I meant adding something like g_at_chat_add_terminator() or so.
> >
> >Yes, that is what I meant as well.
> =

> Attached is the patch to support plugin specific terminator, and it suppo=
rts Huawei's special one "COMMAND NOT SUPPORT".

you need to split this into a GAtChat specific patch and oFono plugin
patch.

Regards

Marcel



--===============6640635493679157674==--

