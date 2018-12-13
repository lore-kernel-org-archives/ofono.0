Content-Type: multipart/mixed; boundary="===============7785431108417333365=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: Sim PIN1 cache upon modem reset/crash
Date: Thu, 13 Dec 2018 10:28:13 -0600
Message-ID: <b8877863-c2bf-84af-cf9b-307a942351dd@gmail.com>
In-Reply-To: <CAKSBH7HtNp7kw6MY-kRHb4+rGP9nFDyQ3E29pKMmgJsOdspp9g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7785431108417333365==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

>>>> Can you cite the 3GPP specification number and section that this would=
 >>>> be violating?> > 21.111 (USIM and IC card requirements), or =

predecessors/successors.> I have taken the rel.7, whose paragraph 5.3 =

(User Data Stored in ME) mentions:> > "User related security codes such =

as PIN and Unblock PIN may only be> stored by the ME during the =

procedures involving such a code and shall> be discarded by the ME =

immediately after completion of the procedure."
Thanks for digging that up, this section should definitely be mentioned =

in a comment in the patch or the commit description.

The question is really what to do and I can see both sides of the =

argument.  So let me play devil's advocate:

If a firmware crashes on a device with a PIN lock and the user was =

browsing the internet at that time, it would be quite intrusive to =

interrupt the user and prompt them for a PIN (after all, they already =

entered the PIN).  Additionally, if the PIN was stored for just this =

case and the firmware reboots fast enough, a crash might not even be =

noticed by the user at all.  Now one can argue that the firmware =

shouldn't crash, and I agree, but realistically the chances of that =

never happening are NIL.

So if we do proceed with this feature, it should try pretty hard to =

comply with the spirit of the cited section, even if it isn't complying =

with it in a literal sense.

Regards,
-Denis

--===============7785431108417333365==--

