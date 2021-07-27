Content-Type: multipart/mixed; boundary="===============8464648409197415836=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Bug/Oversight in gatchat/gatresult.c with negative numbers
Date: Tue, 27 Jul 2021 09:38:32 -0500
Message-ID: <a581d123-5632-ec7f-208e-e7ef7a96a00b@gmail.com>
In-Reply-To: <8171168c-ee95-46c2-48bf-006dbfb59309@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8464648409197415836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On 7/20/21 11:11 AM, Alex J Lennon wrote:
> Hi all,
> =

> I'm doing a bit of work with Ofono again, extending support for a Quectel=
 EG91 - =

> handling additional cell strength information which seems necessary for L=
TE.
> =

> I'm using Quectel's AT+QCOPS which is returning some negative signal stre=
ngths =

> and after some investigation I've spotted that =

> gatresult::g_at_result_iter_next_number() doesn't handle negative numbers.

AT commands do not have a concept of negative numbers.  v.250 Section 5.3.1:
<number> may be a string of one or more characters from "0" through "9" =

representing a decimal
integer value. Commands that expect a <number> are noted in the description=
 of =

the command (see
clause 6).

I don't recall any other vendor using negative values in AT commands.

If you want to add a negative number parser to GAtChat, then please make it=
 a =

separate method, so that it is very clear that a vendor 'extension' is bein=
g =

worked around.

Regards,
-Denis
--===============8464648409197415836==--

